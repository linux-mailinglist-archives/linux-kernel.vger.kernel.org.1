Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB582B0D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgKLTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgKLTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:50 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC963C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so7121875wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E894eMua3BcyVtBQpbTegYEGiTjlkwuli5uk69Q3IOw=;
        b=Kn2ivuqgAsK52Jio64tgCg5gEc3heO8c9beyz/bqFQbf5NkBPLY0+mhmwCJ6UNpA3P
         J4x/Rd3GXHQO/a/7YTp80S3ElfDEZFctAwN1fZKTPz8totTDUrGBrl8p88E9wBEhi+Vj
         2zmyC3n++XMwoLh/RL82lSqhrY7fWGLb6m98Nsc77uAzHP7z86dDHPaXrtRzpLI/SHXV
         fVu3eXDW/AUtoktCjuFoknQPCENGgeS9pTL1Nr/1cP8B8IeH4pRObv232EktleSaFXGo
         GYsnK3HMSXR5k+Gcc5sO0FRKxjZa7Lc2K5sSnN+o7DNgZBGnfLxH4JM1NTZ/nwQxlHgY
         2eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E894eMua3BcyVtBQpbTegYEGiTjlkwuli5uk69Q3IOw=;
        b=XnpTzQOxNw20YkLkIOZ1B/LgF7MCh2KyvobGkUHKcqcLZUDWZ+QgWu6PYMQW6WlrYl
         QgfN9daeiLY2Fsdz9fdhhMRnUEsw+mWaRdCdXbEAx571u6sSVxMDjFsxr8uVBaLf17sS
         kUCeueR5sujQi3tZXiDrFyTGNIw8NvB6SlhNYBhqxZgPAnI3Ojwf169rso+/OZYT83QQ
         Bke0kTn1Nm8vQHbeTiEYcYTQs90Jt3yiiyrfZKqRwIlZVo5W6rW7t+px05CYY8ga7WXJ
         v54SCRP6EiHNj6BmL+B2togvUOH3IsTdVi4yZpTf9e3JNmqTXMKy52Noa2imQRsOigFk
         ybLw==
X-Gm-Message-State: AOAM532zKkZUM7nvZOl+OoJ2Y3a1O6fJ06E9axyNgM9rAt8LhnC//rgq
        kS/tgl+S4bndZjSKSjl9K5lODA==
X-Google-Smtp-Source: ABdhPJyC+zO0DY5MHCIJ0bV9ffOxtDjtwGdlvt4SiEuyNxuXTQ+znllAJ+A8SlC5c9Z7ZtrMrG8zIg==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr1118692wru.216.1605207708584;
        Thu, 12 Nov 2020 11:01:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:47 -0800 (PST)
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
Subject: [PATCH 28/30] drm/mediatek/mtk_disp_color: Fix formatting and provide missing member description
Date:   Thu, 12 Nov 2020 19:00:37 +0000
Message-Id: <20201112190039.2785914-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
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

