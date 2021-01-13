Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8972F4DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbhAMOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbhAMOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F89C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so2405766wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVSUjkIjXEkNiZ9bYl2AvQwRUk7bSgmr726se0qdSGE=;
        b=S6pjMri1LooUzVebsMKl5L/qXAXXf0BQaNWI9zUwzK+jMt6eB9Qc4oOTGepufIBfid
         w8BOqqJSqOTlO1AaMZ2c97EUxzPgYgwXzlP38xgFZHdc5f5/8pnliirr015cmXT5P/6C
         bmXz//hqWY6WZtaLsnyk9w3DTs/zx93zvqMGjgmGEz1ltpAcWFoGUuZTLcV3oaXDRWzg
         TsHN1MtRbF4DsoU67oqGthJ9CyD102ea6PWM8nSeKWwLjDVQYDQOynMxGeM3eMYyzuVy
         k+RwnCTE6vvqOECHhK+/HT1+C06vWU2p6IumxaB4VEqq3egwhncHh1sL8BXGgsKHUjzx
         Jyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVSUjkIjXEkNiZ9bYl2AvQwRUk7bSgmr726se0qdSGE=;
        b=JFNC67wsdaUUbcSqUlWXCShnvq6g6wPrg7nuBnaDeKfnmpy6ucMD5awXWLk/PfiIcv
         Wry1tyDdoN9vd/YDKdpBzTDB5HUzCFUCmC73Ia3siRn7dQLTwcv/y6GpH7vs7+NfKAmy
         +dwY/5LqPZJVacqS+QuFBl48ve0rKsmosrBFYx4G0nxcmy4VviCGw4mAajy5YY7ahMXU
         DYqwdZCW4TWgYs47SQ/A6DC/R1QHOSIVUFaSWOFx6rUC+zLsL1W+r223EKKJ1X6frpJb
         bZVU2xwSNPvyyo1YVElvQN6yfSWUeIWeV1LVXBvn2wKQomGfITBRtjUWzKE9NJT7i0IC
         eHUA==
X-Gm-Message-State: AOAM532vKV0hG8g281gxfVK1h8ZSRz3mlIs0z2ngxgV9jmVft8Bxh6ph
        ijfCZwbgK9mNmyGa89K2tNf6EdymqzyL4fBj
X-Google-Smtp-Source: ABdhPJwQS7eakiW5Ymk7Te1CVRoqQilV5MyqcK9JOS6lfWXJfPo5U8VaTE2R9c7aaPoPlmXHPb50DQ==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr2994233wrn.17.1610549420622;
        Wed, 13 Jan 2021 06:50:20 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/31] video: of_videomode: Fix formatting in kernel-doc header
Date:   Wed, 13 Jan 2021 14:49:43 +0000
Message-Id: <20210113145009.1272040-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/of_videomode.c:32: warning: Function parameter or member 'np' not described in 'of_get_videomode'
 drivers/video/of_videomode.c:32: warning: Function parameter or member 'vm' not described in 'of_get_videomode'
 drivers/video/of_videomode.c:32: warning: Function parameter or member 'index' not described in 'of_get_videomode'

Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/of_videomode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
index 67aff2421c29e..97a220852977f 100644
--- a/drivers/video/of_videomode.c
+++ b/drivers/video/of_videomode.c
@@ -14,11 +14,11 @@
 
 /**
  * of_get_videomode - get the videomode #<index> from devicetree
- * @np - devicenode with the display_timings
- * @vm - set to return value
- * @index - index into list of display_timings
- *	    (Set this to OF_USE_NATIVE_MODE to use whatever mode is
- *	     specified as native mode in the DT.)
+ * @np: devicenode with the display_timings
+ * @vm: set to return value
+ * @index: index into list of display_timings
+ *	   (Set this to OF_USE_NATIVE_MODE to use whatever mode is
+ *	    specified as native mode in the DT.)
  *
  * DESCRIPTION:
  * Get a list of all display timings and put the one
-- 
2.25.1

