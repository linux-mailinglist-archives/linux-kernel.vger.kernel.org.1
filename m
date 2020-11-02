Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB02A343E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgKBTfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:35:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F80C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:35:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id z1so7318831plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2lbMlvM7aWGVHz4uVqI/5p5HZNqB6mCF18RFUVjf3IE=;
        b=i96sEWF+S8v5jjYJ2xNOpF2zGVRZAJkShGc54QxYUawVtICygWu5WTCoiCbQEzV+ur
         QvC3b2fo/4rZLGPGVaun1J/ktqTfl03ws0QjCMa1DTDdhm9hzamk4Pm6kfJE5h/wxv20
         csYlAvfdf+hh8WhkA1+6o6gi1uKShtzN1EdgEMn7FGsNoiz/ojY7TCcSY+VpGtezZFx9
         n7IL3oeFrmx18T4jcC00s+UUndq3+xsZFTXohM/4Wg5C3hCV4hneZ6RN/h2hSwFxjCpX
         2knpV3917P4KHvRl8IhS5uZxhohOtk2TKI2v2r2Ec4J8pgtLkuGkYl3nf9RmQEmi0paT
         CxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2lbMlvM7aWGVHz4uVqI/5p5HZNqB6mCF18RFUVjf3IE=;
        b=dkT3KfRM96Mezf1Cq1lsDIzmyv+MyYj/tt+OiwgxJBO/3lukIgPFAX1ZY1kZ45zzdP
         fe63jEE46Jt60E0KtnUCgFafCYR/OoMSGqaZhdQLAxUnfQJpWiVuewenWnaHiAPGy6Ix
         I+FshDlrSZaSL5XxVw74Zckmd1cPajtppp4BJe4IcjOTBWN9nGc2LlHy639HMeo/Xy9H
         a0EHqipBY27RTLq9nU8MjEyctEKr71b88aEJBBNJ69F10GaAJgMbpshb6Or5tu/3IBVJ
         88SGdjZaUQA2RjRPxg3QphM4aAdOWUsU+3HeTKLgIYbYgixsjLOxS64hyCwYlSpDCDYW
         I7fw==
X-Gm-Message-State: AOAM5337lTBuoCM/Gk//EuWO2tSxkaqhT5LxtObNTPaYCgcLWNOUGPjz
        rFA8NyGW12/vz26/69x7yl0=
X-Google-Smtp-Source: ABdhPJxTjvCKuO1rp6ybPQ0KppAeZO2klLbBN64AHYKjstw2UMMyvJMBmN7RiFHs1EgkUYWlcrAWkA==
X-Received: by 2002:a17:902:324:b029:d6:ba15:90bc with SMTP id 33-20020a1709020324b02900d6ba1590bcmr10902741pld.29.1604345731743;
        Mon, 02 Nov 2020 11:35:31 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id g85sm14651760pfb.4.2020.11.02.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:35:31 -0800 (PST)
Date:   Tue, 3 Nov 2020 01:05:25 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 2/6] drm/amdgpu/umc: use "*" adjacent to data name
Message-ID: <32f014be6bb816aa37b4c0670d2ee990ce596b60.1604345594.git.mh12gx2825@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 5288617ca552..96d7769609f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -253,7 +253,7 @@ static void umc_v6_1_querry_uncorrectable_error_count(struct amdgpu_device *adev
 static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
@@ -368,7 +368,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 5665c77a9d58..a064c097690c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -170,7 +170,7 @@ static void umc_v8_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 static void umc_v8_7_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
@@ -260,7 +260,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 static void umc_v8_7_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data* err_data = (struct ras_err_data*)ras_error_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-- 
2.25.1

