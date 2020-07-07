Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF11216E10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGNuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:50:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F4DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 06:50:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so45182964wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY+HM3YYct/Z+qO4ymD0ac7QxRGx261eVt0ODxM+oYs=;
        b=R27gTMhzK0XO/6RSl9/ffYF6FzHgYljcDrF/qz8oRSEVazY7UiOocx9bJMLbOv2vyV
         62wqDkAJ3mITprygXiMy1otkpp2SCIf7e/PY+IAOoZXfOK+kpCkcpoISteaq7be/LYSE
         Qix4mMTBvqA0dNYTm/bDok57jR8jbx4yVNTEsHt4Ltwpc5LlTX8BNW7u7r4U1JkTt6C4
         wJGFba4VcBFu7iH8z4fbR+Hs+obr3H6wqCtGklYdatCCkuN2tiSi9QlxQiuGikIWzNdu
         D6iVECxJ+OdSrvcEFiQS5SXo+XZXBLDdATo7uXOveYzqNFRKB4g9RZiRiPaav3inQ1xy
         KMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY+HM3YYct/Z+qO4ymD0ac7QxRGx261eVt0ODxM+oYs=;
        b=BkbBSnSsthbqIH4K8iLnQH8HdokcnleoBwxXggeh9fP2ypW2YnqGvnyX2etsZmEkz6
         gA+TFryDbED0Zn/eCsqujOG6mHn3PULbKY6riy32zTSeMdtBa0Kw/d88J4ECQfaY4I1Y
         HcVgXTCm7H1mE+xGdGTc39FWhwQ9ijs5I3838Sug/3MLXopu3KFQnvYYbFC/sTiXoUou
         A5Mf4HhBYUe/RuramOilxxEaoBwVTZV08pxGKRNQDgEugK2Ud0mZNN6zIKj7CfNAEFEs
         a9CZSx7EStoXJxTpa1fk02H4ya3nYeMmxBMvguYLw17FXL0C9WlP/l56aRwPfTLwjD5A
         N1bg==
X-Gm-Message-State: AOAM530TrmT557pzTioUbxzg19m5iOAioq5hsvbwhI/LGLWFW44eSvWt
        dVhqHyvriyII7DKP0sUeca5hzw==
X-Google-Smtp-Source: ABdhPJxE2HHRInDWkh2Q2PIxGGZ9LKPoxNjzyVRAOlV/OZira6waszUIOSnvrB0UXU1NjNoNkiJc6w==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr54706539wrp.421.1594129812977;
        Tue, 07 Jul 2020 06:50:12 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 65sm1354396wmd.20.2020.07.07.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:50:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] drm/meson: overlay: fix build failure
Date:   Tue,  7 Jul 2020 15:50:09 +0200
Message-Id: <20200707135009.32474-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent GCC compiler is very picky with the VD_H_START() and
AFBC_DEC_PIXEL_BGN_H() macros, triggering a runtime assert error as:

In function 'meson_overlay_setup_scaler_params',
    inlined from 'meson_overlay_atomic_update' at
drivers/gpu/drm/meson/meson_overlay.c:542:2:
./include/linux/compiler.h:392:38: error: call to
'__compiletime_assert_341' declared with attribute error: FIELD_PREP:
value too large for the field

drivers/gpu/drm/meson/meson_overlay.c:413:4: note: in expansion of macro
'AFBC_DEC_PIXEL_BGN_H'
  413 |    AFBC_DEC_PIXEL_BGN_H(hd_start_lines - afbc_left) |
      |    ^~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:392:38: error: call to
'__compiletime_assert_401' declared with attribute error: FIELD_PREP:
value too large for the field

It's not expected to overflow these fields, but the compiler did
find a case where it overflows.
We can safely ignore this, so mask the value with the field width.

Fixes: e860785d57306 ("drm/meson: overlay: setup overlay for Amlogic FBC")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
Got Daniel's Ack from irc

 drivers/gpu/drm/meson/meson_overlay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 1f7b2055e012..646e605f30f3 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -58,7 +58,8 @@
 
 /* VPP_POSTBLEND_VD1_H_START_END */
 #define VD_H_END(value)			FIELD_PREP(GENMASK(11, 0), value)
-#define VD_H_START(value)		FIELD_PREP(GENMASK(27, 16), value)
+#define VD_H_START(value)		FIELD_PREP(GENMASK(27, 16), \
+						   (value & GENMASK(13, 0)))
 
 /* VPP_POSTBLEND_VD1_V_START_END */
 #define VD_V_END(value)			FIELD_PREP(GENMASK(11, 0), value)
@@ -144,7 +145,8 @@
 #define AFBC_MIF_BLK_END_V(value)	FIELD_PREP(GENMASK(11, 0), value)
 
 /* AFBC_PIXEL_HOR_SCOPE */
-#define AFBC_DEC_PIXEL_BGN_H(value)	FIELD_PREP(GENMASK(28, 16), value)
+#define AFBC_DEC_PIXEL_BGN_H(value)	FIELD_PREP(GENMASK(28, 16), \
+						   (value & GENMASK(12, 0)))
 #define AFBC_DEC_PIXEL_END_H(value)	FIELD_PREP(GENMASK(12, 0), value)
 
 /* AFBC_PIXEL_VER_SCOPE */
-- 
2.22.0

