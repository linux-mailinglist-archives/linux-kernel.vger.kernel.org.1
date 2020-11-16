Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF092B4E05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbgKPRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgKPRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6353C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:29 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so19621315wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NO2flJnZQ5gKgn/ih0D6aTqpwf9ViRniG5BiRkSE7jU=;
        b=dNwXbsPl6q1/WYDA3oEdV/zceq4tTRbwO6lTXlm5XU9tFJdlL8uLCb2UQHW6BfNZn+
         mgndbZ8TvSG3mtt/+A+jocB/IQFje8yUxevFzpcVFB6E5R2NBK/G30xCQNZJztpaSFpj
         7ZL6jHg4IpI1yxLcXSvFPmiWVMom49yEIm89insI5yf38ZUfud8tZbfGClv+QtqTRh8K
         Gq07tgEv6tNT68z5M1XbSKZVOq8SQXXWhA7Hpv/yIwvULEp8E4HTctxb8tjJFZk/4Bb/
         WbgxYlrEvPj5DQjWt0ZA/cKbW6LHdSm7hTS8aDEIcN1QcPH3xmp0cy8EjLxZ15mIUZmy
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NO2flJnZQ5gKgn/ih0D6aTqpwf9ViRniG5BiRkSE7jU=;
        b=D8yBo73LZvS8lBGrcXPuohx5jcf+oWVGB16htWKc3VSKnbhF7Mt0S2q4sf3f5wvO1u
         wIP7EjRHYQD30dXStfae1vp3M6uYhdpgvqO8nlt7qpj4dSz5aAOYZ/pAxvOR5UJlaZvP
         CSdXoZ/kzqCXkIb3EGwlor+XKRffrDtvpw4f2HPaFw7Ajr4l1T7I+VAUak5+avDk/CK9
         nFMKkITugiEJe9pYzApxrzfHKXCPCX53XXtWWa6GSGkYAFHhqc0+jvR/gurKzVITzikB
         HFI3NOiiLyIkS1i7iB6EY/ArtGOTU+j8XNLEytLpon2EhdNEIl6GRS1rAZbBV1MgH3m1
         pbUA==
X-Gm-Message-State: AOAM530lFbK/GLP961AELI0cL+4yK350ajXiCGtKQ7ayAKEHG7EFBifc
        vcx29nUkoUlFMl9djHCpt/HzlA==
X-Google-Smtp-Source: ABdhPJz+zBLjNMtTAkRpY8Bqlfb5jRoe4b4kXclN6HEEszc34CvpCg6cluG5/xfolZQyW6Bj4pbxTw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr21002442wru.112.1605548488615;
        Mon, 16 Nov 2020 09:41:28 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:27 -0800 (PST)
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
Subject: [PATCH 07/42] drm/mediatek/mtk_dpi: Remove unused struct definition 'mtk_dpi_encoder_funcs'
Date:   Mon, 16 Nov 2020 17:40:37 +0000
Message-Id: <20201116174112.1833368-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

