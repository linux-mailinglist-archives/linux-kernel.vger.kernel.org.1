Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB52B1C81
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKMNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKMNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:28 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44CC061A4C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so8098909wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmFIQSl/IxBdBhsOtG9qrJEA42yvhnGh386TMGMyma8=;
        b=mY/s0pYDEoGhbLaQa/mv0EUVIX+EyJgNnog2bItqV1cG1dEk25StILdGwjZJr5xxih
         FN8D6trlrMabKXBVahRxImsO1cUh5U0yCpMjVlRhdC7f2lwIilN0wEAbaIZVmkudgOew
         6U5Phpb6rM9IxfRwf29E5HtkETLUe3GZL3Rly56wL6E0lRQKZWxLyHDOXhpwvhX+fj6q
         FEL27rKQFfLhxVjg47ANuOyvEoxc16GxFG8cNbQlTMNtocun5CR0V6VQ/3qUNnA/bw9j
         Y7mGAUDGEPDLA8vzFcQWNafqTLmlW4tRKhtxLbzc2CBi5ozxwtW3JirbIFn271BoCVV+
         XETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmFIQSl/IxBdBhsOtG9qrJEA42yvhnGh386TMGMyma8=;
        b=EdfyRn23lNLdvGtCUCZV/Hj8BShC3LE8gvq7k6BcGyJqpno5puQbL/mzWhDWM7HSDv
         ZzeWKj1s+eJynRBSPWHAW4U8BXHMsUlFmmOdvMtmrp2VWMq/wjtj0R+leD7N02qBC+As
         mAIPNgAHAW7JbEGKjJU4nDzj/9T6CCuSRYY3cc98ZWY93/wVsYnLrg0xGu5iiUjE8wk8
         a44GglI9Y7AdAEc/ZF9tF8A6csNpFtohe0SF1Mj6Xxo5YN35/tqwAgEXE5VasFb3qs5f
         +uBoxjLMSMeFLdM82zSoYUWaKStNjjy3sPmO/7LMIZu0Obeee9N8WnN/CZRpm4WqhkRH
         uXiw==
X-Gm-Message-State: AOAM532qy68QzVs+9g1md2x4mmj8oynRM0U3xxWzA37Kwc/bfUg8rfiN
        wt8bioAfJrYSisSeb8ISI9QPzQ==
X-Google-Smtp-Source: ABdhPJzsd+Ru1JA3QyUUZZ09hbsVbGu88ARk0E7Q8iGeLhCIiOkJZYAxunX6gQT2AgjsanxOIzz/SA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr2617695wma.126.1605275426666;
        Fri, 13 Nov 2020 05:50:26 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amd/amdgpu/amdgpu_fw_attestation: Consume our own header containing prototypes
Date:   Fri, 13 Nov 2020 13:49:34 +0000
Message-Id: <20201113134938.4004947-37-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:130:6: warning: no previous prototype for ‘amdgpu_fw_attestation_debugfs_init’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index c6947d6c7ff51..e47bca1c76359 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 
 #include "amdgpu.h"
+#include "amdgpu_fw_attestation.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ucode.h"
 #include "soc15_common.h"
@@ -139,4 +140,4 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 			    adev,
 			    &amdgpu_fw_attestation_debugfs_ops);
 #endif
-}
\ No newline at end of file
+}
-- 
2.25.1

