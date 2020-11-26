Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5C2C565A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbgKZNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390816AbgKZNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:04 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E290C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:04 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a186so2199207wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AJIopnyfhF0y4BTkzIBWxHJHanpp5V1ikes9pxc/Xc=;
        b=p/G/xj32n4i/rb4oTibOM955Wb2c2JuAT8/JEPsK6Cet/M6nBAM0aqReY56K/J5Et7
         amy2F2/m374sjvAeSfHZ8NLJgd13zRPeaQUlDXgMF1RhJwaEI4iiddP5r//znBH0/s5c
         TiI6Okc/1wVVTlo3aEA7Hw5I/qlTKkG4SUsXYGRMPQSpCLbvg3c/N5Zp05LXoZUmogOx
         Q4vmRAs7ruIFA1BW/PIWhKhEpRtw0Sd1GVCt9I66oXJHblxbu+IPgisDe2ydduSg6sI2
         AG33/49mDz/9ILeFURIg75jJR2NGWpP06Mlv6OdF08VX9CNy61y0qHqdhlQcX05y+4yZ
         1gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AJIopnyfhF0y4BTkzIBWxHJHanpp5V1ikes9pxc/Xc=;
        b=H4Z7vJ7MzxY2w8pP6m8ydT6YHp4u6KV9SEjae2ZZiIrgNkXyOpXBldiBmBOkAQHt1l
         4y2VzJQ7PSlo7yDtD4RrdqmkPKZCLkVslBMSbhV09WZnx7j67yWGnHxJYQEcp8YN0m1I
         YMZYqQskmCCjqktgg51+O1ADRNl1tbA9U6B2sqNOLltHMfVtuZZZfskzavYUql0Wtr0J
         b0VkqOBXv+cT82CNfUO+fyDBTLKlTdrGAmMGY9BQIUrx1GiJstLraUtAz3M5evNqbn/K
         sU+C5VVerEbWZ0GWFGFn6NdMJVN3PgK0ky5DxwyCjcGKCAJe2KL2gurQk7U2A5gmFzvy
         vLUg==
X-Gm-Message-State: AOAM532hx2DUTlQCzN+P/RDACjEF4X7i6/ZSIDA7o1XKvYtht/1PlWhB
        NfJbATVALNXcR89DZhkwB7GL5A==
X-Google-Smtp-Source: ABdhPJzsbr1E7lN9PNWNLgjwKyJigQPxpav65eXlV0+KrkMgaazvVNZF2wODZ0Otr3NRGQHQfQJMCw==
X-Received: by 2002:a7b:cf0a:: with SMTP id l10mr3530508wmg.103.1606398182874;
        Thu, 26 Nov 2020 05:43:02 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amd/pm/powerplay/hwmgr/ppevvmath: Place variable declaration under same clause as its use
Date:   Thu, 26 Nov 2020 13:42:11 +0000
Message-Id: <20201126134240.3214176-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h: In function ‘fMultiply’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h:336:22: warning: variable ‘Y_LessThanOne’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h:336:7: warning: variable ‘X_LessThanOne’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index 8f50a038396ce..dac29fe6cfc6f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -333,14 +333,14 @@ static fInt fMultiply (fInt X, fInt Y) /* Uses 64-bit integers (int64_t) */
 {
 	fInt Product;
 	int64_t tempProduct;
+
+	/*The following is for a very specific common case: Non-zero number with ONLY fractional portion*/
+	/* TEMPORARILY DISABLED - CAN BE USED TO IMPROVE PRECISION
 	bool X_LessThanOne, Y_LessThanOne;
 
 	X_LessThanOne = (X.partial.real == 0 && X.partial.decimal != 0 && X.full >= 0);
 	Y_LessThanOne = (Y.partial.real == 0 && Y.partial.decimal != 0 && Y.full >= 0);
 
-	/*The following is for a very specific common case: Non-zero number with ONLY fractional portion*/
-	/* TEMPORARILY DISABLED - CAN BE USED TO IMPROVE PRECISION
-
 	if (X_LessThanOne && Y_LessThanOne) {
 		Product.full = X.full * Y.full;
 		return Product
-- 
2.25.1

