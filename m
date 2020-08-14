Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966322446C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHNJFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgHNJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:05:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A445AC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so7305495wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Awajj0R47lm6sx57tIr1UrmZ8iRE0Zm6ScsJs7CwSFQ=;
        b=JXmQmEJMupkWHWGlNYPwlcrexoKuEmdGptmBbT5gBV/GOjX8tatJOc76QTr2x3v5HA
         TSdDeJmSJkwDeAkDKNFjlzClsETHNRLp0S/pDX7sypwGMN0tkX5MtrteI4dldDlanJSr
         pLHrUoKchuGY+mTV3SeYfSlPU4KRqPvz7oTP/6tr3LZqFEMsQmT+JA16tU6WkfMWFeEe
         pGM+cTQajkI5MSBfcdh/FLEO3m9jUuCgpFk1uh9aJbkt/iu+YHJ/98fAQ3Aya5gVqwMr
         ukR1Vy0mbrR9pgP82KZLcyiXPuRJ8pHoxHBEaa1X3g8IgMbjsWyKb6A3RVqj+502id0b
         m6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Awajj0R47lm6sx57tIr1UrmZ8iRE0Zm6ScsJs7CwSFQ=;
        b=Ea/nufDzvjF7FEBuqTbNYaP5Z3h0HTRtoUa5e6dxZb6+/Yv3ewjilOOs121uyLFxKs
         2ytKt6rYyabrRW+K2QvGLuy1HoefZ24Upx8tK5+nm8LMI5AHj2nyOvHXmynkD1LVRzzq
         qcDTykC44DYHM8O5niXj16Ruk7Vcl2kmdcoMWBcURB/havk2L7Ea+W+7e9FjLKvoSIqV
         eYpT/Eia/U7n57wNDH22qG6x+32IMQaNGXq6Pf3DDfdt3Gk+sqZDl8pI2AfAN4bAk7dl
         mlHc0M3YKBYcUk5aNMrDyGgXC935g+yBznXW2nE7INvCSI5TLEmvXedDvYDBlq9t54cF
         GkYQ==
X-Gm-Message-State: AOAM532g1pcTiwaUplqn8/jwzX2HQ8FkO/1Qpm1K2gczbijA7hcRzjVd
        uChbQTU46v/QJVsdF98BfMAlGWpexQrydg==
X-Google-Smtp-Source: ABdhPJxqi5bXP8Npuw6YVikeX86l73CGaSFxvFOB8f9irFOzcMaelqhYY2g9h8/LDa36mTZSvAYICg==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr1730642wmh.118.1597395936789;
        Fri, 14 Aug 2020 02:05:36 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id m14sm14046745wrx.76.2020.08.14.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:05:35 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/etnaviv: add pipe_select(..) helper
Date:   Fri, 14 Aug 2020 11:05:04 +0200
Message-Id: <20200814090512.151416-5-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded pixel pipe selection pattern with a function.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index b37459f022d7..bafdfe49c1d8 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -46,6 +46,14 @@ static u32 perf_reg_read(struct etnaviv_gpu *gpu,
 	return gpu_read(gpu, domain->profile_read);
 }
 
+static inline void pipe_select(struct etnaviv_gpu *gpu, u32 clock, unsigned pipe)
+{
+	clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
+	clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(pipe);
+
+	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+}
+
 static u32 pipe_perf_reg_read(struct etnaviv_gpu *gpu,
 	const struct etnaviv_pm_domain *domain,
 	const struct etnaviv_pm_signal *signal)
@@ -55,16 +63,12 @@ static u32 pipe_perf_reg_read(struct etnaviv_gpu *gpu,
 	unsigned i;
 
 	for (i = 0; i < gpu->identity.pixel_pipes; i++) {
-		clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
-		clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(i);
-		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+		pipe_select(gpu, clock, i);
 		value += perf_reg_read(gpu, domain, signal);
 	}
 
 	/* switch back to pixel pipe 0 to prevent GPU hang */
-	clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
-	clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(0);
-	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+	pipe_select(gpu, clock, 0);
 
 	return value;
 }
@@ -78,16 +82,12 @@ static u32 pipe_reg_read(struct etnaviv_gpu *gpu,
 	unsigned i;
 
 	for (i = 0; i < gpu->identity.pixel_pipes; i++) {
-		clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
-		clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(i);
-		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+		pipe_select(gpu, clock, i);
 		value += gpu_read(gpu, signal->data);
 	}
 
 	/* switch back to pixel pipe 0 to prevent GPU hang */
-	clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
-	clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(0);
-	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+	pipe_select(gpu, clock, 0);
 
 	return value;
 }
-- 
2.26.2

