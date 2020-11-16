Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAE2B4E23
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgKPRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbgKPRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so19706479wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AA3ifXfkFgEiPb/+ErWAHaArtQGSrp8moUYg4qmaDWk=;
        b=UjF5WqGyB7EH7OhySfFTVMXhaSx34pvV4mfdWl92PAWblT7uWjt4EwdhGq4opaxfLb
         orZ7sxKafXTs+opxYnQzhDGyotWpmYeb9VKFYp3i+810+f64cW0rKZ68feO0yDcmvLC1
         S/Q/4p8zK32nfoxT6fR/BCXo/GZfP2gSDppe75Kbss/WbsbJoHmBR866lH3s/zfwKhZf
         IuYlJIjyzMQaEBu6dsOnwYELcHmpH4/Hb3o9cYIe+FWPQz+C+BvpuXW783/4+ZjzjPIM
         +8Wn80vVhpZXESufXsvdhx5gvWEKTRfxtfegS/nbCAdJUjwMpwutlXm4gYEVbmSZmHCW
         /k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AA3ifXfkFgEiPb/+ErWAHaArtQGSrp8moUYg4qmaDWk=;
        b=MTz2kf4kZv7+lRVLEGEOP6GUw6WTnzsejjgxMRVwMC9wKnoMnDe2vBonq/LiVFm9Wj
         dnofknFE6SMfAjwfnwGNZoJeSS2uMVxr0PaeWpAc6BHKBMswyPus97ZLvc7DMmKsEU02
         AEzUnfRpgAtnpDGxnuyJYCpUUE7JeEEQLJS1TGbECObN3By09sP1jIlDbcczVPay7WdA
         81c64Ddfcyj7GSzpwwjZdZSLkUPH38HM83XWIkPEnWi3r2QPqpB2NoEgBTjVNZjcGqJj
         Jx18XNYWjORYYd0FzaCFrXsB4PE0B9uqz31c2h/XnjaAuqM3C8sh/GMxE+f66pkMHjkv
         snEA==
X-Gm-Message-State: AOAM5320YfcI/8iJ5U8aPZnM5Vkye9RgSn7bXl/al1AlFweIHtaJrKsk
        VJr5pp0zVv4qMM8s6mKIzhtPoQ==
X-Google-Smtp-Source: ABdhPJw6r7DlQ++cTDY1efHbC5r3WHHMN2X6WMtV3NiC9i0Cnqx0lR2bC+5andsXJU2Z2O4IncQtrA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr20119219wrj.162.1605548539468;
        Mon, 16 Nov 2020 09:42:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 42/42] include/drm/drm_atomic: Make use of 'new_crtc_state'
Date:   Mon, 16 Nov 2020 17:41:12 +0000
Message-Id: <20201116174112.1833368-43-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
as a container for state->crtcs[i].new_state, but is not utilised in
some use-cases, so we fake-use it instead.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/imx/ipuv3-plane.c: In function ‘ipu_planes_assign_pre’:
 drivers/gpu/drm/imx/ipuv3-plane.c:746:42: warning: variable ‘crtc_state’ set but not used [-Wunused-but-set-variable]

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/drm/drm_atomic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index dc5e0fbecc04e..54e051a957dfc 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -783,7 +783,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
 			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
-			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
+			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
+			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
-- 
2.25.1

