Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2A2B0D50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKLTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgKLTBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA7C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so6759169wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lV20qvkcXuKJ/8kdoQy2xSMx6pSot2KZYylCMdc97vk=;
        b=FLer8tlTJpW9/03wMweKDBS55avbIBPNMLVtPNnoxD4MVGnFei7f6YAUPIu9J2n2Gg
         +Pdyq75fTNEUeCBTcdXceFn0HzcUeXJxghFUDF6I7M4qx6yCAdYvds2tB5Np4BBOv2cI
         t8jYVNyEU0qnCvxYIhyWwRsHymc31CJa6rbyWGWmd4psXhR2pAvKq9sYOjLn5yYqxv0Q
         IdoP1C1LJvHsCcTkD6WmAjsOOSxxFTPTxeo627RMfQDiMpAu/4GwmOBwcNLcpStOKMqY
         Hwtv55Vxa1wzZdsOhTxilW8KPfa0IwU7MpU2MuMucnSHkdEn5I0AxGoJ+GAbffpCBMJI
         tpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lV20qvkcXuKJ/8kdoQy2xSMx6pSot2KZYylCMdc97vk=;
        b=DikFDZfXS4+trf8MlKAUXtBDS7r0MawxgDVkPqWgVuVaPShgWfFzKek0PCIdkoXWTR
         ogtraJQOI8lNw9MNX9azJCKju/ORa3hmgKmHYuId155s+2ZzLh/Nvh7aeQMqVOW1hVZM
         Y1jxcW68AvVD+9mzEIHB95VUesuTfy3IZx/8SxPThrltR3fMNPUmU8QzGM/6InmcXw+l
         WL7xcTP90LO64v+KaNVagHmqfJiDMslUEuUv8mTdwY6abthez1GRdGALBCDZxegczwqV
         UTvRHTc4ABE/OBcIKUNPa2irKoLoF3jZIfCDm6kHIkumkLu3O5IhqFNkLRHEZ/ymqgZF
         cxIQ==
X-Gm-Message-State: AOAM531bLIglTwT8+uRELSJY8hsfQskYpL+eeLemsLvkDX5bTrjWOcmB
        o81Qp749GYHD+CumOSgR/lIBLw==
X-Google-Smtp-Source: ABdhPJyAsIo5Mm2tjgv7zGGnj0raCm6z8NlmoYajDaNb+hIDZ+v4dJAu7qWeEXrYmi1tid6oDwkBWg==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr1029949wmg.81.1605207711389;
        Thu, 12 Nov 2020 11:01:51 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:50 -0800 (PST)
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
Subject: [PATCH 30/30] drm/mediatek/mtk_disp_ovl: Fix formatting and provide missing member description
Date:   Thu, 12 Nov 2020 19:00:39 +0000
Message-Id: <20201112190039.2785914-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter or member 'ddp_comp' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter or member 'crtc' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter or member 'data' not described in 'mtk_disp_ovl'

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
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 28651bc579bc9..74ef6fc0528b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -65,8 +65,9 @@ struct mtk_disp_ovl_data {
 
 /**
  * struct mtk_disp_ovl - DISP_OVL driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report vblank events to
+ * @ddp_comp: structure containing type enum and hardware resources
+ * @crtc: associated crtc to report vblank events to
+ * @data: platform data
  */
 struct mtk_disp_ovl {
 	struct mtk_ddp_comp		ddp_comp;
-- 
2.25.1

