Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9F1A519C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgDKM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 08:26:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:54081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgDKM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586608000;
        bh=Qe5TIhwuZ0lnZ5c49QtZbb8+6UAILtOmv8OpMKPtW/s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j9Z1itcolLDUNFB+tj54D1Kb9LAbS8mZQl0wvvKcbrD1f2D7k9xOe+sEkQQIjE3Tq
         LXK/VcHu07BbpCy3TWXZJHLOZT0HIiwhFey59Qa6pbV3X7j1yupRYn0JAVCn+zuhdg
         JfzWD2yGlDrvXayoqhHV9zaIKcpg2rbUHLp28TDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MFbRm-1jVRde2QSU-00H59S; Sat, 11 Apr 2020 14:26:40 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: vt6656: Refactor the assignment of the phy->signal variable
Date:   Sat, 11 Apr 2020 14:26:09 +0200
Message-Id: <20200411122610.7901-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411122610.7901-1-oscar.carter@gmx.com>
References: <20200411122610.7901-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZbsLyPJkFpbPl9JOMkJVgPELbbkpG+CtT4twaz1GSAXQ5zaan7a
 PDa4lFhU9GuERl6zX3zSWCXhYctwzy8e9q/7DsJXL0YdKtTA+0Gbt1/tG6yqwg7JMYyXgI2
 ULp8MsacRUTFEatRc7HE6uVkpv24OZWNWa/BMerZG2LFoY/3Dl03E/Uc/sx6XLUrT/IGTyP
 YXV8kXZpqw+o70p5ezqJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+FvOKfZMQ5Y=:ahFcYghwnA88kwwwTL6F2X
 FWUE+QFn0IT8cHNUi770MPJCksl0ifdZ+fs4GzJyVXE1xFJIVWdgZYv/wQMxdsnOVDdHCgfDs
 lnf+uD8jmGxSeb4TVFt57W0ERJ22f6r9iaMcvMmtKVp4W493GSqfnMiZE9T1SEaJhnQxvcTrb
 49LY9skLeiOZmwaOlBDEMRByiP6l5Wi/zrn87z7L9LT8arJQ6Gm0VGSrQH+/bzYar2acWlPoL
 Dk63f+lhOYnFGWZqfnj7352sFnx6zCUey0xn5qHzF9bFyxKFQ8q9HsGFBHYQedD/K9/VQZ8Rm
 K8zKNY34ff3STHXXc33RfUVbc6hOC9Vw+/HXPCMXaP/DI1LJDqFx9o+A8awcdhIjXOLO6p9jA
 rGdgGmW0WE4GkR+6ZjmDGAnUpn4WaIJIL8l1a6KV+v9LmoLyXROVd9NW/Ysk9chZ0TY0sEKVk
 lkUSTZQgOtyJe+XpbHXaFFZBReZXxfcxPz7L7TcNYGgDgHTUltONmfTUl3U03JLgjJwk9WuEs
 Ht9uvRuqRc14WJSFy1BT8TbvEVS78AyJbQfhF1I1Qt5VuqQDiAJJhjc3dbeEqPHN2PJbM7CQT
 nJdYWZSRQI9qOdfkv19u97bbiczpacdo427vgABceFPX4ZgNfVJ05hR9CDwiaoRUWkxykDwb7
 MsGQOJDFE1OdLqNZl0SPkc7droZFDJjUgVgszd8xGqP+hfy2AWTg26ZUgM9XL8htH5XTKYXvG
 LWVBOixvnkDJ993PoPb0Bgpuc145/EdqGU0/gYZ+MAnbTEF6HPIPhJdbGPZyJkSHSJTq8/vog
 Pv/Z8g1QEjHJRDlMaX6bS8UAcwlDLh/7M5QhD2cPQupAU+63KVGW7FpAwKzxYvSaA9pb9ojn9
 5FVbG8pQsTEVhTVJ10NtzDbdp7jVa+RE+FUm1F3SBKBUUGET1e0tbIHp7T7utRXhLu8Kfc6Rn
 grelfrV7Z9fTbEhpcAE3kBtknkWHZ96QiQZtD4S0ca6BRBrvNRmM+cTawo3L5YX5s1agq9xsj
 Sb/q5E24CiMnSCwsi7Maf3T8MCViZPSgINL9CnSsTCCM67DZ8l4d+ivZOJQj1v3aHcA1ncH7g
 HyW8F+K+BFszfgzyam5btFT+Ps61plX4jXOn3rsav35p+xMgEnJMhTN8NSOkYYBuzpNBQMf88
 /Fccj17JAf+tseFIgqj54OHR7J55jaz9GKmjEB5RDQDgP35ysvqBOkNQ4R/O9a1WR+iCjrMF5
 AtKTnmp24v/k/5TGp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a constant array with the values of the "phy->signal" for every
rate. Remove all "phy->signal" assignments inside the switch statement
and replace these with a single reading from the new vnt_phy_signal
array.

The constant array can be of one dimension because the OR mask with
BIT(3) or BIT(4) allow obtain a second value according to the rate,
the preamble_type and the pkt_type.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 105 ++++++++----------------------
 1 file changed, 26 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..05cc4797df52 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] =3D {
 	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
 };

+static const u8 vnt_phy_signal[] =3D {
+	0x00,	/* RATE_1M  */
+	0x01,	/* RATE_2M  */
+	0x02,	/* RATE_5M  */
+	0x03,	/* RATE_11M */
+	0x8b,	/* RATE_6M  */
+	0x8f,	/* RATE_9M  */
+	0x8a,	/* RATE_12M */
+	0x8e,	/* RATE_18M */
+	0x89,	/* RATE_24M */
+	0x8d,	/* RATE_36M */
+	0x88,	/* RATE_48M */
+	0x8c	/* RATE_54M */
+};
+
 /*
  * Description: Calculate data frame transmitting time
  *
@@ -183,6 +198,8 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 	u32 count =3D 0;
 	u32 tmp;
 	int ext_bit;
+	int i;
+	u8 mask =3D 0;
 	u8 preamble_type =3D priv->preamble_type;

 	bit_count =3D frame_length * 8;
@@ -191,27 +208,12 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 	switch (tx_rate) {
 	case RATE_1M:
 		count =3D bit_count;
-
-		phy->signal =3D 0x00;
-
 		break;
 	case RATE_2M:
 		count =3D bit_count / 2;
-
-		if (preamble_type =3D=3D 1)
-			phy->signal =3D 0x09;
-		else
-			phy->signal =3D 0x01;
-
 		break;
 	case RATE_5M:
 		count =3D DIV_ROUND_UP(bit_count * 10, 55);
-
-		if (preamble_type =3D=3D 1)
-			phy->signal =3D 0x0a;
-		else
-			phy->signal =3D 0x02;
-
 		break;
 	case RATE_11M:
 		count =3D bit_count / 11;
@@ -224,75 +226,20 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 				ext_bit =3D true;
 		}

-		if (preamble_type =3D=3D 1)
-			phy->signal =3D 0x0b;
-		else
-			phy->signal =3D 0x03;
-
-		break;
-	case RATE_6M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9b;
-		else
-			phy->signal =3D 0x8b;
-
 		break;
-	case RATE_9M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9f;
-		else
-			phy->signal =3D 0x8f;
-
-		break;
-	case RATE_12M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9a;
-		else
-			phy->signal =3D 0x8a;
-
-		break;
-	case RATE_18M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9e;
-		else
-			phy->signal =3D 0x8e;
-
-		break;
-	case RATE_24M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x99;
-		else
-			phy->signal =3D 0x89;
-
-		break;
-	case RATE_36M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9d;
-		else
-			phy->signal =3D 0x8d;
-
-		break;
-	case RATE_48M:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x98;
-		else
-			phy->signal =3D 0x88;
+	}

-		break;
-	case RATE_54M:
+	if (tx_rate > RATE_11M) {
 		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
-	default:
-		if (pkt_type =3D=3D PK_TYPE_11A)
-			phy->signal =3D 0x9c;
-		else
-			phy->signal =3D 0x8c;
-		break;
+			mask =3D BIT(4);
+	} else if (tx_rate > RATE_1M) {
+		if (preamble_type =3D=3D PREAMBLE_SHORT)
+			mask =3D BIT(3);
 	}

+	i =3D tx_rate > RATE_54M ? RATE_54M : tx_rate;
+	phy->signal =3D vnt_phy_signal[i] | mask;
+
 	if (pkt_type =3D=3D PK_TYPE_11B) {
 		phy->service =3D 0x00;
 		if (ext_bit)
=2D-
2.20.1

