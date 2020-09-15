Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7326A2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIOKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:06:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:06:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t16so2417517edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGES+GMaY9UbFbiZ3qdnVlJVdv/k3iehrDRv/+9sIW8=;
        b=2D4/nOv6XQ1abSLXeiLPf1ppV3vEgXLegfUhDjyPU6f9rkZUI6Zc0uZVhVbiuZXYsu
         tjWvAtuMvNEdeVQSnVjtTPWo5IkEyhhlhB7z9xZTRcYL1eo9QIqBvTRuTOa5MFKk7DOp
         aWZN5x2gSymrO688VHXUnbkEvwZRfKHP38kFSmky1l5G+Jw67zvVj/vBMy8lSdIvB4G9
         r4adVUvc0wM3nKGjVP+5JfSz+rvMwj1vl9FFg2lInns4RboBmOys9w7iw6GveofTEo79
         8B2C4LD+xcAj9NEzlEFyxXvapUI+Iy3fZYp15s1wFt4/AEWv2q0EZk5iPj75I8WYOqbn
         vopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGES+GMaY9UbFbiZ3qdnVlJVdv/k3iehrDRv/+9sIW8=;
        b=t7sagtZUDKjKWhaL+ZjTA6zqPcP8L/CY/O2OHbsENMOlzSnlHhX+vSS3H2+nO4YWi7
         Jmcmx3UCsrxmeCcUNgVTEKnNxmQVS6AjcbNJiZ7XgqVrlSzBWnFOVYMBEWwkE0e8nXn6
         AO7yxiklOMkuZ0lXXDb4VB/KcjGUnJYRpZnXpnl2orz1N1cYYuP687ubCQXaRneZYZ34
         vF7QSlVbnFvowzIw/vXn7K7+HtUZjoUFjGVJ/Ir+w8vaqDqs8HorF8i+/752gOv78/eA
         28eVezHSVrxcKIE53R+8fI9SpG3A7JWozitTKi+xkmgM5n7jwu0O2R42A8kd5EFGDkm3
         kb/A==
X-Gm-Message-State: AOAM531jENBtWYF7Z86oHrOigPgiNKCO82JJk66lGhUynmKFVIqQ2Df9
        GohUUn1lAZkM/NCpKejARY1JZA==
X-Google-Smtp-Source: ABdhPJy8A6ovoJZ+STs9AZCcBRWSF6zvWwyStMf9J+qIP+TpO/xvTFLH8WpxEGhamk0caBIkzTWjaQ==
X-Received: by 2002:a05:6402:1151:: with SMTP id g17mr21988047edw.227.1600164390299;
        Tue, 15 Sep 2020 03:06:30 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-22.xnet.hr. [88.207.97.22])
        by smtp.googlemail.com with ESMTPSA id z18sm9942300ejb.92.2020.09.15.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:06:29 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d
Date:   Tue, 15 Sep 2020 12:06:23 +0200
Message-Id: <20200915100623.708736-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the mx25l12805d datasheet it supports using 4K or 64K sectors.
So lets add the SECT_4K to enable 4K sector usage.

Datasheet: https://www.mxic.com.tw/Lists/Datasheet/Attachments/7321/MX25L12805D,%203V,%20128Mb,%20v1.2.pdf

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 drivers/mtd/spi-nor/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index f97f3d127575..9203abaac229 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -50,7 +50,7 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
 	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
 	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
-	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
+	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, SECT_4K) },
 	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
 	{ "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.26.2

