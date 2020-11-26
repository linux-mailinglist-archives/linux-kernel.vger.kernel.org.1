Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624E22C5642
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbgKZNnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbgKZNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587B8C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so2196799wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsUlZcyK9oDSYfP7aoF4k5mpqGBHBlqjcNJ6DNrVjtQ=;
        b=lhUckZuAchBUkEww102CZlmtg7ZDdRdMNObIae7NG11Fh5nIJxysDWj0BqvK17jNrv
         DYy9m2oKxLW1Fq9PTcR5kfARz1z3tXycyJMK46eHeePCtKMEJdUbSKlzu3XJKBjMoamf
         bUapKZWnMGvaSmW4aL1UA1kIJ8L4S5q7Fm7VncMBM9HnlN1Gmav9EOfrSNVvvzuHvQ2C
         DPvybRAuRRbvvUpsEE3Tamu47wGUBrepeNVKTlG5HmVSEq2RQjcpMlHgWTyVCaO12V6z
         9nOgkzjVza7g9eOwLNv+D5f8ynNDWyWQG+zybg+6hM10t67YMnenfQDPa9zA3swElhzT
         kBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsUlZcyK9oDSYfP7aoF4k5mpqGBHBlqjcNJ6DNrVjtQ=;
        b=M5uxJ3DfMC0pkGYF4hGy8od1kYlfs+jl58EQIijcHViEfhChcKA1jRYMGQoXmbD170
         l6N991YmG+Krg5Tinr/Xjd/2Fe0Db5Ozwd8jPTRe57QabUOkAkbgQWeuKWG7mQi1q2DL
         dqZRfyIOQn8hzPGZESr4PZNQF3UtO2NchMgP/KxHN3fUt0278tDIFoxU4PzMopP17kdF
         xtkapgcqc222OhierHdBxZgHl6OccfHlAKnuImLMG3kQL8T3rEvZ6ainacSMTKjl2luZ
         Ux2Bbl8Oju67RAbQA983OIO9PyDg78Ur4Q7Esij9oyPPhMpltvbY8b9fYhcPwjHiZOD0
         n5+g==
X-Gm-Message-State: AOAM533t24Rix4sRL/o34+j1rEAlyDy+FHpCHtw064fhuNniKxCJHUm1
        A6XagIAfyN51WwbJkOSL96iisQ==
X-Google-Smtp-Source: ABdhPJxTtnTSysGbUMGfkOYBe/RMMJUsCFSYyVyn2rfvnPvE5fMIiiMGfiD68z7l/6axdmcLLerg1w==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4113531wrq.204.1606398196124;
        Thu, 26 Nov 2020 05:43:16 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amd/pm/powerplay/hwmgr/vega10_processpptables: Make function invoked by reference static
Date:   Thu, 26 Nov 2020 13:42:20 +0000
Message-Id: <20201126134240.3214176-21-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_processpptables.c:1148:5: warning: no previous prototype for ‘vega10_pp_tables_initialize’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 535404de78a20..95b988823f50f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -1145,7 +1145,7 @@ static int init_dpm_2_parameters(
 	return result;
 }
 
-int vega10_pp_tables_initialize(struct pp_hwmgr *hwmgr)
+static int vega10_pp_tables_initialize(struct pp_hwmgr *hwmgr)
 {
 	int result = 0;
 	const ATOM_Vega10_POWERPLAYTABLE *powerplay_table;
-- 
2.25.1

