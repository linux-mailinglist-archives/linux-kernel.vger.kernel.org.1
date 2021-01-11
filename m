Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F472F1F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbhAKTVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390980AbhAKTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0CC061385
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m5so904658wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOyt7JjenC3JxqplAWuaS0Peh67vONfoPebrIaqCVaU=;
        b=Ury54x86y0TSuDIGEgMyFRNXMi6mvZtZR8AiUGxf02KEg/Qk4G3safKG2e0UTeBkIf
         tXip/SBGN84y+PtcTOPecltGCNZgttFwjF/gJbhObDFirf9Rqw5bR2AZz2ksZyf7kKSV
         LOuPcaEwhtYXNt4q2+3WDkeqpt+utoKpIqA4jdW/+BWP8EB2d8igUF5Z2/7UrsUNR5hh
         /tcnM7v8bdlDCDCDVJrfqd2kAe+tUzeDZD6FNYloXHdK4JKthUYZmTKZMdDF8UYC7/4j
         hY7uoKS6mYPQAXl5PsZs99OkmqMqhPfDsh3LFCkrpi2U+fz6ruKWyc1c0iZgHthVYQAB
         O34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOyt7JjenC3JxqplAWuaS0Peh67vONfoPebrIaqCVaU=;
        b=dP64i26FbyBbNzT+i7DH2JzaGmdzxyd9QdbdJAjHc3/LCg/USwbcyY62m7QNdKduxL
         hncY80yFH4FgRMj6lO0wO4qDkKUTLt/Btqpn7qpcKd74KSHZT1i7ugbtKtEyEgOHBFuF
         h5ssWjc5Wb1+aS8yYkvClUwecdFx2UEjag9ls3ksaWVEZuwrs3gg6FKCrpS1BrEcVjt3
         MkOBp+zUwCcc5nSQ3vzSUnpXkO4+EcwMzW6bCGjVvVYKAXn7lUZ3ZwOOTwpFyqpIkCUx
         Xf5EIgphV5jFOQwFHbXlwYcE9TiYdZMlZjkecCpSQXwfkpWTb8AQ8Ljaj6ryQtwVBjgZ
         EWSw==
X-Gm-Message-State: AOAM530ak85BI4g0qMDtmlpYrEAyG4PIkpdGHaOZOUJ0HnBLqWQTjaOC
        vrNAjFvO/DWFuvHSpWhI+ghaIA==
X-Google-Smtp-Source: ABdhPJxLFoQgYmFl5UgzBe/khAM2fQsCzRuicD+oGb/jb0HKJXsiQGNceE76zUWTuG4yFLctHbnX9g==
X-Received: by 2002:adf:82c8:: with SMTP id 66mr592128wrc.420.1610392801743;
        Mon, 11 Jan 2021 11:20:01 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amd/pm/swsmu/smu11/vangogh_ppt: Make local function 'vangogh_clk_dpm_is_enabled' static
Date:   Mon, 11 Jan 2021 19:19:10 +0000
Message-Id: <20210111191926.3688443-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:613:6: warning: no previous prototype for ‘vangogh_clk_dpm_is_enabled’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 75ddcadf3802a..37bd4c647418d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -610,8 +610,8 @@ static int vangogh_get_profiling_clk_mask(struct smu_context *smu,
 	return 0;
 }
 
-bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
-				enum smu_clk_type clk_type)
+static bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
+				       enum smu_clk_type clk_type)
 {
 	enum smu_feature_mask feature_id = 0;
 
-- 
2.25.1

