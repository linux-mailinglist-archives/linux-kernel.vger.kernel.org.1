Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F62B4E06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgKPRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgKPRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A5C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so48598wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E894eMua3BcyVtBQpbTegYEGiTjlkwuli5uk69Q3IOw=;
        b=iE+GfQv7S+GSvLz2XqilNiYCnjVAF3dl0i1NdZt+LoSFIRELaZUc3+iVqUhwSYL0aL
         pjti1ADepOb4FJkdojySoQwMDaPrwh7j6aO88NbHuD+w84SjoGK0W2eUvbUHE5pG9eNr
         pViE4R8pwS1eyXthtq+uAS/Y9RT47NfD5j64F8teilBivL8FdqFk6gOihpy9n8yRTglP
         lisu3mYddSpY3XWHFLYoda6EU319ZkdjHtvRyPZaVUwaz1/TvNiXMv3VWuIHTWT9xLbf
         Rcelarr0lAeUtKHga5xymhwhANiCRxFrOKVXBl4V0qNoneN3zTpuk3fXRa9q4v3ewMbx
         bMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E894eMua3BcyVtBQpbTegYEGiTjlkwuli5uk69Q3IOw=;
        b=ixkGPrEkK5D56ksA4mWnUCBcNkuc7oW+bHJtxnHn17a8lq1ZMNIxFhMOhNXAh/Cglj
         B8G/o95UiV7LAgT01am1L58uK95OS4pVNC54vz/a5a5vDRnI54DFfbbSAmcf61N2GrjJ
         v3bVACUyb8vl/ss3l174tJLDZ0QlNlQ0ybM8W3U1Mv9xXt9n4SDuAvhBjT6l0dVDOJQK
         BuU9S9mFao7CdEyGqPHVxQw8WX++P23rXSxClOKdnB7SCs4rI964723pxWKOUB7fs1hv
         IJIU686tz0di72obG3LtK54+EoT3AwtrjgpTjHf+EXYZeXOeP2UeUkAY8asD/l1aWTlm
         WxVA==
X-Gm-Message-State: AOAM530OiT+mUp14xMNvCw3tDPzth8Nq7hOaf7u8w6wyLK5Y16T1fmpd
        kdjP8kQs/KANfZBL6hxE0jYQAQ==
X-Google-Smtp-Source: ABdhPJyAtdkZ7H/8C+uFfj6r311zF9vn30gnWin/fN7tzo1uOND51VmS8moUU4d/wdcd/nghzYnvaQ==
X-Received: by 2002:a1c:7202:: with SMTP id n2mr39184wmc.38.1605548489918;
        Mon, 16 Nov 2020 09:41:29 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:29 -0800 (PST)
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
Subject: [PATCH 08/42] drm/mediatek/mtk_disp_color: Fix formatting and provide missing member description
Date:   Mon, 16 Nov 2020 17:40:38 +0000
Message-Id: <20201116174112.1833368-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function parameter or member 'ddp_comp' not described in 'mtk_disp_color'
 drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function parameter or member 'crtc' not described in 'mtk_disp_color'
 drivers/gpu/drm/mediatek/mtk_disp_color.c:40: warning: Function parameter or member 'data' not described in 'mtk_disp_color'

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
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 3ae9c810845bb..a788ff95ed6e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -30,8 +30,9 @@ struct mtk_disp_color_data {
 
 /**
  * struct mtk_disp_color - DISP_COLOR driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
+ * @ddp_comp: structure containing type enum and hardware resources
+ * @crtc: associated crtc to report irq events to
+ * @data: platform colour driver data
  */
 struct mtk_disp_color {
 	struct mtk_ddp_comp			ddp_comp;
-- 
2.25.1

