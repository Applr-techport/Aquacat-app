# 아쿠아캣 디자인 시스템 V1

## 🎨 컬러 팔레트

### Primary (물/하늘)
- **Primary 500**: `#289BDD` — 메인 액션, 프로그레스
- **Primary 400**: `#41BDED` — 호버, 액센트
- **Primary 300**: `#7DD3F8` — 서브 요소
- **Primary 200**: `#ACE7F6` — 배경 강조
- **Primary 100**: `#E0F5FD` — 카드 배경
- **Primary 50**: `#F0FAFF` — 페이지 배경

### Semantic
- **Success**: `#34D399` (목표 달성)
- **Warning**: `#FBBF24` (주의, 50~70%)
- **Danger**: `#F87171` (위험, 30% 이하)
- **Perfect Gold**: `#F59E0B` (목표 초과, 왕관)

### Neutral
- **Gray 900**: `#111827` — 메인 텍스트
- **Gray 600**: `#4B5563` — 서브 텍스트
- **Gray 400**: `#9CA3AF` — 힌트, 비활성
- **Gray 200**: `#E5E7EB` — 구분선
- **Gray 50**: `#F9FAFB` — 배경

### Surface
- **White**: `#FFFFFF` — 카드
- **Background**: `#F0FAFF` — 스카폴드

## 📐 타이포그래피

### 스케일
| 용도 | 크기 | 무게 | 행간 |
|------|------|------|------|
| Display | 32px | Bold (700) | 1.2 |
| Heading 1 | 24px | SemiBold (600) | 1.3 |
| Heading 2 | 20px | SemiBold (600) | 1.3 |
| Body Large | 16px | Regular (400) | 1.5 |
| Body | 14px | Regular (400) | 1.5 |
| Caption | 12px | Regular (400) | 1.4 |
| Overline | 11px | Medium (500) | 1.4 |

### 숫자 강조
- 물 섭취량: **32px Bold** + 단위 **16px Regular**
- 퍼센트: **20px Bold**
- 시간/기록: **14px Medium**

## 📦 간격 시스템 (8pt Grid)

- `4px` — 인라인 간격
- `8px` — 아이콘-텍스트 간격
- `12px` — 카드 내 요소 간
- `16px` — 섹션 내 간격
- `24px` — 섹션 간 간격
- `32px` — 페이지 좌우 패딩

## 🃏 카드 스타일

### 기본 카드
```
배경: White
모서리: 16px
그림자: 0 2px 12px rgba(40, 155, 221, 0.08)
패딩: 16px
```

### 강조 카드 (팁, 스트릭)
```
배경: Gradient (Primary 500 → Primary 400)
모서리: 20px
패딩: 20px
텍스트: White
```

### 상태 카드 (게이지)
```
배경: Primary 100
모서리: 24px (pill)
패딩: 8px 16px
```

## 🔘 버튼 스타일

### 물 마시기 버튼 (주요 액션)
```
크기: 72 x 88px
배경: White
모서리: 20px
그림자: 0 4px 16px rgba(40, 155, 221, 0.12)
아이콘: 32px, Primary 500
라벨: 13px, Gray 600
활성 효과: scale(0.95) + 그림자 강화
```

### CTA 버튼 (시작하기, 다음)
```
높이: 56px
배경: Primary 500
모서리: 16px
텍스트: White, 16px SemiBold
```

## ⭕ 프로그레스 링

### 메인 (홈)
```
크기: 260px
선 두께: 10px
배경 선: Primary 100
채움: Primary 500 (100% 미만) / Perfect Gold (100%+)
끝 처리: Round cap
```

### 게이지 뱃지
```
배경: catState별 색상
  - normal: Primary 500
  - happy: Success
  - thirsty: Warning
  - critical: Danger
  - perfect: Perfect Gold
모서리: pill (999px)
텍스트: White, 13px SemiBold
```

## 🐱 캐릭터 영역

### 홈 캐릭터
```
크기: 180px (프로그레스 링 안에)
여백: 프로그레스 링 안쪽 40px
애니메이션: state별 idle animation
```

### 말풍선
```
배경: White
모서리: 20px
그림자: 0 4px 20px rgba(0,0,0,0.08)
패딩: 16px 20px
최대 너비: 280px
자동 닫힘: 3초
입장: fadeIn + slideUp
```

## 📱 BottomNav

```
높이: 64px + safe area
배경: White
그림자: 0 -2px 12px rgba(0,0,0,0.04)
아이콘: 24px
라벨: 11px
선택됨: Primary 500
미선택: Gray 400
```

## 🎭 애니메이션 규칙

- **전환**: 300ms, easeInOut
- **팝업**: 200ms fadeIn
- **물 마시기 피드백**: haptic + 말풍선 + 프로그레스 애니메이션
- **프로그레스 채움**: 600ms, easeOut
- **캐릭터 상태 전환**: 300ms crossfade

## 📱 레이아웃 규칙

- 좌우 패딩: 24px (홈), 24px (설정), 24px (통계)
- 최대 너비: 428px (태블릿 대응)
- SafeArea 적용 필수
- 키보드 시 스크롤 가능 (온보딩)
