Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBA3012D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAWDrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbhAWDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:46:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6945C061222
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m5so5081674pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR8YQMKfgP2HW7WhNJdeAV7/ctNsHW3A/OLYCiFLrok=;
        b=b639/5WXIPJKT58P9xeSP1JaicOfVaw68rgoB6ixWuLWuRnjv1R9nhdQmvtIQhf5uv
         sb8QrtLVBCaVNE/ke2X86B8/akvUSiqo5kNEP1p92wvub6eoMEDRgD6O2KGV/aAHj90A
         MBRtkikOQMmUqYogC9xlA1SIGLpgORIJq6e30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR8YQMKfgP2HW7WhNJdeAV7/ctNsHW3A/OLYCiFLrok=;
        b=oB245lUOrOoRheHzDXHINjTzi/RHCXXRJs+HnrRu6TSXwlJfE6Ns2DPUZbhR8ccrOB
         9j5iq4ZCFSi17p9ffn62l7YrcHfWMU3F5Uf0K1gq1eQZdJlUYs38mS63QEfs5zQFrVO9
         ji4aL8PAt6eLb3Nb9C3CuRTpfGgwod6QF1GU70ogWx7krssdZFlpm6BWYvGFFjqRWjc9
         MB5d35qn0uIosFdQsnmq1qfSIoPxRHjUeeGMjEyBvd9DaIAswrydAxwuX+7ZGjR+VK+p
         RAYi5q3Kcy6EZ+9/LjoDX5XHzIxLgep16a1l52DS7F0pBWWIZ4XoDv/oyT7p49RPeT1w
         3Ovg==
X-Gm-Message-State: AOAM530gA4tfYRfx3wzn6mH+h+/OHJmGA4XggVkZdqej7ZliNiZcYXjH
        +8ABoBBdHS3tdbOpq7+4LsCuyw==
X-Google-Smtp-Source: ABdhPJxjpyrtoHQKuXYDd99QrdPxjgxKSzYNJ0kZP6Q5tAl++sVk8vA/tI1Q8vi4PiUjKULQZ/QwNQ==
X-Received: by 2002:a17:90a:5d13:: with SMTP id s19mr3332843pji.110.1611373479572;
        Fri, 22 Jan 2021 19:44:39 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gf23sm10480343pjb.42.2021.01.22.19.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:44:39 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2 5/6] hwmon: (lm70) Avoid undefined reference to match table
Date:   Fri, 22 Jan 2021 19:44:27 -0800
Message-Id: <20210123034428.2841052-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123034428.2841052-1-swboyd@chromium.org>
References: <20210123034428.2841052-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to remove of_match_ptr() from the definition of
of_match_device() when CONFIG_OF=n. This way we can always be certain
that of_match_device() acts the same when CONFIG_OF is set and when it
isn't. Add of_match_ptr() here so that this doesn't break when that
change is made to the of_match_device() API.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-hwmon@vger.kernel.org>
---

Please ack so Rob can apply.

 drivers/hwmon/lm70.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index ae2b84263a44..e3153ae80634 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -178,7 +178,7 @@ static int lm70_probe(struct spi_device *spi)
 	struct lm70 *p_lm70;
 	int chip;
 
-	of_match = of_match_device(lm70_of_ids, &spi->dev);
+	of_match = of_match_device(of_match_ptr(lm70_of_ids), &spi->dev);
 	if (of_match)
 		chip = (int)(uintptr_t)of_match->data;
 	else {
-- 
https://chromeos.dev

