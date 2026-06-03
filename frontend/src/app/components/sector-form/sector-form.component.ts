import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { SectorService } from '../../services/sector.service';
import { Sector } from '../../models/sector.model';

@Component({
  selector: 'app-sector-form',
  imports: [ReactiveFormsModule],
  templateUrl: './sector-form.component.html',
})
export class SectorFormComponent implements OnInit {
  // this goes to the html for loop
  sectors: Sector[] = [];

  name         = new FormControl('',    Validators.required);
  sectorIds    = new FormControl<number[]>([], Validators.required);
  agreeToTerms = new FormControl(false, Validators.requiredTrue);

  form = new FormGroup({
    name:         this.name,
    sectorIds:    this.sectorIds,
    agreeToTerms: this.agreeToTerms,
  });

  constructor(private sectorService: SectorService) {}

  ngOnInit(): void {
    this.sectorService.getAll().subscribe(sectors => {
      this.sectors = sectors;
    });
  }

  onSubmit(): void {
    if (this.form.valid) {
      console.log('Form value:', this.form.value);
    }
  }

  indentedName(sector: Sector): string {
    return ' '.repeat(sector.level * 4) + sector.name;
  }
}
