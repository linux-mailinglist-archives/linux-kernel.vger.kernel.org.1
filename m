Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AE2AA582
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgKGNma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:42:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:57111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgKGNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604756527;
        bh=5HgqEvvJiH/bZLPEWmKV16KDFdLKNOtgtdg08AcddNE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QJxGKw74yjzwZcA5YC0NcK+scU/tWV8IOqHh9438zcIfHg+G0VOOR+ZBEg5zUoGL9
         ZU72vVfHzJiNN1T2HAhaCMtQuLmnq1tJXFA0KXBewLCd1ry5fysv6FLrQAsVGiG3QG
         ncayklwWJ+/U3AcCDgKfLC2WUPaX7JZRTq60AflE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1kcE5Z46s3-004AbJ; Sat, 07
 Nov 2020 14:42:07 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Fix multiple typos
Date:   Sat,  7 Nov 2020 14:41:51 +0100
Message-Id: <20201107134151.1071327-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DTS66gvIc0DDkzLq0yp1rJp3/B+3nK0vtp69pRD/TyKz+mGY/4F
 6lbLmwaM4tBVAdunsrFOzHtQNscFFZm7b5BbV9HFiJecgABDqgLliI2mWhpcs0bmwhu/cYZ
 nCZyR9GJSDoUAmegDe2xxyHcHhoFcSDp2hmSnMc3OBZeK7l2lu5dSk4velEnHhwprFzaHi+
 59RRmDx8jiHxAGccMX0Dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/WkoJTRTv4U=:cb1BQr7r5je6Dfh2jjoiLf
 SyeP/1KeP8gMwE2d7CQiNIRfK+8ohnNTcbOjS3NdiASteZj621LnPohHVxY17qLtRUIR3TJX5
 dFp2/eBZlPjlskrLZjGNPjkejD52Pz/nhgxF8XHNFN8PWgu7yDS3NJr2+CWm68P7XXrtiLJmu
 fVMrnOtmvy93HAONgz7HOfUdmyKVPJrHwZaKboXECKSENTeU2kbpmhqR5XKnZtxAvZb53vWQU
 k2DaZolu1Hk7hqX78BT8C2jpE1WBTXWCsF51L1SVSrui2rOAo1BdhRDLEOepzoI5Mw9VHB9D8
 jrDz3hn/0CrSBRdMw/U+o0nTQAe2GLMtHLstvSDBUFs0ZbcnEYkrDCJjA2cW3vTVZ33hlUFpF
 4pjxyBCVPK1CWDfB/7T1wK4Po2ImCsH0buvklwtvqVQ4QWyT1rDzAHUBVICcOELlfPw5ru14/
 GuI2IqFLndQwchevYRbizt+3n8qQnL8XgzQC5YXyJf4EAASSsOXZQjg7JQFWskCsFDAO8C+FS
 fdzpwAdxwMIC5CL7bb/AP88hywT4BuyUGyoSVvRFWHzlogLnTkkAQcCjjkdq0BSyeAc2F9gaW
 XUECpVzF9lmTRIJCdMzjtYQ8aKYO8wrk5ojvcrigfPl21z1VGTGprnJ30FcHrvyMOUgxiBY1y
 P45e1q8Dg48a+mVuvrxmREgPAPjsIbseimwybaBlFYAn1rhhCl6HCWz2Yd7R/kP66p/dfYjnT
 wC7Bb6WtvLJp/b4E4dypJkh+baWAEBAm28N6oMsYDHa7W8vaXfPcZ8Z9l/eD/D/WNma/CFBj3
 yQGs3ED7wWzM88x8ZQKeWq55kurko1xzlfILFpkoTMrbdKS15pqG9oDNHZBSZFQDXbSa82kLe
 V+fN2ZQvU3qW2g/YF19hZ0UWrR5OvrtFLjg6zYwxk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mtd/spi-nor/core.c  | 4 ++--
 drivers/mtd/spi-nor/sfdp.c  | 2 +-
 include/linux/mtd/spi-nor.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0369d98b2d12e..85c0704945259 100644
=2D-- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1447,7 +1447,7 @@ static int spi_nor_erase_multi_sectors(struct spi_no=
r *nor, u64 addr, u32 len)

 /*
  * Erase an address range on the nor chip.  The address range may extend
- * one or more erase sectors.  Return an error is there is a problem eras=
ing.
+ * one or more erase sectors.  Return an error if there is a problem eras=
ing.
  */
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
@@ -2537,7 +2537,7 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_ma=
p *map,
 		}

 		/*
-		 * Otherwise, the current erase size is still a valid canditate.
+		 * Otherwise, the current erase size is still a valid candidate.
 		 * Select the biggest valid candidate.
 		 */
 		if (!erase && tested_erase->size)
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index e2a43d39eb5f4..05b22c6576832 100644
=2D-- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -59,7 +59,7 @@ struct sfdp_bfpt_read {

 struct sfdp_bfpt_erase {
 	/*
-	 * The half-word at offset <shift> in DWORD <dwoard> encodes the
+	 * The half-word at offset <shift> in DWORD <dword> encodes the
 	 * op code and erase sector size to be used by Sector Erase commands.
 	 */
 	u32			dword;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 60bac2c0ec456..582ee04eeea20 100644
=2D-- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -406,7 +406,7 @@ static inline struct device_node *spi_nor_get_flash_no=
de(struct spi_nor *nor)
  * @name:	the chip type name
  * @hwcaps:	the hardware capabilities supported by the controller driver
  *
- * The drivers can use this fuction to scan the SPI NOR.
+ * The drivers can use this function to scan the SPI NOR.
  * In the scanning, it will try to get all the necessary information to
  * fill the mtd_info{} and the spi_nor{}.
  *
=2D-
2.28.0

