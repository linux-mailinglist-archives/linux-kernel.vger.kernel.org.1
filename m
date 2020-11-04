Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBA2A6996
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgKDQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbgKDQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:24:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:24:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so3541468wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JM2T5gVY6mQCYq3pa3CtVVdmUuOhZqTmm7j89dYLWQU=;
        b=i/SMHsMT00YS2lCynxMmugbtsc2/7yy4xnA5bc0ana2gO2cCL2SEp/JMla/n126zZh
         NPYH+jLh1YN4Df7mt2FAvaVYe/s8DxEH/mgQkK7E5j8pI/BNv9nCagofcEoikxhSYI0p
         YvxYFpnOfvtlbnHs7mK7pwZrCRaBdb2n9YLw2dnLGay6Ue4hHFG9/u+QGNEG1KQUmu3D
         2Zj5Mg/DCXSLILCkeHP45dbLiZou4OR+z/6QP9ZfoF5AhABxuTFVSWs7gCU1TgcevrDr
         KjzhgM4jNrN/wCGCTgWun7Wd+xpKH0kGa3RhPPk+UjfPccndKb1dom1VZk3WoRnu+fgM
         Zpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JM2T5gVY6mQCYq3pa3CtVVdmUuOhZqTmm7j89dYLWQU=;
        b=MGBmOzUwXub5xyFMCGJq3DpqwIX6jRn4dcZhbOw+wrpIroZc+PM/zEcmfK45dQllev
         0IBQxYS4+0nLqUbIKNJvVbuYZ4RiDjymY5R0OAQs8nWS9JA835f/OYw/QdqLJnMeMMNF
         B9oTua2uZnLQHJCYuxFmv+uGgV//3kX6f0R/FBGgf5wqRDOrboM6Eri65+5otoLUZh/R
         L/T53vbDuVCyBIE/P5L9vbbAjkENzmmGK0RMkoCBeYyoFTqjtvFv/rvqR2BLwGnv7aqs
         JvMLMLhQs3P/37GEzbofu18m43Ng83CaSTpaiMLc9pgCfusnSr+10IQb1AiMR4cwNPHQ
         7h4Q==
X-Gm-Message-State: AOAM532EwKaiKcchz9k4XqzIOZRXdDKS1fKKHEmzlsGlFfBLvfKvLIfU
        /hcK1cnJZlzdtzR1+SKH9fvUWQ==
X-Google-Smtp-Source: ABdhPJzdjlS/LhhU7HXjUaKMzpL+Law5xU6ARfYwU1WOJ3TBZddsJ93/Gm+k8L5S/PJ71zU7Xo2rGA==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr31862922wrx.215.1604507093262;
        Wed, 04 Nov 2020 08:24:53 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 09/20] input: touchscreen: resistive-adc-touch: Struct headers should start with 'struct <name>'
Date:   Wed,  4 Nov 2020 16:24:16 +0000
Message-Id: <20201104162427.2984742-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/resistive-adc-touch.c:34: warning: cannot understand function prototype: 'struct grts_state '

Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/resistive-adc-touch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index cfc8bb4553f78..e50af30183f4e 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -23,7 +23,7 @@
 #define GRTS_MAX_POS_MASK				GENMASK(11, 0)
 
 /**
- * grts_state - generic resistive touch screen information struct
+ * struct grts_state - generic resistive touch screen information struct
  * @pressure_min:	number representing the minimum for the pressure
  * @pressure:		are we getting pressure info or not
  * @iio_chans:		list of channels acquired
-- 
2.25.1

