Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017CF2B1C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKMNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKMNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF7C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so10023830wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yt85C2+NzGAlI5emEV4T+vNOl5giBIbnEfifffD7CnE=;
        b=Cy0FIFBOqKt9Owiq+Dqg7+C23huzVDETryFyww7hngaX44EDG2i3SfAegg/ufoaL2u
         uzX5zuxtv9ViDaCFPsw8oXmaaEtTFHVWqtn6aZ7Bvype0KXwKlw2IXtMoy4hRUdSmi0C
         XlbjQlhdV0BLzWGUf1FDhesPOdHZTy0bXVpBs8gWwToqFsTfXI1NibEEdysQ8CdwzdaH
         Rb+7WADVUWE0eDtwkGg3n46j/NSuLXVSqWKAMRLw/kmi/Q/MDBAg5abRJbcVE+XvI1TD
         uoRTVC/CIqtQpSsEKCrHaagzSqer6TxrW5YMW2V4zVC1UhYE2rLoBCyGTamzEAqx53j6
         Y7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yt85C2+NzGAlI5emEV4T+vNOl5giBIbnEfifffD7CnE=;
        b=cycHFC3akv2RfUM9zAdmbkECnbWn9qdWw+b/IPq6nPiySIek00qBQ2JIczcaf7HM9P
         vz5/VxAagog7NuTwMJqBKYmIb/qFtmzdk372g0VhiDhERWmR+Iw+spNzcCZlyh5KYkea
         EA4X2RsgcgFtnv/1OYl/FpjINYpZHB2KbavP397WdQVXIA/+Pr9B0tTRGbufYkx9adnv
         ZMAkQkU7fJX9niQ7WcGIesQeFVzN6PIxm6QB755KlN+MluUxZrCWTEeIcpcM/KoLXBb1
         iMg8S/XGfK85v0sCEYCFXUmQ5vRyBCeLBeef2eHYlSpVf22OGJcoMW0Wf7B+tccfRfX3
         KHog==
X-Gm-Message-State: AOAM533JZfcYZggHENima1BROPgD9Cn9nmRHwl46itD5efPEYe8NZmGB
        DRF1fuu9VIg9lzja/BoC6BJYgA==
X-Google-Smtp-Source: ABdhPJyB1aM/U0SYQBQS2sQ434uZIWEyyXQHKmq7NJg+pZgX9+e1LYtp8/RyoqCFrQV32ZTz5voxrw==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr3575994wrn.408.1605275399152;
        Fri, 13 Nov 2020 05:49:59 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:58 -0800 (PST)
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
Subject: [PATCH 14/40] drm/meson/meson_venc: Make local function 'meson_venc_hdmi_get_dmt_vmode' static
Date:   Fri, 13 Nov 2020 13:49:12 +0000
Message-Id: <20201113134938.4004947-15-lee.jones@linaro.org>
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

 drivers/gpu/drm/meson/meson_venc.c:893:6: warning: no previous prototype for ‘meson_venc_hdmi_get_dmt_vmode’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/meson/meson_venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index f93c725b6f02d..5e2236ec189fa 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -890,8 +890,8 @@ bool meson_venc_hdmi_supported_vic(int vic)
 }
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_supported_vic);
 
-void meson_venc_hdmi_get_dmt_vmode(const struct drm_display_mode *mode,
-				   union meson_hdmi_venc_mode *dmt_mode)
+static void meson_venc_hdmi_get_dmt_vmode(const struct drm_display_mode *mode,
+					  union meson_hdmi_venc_mode *dmt_mode)
 {
 	memset(dmt_mode, 0, sizeof(*dmt_mode));
 
-- 
2.25.1

