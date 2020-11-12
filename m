Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF82B0D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKLTBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKLTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B20BC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:04 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so6436930wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKxekprTcNWz9+T5s0dM8zcd4eG/OHSFQB40CDP13bg=;
        b=rHR1M/HdLeknkhdU29h/wSKR0Z784FWvAxygS4TEan/fVybAGYjXtGeA1aoM9wZq2h
         hJiib9TAK6qzqOPC5rHAFJjNejPFMssv1+/K4OmOnGa39NogI/tywrL6omtcFmPdI9kh
         C34/RfRcMWoBB6S714oSu0qmqNLzJw7RkXY/Fsnjb26TfPCMxXIDHMl/v30JtcEsf9tu
         dsgMJA948Gy057X021/jxsOOlK1glllrMFEO7OYqEGlqBxdhBo9SsRAKwdKzinJoIjty
         yqKbeI9U7sNRB58SxGKWahgWA7HSvwb0Epayp4Q3QswTqC5iMrtjr0dviGfcPuyQqaef
         5LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKxekprTcNWz9+T5s0dM8zcd4eG/OHSFQB40CDP13bg=;
        b=aWnBCGb2eeCVaMoWeWvZZb38SgvdDSPhNSxik1s279XiYlCvn0+y3col5EHl6CKFiH
         5ft6n7dhYBpeXeACfVypKznAKSg2NLFenXP8zYMGfV/aVi5QjM3RQmINbw1tgPR+2b2W
         ooLISKXzvSTw0G5pgf45XyEaU0DEujCP92m6ad7pZ9xqySq7WiA+c0dg0nhfX83v3MH3
         /krSOUAeOikFySdd1NHYD08hEjHw6nbMTKEEylf2Ut/ROjwzyn0FWpWa3DWQPNjYStWQ
         gjNHphoP/aAMVF5IDa55GcBPx9UMOZub5EktgEzESNfy0w+WUXNqGmN978dPDtl4XmG6
         NX1Q==
X-Gm-Message-State: AOAM533IDGSRS3vmZ8RJEpKoinmBjJHmXxtjvSHNnbGjNKv67rKYWQk/
        OtINOFtSmgFJYxP3vMxAN2+rQ38OM++qnXEN
X-Google-Smtp-Source: ABdhPJwyuT8LCe/shjgpHpT+VZjAVT+yMOF/6Q780jWrw9yW9KSyX2R93GMP41cG3s604agpMz7/fA==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr1045327wmf.149.1605207663296;
        Thu, 12 Nov 2020 11:01:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Akshu Agarwal <akshua@gmail.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 08/30] drm/exynos/exynos7_drm_decon: Supply missing description for  param 'ctx'
Date:   Thu, 12 Nov 2020 19:00:17 +0000
Message-Id: <20201112190039.2785914-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos7_drm_decon.c:354: warning: Function parameter or member 'ctx' not described in 'decon_shadow_protect_win'

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Akshu Agarwal <akshua@gmail.com>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index f2d87a7445c73..431c5d32f9a47 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -346,6 +346,7 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 /**
  * shadow_protect_win() - disable updating values from shadow registers at vsync
  *
+ * @ctx: display and enhancement controller context
  * @win: window to protect registers for
  * @protect: 1 to protect (disable updates)
  */
-- 
2.25.1

