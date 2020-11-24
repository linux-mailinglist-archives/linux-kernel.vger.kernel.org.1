Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385E2C3145
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgKXTrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgKXToT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAA6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so23519108wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYDh/UZaCdDEqxdxKnQmY0HFvSGalhT0MJKMTrRDfOI=;
        b=gHCQnDfrUQvyfePswNPku5Eno1OnQAgON8KyhF9osw/Kwp173O3dgv/Kh67d4pTKrJ
         tCF7v2k3uU6xUaw4xaoH3qkjJ1JHPNbhKJa5y1uOHgPU03pLRkk7T8IkL7kEVBd8EKY+
         o8HYEiTVYbnsRS7StIw0J/yMf5Zjf5vI+my7ats5suII18PtNVVaxREQTOX5sRbl5WyN
         byRVkMU9r/XluNhwdM82UW5F5+SV1sRhg1OTg3eyiUqGclX7y92PRu1SPlCI5s+A8Sa1
         55DO8NqjaBV6BOfDEXFioSMBr7A88v3JEFE1g8/K1IJFCH0FjNWBvcKPhrnmQZTtWwHq
         o+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYDh/UZaCdDEqxdxKnQmY0HFvSGalhT0MJKMTrRDfOI=;
        b=KcaTnkoeOuIpsaK/P47RiD4LJt0a7+vAVYYi+0pIsMSWPqw0nFkR9+Fy5xm2xb5fWv
         yZcJh136mN5OkfecEYZgw9kkCjUbTN2taJXpZlTMxEkYPm/LzQr/rniAPY+FHmF/ddAe
         MMRG+lgQ+Zfos6M1054tH7mmLm83Fr47/rd+nce1JLXBA+BgShCDifxXXuwVW3/xRWOk
         GZONyLuFFMAG2UCuumu1HRGyFtjxy9IMJ9NNB7HokMqsMi1khSsqYryxUIYlo0KmH7Iq
         3lqVTjpFnPaI5V7MvB1GQQPtdBgVCZInrDbs4nVX6h3JwU6S4se4T1IvmWUQmzMu6CTw
         DfNw==
X-Gm-Message-State: AOAM530KIQBqFdpRLiXQG5a+A7uMl24IfNka5o/TrZnINJggL+nwfgVu
        Ckxn1ftuVFHFOS5TJj+QA42PJg==
X-Google-Smtp-Source: ABdhPJzKynsmfdYK9VJRUnYMzqpBWIlV3r+EUp0UVnf/NsgxF3loXx95BD6FsHMtaaha/M9uHvBSqA==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr67154wrw.145.1606247055196;
        Tue, 24 Nov 2020 11:44:15 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/40] drm/amd/amdgpu/dce_v11_0: Supply description for function param 'async'
Date:   Tue, 24 Nov 2020 19:37:57 +0000
Message-Id: <20201124193824.1118741-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c:255: warning: Function parameter or member 'async' not described in 'dce_v11_0_page_flip'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c62c56a69fda6..1b6ff04700118 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -246,6 +246,7 @@ static void dce_v11_0_pageflip_interrupt_fini(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @crtc_id: crtc to cleanup pageflip on
  * @crtc_base: new address of the crtc (GPU MC address)
+ * @async: asynchronous flip
  *
  * Triggers the actual pageflip by updating the primary
  * surface base address.
-- 
2.25.1

