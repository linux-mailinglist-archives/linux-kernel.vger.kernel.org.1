Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9B2D093B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgLGCr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLGCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:47:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4FC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 18:47:16 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e23so7649246pgk.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 18:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lUjtHUc+/RanEZLK6AwzwiyRY6nDEaJFoU8TjTaj7Vw=;
        b=r/EAKvlk4KcV0aPkG+j+X82hY3XfkftcAGtTkSC9c8jiCUbqn4PsY9xEwr9EzwBtGl
         b8v8XCgyaH6qyOPdRnys1bkOVGp8HTP5a6nfTV4JZM0tDaI9HAwS+9egM/RLxLz06AJc
         c5Io+pDvd8tJ5+Ke4Tj+MQITiK+yDQw3MIun3pG1EPWXJ5AViHV2LSmhdMVd2CWjKo2m
         cGBxob9huGEcTXHFBbxsPMlSEPan29kQeWlysrEXG2487KEknCTJLyZqdAJJ0nj3hoLl
         pI0dTsqWDdgGH6+Pkl2EiaPBBAv2kGhWw4EKOqESXvyGPL/I6nNOCiyjvO3+v2Mcq4pQ
         zYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUjtHUc+/RanEZLK6AwzwiyRY6nDEaJFoU8TjTaj7Vw=;
        b=YLyjv6aSSDLMC9L1Fcv9bIg+WGAvJSnCWe6DwFErJeEgeFFUr3Rq8+ZSmQ2TQsnzYr
         PZeVf8CbbuFZpxTdkzD30G1wJTFFx8AcMKbWJhMx/PvxjIxIdqQVvcx0vFvZy46U5Qd3
         GChHjnv7UnB6b+2NRhXsIYvKA1YlYsk8cwMk9WC11KNxQgX2+TQFml23aRT3kG6dHlu/
         iClQvcLNeKoFu65rdZYUo76K34zbPXQSHJGtRAlKaONvbJdaL0XLz1SHtqvZrkZUf6q6
         Js/b/N/9GjUyBtfolr7s/ItnrIMiIX0WcKFS/JciElcaT94wcznhyu6SLO+Z9A4+dcV9
         I8DQ==
X-Gm-Message-State: AOAM533BnD42W/QZLkDvFtmmLwSz0r74wSQhfBWuU+7D+k/XCwzIhh9J
        iBMmUOMRNHb+aOCuBrZXvnY=
X-Google-Smtp-Source: ABdhPJxbot3J20xUZBkWXQqicQ6Nxxr4DCxsmtzKWqwM0VBuqyA3iZLhF+EqEnbaSYUgkQchYWDFcw==
X-Received: by 2002:a63:f308:: with SMTP id l8mr17020520pgh.68.1607309235694;
        Sun, 06 Dec 2020 18:47:15 -0800 (PST)
Received: from DESKTOP-8REGVGF.localdomain ([115.164.208.235])
        by smtp.gmail.com with ESMTPSA id 5sm10328812pgm.57.2020.12.06.18.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 18:47:15 -0800 (PST)
From:   Sieng Piaw Liew <liew.s.piaw@gmail.com>
Cc:     liew.s.piaw@gmail.com, Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: macronix: enable 4-bit BP support for MX25L6405D
Date:   Mon,  7 Dec 2020 10:46:12 +0800
Message-Id: <20201207024612.1318-1-liew.s.piaw@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/mtd/spi-nor/macronix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 9203abaac229..7aa8b1ee9daa 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -42,7 +42,8 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
 	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_4BIT_BP) },
 	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
 	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.17.1

