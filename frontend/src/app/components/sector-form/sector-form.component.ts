import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { HttpErrorResponse } from '@angular/common/http';
import { SectorService } from '../../services/sector.service';
import { UserProfileService } from '../../services/user-profile.service';
import { SessionService } from '../../services/session.service';
import { Sector } from '../../models/sector.model';
import { UserProfileResponse } from '../../models/user-profile.model';

function noWhitespace(control: AbstractControl): ValidationErrors | null {
  if (typeof control.value === 'string' && control.value.trim().length === 0 && control.value.length > 0) {
    return { whitespace: true };
  }
  return null;
}

function atLeastOne(control: AbstractControl): ValidationErrors | null {
  if (!control.value || control.value.length === 0) {
    return { atLeastOne: true };
  }
  return null;
}

@Component({
  selector: 'app-sector-form',
  imports: [ReactiveFormsModule],
  templateUrl: './sector-form.component.html',
})
export class SectorFormComponent implements OnInit {
  sectors: Sector[]  = [];
  sectorsLoading     = true;
  saving             = false;
  successMessage     = '';
  errorMessage       = '';

  name         = new FormControl('',    [Validators.required, noWhitespace]);
  sectorIds    = new FormControl<number[]>([], atLeastOne);
  agreeToTerms = new FormControl(false, Validators.requiredTrue);

  form = new FormGroup({
    name:         this.name,
    sectorIds:    this.sectorIds,
    agreeToTerms: this.agreeToTerms,
  });

  constructor(
    private sectorService: SectorService,
    private userProfileService: UserProfileService,
    private sessionService: SessionService
  ) {}

  ngOnInit(): void {
    this.sectorService.getAll().subscribe(sectors => {
      this.sectors = sectors;
      this.sectorsLoading = false;
    });

    const sessionId = this.sessionService.getSessionId();
    this.userProfileService.getProfile(sessionId).subscribe({
      next: profile => this.fillForm(profile),
      error: (err: HttpErrorResponse) => {
        // 404 means theres no profile so we leave it empty for now
        if (err.status !== 404) {
          this.errorMessage = 'Failed to load saved data.';
        }
      }
    });
  }

  onSubmit(): void {
    if (this.form.invalid) {
      // all .touched so forms go red
      this.form.markAllAsTouched();
      return;
    }

    this.saving = true;

    const request = {
      sessionId:    this.sessionService.getSessionId(),
      name:         this.name.value!,
      sectorIds:    this.sectorIds.value!,
      agreeToTerms: this.agreeToTerms.value!,
    };

    this.userProfileService.saveProfile(request).subscribe({
      next: profile => {
        this.fillForm(profile);
        this.successMessage = 'Saved successfully!';
        this.errorMessage   = '';
        this.saving         = false;
      },
      error: () => {
        this.errorMessage   = 'Failed to save. Please try again.';
        this.successMessage = '';
        this.saving         = false;
      }
    });
  }

  private fillForm(profile: UserProfileResponse): void {
    this.name.setValue(profile.name);
    this.sectorIds.setValue(profile.sectorIds);
    this.agreeToTerms.setValue(profile.agreeToTerms);
  }

  indentedName(sector: Sector): string {
    return ' '.repeat(sector.level * 4) + sector.name;
  }
}
