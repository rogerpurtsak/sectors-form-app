export interface Sector {
  id: number;
  name: string;
  parentId: number | null;
  level: number;
  sortOrder: number;
}