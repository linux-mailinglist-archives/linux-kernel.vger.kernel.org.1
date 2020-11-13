Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EEE2B1C70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKMNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKMNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD90C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so10019762wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NO2flJnZQ5gKgn/ih0D6aTqpwf9ViRniG5BiRkSE7jU=;
        b=oU+bZDcIA8AQ53jLjMhsbcTjoc0o9aqwixUMDFaPxx4SjacHt/w7oe9W1HMKSdIsn9
         6MbabSjAFbSm0k1Wtzvrq0NdT42aTWaBzzmUWCU8zrAC1ar1JcV5agJQhKKqmsvQRDx8
         DugB2mjm1THeElsZsw+uY85zNMeJ8YXM1g5rjMPx7fYOia71z/cOlFmrj0P/AASK1cLd
         a19gm/PUefiBML3NgcSMj3reICam5oEhlLKz5NZeKUjHwCdh3UqBZfXHS+7mwb1CQBMp
         083hgZs8utmuWHk8W0+RbnRiirUW1LsWFcExyMHgs8HKN+uangYIThSsaPlgGG/FncvU
         Wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NO2flJnZQ5gKgn/ih0D6aTqpwf9ViRniG5BiRkSE7jU=;
        b=M7dg/t9vggNHBtJONiHgZ0n2tCFYMVb0ewm1kdmnuOTSg7B8acIj3dYeZFkUhJSqIy
         EhFjdpsNeIR1DJVvY2LLVzhmFAg33fX+BheSgAcyod3wGlI11T2osd1hwIbkJH/T3wAi
         53nSnz5B3fDkIQCNEti7Pwcpco6jRoC4E5kgngzMgtcqJ7fEB32t4GxstC9vTfN2ZYY1
         Y6TI/4gMhsjLWGaOWPG0h3mmJrhAopGwhuBhM1oi8SU78I8NjljLxh6BhpfWhEbW8Peo
         ci/bIFfUAZo93U568i1ih+pJ9jGR+ym4gYfYSltm2HMQVNDH9PFEi2sP+QLq8Hzl2GlI
         d5Hg==
X-Gm-Message-State: AOAM530AXK47m/9KblylZGBpI98mZWYjnhcmCVJwhN06Aj5wle4NyO11
        7DEeGHaXXP38L4Br+gtKtZlkXQ==
X-Google-Smtp-Source: ABdhPJzKJjo+4i22doEfV7yx3IYktJ3jj4EOHDvZEs21nHetaud1mfeiFp8gdC0lK6WMgPjwB27Hhg==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr3589306wrt.218.1605275403918;
        Fri, 13 Nov 2020 05:50:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 18/40] drm/mediatek/mtk_dpi: Remove unused struct definition 'mtk_dpi_encoder_funcs'
Date:   Fri, 13 Nov 2020 13:49:16 +0000
Message-Id: <20201113134938.4004947-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_dpi.c:530:39: warning: ‘mtk_dpi_encoder_funcs’ defined but not used [-Wunused-const-variable=]

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jie Qiu <jie.qiu@mediatek.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index cf11c4850b405..52f11a63a3304 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -522,15 +522,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	return 0;
 }
 
-static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
-	.destroy = mtk_dpi_encoder_destroy,
-};
-
 static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
-- 
2.25.1

