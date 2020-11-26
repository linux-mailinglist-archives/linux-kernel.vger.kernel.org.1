Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE302C560B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390765AbgKZNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390758AbgKZNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:54 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so2173465wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldsB1ybseYMp8ZBJ12vzzY4XQciSVJ5HSbnDxd3OzfI=;
        b=nReHHg4y2GwBg+ELtmf6FKwwwAdv6FVyF8TSlch4nRCGTQIlzqgbmoe8jOy65PUNtC
         QZA85Hl+za8IH3wCN1maDRJBzWHgekSGAWVe1ujb9l0mJ381TiuS7MAOxETiefpPaXal
         9KUA/uc82NsiO5ek53XTMgL87wJZNqP4j9zolH/e0trnLg8vMZAdBBQ60k5vrk2DVMTi
         pIHLlgDKi+Tirc5Ix9rsVwi/D+KCuXckmZQ8l9Lmqw8WRADwOMXChgsKEm8RyaVVTuzl
         /LpSYMLRqRuuddUIUGJ1zrrqYv5ymqV1+9f3PEdlgwfMFp0IvAjV7Vw32h1noxdmD2v/
         rVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldsB1ybseYMp8ZBJ12vzzY4XQciSVJ5HSbnDxd3OzfI=;
        b=GaBpu+QC7m7twPGME/90ykBSSii31jF+5QiydK1yPosXAMMFM33jlTL1dH6us/KYcB
         Qj2os2Dit0YT6jmisnsclrzzQmlRqZqkCI0qOMzxLTPEj6+wmdgpy3vwf1nPl8ZT929N
         BonL6dwMXj7Zk2os84hXpa+HsEobZBNoggsCDowS5r3TjdEqT51JNJXKn4VEskW818jR
         DxwpN8RLjeMwPLJySPWavee0K4D+55PxIJ6hGncmiIACI4LZC168+fwqhKYjXm7sqOPZ
         1GSfhaXfR7Q5JenYpSU8Nei5jlXHPmkE/zrFAlNx5CcTWyZLZZ4xpLHtua1QkmO0Ww7c
         cgjg==
X-Gm-Message-State: AOAM530R/jmBkotdTyk0qOAuxvPhpi/CTLXlXzP2BPPftj/DAMh8S1O8
        +EstlJbLVD0hqGEV/eL0pNxmiQ==
X-Google-Smtp-Source: ABdhPJzJRjrTBh1mNZ3EweuonfhsRNL0SPGQIQZVyDeSp+pKVMCn3IhQ4KBalcGJsP6s5OHfo901MQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr4114461wrq.308.1606398171231;
        Thu, 26 Nov 2020 05:42:51 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/pm/powerplay/smumgr/vegam_smumgr: Make function called by reference static
Date:   Thu, 26 Nov 2020 13:42:05 +0000
Message-Id: <20201126134240.3214176-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vegam_smumgr.c:2249:5: warning: no previous prototype for ‘vegam_thermal_avfs_enable’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 38a5cdcf58967..7d024d3facef0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -2246,7 +2246,7 @@ static int vegam_update_sclk_threshold(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-int vegam_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
+static int vegam_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	int ret;
-- 
2.25.1

