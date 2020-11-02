Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18D2A3441
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKBTgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:36:48 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:36:48 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f21so7338363plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHfdGffEtslcisUCbmOeWSW1VApIiY4Mb7acBIRPvyE=;
        b=iiUFqfdjvBU7bcdjzspXUShhRDTCbo5dH9vmWRO78vkNOfrSrhFjNBpCGfr1Azs5ks
         HbyvxeWs2SsrmO00bICt8cKMJ94AW7vJBmCryOcaIzSrk2JW65JRoJI/iohRUVqX/ZbW
         5p5W590hKKaSGXe4ACQsa4trr7+U7kpTjjqsnaz4m8/a2WpIvCrAHbMq6r4DX4ywfYwY
         8T3jHAdSTGdDp4CRPuuUhgy8l5lZLkyfSgvkmNvxwWE5u6AZUipFZt/wWq/AYuNUnmKa
         AjSvPFKBAiFVe5Z4q26aKtdrPLzGjmu2MoeOZsIE/fMEbwZveMOUrK08jypD/OiTS8kE
         kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHfdGffEtslcisUCbmOeWSW1VApIiY4Mb7acBIRPvyE=;
        b=MgniZ1UbTv4oz80ZVakplKyBX3Lq++rz3gybX6Ka4IbWpGWt7BTMuukk95jDSccCGU
         VpJ3F0GMtY6wCQPYtBec2lQyGmQKMEohlYYCYCRoAU+GBOvLSY5xnFF6xfNVs/Q2ySGX
         LTSk0fu3vlvMWLjzlqYseLgDPWdhkxtZjBRd++amsVGM004cILzvYr4wtCIQLCHooRjp
         D4+jqRXsLOAZa+dt3BNfes4XNXqHGVwb2okbY6PZomvAy0wC0NpM4TpqXaRYOGyRkHmc
         YXzxUq9iH5/1GOX3C1V3EOq+1fuICRACwplIxXLvfAcx5Pmv5nAkH2SgM1qR7dLt/VOV
         TjPQ==
X-Gm-Message-State: AOAM530gL1lATlmLmlYzod4J6U4d7/SZ3h3BBiG3na2IO7m1bwnQNzo2
        5uOZyTv++lU45LSTIuSac5E=
X-Google-Smtp-Source: ABdhPJzy9xZcX3I40BwODb2//W/PYSgeWE+3SkP23N7SQ/GgoBHF6dG7cSBPJUz/BgsgMYp9ZiqYXg==
X-Received: by 2002:a17:902:525:b029:d1:920c:c200 with SMTP id 34-20020a1709020525b02900d1920cc200mr22502370plf.25.1604345808083;
        Mon, 02 Nov 2020 11:36:48 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id y5sm8213522pfc.165.2020.11.02.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:36:47 -0800 (PST)
Date:   Tue, 3 Nov 2020 01:06:41 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 4/6] drm/amdgpu/sdma: use "*" adjacent to data name
Message-ID: <38e48a03d83e2c6bda3f3b71a1d09ca4a27b40ff.1604345594.git.mh12gx2825@gmail.com>
References: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When declaring pointer data, the "*" symbol should be used adjacent to
the data name as per the coding standards. This resolves following
issues reported by checkpatch script:
	ERROR: "foo *   bar" should be "foo *bar"
	ERROR: "foo * bar" should be "foo *bar"
	ERROR: "foo*            bar" should be "foo *bar"
	ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 86fb1eddf5a6..d1150c33d02e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -568,7 +568,7 @@ static void sdma_v4_0_destroy_inst_ctx(struct amdgpu_device *adev)
 			break;
 	}
 
-	memset((void*)adev->sdma.instance, 0,
+	memset((void *)adev->sdma.instance, 0,
 		sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
 }
 
@@ -639,8 +639,8 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		if (adev->asic_type == CHIP_ARCTURUS) {
 			/* Acturus will leverage the same FW memory
 			   for every SDMA instance */
-			memcpy((void*)&adev->sdma.instance[i],
-			       (void*)&adev->sdma.instance[0],
+			memcpy((void *)&adev->sdma.instance[i],
+			       (void *)&adev->sdma.instance[0],
 			       sizeof(struct amdgpu_sdma_instance));
 		}
 		else {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 9f3952723c63..90c47f1801fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -124,7 +124,7 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 			break;
 	}
 
-	memset((void*)adev->sdma.instance, 0,
+	memset((void *)adev->sdma.instance, 0,
 	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
 }
 
@@ -177,8 +177,8 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	for (i = 1; i < adev->sdma.num_instances; i++) {
 		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
 		    adev->asic_type == CHIP_NAVY_FLOUNDER) {
-			memcpy((void*)&adev->sdma.instance[i],
-			       (void*)&adev->sdma.instance[0],
+			memcpy((void *)&adev->sdma.instance[i],
+			       (void *)&adev->sdma.instance[0],
 			       sizeof(struct amdgpu_sdma_instance));
 		} else {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i);
-- 
2.25.1

