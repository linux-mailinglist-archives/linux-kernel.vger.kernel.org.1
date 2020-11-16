Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3393F2B4DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgKPRlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbgKPRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C2C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so19700594wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
        b=o1UX4zCdDDDNMV0OKn61RJZh5y0bXjwuSLSb/l0adES4M9qoqn7sv1BgCviUEyBC9c
         YkW31BulSSuyM5+eWBzeavPqQ3NlTBNZubQzQ8wtBRC/GUKmFYk3lzpk/YE3zsJ/6WBl
         OpKn4Wy9zyDhuplwApEWD5Sa6zKv+AxMW88gW874lf++usj3pJ6pcP4EB7aKSnEKcHnY
         kCasy1dCT1JGnPTFofUgrWLFptS2mPNQSJqgRojLSiEN6sitXESVrhduYN1uH3wka2Bv
         yg8/3HsJ4Ku+jxbJGWlvJEDL04L/+8P+k/Us8Su3EihI97fe/pyVcTBp5V8a0wj1wcDA
         CTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
        b=YsUNGvDNIsUmBWB26wn+W7N/Afy0L7qwZcOWhFrriLR3kWYeM8wuAblYnCZAlD0hT5
         s5CCJNCsE5PuWAEd3lbUNZNQYuDgpTjOttZvFtXagK2z4AMuLGSCtm24MZ6Wbz+GoIXu
         XsrP0/ibsNwJJfQnnMt/R1phRvvaHDaCIkJ5Z3Ilkg6cm4JCgm0GqFrILcgvlK/MlPcU
         rOfK41z8grduQ64duxalxb1/MpiHJEVeD00ngF2++YDwImxXwsBYdhHD3KffhBWNsnMe
         vHONTMEqZFHwQNdPWME7J3J+J90Sns//ddKFQz+bzQE3SwXlmGolPqUKfs4ynw0PAEVd
         pd0w==
X-Gm-Message-State: AOAM531y1wwL6Oo11gx848qQbNclOIExi5vPZyKZ6er4X+BZhJvid8cP
        j5bQ9EoPxDdF1Dflr/cr09JT1w==
X-Google-Smtp-Source: ABdhPJzRRRIcqjO4tgQf4glCQA5hVitq6bSC5qSo/xDr9yKWinhRugh4nu2qRSQ/wCZZC7eA8JUXXA==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr19708579wrr.85.1605548480370;
        Mon, 16 Nov 2020 09:41:20 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/42] drm/amd/amdgpu/atombios_encoders: Remove set but unused variable 'backlight_level'
Date:   Mon, 16 Nov 2020 17:40:31 +0000
Message-Id: <20201116174112.1833368-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also removing the call to amdgpu_atombios_encoder_get_backlight_level_from_reg()
since, according to Alex Deucher, "We call it again below indirectly".

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function ‘amdgpu_atombios_encoder_init_backlight’:
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable ‘backlight_level’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index fa817ebff9804..6134ed9640279 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -171,7 +171,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	struct backlight_properties props;
 	struct amdgpu_backlight_privdata *pdata;
 	struct amdgpu_encoder_atom_dig *dig;
-	u8 backlight_level;
 	char bl_name[16];
 
 	/* Mac laptops with multiple GPUs use the gmux driver for backlight
@@ -207,8 +206,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata->encoder = amdgpu_encoder;
 
-	backlight_level = amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
-
 	dig = amdgpu_encoder->enc_priv;
 	dig->bl_dev = bd;
 
-- 
2.25.1

