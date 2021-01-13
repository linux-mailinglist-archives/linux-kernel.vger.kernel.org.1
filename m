Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD562F4DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhAMOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbhAMOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1AC06138F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m4so2390175wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8LGsHawy1FykMfSNgFdlsHpkSijq6aQuT4rYUHFPB4=;
        b=vlfUbYCaI8nbSGsNOrvP4jNkRNNQft4Td7Q/qK7df3eMXHJiNDMJ7WqrL+lctbGzof
         irvEGx52lUUHqOlSxdne5KYtvcv637NvMYUh46CWn0hYxBYGrnYgpxsFeL+hxHB7aXZz
         nKEugO/vNXJaQpOyOYQD1cz7XxScABklnzNnXh+KI5q1rPET24SGQL0t9lgX19e+C7fR
         eFsxphGPTVhjYYo/VvE2TbVEkj/Dq8F69zcFARqN+rtlR6zQXNuUSLhFlkcsV/wpyhQh
         1eMd62z5eauJMxNi8y0gGmRjshelxQz5tkvi3VyP8GGcTFLF5ZpE7yXf3E7Hveu5aQgK
         93FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8LGsHawy1FykMfSNgFdlsHpkSijq6aQuT4rYUHFPB4=;
        b=VWmcglbTrkG+6eUUP9yMNWh9wVSqcON+97CxV8Bx2mAl5tmZ4Smwra3HsEJPP4mrO0
         5TiW6z5T1Gb3TSswFAtc43IQFHlmptpct2tGM0NTINVw1VkrfBrZjTbJCMdT0oo5HC6u
         UlO2JTybBUWT+7Enp64y0wTtl3CQ6Np6q64UNWgboe3C/5JmWs7xPgNRomoVCRm3narD
         6eG4NTFE/QkuGY2f/6cJUy5YG5nZePkCqynWc96+CX6/UC0Mi581JpxaWd14syibWG+A
         qJy1Gxgt6PAGRnnoa4+67/Lrv50azfssMB1H15a3d0M6m29Uic9JBTq69etAkLYdDD6o
         rRMw==
X-Gm-Message-State: AOAM531QuSwMce2Tv9oOUI5+gNb49yLe6CBziLZ+HXRx+IPFnxRqu7Dt
        uQ1txF4t5YSrpXkQTMk2IZkY8A==
X-Google-Smtp-Source: ABdhPJwDJgxU/PSj6fZ35ddRgyivt16zN5Q0Jj9wVZXocDRBHdXbn58OnsQtAexupAPNKExN9UaOeg==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr3188792wro.244.1610549441019;
        Wed, 13 Jan 2021 06:50:41 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>,
        Mike Rapoport <rppt@kernel.org>,
        Oliver Kropp <dok@directfb.org>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 18/31] video: fbdev: neofb: Remove unused variable 'CursorMem'
Date:   Wed, 13 Jan 2021 14:49:56 +0000
Message-Id: <20210113145009.1272040-19-lee.jones@linaro.org>
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

 drivers/video/fbdev/neofb.c: In function ‘neo_init_hw’:
 drivers/video/fbdev/neofb.c:1846:6: warning: variable ‘CursorMem’ set but not used [-Wunused-but-set-variable]

Cc: Evgeny Novikov <novikov@ispras.ru>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oliver Kropp <dok@directfb.org>
Cc: "Thomas J. Moore" <dark@mama.indstate.edu>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/neofb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 09a20d4ab35f2..bec199a34037e 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1843,7 +1843,6 @@ static int neo_init_hw(struct fb_info *info)
 	struct neofb_par *par = info->par;
 	int videoRam = 896;
 	int maxClock = 65000;
-	int CursorMem = 1024;
 	int CursorOff = 0x100;
 
 	DBG("neo_init_hw");
@@ -1895,26 +1894,22 @@ static int neo_init_hw(struct fb_info *info)
 	case FB_ACCEL_NEOMAGIC_NM2070:
 	case FB_ACCEL_NEOMAGIC_NM2090:
 	case FB_ACCEL_NEOMAGIC_NM2093:
-		CursorMem = 2048;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2097:
 	case FB_ACCEL_NEOMAGIC_NM2160:
-		CursorMem = 1024;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
 	case FB_ACCEL_NEOMAGIC_NM2230:
 	case FB_ACCEL_NEOMAGIC_NM2360:
 	case FB_ACCEL_NEOMAGIC_NM2380:
-		CursorMem = 1024;
 		CursorOff = 0x1000;
 
 		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	}
 /*
-	info->sprite.size = CursorMem;
 	info->sprite.scan_align = 1;
 	info->sprite.buf_align = 1;
 	info->sprite.flags = FB_PIXMAP_IO;
-- 
2.25.1

