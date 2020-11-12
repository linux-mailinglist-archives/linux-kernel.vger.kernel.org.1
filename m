Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB62B0D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKLTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgKLTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C0C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so7191962wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VZRZT8daPeGmypqlkiDD/bg2WPWGzH9nAJzamvIbC4=;
        b=cX9+YeCqT9sC5aPbLf/Z1l7f1X6pFMGszA2M2We1Q1ujxzgtnQJ/o8rksf/vFe4jqZ
         hQTGnYQ8u9RsD0LmmkWZr9PIymGaGFTOrqfpso6SG6bNRwOUrGx+7f4D7Z52mxOfCdmo
         OXQ67Xozr/0PHcjr0mR8c/6p3XNT+wsoVaMxbRmFFgqyEmjNdS78DB6WM64yWp5A6MXO
         FRi5mjieC+KYIHYTAdl+Ljc0Qvn1hyKCOt88nQbIXtJTeZ8HZmAdAzB5wsIgijCuFIFk
         1hf8gpXqOUolQ0BigNhDvmML9OKIVfKx7wa7wjx3tWCh4Oi//xUVdvBoxco0NohraCtE
         WJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VZRZT8daPeGmypqlkiDD/bg2WPWGzH9nAJzamvIbC4=;
        b=bdTMSOQR1+rCrVPTeMonEu9n5Y5Iq3ngSbF7FGrpHkFRtkEwlqcE0tw2WiD1ZYhn+b
         aXIFKXf2S+DqXQDA697qD1HnBqdlZbb8hipg3qJIARLviSlS5/p9Tmt9haIO6cxrb7w8
         Or7QIm4Fya7z4+vwaH2Zc5VNTvAaWdH+IY9OABsqYikcDO4rxwx4NlbjhSawa9PR26DB
         1c54qZhkj/Lq84iAI8Nq9WRP2AcpyhabG36uVjEw7NJtQ/65p+tO0xGCdVlC9Tde2p5a
         U9IQKhI7V8VqwdG6k0WvrKVc3x+pJBkLoKAcc33bSrTaSfYqszhggi+HyEecAWLhMDtQ
         Q52Q==
X-Gm-Message-State: AOAM530zkNXQ0j4HRdO19yD7WKqTu5LIC3PG8zYC2YKfoeKnq15Jo7zu
        UIw7XZlZ8tlpx59ccjAmuUQIRw==
X-Google-Smtp-Source: ABdhPJyR+wd6FhkS0NkkOKAYgU4dmP5CIQs3cXDU8ZMCkttt1IuxpT3+zhy8UwFysxWYC+JRR17X2A==
X-Received: by 2002:adf:f546:: with SMTP id j6mr1145810wrp.219.1605207664630;
        Thu, 12 Nov 2020 11:01:04 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 09/30] drm/exynos/exynos_drm_fimd: Add missing description for param 'ctx'
Date:   Thu, 12 Nov 2020 19:00:18 +0000
Message-Id: <20201112190039.2785914-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos_drm_fimd.c:733: warning: Function parameter or member 'ctx' not described in 'fimd_shadow_protect_win'

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index bb67cad8371f0..49a2e0c539187 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -725,6 +725,7 @@ static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
 /**
  * shadow_protect_win() - disable updating values from shadow registers at vsync
  *
+ * @ctx: local driver data
  * @win: window to protect registers for
  * @protect: 1 to protect (disable updates)
  */
-- 
2.25.1

