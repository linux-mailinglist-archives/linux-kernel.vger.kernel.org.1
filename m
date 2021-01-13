Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F82F4DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhAMOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbhAMOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3DC061357
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m4so2390742wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx+Lvpr+opVztxwCrpEEue+3ZpAhdFGYil/Lm2hEOBU=;
        b=ClTWBKea4vm3y9ZVGUdkzqdOECtwhR9PudkWuiyjwsis41BqC493w/zvDp2ojr1Xuc
         ZKnKrxsByJZR0AsZRzPwnncxKrIpJo8q/JxnXgt5uVjgHffxSyJ/m/GiYYZFr0k/fKPF
         mAUTMzojahcDs+ltW3aBgJgY0pUiUSDu1uCQsHcM5514XCdauiHH8Frr9ruELCw0BD/E
         FTVVet0fiPEihuRkcU9+1jE680PoB0pOR4Fx8MdQ56p1l1lAxW4F53kcOf3dMgFbW0wD
         nLFBJyF35Zz+nr0o3nFYMPOFbn8EmarY0vsbpWCUmYqEvxpBpYIoiNLTuo7DHxfJGp22
         4RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx+Lvpr+opVztxwCrpEEue+3ZpAhdFGYil/Lm2hEOBU=;
        b=q6oxLBf0aDLQ6m2vpmQpn4he23YCAIYIIKM8s+caZhXP8lvGS/hF51yiBp6GU+GsBA
         wqPUJRO1ZT7fYpVST5VStJ0eKVlntHIVq6GxCMW9IoHvgTtrS9iI9KlfRrbHz8IWARcZ
         px0ptDSJN0dIH9s/J1ihltgFI7uXqAHZ6fO736vjiTuwKKrcIWkaDFYFY9EBBAkxJcgu
         9ThB81PgmbaM9j/3p0p6fcMg4oJB4opG3xX5r3O+L8creW2B2jwJIuu5Q7VWB1OhdBw4
         QnenI8HkTpR9dJNj2I4ky57dObGWruHG37Yeq8ACoDxtHxE8dkKrXwoQa9FYurOwK4Qb
         eAhg==
X-Gm-Message-State: AOAM530TlAaA5EjQa00AHrBg5O3Q0Smpn4HaosD3AGUPxrQ155x3c06u
        MCus2C7c0E4pQxShNHKqlvSPja0QWwPvP40a
X-Google-Smtp-Source: ABdhPJy85VePePA0CqsKm5siGrKpak6OmOYMGqGLRupA7S/S8zgvi5kBWxRpHIlYj831TLmAru4Taw==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr3094653wrw.247.1610549449265;
        Wed, 13 Jan 2021 06:50:49 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Software Engineering <lg@denx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 25/31] video: fbdev: mx3fb: Remove unused variable 'enabled'
Date:   Wed, 13 Jan 2021 14:50:03 +0000
Message-Id: <20210113145009.1272040-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/mx3fb.c: In function ‘sdc_disable_channel’:
 drivers/video/fbdev/mx3fb.c:448:11: warning: variable ‘enabled’ set but not used [-Wunused-but-set-variable]

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Software Engineering <lg@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/mx3fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 894617ddabcb6..d1c8f7a969ac3 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -445,7 +445,6 @@ static void sdc_enable_channel(struct mx3fb_info *mx3_fbi)
 static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 {
 	struct mx3fb_data *mx3fb = mx3_fbi->mx3fb;
-	uint32_t enabled;
 	unsigned long flags;
 
 	if (mx3_fbi->txd == NULL)
@@ -453,7 +452,7 @@ static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 
 	spin_lock_irqsave(&mx3fb->lock, flags);
 
-	enabled = sdc_fb_uninit(mx3_fbi);
+	sdc_fb_uninit(mx3_fbi);
 
 	spin_unlock_irqrestore(&mx3fb->lock, flags);
 
-- 
2.25.1

