Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3F2AC6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgKIVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgKIVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:20 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31AAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so911326wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNbwgos7EBbAiIS/whVqYV59kF6ty8MKTbhrWe3Hj/4=;
        b=vDRSOmaOWfnFuTXwEONPBcO8vJz7zF39LmqlgHPib6OIXViysSis7axMfLToI6uzcL
         fflPl+k/7ZFLIGyyXOLQ3TiIrfwGxSkGA9MmRO2uUcGtCt0kGjl+uBPJRp3aPomVX1BF
         EsHIQZXRDK9Vnv4zD/sgKAUuLnYw0kUHMXsav4ieFfUvp3ZnOj++Jot2LssQVDnBcsPx
         39lCcPvgMs9bMyUsvFNk7r5g109XNQaut2J9n314ZUar9st0RyOSYygednECLaUvqshj
         UwCOwCaWkMWuHpYepBA4xCTKSRCE/Z6mWJww+6Zuk694xH4pxg0gQXodu1LbNfYithWA
         sLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNbwgos7EBbAiIS/whVqYV59kF6ty8MKTbhrWe3Hj/4=;
        b=t96bJtkpGlfSxTBTUXBuIeEkpkkWPd8ryETCjJdXa28wyzaCOohguQxlVcf+guA5mc
         z7A+n/d7T/TeMSZxk9QexKLCJcWElZETtARXqhmhkusA1ELIKMqcAjbbHRY7znoz1kZX
         izGcUjFIJP4VKG0zQQtPcV9ktJ+yGn4XpxiMNz/nuKuUv877Gm5eXGenVpqxlhiyp6c9
         oqF252++7+xg4plb2HLqomPTkagr/GDfzI6bLg4Df+Dg42zlU/G8gtUNfjKvel3nOW6i
         xHsGXTMoTkzWRsLftS01VohW9bNFTq3jaqPA1M4HI9KzbP5DORkwpPV6l9PbNtWBNXwe
         S8zw==
X-Gm-Message-State: AOAM530ET3oB4oOBQzFbNjYF5sfwlWUfgH9I210BqNTIg/Cg81/i6skA
        6eVTG1tgSlktlD9z/VBNO3Nb2g==
X-Google-Smtp-Source: ABdhPJwXSIdyefVkSvwIj9A5z6/yqfw7C2R6xM1Kyh7ySdKYokfnHteeebzlBmPFWZibPYCJ4/B5lg==
X-Received: by 2002:a1c:9950:: with SMTP id b77mr1103869wme.123.1604956758642;
        Mon, 09 Nov 2020 13:19:18 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/20] drm/radeon/radeon_connectors: Strip out set but unused variable 'ret'
Date:   Mon,  9 Nov 2020 21:18:41 +0000
Message-Id: <20201109211855.3340030-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_connectors.c: In function ‘radeon_setup_mst_connector’:
 drivers/gpu/drm/radeon/radeon_connectors.c:2574:7: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index e308344344425..607ad5620bd99 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -2571,13 +2571,11 @@ void radeon_setup_mst_connector(struct drm_device *dev)
 		return;
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		int ret;
-
 		radeon_connector = to_radeon_connector(connector);
 
 		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
 			continue;
 
-		ret = radeon_dp_mst_init(radeon_connector);
+		radeon_dp_mst_init(radeon_connector);
 	}
 }
-- 
2.25.1

