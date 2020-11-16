Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D522B4E07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgKPRlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgKPRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE0C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so60883wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lV20qvkcXuKJ/8kdoQy2xSMx6pSot2KZYylCMdc97vk=;
        b=Zrf2ywI6nk+V0LerSSoBh85knKxg9wJ+fPH0SnSGqaqQ12rxleOIn+iiCOD32LvrWe
         Bkf/Wb6oGiBXh81lSfbbUzMj46qGlT4x4+1uL52OqwD66udoi+19y2OiHokqejefMpki
         LmeWQ+MHrkhBMuJk+MdgLyk7MESyvv31arSx0QUkqSIS1x66KRZp1d4y24TPZMNm83lQ
         Z/8XQ6zO07K0BXmGzG4J9egEP+HIctkyoaLLrtPIWFXQNAkfouPKrKFL3r8kdJz9S87x
         0LJf4EPdEEJ9lt64nU1UXv2v/MlEJ25+E2sOtvy96/QpqSBFGgfC2NTk1OGeGMfirb+6
         SY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lV20qvkcXuKJ/8kdoQy2xSMx6pSot2KZYylCMdc97vk=;
        b=lSu9B7er0j1nUP8rHtL7bC4jW/sYL/7HmPRt1s2Ta3//KRjaKzLbHmJaBAUVBtLspb
         1qTFXx63w8/XUJBOp9PNyGeVqs7nOC4XbPbi+tNrn4K5wSHe+caiuJB5Ap/PicwmzpTk
         CaQzpEu41v2TWsmpmaRb2oyODX2dxEq3u3eMEUWOa7DjQBGCoLi7+VoROaIMffAuQqrV
         HHCEqxMPrbNJ5wunn7JXudyXL0ZDqW80ztV5H9bQ6Rii2QTfC67seZ7+xvqn/iBh7WqJ
         PK43pzH6B7WQRIJO34rMW0QMhro67UX1ge12guxcdQY7XkAUkRQAG6BmrAAlCgGkr0xp
         125g==
X-Gm-Message-State: AOAM530euyBiLBzthNNloiG3jwHYmfKqwqKELeyvUCYQWoWzSh6uKDmi
        b45UDmzOzj5zVdhVZnygzMfE/A==
X-Google-Smtp-Source: ABdhPJxIdXRERwdbm0KN6pgN4q/8GjFcbWLDvydipEOB1BxVtliCNpiCbiQUfPa+193dGkiQ5Fu86A==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr7692wmb.1.1605548491414;
        Mon, 16 Nov 2020 09:41:31 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:30 -0800 (PST)
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
Subject: [PATCH 09/42] drm/mediatek/mtk_disp_ovl: Fix formatting and provide missing member description
Date:   Mon, 16 Nov 2020 17:40:39 +0000
Message-Id: <20201116174112.1833368-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

