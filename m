Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0487C2B0D25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKLTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgKLTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:00:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BDC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so7132642wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVcDG3IiNQEq4rpTJUM8b3mZR6jA74yvr8OWtv64epQ=;
        b=Y1OLNk/UJGCriJrFzTJyz/7mEB43UxZLzJz8hPJJs02oFqzKBJE0899W3d0AtzsB43
         GMkA5SjnvYXBpOkdpVgOqsywYS3E41ROtpGzJP3Lhtda/31ycYXjg/AvNc8eCFD+o8xn
         02aiZoaSxAOHPpz+uw3fQ7TpG0KwYt68Xj2IXLd1lBmEtMKeTpxzgdZHgy3idhQbe7x/
         Br/Wm4m7eyvRH3mh+xGUw+J3EjfSL36y2O1H26GQ6x2F1WtrGEjUe3or6rJZGYL4Wd6W
         3EfdycZCcsWf7uQwp2tA72EQUq6o8/bw+dgq4RoEeHmmEyJpnJE6elo797Oa9WJTgogr
         Wxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVcDG3IiNQEq4rpTJUM8b3mZR6jA74yvr8OWtv64epQ=;
        b=VZjAPW0lV1NV2HviLUq329m4B5urJGJ/XMGW3Ry7Pgg8oVB1W50MABTsL2NQjHNydZ
         e6cN7SweHNFghjkkg/ZfORiWc9jwjhw8oDcLp1Xb4fvJx0Ya4jK3YTLPLSceeS9T2EAr
         OzmJ7ZBD8N3NE4tt+x/oNNifNuT7LXZO2DrmgqGqr1e5GK57A2gjkzBLMTrKffqiayWu
         QRzcWv09l/kglgaBu0j5v6Vp5hCocPeYPQM4SNfS5STsiIR8znNXYxx7JNxA9LwTtO94
         SC3R7Ek/JaCmk3ilm9+7NZ0YlM7Vm0z2yBFUZYRx1/OzYWyUUmsSm3b77YTwzSC4W+gT
         dSIg==
X-Gm-Message-State: AOAM530hrBGP+B63LvIesQZRGXl2PocAb2YxnYr/1qTP2yUfjnb/LA7g
        80rskXvc5T5yB8XEZMetOF5Rww==
X-Google-Smtp-Source: ABdhPJxFv4jWUIh1wd651ZYopF50nq1JdswFNn22NA1B9EBp1HaArdAU1PnW00YXU3OzKtTCcHEQSQ==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr1108099wrt.312.1605207649222;
        Thu, 12 Nov 2020 11:00:49 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:00:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/30] drm/via/via_dma: Remove set but unused variable 'agp_base'
Date:   Thu, 12 Nov 2020 19:00:13 +0000
Message-Id: <20201112190039.2785914-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/via/via_dma.c: In function ‘via_cmdbuf_jump’:
 drivers/gpu/drm/via/via_dma.c:596:11: warning: variable ‘agp_base’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/via/via_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/via/via_dma.c b/drivers/gpu/drm/via/via_dma.c
index 1208445e341de..cd56ffa3df589 100644
--- a/drivers/gpu/drm/via/via_dma.c
+++ b/drivers/gpu/drm/via/via_dma.c
@@ -593,13 +593,11 @@ static inline void via_dummy_bitblt(drm_via_private_t *dev_priv)
 
 static void via_cmdbuf_jump(drm_via_private_t *dev_priv)
 {
-	uint32_t agp_base;
 	uint32_t pause_addr_lo, pause_addr_hi;
 	uint32_t jump_addr_lo, jump_addr_hi;
 	volatile uint32_t *last_pause_ptr;
 	uint32_t dma_low_save1, dma_low_save2;
 
-	agp_base = dev_priv->dma_offset + (uint32_t) dev_priv->agpAddr;
 	via_align_cmd(dev_priv, HC_HAGPBpID_JUMP, 0, &jump_addr_hi,
 		      &jump_addr_lo, 0);
 
-- 
2.25.1

