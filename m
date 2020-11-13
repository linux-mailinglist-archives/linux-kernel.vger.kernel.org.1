Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723712B1C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKMNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKMNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86DC061A4A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so9986890wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCTuXmjwQai/CDFPUzQ3kg8YDOVHQv+4DVCFDqYGwk4=;
        b=sDMRPQswWGSH++5S2Loy2vzVU6PKTlMKGyiB2LA3prnW76xMrNwZA0nmexJsaEobkL
         38w/XO7PKggGRLVdb2wtak4X17JNVk35qD6R3pbK0i8q6LyutT3Iou5Y94lsl1k4blLz
         p2xkf3ETUNYs6hssfPEjjPlm89LkhETsVduJvbmkM3oEMJrW5ApTPE2MkFqTfGAQ5U5R
         w7ZuvayjNoZuO5u87vJsYPZsZ0HoKo43J0Vty3iLo3fpfA8NBAVzw4EFGH1TJZbsHJnA
         tvdmSrzbQTEsCnu2Izn1p6tYQRXU5QZq3hdTi8ApEpzNiZ6yyhAX2cc6OmgfC51eg6y8
         0meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCTuXmjwQai/CDFPUzQ3kg8YDOVHQv+4DVCFDqYGwk4=;
        b=C9VQfMqOQQRtIUHnIxqQYWPjRWlZoURuRlz49yCqyC1dbgdbBC48Wb4QJEtRt+cFeS
         /7LmSwJ1FaU5pHUi3pLNCSubjNcyBUtUhdA8SIkb5LB1ObgdVlW9BKLSV2Lc8JipDVio
         QEfeto4pH444N6e52I/g3kWlbx/3JvegCj1Gr7bEmC6Bu8yK5gIRo8TDBfE6u7F+UwB3
         C/P6mHftWk1NfF1xeW6hYT7s6d/hJds9RA0WD3X7mrzBM4pGrrADugA9u7usP0t+C/Z5
         ip9AaP3bUch+kRcK5DuS32p1qABmt7xxnYBbMcO6o3PaM/visppBIrlBI3AwEz9OVX6q
         XTKQ==
X-Gm-Message-State: AOAM530avt2HdKllgdW6L7YhMdGFe5m7JOcFB0Yv4nSyDouQNnhEf09d
        mJnZeNJsUeAMNtLIiOXGDk3i9g==
X-Google-Smtp-Source: ABdhPJwC5dZ17zovLWTwBFMnjLJ/S6DTsonz5wBvHLFm45TRGQA1LxJ9EXZzT2BBh6sywylyM2FixA==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr3461026wrv.46.1605275393304;
        Fri, 13 Nov 2020 05:49:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/40] drm/mediatek/mtk_drm_crtc: Demote seriously out-of-date struct header
Date:   Fri, 13 Nov 2020 13:49:07 +0000
Message-Id: <20201113134938.4004947-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs someone with in-depth knowledge of the driver to complete.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'pending_needs_vblank' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'event' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'layer_nr' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'pending_async_planes' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'cmdq_client' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'cmdq_event' not described in 'mtk_drm_crtc'
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c:62: warning: Function parameter or member 'hw_lock' not described in 'mtk_drm_crtc'

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 193848fd75154..bfe9942305435 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -24,7 +24,7 @@
 #include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
 
-/**
+/*
  * struct mtk_drm_crtc - MediaTek specific crtc structure.
  * @base: crtc object.
  * @enabled: records whether crtc_enable succeeded
@@ -34,6 +34,8 @@
  * @mutex: handle to one of the ten disp_mutex streams
  * @ddp_comp_nr: number of components in ddp_comp
  * @ddp_comp: array of pointers the mtk_ddp_comp structures used by this crtc
+ *
+ * TODO: Needs update: this header is missing a bunch of member descriptions.
  */
 struct mtk_drm_crtc {
 	struct drm_crtc			base;
-- 
2.25.1

