Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8302A2D2068
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLHB6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgLHB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:58:39 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB6C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:57:53 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so6144896plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 17:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEbqzzqCEqvcGZp9bdSJJ8AMDzH/+lH+MN/rwH64wJo=;
        b=tpcfkOK4AiGpW/gJsFTLcjsn/2HvWOAp1O4CdQOTwRoLRW9AXtTduIPuKLdbP2ai49
         iiWiQ8A6SwWQx3GgFcSaFXcymA9hdSD8ScLGnnS+dBlf5oiyH+o3cjY1kcEYNkJ93lXx
         IzW/HJ6DvY2if3+DgzCJFP/SAID3FsONo+//KmUpcL2uryGn7uHlyAke/zMMzuACV5VC
         UHwRsUFzwhjSqqCQH7mmyUMsk3Jpbzbezkj5TrthQyonT2avqX7fYjgzFnCv1b6sAC7S
         0qivsmcH/cjm+MvWubD82gAC1/JFd7TeQR600xEx1g8X6e7/8WhEEyTZtIjeHpVrCF6l
         N4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEbqzzqCEqvcGZp9bdSJJ8AMDzH/+lH+MN/rwH64wJo=;
        b=k3fD5A3uzHo9TbqWlSiH6m9e0OYBJcqO1xIXEGDouD21lGhfksz8vPcA0XFuH4DLWB
         T9oBfjGpU39dNRSduUedryAyKdMxBog3Saz9IwC4kzHMxNlzF65Afv2hLt0ku05pSfG7
         7pXekjY5I4rtQ2ZbWza6SzSlEyV1D4ngYlZmSVWylJImqLWcH1VfVrpOfVoWA8uYTR0E
         I0GIuWnOBCZ8QWUwEjvgJ5jfQ1YHVcDxZ4LKUDfRq1ZOnBisYL9xT/mAl/cxCFY+Y8+R
         QseXFWzYDHQUtipUL82oOns5i1ZTCLfk8J1LUeJX/3lCGKJe74bPX//hRdN+WgynDZek
         BvnA==
X-Gm-Message-State: AOAM533OMABQ9Or+c6U7awvIqxja0R/qf+8aX2nVK9BkKE/cxHn5s+kE
        acoYZhxaPTpuHE0TH/S8rjQ=
X-Google-Smtp-Source: ABdhPJwy0sVvTrNJCU/91mPdx1mvvw3ejgk0sGgkyj5PVcoOGX/Nl1dZHNYR2N6dTDKgmtwQhWWaUw==
X-Received: by 2002:a17:902:6903:b029:da:f458:798c with SMTP id j3-20020a1709026903b02900daf458798cmr8687962plk.68.1607392673070;
        Mon, 07 Dec 2020 17:57:53 -0800 (PST)
Received: from DESKTOP-8REGVGF.localdomain ([124.13.157.5])
        by smtp.gmail.com with ESMTPSA id gp17sm686030pjb.0.2020.12.07.17.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 17:57:52 -0800 (PST)
From:   Sieng Piaw Liew <liew.s.piaw@gmail.com>
Cc:     liew.s.piaw@gmail.com, Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: macronix: enable 4-bit BP support for MX25L6405D
Date:   Tue,  8 Dec 2020 09:57:30 +0800
Message-Id: <20201208015730.12351-1-liew.s.piaw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208011938.GB12175@DESKTOP-8REGVGF.localdomain>
References: <20201208011938.GB12175@DESKTOP-8REGVGF.localdomain>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable 4-bit Block Protect support for MX256405D and its variants using
the same ID.

Tested on Innacom W3400V6 router with MX25L6406E chip.
https://github.com/openwrt/openwrt/pull/3501

Signed-off-by: Sieng Piaw Liew <liew.s.piaw@gmail.com>
---
Changes in v2:
- Add SPI_NOR_HAS_LOCK which SPI_NOR_4BIT_BP required.

 drivers/mtd/spi-nor/macronix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 9203abaac229..033ede381673 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -42,7 +42,9 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
 	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
 	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.17.1

