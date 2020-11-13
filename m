Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D12B1CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgKMNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41570C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so9999830wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlKk1bN1CES0mgH+wUmCXkMlZA1CVtbOfxEG6y0GM50=;
        b=OcVFHvgowhYl0ECvQLfpLorqw2RlulROMnX4KA0JdKlQSLv9mVUpHCZi3/3LowHNyd
         pPbib+JUF/TZx8WcxyO/ewyRBfjMIKS3UtXxxiapN+aLc3DL3tKjsK1RstnLzU6A7OOu
         raaPYzUHAk9pQHEX8DdhINPQHyXgCWD+EGqFlUaImR9oRRNSCrg3RwlpBO1rA8gRThur
         5ufXOxBBG3r/CwQgQ17S2gixxqvFYvcJhY5owIsbOAQnLy+muaiTQpOZiviP7ChJaRsR
         WQ+DcU7lcgVDScBOZS3SuTdJr7c9G5qztri+ctAZ9PmmnfGvXcyuvz22sG4Ynfu8k5ZR
         rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlKk1bN1CES0mgH+wUmCXkMlZA1CVtbOfxEG6y0GM50=;
        b=U9Zzsm76F+zzo6m/1sB0MwKm8QDiBiCvNRH6MYl+rfws/4x2V5vqmQJsv4ZynFS7X4
         lZeA/8mFX0VelFNzN6It06YiXIotA1ZO7+VwZyQMOkQ+Qhzu0gnIqD/BFy7GGTDcJuhi
         4yuxx3D7HPHbEilsmoqHpH+YHwOmF4orxIvcpvg4c8nRwmJqmmzMGyjKQ0DMy6eke9rB
         usjg3+jTOsbjlJOVnAjefmWH2i4y+smh7yoUY3QRYgLuipZQCgPlknW9RolS+KyeYHXX
         s1OVen90Jy3PJXjX46JtoS3bbS1K1LYIWzZgmX2FoV2t9m5Z7nyq78/Z35HiiqHrXo4x
         vQ9A==
X-Gm-Message-State: AOAM530fmenQ0oiWBxOsTmLlCg+zA4oXJqDELxs+Xufky3Se70tBD5A1
        DsOLFOltGtTnKTy400mokweaCgz8+6sXySRz
X-Google-Smtp-Source: ABdhPJyXHSTj58kWv9AHJ2Kd4IYB+cK8mVPoSovQ0Eu/M93IyXpZFI4npYQc9WOZVFn6vm9pr1K9Lg==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr3629612wrn.396.1605275391038;
        Fri, 13 Nov 2020 05:49:51 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:50 -0800 (PST)
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
Subject: [PATCH 07/40] drm/mediatek/mtk_disp_rdma: Fix formatting and supply missing struct member description
Date:   Fri, 13 Nov 2020 13:49:05 +0000
Message-Id: <20201113134938.4004947-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'ddp_comp' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'crtc' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter or member 'data' not described in 'mtk_disp_rdma'

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
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index e04319fedf463..d46b8ae1d0800 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -56,8 +56,9 @@ struct mtk_disp_rdma_data {
 
 /**
  * struct mtk_disp_rdma - DISP_RDMA driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
+ * @ddp_comp: structure containing type enum and hardware resources
+ * @crtc: associated crtc to report irq events to
+ * @data: local driver data
  */
 struct mtk_disp_rdma {
 	struct mtk_ddp_comp		ddp_comp;
-- 
2.25.1

