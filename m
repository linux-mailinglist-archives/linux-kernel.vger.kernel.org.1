Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C492F4DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhAMOyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbhAMOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5BC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a6so1851568wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDDpX4Tq8YbOoBzLmaAPLoJ0FkV3kIft9xiJt5MwHsk=;
        b=P/TckwyC+Zpm96Xw3jhnQcTPN4yEDByRSGHhaDy4FTUtGMu06Iu1Lz1wyjqkxnYGD8
         Ka0UeFrgp+iGG7nEK9sOqDisiaFpLSK1hp1DISbHIQX8TDn4GphpHRUfABx50dTEboH0
         qeaFWlT7UN/Vu7aoSNXpYCaMFlK+DfSHuhMJjBshrb8gKl2yGkzp7JIUWGPZphFnEfly
         608DGRjP7K/CPR0c/OxOSedMrPcUuDd1OSXearvHBAU6PUJXtpFKR1uPWbedCfsb9D0l
         VZxN7mXIKLzNxEZYF8QgplqX7VbOWBfbEy/IEpStDEkkgxcfNRAH9CcHckNWX7BTHpf7
         EMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDDpX4Tq8YbOoBzLmaAPLoJ0FkV3kIft9xiJt5MwHsk=;
        b=MesXjzqU3UMcBBleaTIj4V2B1oU3HU83gVk3nzUm74ZMg8PO1lD65h81ztEL9TzUVw
         067S9N1lsA0ckCJtLVJIq2W9gzIENoSxvoxwk6bS5It975x9rqkcyqO7QxKkjfAftu3D
         qYfjp+ZT/yth7eQ8cMNiaYADF36ZDg6pfeTnJBswG66rBN9iwuwPWGX9h9hYPnbA35lN
         9NdZqu6CPZD7CzoqCsAB/EfypNtBjOdflZ0AxGP/SziPld+3yctE7SiZ0yaRuDrn3NBX
         dZzL4MUCZK0xMH3prahtl234cSP6Q6jlezhcATj5KE0fikBDrckFdbnNR4m1Ea/amUN3
         SMxA==
X-Gm-Message-State: AOAM531OkZx1SD1TTJPJu90v33h3v9SAfNF7bASBT+IjC40hQPNpz+It
        3Skukkh8sPRiJsfpjFDuMhir7RGRUqTm97TZ
X-Google-Smtp-Source: ABdhPJzYqXQr0JAQFjeee0qoDpAYIIkOJfbnlgTUbeOjt6+QKL+q1AvPdGMRRUWutIMa4sTg1X4bsA==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr2598878wme.30.1610549439832;
        Wed, 13 Jan 2021 06:50:39 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 17/31] video: fbdev: aty: radeon_monitor: Remove unused variable 'mon_types'
Date:   Wed, 13 Jan 2021 14:49:55 +0000
Message-Id: <20210113145009.1272040-18-lee.jones@linaro.org>
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

 drivers/video/fbdev/aty/radeon_monitor.c: In function ‘radeon_probe_screens’:
 drivers/video/fbdev/aty/radeon_monitor.c:491:8: warning: variable ‘mon_types’ set but not used [-Wunused-but-set-variable]

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/radeon_monitor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index 9966c58aa26cd..5ff01aa389381 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -488,12 +488,10 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
 #if defined(DEBUG) && defined(CONFIG_FB_RADEON_I2C)
 		{
 			u8 *EDIDs[4] = { NULL, NULL, NULL, NULL };
-			int mon_types[4] = {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
 			int i;
 
 			for (i = 0; i < 4; i++)
-				mon_types[i] = radeon_probe_i2c_connector(rinfo,
-									  i+1, &EDIDs[i]);
+				radeon_probe_i2c_connector(rinfo, i+1, &EDIDs[i]);
 		}
 #endif /* DEBUG */
 		/*
-- 
2.25.1

