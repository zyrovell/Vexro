import json
import os

def temizle():
    if not os.path.exists('emotes.json'):
        print("Dosya bulunamadı!")
        return

    with open('emotes.json', 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Tekrarları sil (Sırayı bozmadan)
    yeni_data = []
    gorulenler = set()
    for d in data:
        t = tuple(sorted(d.items()))
        if t not in gorulenler:
            yeni_data.append(d)
            gorulenler.add(t)

    with open('emotes.json', 'w', encoding='utf-8') as f:
        json.dump(yeni_data, f, ensure_ascii=False, indent=4)
    
    print(f"İşlem tamam. {len(data)} öğeden {len(yeni_data)} öğeye düşürüldü.")

if __name__ == "__main__":
    temizle()
