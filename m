Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E12EF8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbhAHUQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbhAHUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E5C06129C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d13so10096515wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/JKS4Z9qKDOKy5sO9nbCc5XSxxopAD1h4qHJfgSdqg=;
        b=wBSjRd6hUt3BDerrolAnKVhQ503TF7vDvG8dtbt/o8U9vNcsSGQEhFuSmNBOZGNp10
         PIzT2j7v23x8tNl3mkHGXOcF+GrbyDeTlpsSGDgKmSEcKYq0dab/m2KdmmOB57EVyCpI
         r/A8Jpxw89BpPtpwDjyN5aPAuMZ6s/KjgVgcsFPBXl9ioick3mKTDMbOEZOEwxasDz6g
         kl+0YEl+Xa46pYow7bex/TCbi1vZ4ecASb12ivzYiyc1CtI38PubzyDvHvhdXqR3IFIm
         7hlsKs/zBlnsTrpiIEgwVdlZk1DB0zjTg9F3/sQC5vQghrwIso0dr5KcEZBs+6wROCj1
         YPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/JKS4Z9qKDOKy5sO9nbCc5XSxxopAD1h4qHJfgSdqg=;
        b=gP6kIH04vZlhBe4YyFtdJevyrZhPIOF4aLbroGPMt5nhrVP8HQnQMslZS/B6AFFrc/
         vhcs1nER39kKjaT9F6/OFJnAvUoeW1jcA39cubDwdRlhhqp4CVfFa1FQxAJ6JuwG0JHe
         C+xrAipzmaytjjafVn2VM7wQxOyBfaD9rDc016/zUHbwq4XT2uuj5xy0Xa29xKROvD84
         8X3ST3KOCzeAwq1Jn+5y1IcJQG5UnR0Ktkj940UR2/okMovdZwoFIceTyIJmHYLbmUdl
         yadW3dwGNVOkVrmluWWx/zy0ERFQdd3KvmDDmunf2aBFT6RslG4C4m36E36Q46GVNyps
         gkdA==
X-Gm-Message-State: AOAM533hOJ2KUzd36+byjLherAym30X5B2knFOOXepTvEBrOBZ2F7AvS
        wEqr6estjQgXyajeC9RVsW2RLe0GFQ5wxEz7
X-Google-Smtp-Source: ABdhPJxbhB+24hC60aHyeAnKIacOXED/VpuqohB/XOtKWtR3SUXj9zKBQgJMyNVeGBh14t7z/3fisA==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr5306753wrn.296.1610136908812;
        Fri, 08 Jan 2021 12:15:08 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 03/40] drm/msm/dp/dp_display: Remove unused variable 'hpd'
Date:   Fri,  8 Jan 2021 20:14:20 +0000
Message-Id: <20210108201457.3078600-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/dp/dp_display.c: In function ‘dp_display_usbpd_attention_cb’:
 drivers/gpu/drm/msm/dp/dp_display.c:496:19: warning: variable ‘hpd’ set but not used [-Wunused-but-set-variable]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6e971d552911f..637a5585c2fd8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -493,7 +493,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 	int rc = 0;
 	u32 sink_request;
 	struct dp_display_private *dp;
-	struct dp_usbpd *hpd;
 
 	if (!dev) {
 		DRM_ERROR("invalid dev\n");
@@ -507,8 +506,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 		return -ENODEV;
 	}
 
-	hpd = dp->usbpd;
-
 	/* check for any test request issued by sink */
 	rc = dp_link_process_request(dp->link);
 	if (!rc) {
-- 
2.25.1

