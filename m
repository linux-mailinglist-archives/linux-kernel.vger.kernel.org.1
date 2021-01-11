Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26CF2F1EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbhAKTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbhAKTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4F8C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t16so948572wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuOitA3aMnrp8CglwtShTzzn7jDAI9y/ji+mu/BKLpU=;
        b=FHGS3Yz4+1uqLaYb51IUybjr25DwHxn1LcCJZAw4g9amf/enmcfg+DhtQu8GqokZvd
         bDFkCeC4jt80rWilLOaSekS/ChX6BJgQBMXV0oKw57dzcusfRhsmLBxSqlDnqxm+FW32
         pHB7qQWTfaCxgNNQIM25xK+ga20o2fgDYfu5ed5Mz0vmCd8ZxWEwo/tVRYMUgkx841kE
         RAqQLZd4dmSTHYAEVuJMgSnOCJI8bCU9jORkq7sogYyYD2+mw/h7s51KSuIWtIf31tVm
         BamR5VUzQNm9cTnCJkfVSUD3oGWvdBUFwKe3yWpLxI6pv9zC4enlxSoaogztlqTzEf8Z
         jcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuOitA3aMnrp8CglwtShTzzn7jDAI9y/ji+mu/BKLpU=;
        b=mv+fO0HpD6hzjBiMyTyzcNpiRUMs2QDnILpdkSYHJDv9MGEEFPAYfMk0klNOVpPcRy
         emphobKXGtK4Hu/SI9swca301iB1m0FeTwylb28bcmySGbbbjyjl/KOK0LpvrpfVNpMZ
         gVz1BkoYw4Kg1TNufiak6iF3hXRgyGglsCpVuCpT1kJlUUEYpAqz7miAAliK44fPRjpW
         zErIMZZpIek5q4qmDII7KY4AH5L+H3UUNtA/OOwXp6ABHVJaAly1y9UMt6Q92aCmRenv
         nWr4DBU5g0cM7rwuAqxsFxU6dRjOtb3xj0rmCI8lbiSqbwFCCSaErIYevnkTb37SGBju
         0Hpw==
X-Gm-Message-State: AOAM533+zwf03HNtdDG6VeaqioHRzCjSA9l4JocKakKdacFeO2jV/rJO
        5EVMsMDmycI3d/+sTuM2/b70FQ==
X-Google-Smtp-Source: ABdhPJy5k5eTrlHXOd41/BzzmGq1UKuzMUpQHvfEJQfMsk1I4ii8bHCBtOi5cka5gfRVT5eRzU1n2A==
X-Received: by 2002:adf:c454:: with SMTP id a20mr594473wrg.314.1610392771765;
        Mon, 11 Jan 2021 11:19:31 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amd/display/dc/dce/dce_aux: Mark 'dce_aux_transfer_raw' as __maybe_unused
Date:   Mon, 11 Jan 2021 19:18:47 +0000
Message-Id: <20210111191926.3688443-2-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c: In function ‘dce_aux_transfer_raw’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:579:7: warning: variable ‘bytes_replied’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 3204292a5aeae..d51b5fe91287d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -576,7 +576,7 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 	*operation_result = get_channel_status(aux_engine, &returned_bytes);
 
 	if (*operation_result == AUX_CHANNEL_OPERATION_SUCCEEDED) {
-		int bytes_replied = 0;
+		int __maybe_unused bytes_replied = 0;
 		bytes_replied = read_channel_reply(aux_engine, payload->length,
 					 payload->data, payload->reply,
 					 &status);
-- 
2.25.1

