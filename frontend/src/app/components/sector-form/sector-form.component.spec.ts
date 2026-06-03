import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { SectorFormComponent } from './sector-form.component';

describe('SectorFormComponent – form validation', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SectorFormComponent],
      providers: [provideHttpClient(), provideHttpClientTesting()],
    }).compileComponents();
  });

  function createComponent() {
    const fixture = TestBed.createComponent(SectorFormComponent);
    fixture.detectChanges();
    return fixture.componentInstance;
  }

  it('form is invalid when empty', () => {
    const c = createComponent();
    expect(c.form.invalid).toBeTrue();
  });

  it('name is invalid when empty', () => {
    const c = createComponent();
    c.name.setValue('');
    expect(c.name.invalid).toBeTrue();
  });

  it('name is invalid when only whitespace', () => {
    const c = createComponent();
    c.name.setValue('   ');
    expect(c.name.invalid).toBeTrue();
  });

  it('name is valid when it has content', () => {
    const c = createComponent();
    c.name.setValue('Roger');
    expect(c.name.valid).toBeTrue();
  });

  it('sectorIds is invalid when empty list', () => {
    const c = createComponent();
    c.sectorIds.setValue([]);
    expect(c.sectorIds.invalid).toBeTrue();
  });

  it('sectorIds is valid when at least one selected', () => {
    const c = createComponent();
    c.sectorIds.setValue([1]);
    expect(c.sectorIds.valid).toBeTrue();
  });

  it('agreeToTerms is invalid when false', () => {
    const c = createComponent();
    c.agreeToTerms.setValue(false);
    expect(c.agreeToTerms.invalid).toBeTrue();
  });

  it('agreeToTerms is valid when true', () => {
    const c = createComponent();
    c.agreeToTerms.setValue(true);
    expect(c.agreeToTerms.valid).toBeTrue();
  });

  it('form is valid when all fields are correctly filled', () => {
    const c = createComponent();
    c.name.setValue('Roger');
    c.sectorIds.setValue([28]);
    c.agreeToTerms.setValue(true);
    expect(c.form.valid).toBeTrue();
  });

  it('markAllAsTouched is called when invalid form is submitted', () => {
    const c = createComponent();
    spyOn(c.form, 'markAllAsTouched');
    c.onSubmit();
    expect(c.form.markAllAsTouched).toHaveBeenCalled();
  });
});
