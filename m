Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE42B1C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgKMNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgKMNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F74C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so9947750wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPP0KPBE9bJ91PMqYQecftz5TXmHEXYH6/4+Sl+qsTE=;
        b=atNqYZ8kRbRqU8GNbprKEAbi23pRTlYb5L0MmlYxC7m6PmpZNGQuhqP6ASY22r5shn
         j1W43Id8OBhgGoyS3zM/JamzfB6UNXGFblqrp5WI1jIz1bxgmVD6gTxPvE+CWSipHFfK
         6n5Rryizvvc9J6mIbOwX2TP6WkS9/ZKzFI+xgT5oMcJ2rpcOtdgCpf7WOcrRH78gg+vn
         ywhJNI9DQHewqFej2ROXNGRf0ixudva9FfMawIBD5Z8MJcrzAIPrTLPNKGoydcPVKRLU
         1JJPW4cqi4cGWAkpwJmhjSGNo2ofbJA1/N6sih1n/2VAD+c9DbDFpseCcXv1ncnGQMxr
         QadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPP0KPBE9bJ91PMqYQecftz5TXmHEXYH6/4+Sl+qsTE=;
        b=N1gWBpnqvTP7Itum7mKwwjyDSgh757lp+Ho5AxLI+BS8K4437cqY2yrBKNuCJC7VTW
         F6diXYo+4T74KWrG6Im4+DOQEUzdPQ9+DNXWpIOl91UEHE2eq8v9qHb+5fFrWnORWfhJ
         oiyhXACZztwsz6KQAXQbY/l9xdQN53zcHOyTTSr7dEpvkuMgi8Or/BF9Ih/qrb8JbsVx
         aAmpUI1Ngn82SV49Z57bAlVWvzbmuch/FwZBEJjjSoNHgIsOmjFUhhKUBP0P0t1awo5Z
         9sGI6za3HcaPSgrhMTCUzM7+e1uB30w4saCiGl4PpBn02DVnhfdc2SaIbWo7O22si6S3
         vLog==
X-Gm-Message-State: AOAM533ecYjDkUzXu2tjWo5bNDfDpJZBGkpSrok6URj0ipA8H/4kqjtV
        AYEKxq9FJ3GAyss6DRyhDJUOHw==
X-Google-Smtp-Source: ABdhPJwH0G0Dh1nWggTcRBgogx0/P/R+hHDVfYcBOXgPs1OuarDaHOCCcZpMJv2RIDqqw50TszH2jw==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr3550191wrr.353.1605275402684;
        Fri, 13 Nov 2020 05:50:02 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/40] drm/meson/meson_vclk: Make two local functions static
Date:   Fri, 13 Nov 2020 13:49:15 +0000
Message-Id: <20201113134938.4004947-18-lee.jones@linaro.org>
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

 drivers/gpu/drm/meson/meson_vclk.c:134:6: warning: no previous prototype for ‘meson_vid_pll_set’ [-Wmissing-prototypes]
 drivers/gpu/drm/meson/meson_vclk.c:490:6: warning: no previous prototype for ‘meson_hdmi_pll_set_params’ [-Wmissing-prototypes]

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/meson/meson_vclk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 0eb86943a3588..2a82119eb58ed 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -131,7 +131,7 @@ enum {
 	VID_PLL_DIV_15,
 };
 
-void meson_vid_pll_set(struct meson_drm *priv, unsigned int div)
+static void meson_vid_pll_set(struct meson_drm *priv, unsigned int div)
 {
 	unsigned int shift_val = 0;
 	unsigned int shift_sel = 0;
@@ -487,9 +487,9 @@ static inline unsigned int pll_od_to_reg(unsigned int od)
 	return 0;
 }
 
-void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
-			       unsigned int frac, unsigned int od1,
-			       unsigned int od2, unsigned int od3)
+static void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
+				      unsigned int frac, unsigned int od1,
+				      unsigned int od2, unsigned int od3)
 {
 	unsigned int val;
 
-- 
2.25.1

