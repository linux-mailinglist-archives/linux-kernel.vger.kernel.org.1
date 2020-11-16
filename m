Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA72B4E54
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgKPRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387720AbgKPRlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953EBC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so19620425wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5j9nO6ToQvZzh6GJLxxL5NsV6KcH6bI4EH07Iu89H8=;
        b=YVgEUmjSraSC4YQk46p6uPgedVESFPJ3UsJO7Tu4f7fuWARoplJS6YC3o97e91JkZv
         cBJvp40l0dgXRQaLlTpEuC2Q0uQjxFAwNIn+7nMhNDcFl9mgKct6xkqQsfkHOtazXz+2
         0vtjIjV1rLHuQlghb40vINrSHBkLUdnkRlbaH3ZaQRgQRO3OPNBtpNrxK6JPR7CTnpxq
         tdZwoh0efmPizM+AxDTig/MH+rwvLAxSZ445H6Y9Te1xq5aiCAH4ok1RxdGRQKkSivx2
         HbtPLYE+ge6oxVRG/WTMb8LBqTG8kvBwxC8wW8p0HVl4kN8Y7Tn8G1Id1wAgUtBe/mLD
         s0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5j9nO6ToQvZzh6GJLxxL5NsV6KcH6bI4EH07Iu89H8=;
        b=LwgXJtYOTvijEx1j/OidJs3YHsCJ14AV5V0q3Apnfqpkc9F8tuBCqF8nxtGDYQryCv
         qUxUGuTEjnIOlrSxsEpkxoAy3iCQin+QZILHcrmDu+mMz/1lGo6Whl9U3FYoPerjkq4Q
         Mz7QxCcToQA3RJUaqeN5a9YDFL+aLTdFIbsnkZI3+lSi8sF/exW7rRofFNiZZRUh1rzw
         0/EFarxhaModzXxIQHXtnXdaH9Bi48PMJTCbzImL+FkYvQBNRZmJcr2Y+XXJGsre+0eJ
         IOXmK+C6i9AZIJhAa2ypWnV6/z49MWEyEgNwIF8eVnxMWPhzL271ac/Xcm9ShQDFyBLf
         dsrg==
X-Gm-Message-State: AOAM530KQ3nno2Rt7IrTvMUxQ5ut0cE1Z+Be/JKArS5KuuezIuaoSv7r
        9wKEbZqK6qykFS2IHTcIT1wRQg==
X-Google-Smtp-Source: ABdhPJzrDkYQrEjZLrNb+YUFl0cr5yDvtdbI8mt3oNtaaL8k2XZ9HKXWkCH/mgSrQlJyfuBrthO8LA==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr20417522wru.362.1605548497365;
        Mon, 16 Nov 2020 09:41:37 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:36 -0800 (PST)
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
Subject: [PATCH 13/42] drm/meson/meson_venc: Make local function 'meson_venc_hdmi_get_dmt_vmode' static
Date:   Mon, 16 Nov 2020 17:40:43 +0000
Message-Id: <20201116174112.1833368-14-lee.jones@linaro.org>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

