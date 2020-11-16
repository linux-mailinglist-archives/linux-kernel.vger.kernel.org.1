Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E392B4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgKPRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbgKPRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:36 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so43928wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCTuXmjwQai/CDFPUzQ3kg8YDOVHQv+4DVCFDqYGwk4=;
        b=gfFikjbNe9YkvOd+VXcfbf0J4Wd2441zhnFbQBUFTSfGl/11fLgrzMNsROSrDNKZnB
         56O56aOR/HmR02tQ/3tiNJAhdUCmKv3PyRLNB0tFPnqebgucJjargzJMwuSJqsg4qUDz
         lUADz1TsIKFAEDWw/i6YYk8HVxvDJqeRjFeh11I8P7jIVCANAQ8XqJPeo2AmjbptibFD
         3BUaOo+e/x2FHDxxqyNUMx1CFmyFSNvfDMIXzxiO4enNnSLj6DwZyaW/AX6d3z+XhZkM
         Hol8SB/aqA0USEkFwB5UEN9vO92vFQ3LpEYj0SMeSchExJmGtxQjQooiNX6+MTrjskNO
         qkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCTuXmjwQai/CDFPUzQ3kg8YDOVHQv+4DVCFDqYGwk4=;
        b=DK5uLE12aBvgKr1jw65/CtWP04xQ60MDDdmJmR+klmpE+YSZYYbDRaQjXWP1h52QiX
         VU/vd4T6lyMO4Yo1zM16HdURX35yQghAK7t7ZwXNuHlk+plVaUi1y0lkS0xbHHReHNpe
         ydd2FZ5/fp9rLv3Rx32kib/8jS9W/GNKEtxmlYp0BAxaQ/FQ4hmTsPoSyesabALgpWx7
         HlVl/Qd8GUJcwf2h87QDSqgRMSS4l5SIc96RKsStwOEy/aKGefftvBa5aG3IoAlP0Zwh
         IpLNzmnbuPXuIc+upm7MsrNJq9ladUFf2DKIjfZvRbPkC91V3U8qeyEVPrbtAAE69CDo
         oO/g==
X-Gm-Message-State: AOAM5328+qi6yNpjYvUf3O8+n8dLJBvdUqMQOGHjXqbUmfc5bMPkCah1
        vkiqTMRB7gOJwOZuhW5tITRa0Q==
X-Google-Smtp-Source: ABdhPJwrqzcWWtyPydLaEIxmPE66hOyh5iCvJ3dX8GBSzMZleXIeT0J7SjvsguKoHdDSGAfq4DLbJQ==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr48224wme.8.1605548494375;
        Mon, 16 Nov 2020 09:41:34 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:33 -0800 (PST)
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
Subject: [PATCH 11/42] drm/mediatek/mtk_drm_crtc: Demote seriously out-of-date struct header
Date:   Mon, 16 Nov 2020 17:40:41 +0000
Message-Id: <20201116174112.1833368-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

