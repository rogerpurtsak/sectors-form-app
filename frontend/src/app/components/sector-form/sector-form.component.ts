import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { SectorService } from '../../services/sector.service';
import { Sector } from '../../models/sector.model';
import { SessionService } from '../../services/session.service';

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
  // this goes for the html for loop
  sectors: Sector[] = [];

  name         = new FormControl('',    [Validators.required, noWhitespace]);
  sectorIds    = new FormControl<number[]>([], atLeastOne);
  agreeToTerms = new FormControl(false, Validators.requiredTrue);

  form = new FormGroup({
    name:         this.name,
    sectorIds:    this.sectorIds,
    agreeToTerms: this.agreeToTerms,
  });

  constructor(private sectorService: SectorService, private sessionService: SessionService) {}

  ngOnInit(): void {
    this.sectorService.getAll().subscribe(sectors => {
      this.sectors = sectors;
    });
  }

  onSubmit(): void {
    if (this.form.invalid) {
      // if this activates then all the forms would go .touched and show red
      this.form.markAllAsTouched();
      return;
    }
    console.log(this.sessionService.getSessionId());
  }

  indentedName(sector: Sector): string {
    return ' '.repeat(sector.level * 4) + sector.name;
  }
}
