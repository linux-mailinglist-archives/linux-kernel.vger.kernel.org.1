Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D62B384E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKOTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:09:26 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A32C0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:09:24 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so10728602pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ujoTivO0ZJwnK7oE4zr4LTdLFw3eF11FNlG4Lc9FRsU=;
        b=XWLUDuNm8sfMSQBx8Enb+OoisiNDWBe07iLBLHlunasah8Io6+jQNEsuxgE+PtnKx4
         XqaU7laR5LoxtFtw7ag3j6BCe9oFpj9m3WmmdUAX1B/HHlR7iXpSuJfatS6MpL6RXNgx
         N/P/i6HZjclYqfStZGqLhcqd19JTpN11lXTNbAc7StqZSvgeh9uvlHjYD3AFPf4HZZLZ
         2VMIiZhIZ5b85C/nHvBcHU+bdvDWAGLm354y20GnbG9pMeIx4Gnhy8ETnPyedQ/YX4gx
         UjdbeUEJL2OhUFIVsAHnUKJDv4U4hVTYVHN/FCVzzWpJ8lG4jRa9nLrSDEpkO/Rm83rr
         uUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ujoTivO0ZJwnK7oE4zr4LTdLFw3eF11FNlG4Lc9FRsU=;
        b=lTbwgFOTwyr99Ew3OXAC8EGurJZHGgvIJnnwKTYugzpGvno0hVtZWMESZDT4BrhuJo
         H0gHdXl2YEk+6nCmvNVLhoSblh6pbyh/DkFXHVSkUwVQ2wTdI+SnisDINC88KqQl6sVj
         0mPLjsQjYc32KGTtFK2lXEW5l4KJZpvFPexSZyk3+4ywT5yfRZAwOPsRugN/XLo5aX04
         ZiwGdOv5lfIXTZVJrz279w8JBqVyUHT8d1+nqum1TGeto/NMhd01UxMxPBJHoYaagv0d
         HYvAvBq7gtkIavYHWc3S4ZBioh7v2DXFYJHQxT4qYKCnnYQWuXKARLM3WATgZ/xsiSL/
         hrYQ==
X-Gm-Message-State: AOAM531u5kAnH0CndifIPZ8MvxjWbac2vUZZwyUP5/Z8WGnoFMODXH1t
        IBppbqtvrnyOUgdUW4eOuix2Gw==
X-Google-Smtp-Source: ABdhPJzDpvDDoDeAQtR4qPQ1yu0uEmuzbFEazgM7zReICe9a0mIboMZnlkDXc4LXEvKg8T2k0AqWzg==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr12536790pjk.36.1605467364349;
        Sun, 15 Nov 2020 11:09:24 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id gk22sm15616211pjb.39.2020.11.15.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:09:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] hwmon: drivetemp: fix typo temperatire => temperature
Date:   Sun, 15 Nov 2020 19:09:10 +0000
Message-Id: <20201115190910.12539-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a trivial typo temperatire => temperature.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/hwmon/drivetemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 72c760373957..1eb37106a220 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -10,7 +10,7 @@
  *    hwmon: Driver for SCSI/ATA temperature sensors
  *    by Constantin Baranov <const@mimas.ru>, submitted September 2009
  *
- * This drive supports reporting the temperatire of SATA drives. It can be
+ * This drive supports reporting the temperature of SATA drives. It can be
  * easily extended to report the temperature of SCSI drives.
  *
  * The primary means to read drive temperatures and temperature limits
-- 
2.26.2

