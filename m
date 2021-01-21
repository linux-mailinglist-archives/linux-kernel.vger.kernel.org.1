Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1B2FE66C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbhAUJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbhAUJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:31:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10104C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:30:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u25so1601902lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYTQTGctY6S1LXDbmIRJbc/RDqzqKBBsuHcY8ZMIdUc=;
        b=sLCVHWEHfLYS9pPPq9DE2D8BejH9jVTdGvGSNLrJmTNRyU3qK1UL/Japti62xvvGj0
         5Avm/TzJJwNMsP4vXO7IV/YGMeSHD9Z5xJGQBeBQuSrdp7TnnzT0M3416WWZqaZZQAH7
         pMyzBaP2nAkLlEriW7saEyrCuTStELiPrDjhIfGKWLNA9woFhHoxvP0eV4t2ygjKioHC
         2ftGudcYLHB+8v7PkHzTJh/CmkPpa7WZMX6IwmSsmDH23CJw0QIFiUXrDTnATF4IZdrV
         lWjebkxkiH797+Gcw62ipaUya2lvYkL33MyynX4hOmHygRnVfu9QsWFY/r4pZmCRXS0I
         m9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYTQTGctY6S1LXDbmIRJbc/RDqzqKBBsuHcY8ZMIdUc=;
        b=nBHQcZsEqaUn05fNgNMHgWqoAbKKiGhADhZf5mmP4/MuxtwgJBA0ZiMZUzB8yYOvXv
         TjFOwUza9P1DiBx3Hto87eVn7TG5ajpS+hxu+FtxyZk8vkGnwvH6hiYSumWdG7WGSb6O
         3Uz3rXp9fJsLE/xyrsotJ+dohvg+Q2iUMkFzIowS6+skhaOvbo0NYU/SMox7tSPMWVs4
         0O1+uMAOU5SREuHCR92LZQsQS98FN7eJq24F+oGV8AtWg+PgjssGw77p8NpewL1TiEG3
         NXBfju9ryVdVSdxlWdh5Cz/SDxntlgMjRIojW3Q3mSQ6UDPzDbWZbPxMu0BnqdFeTuio
         n7Aw==
X-Gm-Message-State: AOAM531yvX4B7EX6MUOtrIEwVi2hPCT0DCIot6mnvdsP5jJFlYpFoUxr
        hC9rx9KAHsfC5/QTlo+SPfqKBA==
X-Google-Smtp-Source: ABdhPJynDDqyIV0XfpDSx/Xj31akdzM3u5qkT47IyttudRs27F0GRro4EljiWlPy9MCZdDQyzRbdLw==
X-Received: by 2002:a19:230d:: with SMTP id j13mr6173672lfj.378.1611221432616;
        Thu, 21 Jan 2021 01:30:32 -0800 (PST)
Received: from localhost.localdomain (128-72-179-68.broadband.corbina.ru. [128.72.179.68])
        by smtp.googlemail.com with ESMTPSA id z1sm304417lfc.303.2021.01.21.01.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:30:32 -0800 (PST)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Marciniak?= <sunwire@gmail.com>
Subject: [PATCH] w1: w1_therm: Fix conversion result for negative temperatures
Date:   Thu, 21 Jan 2021 12:30:21 +0300
Message-Id: <20210121093021.224764-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS18B20 device driver returns an incorrect value for negative temperatures
due to a missing sign-extension in w1_DS18B20_convert_temp().

Fix by using s16 temperature value when converting to int.

Fixes: 9ace0b4dab1c (w1: w1_therm: Add support for GXCAS GX20MH01 device.)
Reported-by: Paweł Marciniak <sunwire@gmail.com>
Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
---
 drivers/w1/slaves/w1_therm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 3712b1e6dc71..976eea28f268 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -667,28 +667,24 @@ static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
  */
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
-	int t;
-	u32 bv;
+	u16 bv;
+	s16 t;
+
+	/* Signed 16-bit value to unsigned, cpu order */
+	bv = le16_to_cpup((__le16 *)rom);
 
 	/* Config register bit R2 = 1 - GX20MH01 in 13 or 14 bit resolution mode */
 	if (rom[4] & 0x80) {
-		/* Signed 16-bit value to unsigned, cpu order */
-		bv = le16_to_cpup((__le16 *)rom);
-
 		/* Insert two temperature bits from config register */
 		/* Avoid arithmetic shift of signed value */
 		bv = (bv << 2) | (rom[4] & 3);
-
-		t = (int) sign_extend32(bv, 17); /* Degrees, lowest bit is 2^-6 */
-		return (t*1000)/64;  /* Millidegrees */
+		t = (s16) bv;	/* Degrees, lowest bit is 2^-6 */
+		return (int)t * 1000 / 64;	/* Sign-extend to int; millidegrees */
 	}
-
-	t = (int)le16_to_cpup((__le16 *)rom);
-	return t*1000/16;
+	t = (s16)bv;	/* Degrees, lowest bit is 2^-4 */
+	return (int)t * 1000 / 16;	/* Sign-extend to int; millidegrees */
 }
 
-
-
 /**
  * w1_DS18S20_convert_temp() - temperature computation for DS18S20
  * @rom: data read from device RAM (8 data bytes + 1 CRC byte)
-- 
2.25.1

