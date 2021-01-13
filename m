Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6335C2F45FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAMIKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbhAMIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:10:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA97C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m4so1056610wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qkAO/aGHo5CcrKre6xluwg8dEdIWKSiyZUvz4qO5fI=;
        b=fK1nyW2AuJAUc4P3U08Io3K5pslY3Qe+t7ZLNtrnVRB0J22NU2/CdxFP096XibmbmF
         TPgZ014z9pkUJeqBZgCb+LqDnEj1wZTKn1K9vsS8BP2fRvu8MqEADkgJC4iSAVRExKvH
         TFVcuQId+YR1/mySwfbskaUpIhXx5/dFTrDmiJpp7n2rpSnm+qhsWDAWEzZyiCmweMeU
         9CU49nydxJsRPbqrX5Fma0dooI88HQ/C5U6sM6XS3myuJla2FvTJxSYFijuSF4lPBFeO
         sK747r7kYb2EQ6Cj1yhQK99qglrQNrSY/svRrKZuJPG4KgceTPFb/EO2bpA2wMtsOfTY
         lDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qkAO/aGHo5CcrKre6xluwg8dEdIWKSiyZUvz4qO5fI=;
        b=Ew8SzCrp7DTxbg+WFpPk14pUbgeIq+tfoemqzfwlXsRTco4wUWmu4cso0cLhtDGFeL
         EkB0OE1Zfro/hPLkSI7R/CIFjhjgc5U7LX0WFZckIW5AHnIOMUjV3HSbgkEmTBYhgYDA
         tIDe5ylYtpvBj77gE/cqwFFpxAWEPFLUta/veR3w+LL8WDeoTs0GtG2/+VeFEtg4MAdm
         GcKa7bXsp7CSBny/0bFg9KzZlNEs3wUVx+PvE9qFWyR+pB0XESZHGCkxWomDXfTgElET
         CFjg91rxe1F1SkMtY5qfVWUc5Obmc/FsMyIRf4Utyv09jQc3cTSjX9A5buw1F+CFMIAn
         NwjQ==
X-Gm-Message-State: AOAM5303DcpuuXLeQaC0fa3DizxNhkxUU0fxrHwHVDn4gh+IU1qUGddK
        Ted5xWjbX2W6OThGqvU0kSywJQ==
X-Google-Smtp-Source: ABdhPJwm1hXgI8m72Rvsxy8t+CaS4V32+7aBrAamJKyyaKIMciFMNOVopmGGOLhsccFZBjF4t5GjWA==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1179688wrq.75.1610525311521;
        Wed, 13 Jan 2021 00:08:31 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 29/30] drm/nouveau/nv50_display: Remove superfluous prototype for local static functions
Date:   Wed, 13 Jan 2021 08:07:51 +0000
Message-Id: <20210113080752.1003793-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build error:

 drivers/gpu/drm/nouveau/dispnv50/disp.c:2530:1: error: conflicting types for ‘nv50_display_fini’
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:36:6: note: previous declaration of ‘nv50_display_fini’ was her
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:35:6: note: previous declaration of ‘nv50_display_init’ was here
 drivers/gpu/drm/nouveau/dispnv50/disp.c:2581:1: error: static declaration of ‘nv50_display_destroy’ follows non-static declaration
 In file included from drivers/gpu/drm/nouveau/dispnv50/disp.c:71:
 drivers/gpu/drm/nouveau/nv50_display.h:34:6: note: previous declaration of ‘nv50_display_destroy’ was here

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nv50_display.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nouveau/nv50_display.h
index fbd3b15583bc8..2421401d12636 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.h
+++ b/drivers/gpu/drm/nouveau/nv50_display.h
@@ -31,7 +31,4 @@
 #include "nouveau_reg.h"
 
 int  nv50_display_create(struct drm_device *);
-void nv50_display_destroy(struct drm_device *);
-int  nv50_display_init(struct drm_device *);
-void nv50_display_fini(struct drm_device *);
 #endif /* __NV50_DISPLAY_H__ */
-- 
2.25.1

