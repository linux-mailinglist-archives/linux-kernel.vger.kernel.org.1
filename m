Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC02C563A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbgKZNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390836AbgKZNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81250C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:06 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so2219275wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zctwnJbPr/3TheGemqq6daAKnhm6ZrMfRQU0PGJhDOc=;
        b=pDltQRsbWl/HhtFyKynIgVHjgGqhl8RyOCVAoakl6T2/8wQPLspSu3Oa1tiDcnfopy
         e9D3OF04dD82YCqF5viq37JgLD1HapAh5shN7dH6FVZnGYgYbc0Nr9n5wp71x9uyA763
         hyVzYQIDCSKZ3qg7AUYKz2AUUOxhJCBcdKTAPiiEogEBCt6VifYy3y7fiWtoAvYKOqMI
         Tfc9eqOdOIM9Zu537WK38RgCB3nxr4F7F7MLFjrUEbq0WGiUq2ArU1o8ynd243lFu6vm
         Q1F4RwWUGcFs24XS6hUYjYtSpz/1ARAh6nm2izEluG7BUhlkfK9Eh6L/d7/JnUIEHLN2
         FxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zctwnJbPr/3TheGemqq6daAKnhm6ZrMfRQU0PGJhDOc=;
        b=LNXpAcyRVITYF6P9ERXLi8nnaqKEKqilKmWkUBv89G6TuxNmExNLH17MvqHNAf9UDt
         jyXG9Cvat6gWqvRSGBpDe9dojWY+eCQr1aO450GbUyyWWNNQ/5TRL4xaC2zo25+QASzu
         gHn/cg31a5QIydPON9b7B0mK1m7eqTxL+Zs+/9x0AHxP2IJI/7eAjYsv4PjemoateE/t
         79v79aar8c+TeAWNPMrXV/x8yc9g3kBEmWCJcDkRu4FpogqEm/o3LdvPepd1/KFffdPt
         /w37dSqxhQnWXyu2VqMJffRuFl7oi1nPzusF6fltXkjSosqsdp984K3aWau0m3s3MGod
         9swA==
X-Gm-Message-State: AOAM530Pd0sSB6iEhc1/+f6T/w3dZ5C8opOwpmiqOn/MPyrZgUi8acsA
        35JNl8tGMQSWwh9Z9/94B7wyE9vIrQcdhMTl
X-Google-Smtp-Source: ABdhPJzkB7cDZV53G5xGq+in92IOfoSg7x6IHx+jwt3Fbh0mdS3Y8K7Tay/v5tcXoBvYZmHGxLlldw==
X-Received: by 2002:adf:ec8a:: with SMTP id z10mr4054719wrn.113.1606398185299;
        Thu, 26 Nov 2020 05:43:05 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'smu7_init_function_pointers()'s prototype to header
Date:   Thu, 26 Nov 2020 13:42:13 +0000
Message-Id: <20201126134240.3214176-14-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:5696:5: warning: no previous prototype for ‘smu7_init_function_pointers’ [-Wmissing-prototypes]
 5696 | int smu7_init_function_pointers(struct pp_hwmgr *hwmgr)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 0e22cba3ce3a6..393e4e76a8961 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -828,6 +828,7 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
 
 #define PHM_ENTIRE_REGISTER_MASK 0xFFFFFFFFU
 
+int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
 int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
 
 #endif /* _HWMGR_H_ */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index ec17a3e63ea02..7999091cca16e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -46,7 +46,6 @@ extern const struct pp_smumgr_func vega12_smu_funcs;
 extern const struct pp_smumgr_func smu10_smu_funcs;
 extern const struct pp_smumgr_func vega20_smu_funcs;
 
-extern int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
 extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
-- 
2.25.1

