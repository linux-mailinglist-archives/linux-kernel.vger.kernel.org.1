Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE882C5657
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbgKZNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390878AbgKZNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so2219960wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyYzloTK2PfirZ1Vnz7WwlEZaviGAn+VoMQZs9r0bNo=;
        b=WIR3eyDWyT0TNYDqtte4PXcGFnQ/Bzb+Asak+yqUlKdmVUKM+P8LwCz+pF8EULE5+/
         fZinsvtDeDUkdROR8iwoQhYwsSpfiBSnsb53I/X1vvIN1Ovi2g+yPYoMopGnxjN9F/5W
         UPpITbQrGcPw7TF5WKmjqU7aWG2LUNkXqw+rOumjd+sUPX+oNN1dZqZDXypi2Vq2jrow
         RaZzKKxoYhCq/0w8IziaR/LEYYfT53WrwsrZPhrkhCz0TAwqYXXhH6zt6pnn1UWk8B8T
         BrAWROua9zKbFRYr3mYl4639FFMoyPQbjJhykn44Qtv5NyKrcezEoXpjDYlKciQTk8fh
         bFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyYzloTK2PfirZ1Vnz7WwlEZaviGAn+VoMQZs9r0bNo=;
        b=bpZ12+AKQb+UEfot2c3aKutmStoVoqCK2qMow7IdtRUEM2fk7JK6MP0kME18aX+wvG
         mbWUp3pwnOmAykjcdG7l6fVqyq4i8RZepHc0OJoqjhWu8v17zbQ8cAWQG4fR8bt+FNY5
         CiGoPNstDw048EHm0NuMwRi2QTypDRzbFm1uNXhlxpVrSbuHQuDnoGcXZRImek9LM+5b
         nHQLPmOEQ3mZno5hypockef34699Wp0ghFobewGYjqHdgNj3fejiF9Po7jIryF/IrK1l
         pd/MloxpsSBpFGuOpOCgJJ+UB7cBkcgtHjjR+XPfzbAo0FlOwzAr4FQGwFy1Dut3q5eY
         K7EA==
X-Gm-Message-State: AOAM532T0jFCE/5+SJnltIW0Ioir2+OSfh4olRYfYfhAG+VI3nvZoUjX
        pJDVBFTm87sbBkdg+F3wdfaciA==
X-Google-Smtp-Source: ABdhPJw80r7EtghtjN7YeairyQPRFFBj+KIT/no7NYCDyVPWnHmFtcPpdt08ETrsr3m/vYxhfQc+dA==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr3839571wru.279.1606398198653;
        Thu, 26 Nov 2020 05:43:18 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Remove set but unused variable 'result'
Date:   Thu, 26 Nov 2020 13:42:22 +0000
Message-Id: <20201126134240.3214176-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: In function ‘vega10_get_pp_table_entry’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:3135:6: warning: variable ‘result’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 7eada3098ffcc..ac88f5483ef70 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3132,14 +3132,13 @@ static int vega10_get_pp_table_entry_callback_func(struct pp_hwmgr *hwmgr,
 static int vega10_get_pp_table_entry(struct pp_hwmgr *hwmgr,
 		unsigned long entry_index, struct pp_power_state *state)
 {
-	int result;
 	struct vega10_power_state *ps;
 
 	state->hardware.magic = PhwVega10_Magic;
 
 	ps = cast_phw_vega10_power_state(&state->hardware);
 
-	result = vega10_get_powerplay_table_entry(hwmgr, entry_index, state,
+	vega10_get_powerplay_table_entry(hwmgr, entry_index, state,
 			vega10_get_pp_table_entry_callback_func);
 
 	/*
-- 
2.25.1

