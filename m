Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5722C87F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgK3P0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:26:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:41023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgK3P0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606749879;
        bh=5+U793qEgJ/jb9OmcVYf63Yh/ejUyZBNttGan64SZjM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PB0ZQmwF7GHfFxn/OJiPglDWxuMSUUT44MoAirqrAzR/kjNsJcjz7CaIzGq5ABLux
         LLfTJex+Sf2VouVB9rit0BDd17VjXCXyue8eIKE62oSBuGUVNt3LykEawVEtX3uduO
         Z31MQa0HtdkbMzBnMhbHFdOvd7YcCCjHXyaY+H0k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1kUh2427gJ-00Kde1; Mon, 30
 Nov 2020 16:24:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: Fix multiple typos
Date:   Mon, 30 Nov 2020 16:24:15 +0100
Message-Id: <20201130152416.1283972-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tuRJKz0CiM5kci92vMAABw+dDJAybLVWSscZlQPGm5EMtFbIdTy
 Y/sFeu/UbcYG+cjlV55g+Z6u5SJMPtU65hyk6L7tkDNibBTnCZN+lfwIfRi3kjCUitdx4uV
 WC4RIl0Ww1fZkG63wlVov7F4cdkUoQ0GGT6QFVmuVZUBv1E3+0iATGhALxOWQLiX/rWUTdq
 7vNdaEIKn0fvm8lRivX1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mfjaYp6oJAA=:7pAQ/ZNyl6UsTcfiOLYBnC
 CvuecukH2WCgQpi48RvTsjxl+X3K+SwLt7jV9gahf6wMQ7nckr2ADvsRcwd1WeqXu+89j85Md
 Qjj59G0JYZ4dUwwyR5VVeshY57p5Lq/ewo8pJmgY8od/gnKM7yrJLGTeP/KiRKcXtLih+tP3Q
 JG9J/OfC04W/+3oYcCcu0cAj94J4TcjJ9S3fZLqLStdC7XwBlzIT8VvuQfuV/PhBPgO3mvgED
 c9tn/COJHtPyRGXhmUAmqDB5Mf+0q8oS6/JcGe+1bsTy+aSkwQ80Kf7C2TY7gwpkwJE2AjKb7
 2JRQOEysPtTfhG+JOlhiJd9imQAoG7m2pULBbyzfJBuwuMvu0gQU1Qal5u+KDtTzATqfaW9gL
 SLqeg0Cgt+lykF8+HTYaudWCT5Gs5VMB26Dxk9WH2zNDRvOjRwToTgqvpbTpju8bIfKQqhmrF
 xn/HcCOH5JLiNIcewX7c/iZ1mblj4+LYDiD79jhlDcpOcIQDejqXdKB4g0gFVTjpO9tl7xOxz
 AeVqGkbSII0yoX5XNtECsoJvH0j5JhZr21oQd+X4YeWF2hQwoK5/qSxG4tyUhdLeeY5SymvC5
 CSSguA63vhTVJgVrdr73a7w7hYVxiqFbgCpX/YR+5VeR0r1QiYxBBWj80qOJeuAVA5NBAyac3
 nuUmlGsGUv1pRCtKaTWhLFj2pqz1pKNX+h96P5dqIC+y40n0G27Q7L0u8EaEFtM1ZJrSc2Pxb
 Q0rn4zK0JH8VQdbNJOPKFMVZGamp5mFr9i1quhEuRTBwLo6lNO3RGVBddElve9JuTVb/vh+mu
 uvQTxpW8IqAzdqQMnyybceyfb8d3NC9Pv3y69UCiubnYX9JYBhKLiQC7IK04ua/saJlyD6140
 PT2faJKagxTwvUsYqn8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few typos in comments in the SPI NOR framework; fix them.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mtd/spi-nor/core.c  | 4 ++--
 drivers/mtd/spi-nor/sfdp.c  | 2 +-
 include/linux/mtd/spi-nor.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f0ae7a01703a1..b224b275125a3 100644
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
2.29.2

