Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3518E2B4E53
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbgKPRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387721AbgKPRlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA49C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so38581wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SDDB7TiTj4Jx/yTpGVCS2uqUdyiewZ4Ioe8JHQpewVc=;
        b=CpSZkmo/j2Y34JQwmQr2gL++XO1KYPcKHx6aqjTMLngU/acwN4t98DrtpoEAR+uHeA
         LEd2aN+YIEqfjA8qJitJOl7OQDlvxN+ELOtvUyVfK6NYEUWOZlChIVs4nqcg9elGQehe
         Mlbh/kBNojHRJE8HUO/6j3KiFXWV/lY/H0EeqDJEMCmSSqc8uetWdcK7KC1SKun3LNfM
         OsAvUf3KGN8GI1Q88IWDJ4JqQ4UIzj7/9UKQN0rkBTAyNfaB9AD252Kp8BTqLX7Ree6o
         9Df3tJOHKVus3QnMsM1RqTTwVDZxjAWbtxLYFmHOymQolEp5oB4vsX1J35OYld7qBk2A
         gtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SDDB7TiTj4Jx/yTpGVCS2uqUdyiewZ4Ioe8JHQpewVc=;
        b=UET6N/Evrw28LN6eYJRpIlJJMIXrsapGQv8ZX3fk4K4qx2fGOJ7pPFNSRQjQ+4G9gl
         FXUC+ABfYeO7dzm8w/9Q37CFdirc9q85kFXhoBDVimLP1n+nHceEsEua/9z6IKG9nyvi
         2f+Wl+02yz9V8zCypS0+amI9j0GJdA8qn/ZznwYYt2IETHfnqz/rexJwz0KinXRPfpf6
         wo6zb4Lf2OFheGGkTWytqujS5D0JQ+S5WBcj/5/ih8q1h67WKqjkjTVDIhAyq2i9Hb/O
         BmmOJQjiq/N/35/QkQGmuoOqDkR5nmDnDoJ4Nj9aNSS5oTrRZnkp8mndxb3c/SyHyN0Z
         XaAw==
X-Gm-Message-State: AOAM531FQOU8ioG8NuGV24pBtYvMItNEhCTWPEY8+4QoqCpo3nOJoNa4
        a4f3Doy3HfjLeYtcApWCUcbaUg==
X-Google-Smtp-Source: ABdhPJxPbxCum/XYvUgQugDBX75aEbB+JJYQEqSRBMPO4F/I/vRzV1yTYp53NsEEXN/uJBkrtTjG5Q==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr10459841wmf.121.1605548498820;
        Mon, 16 Nov 2020 09:41:38 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:38 -0800 (PST)
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
Subject: [PATCH 14/42] drm/meson/meson_vclk: Make two local functions static
Date:   Mon, 16 Nov 2020 17:40:44 +0000
Message-Id: <20201116174112.1833368-15-lee.jones@linaro.org>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

