Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27E29FC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgJ3D1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJ3D1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:27:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CDBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:27:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so4095062pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bnHvCuE87pUUeamFRrdRkC3/PfrKdLRFG6Yr9LjsnHU=;
        b=nRD8AmlOqJ8JayRjEopJ5gsIvdMeLsA6FdS+XJv2WFxcMo/+k7r9F5ErGu6fOFW8AQ
         RTdDljKeM5HQDBummdsxSpQUh3IjjRVzi87ByrvD2MkiJrhTmGRT35F+7aLPWD7+sidl
         Kv9plJtGdW2FL9gT2gv5Ri69CUQrpxWgieYZM2uZXZmUt431/qypzu54jCsKUAFsG7nQ
         f07ABRL0UayrZZsHvk1NfDvTzhRtiL4uBs/K5SGIIB+6Q6gbcI+mcfKw7kTPV7Owsq+X
         3bI33+X8zHRUpqf0Ehk6Q9xJQkjcVMbWirQ45OILc08QA7/bdbhZjg8RTuOpUyERvQDE
         7dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bnHvCuE87pUUeamFRrdRkC3/PfrKdLRFG6Yr9LjsnHU=;
        b=XersVzC/TkyavjJpNni7ZFpKgw/4H95LV7MEtizd5u4RPYanvaAc2IYD+WxGq6q9Si
         xNsyBtopCi4LR9Ztha4WTGz1UlHPPAn6tXW6u9HyysvEJpGmzBTIkjrVx7CD0jhtC+8p
         /U+bQ+f5rXgiSAV5ljvgFChSpFk+26XAT40U4+g9W+sGYAp8gDguj6QxbPzw6znAy5tQ
         SWevrDSS6QAZkoHqLqHlm2P9gUCbtgN97fD/N33uHeUAMlnb0Vh037oKFHpa5UbVsE91
         bdGwN/qUFCMpiuCTnlbvjOqLgZ0pmxmZHHKUFZxKF3FFmy588gsZ2GSM3TpFeLi1+UUr
         ZvtA==
X-Gm-Message-State: AOAM533WA958HqCQPSg0L3xBbilRkZoiEMFiG7ZKkptXbrrWDsfvoReI
        xN5LY5bmtq/9Vd2CUU14icw=
X-Google-Smtp-Source: ABdhPJwsO/zwvK0kUCMTFALpAm2G4TaQ+/FtpdQPfUSL8E1dywEkU+dfQeT0it8MKkuUba3+AQFDIg==
X-Received: by 2002:a17:90b:3658:: with SMTP id nh24mr310667pjb.177.1604028451119;
        Thu, 29 Oct 2020 20:27:31 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id z66sm4274336pfb.109.2020.10.29.20.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:27:30 -0700 (PDT)
Date:   Fri, 30 Oct 2020 08:57:25 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/amd/pm: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030032725.GA274689@my--box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
function in place of the debugfs_create_file() function will make the
file operation struct "reset" aware of the file's lifetime. Additional
details here: https://lists.archive.carbon60.com/linux/kernel/2369498

Issue reported by Coccinelle script:
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Please Note: This is a Outreachy project task patch.

 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c  | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 740e2fc7a034..1e79baab753e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -252,12 +252,11 @@ static int init_powerplay_table_information(
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
 
-	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
+						   sizeof(PPTable_t), GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	memcpy(pptable_information->smc_pptable, &(powerplay_table->smcPPTable), sizeof(PPTable_t));
-
 	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 
 	return result;
-- 
2.25.1

