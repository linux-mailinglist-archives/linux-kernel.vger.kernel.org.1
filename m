Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA02C2B0D59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKLTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgKLTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C02C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so7169523wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5obwl2HLa2hJZGgN7+byxbis29C9PE5dIA5hYQvye+A=;
        b=Ou/EHKHaEikqtJE8cSM3UeFbvQcGsPiJBRWhjq0TuVV/p+7lAQB2pg8b4Kd4VZd3N1
         /ZIKy/fqiwlHuzVcGicWjs831K9oFyeMNkx15nOMF0ribAwncR+UlsMsN53nJxHpf8N9
         HXUn3sdCI7FBbNOTOcZj2kanCeY73XcDbJJE9vCsZpZOtsDcws/JJn8heE5TwbNydQyK
         Z3uZJT4YcJlwukgQusZuPZoA6EJC5YxUtc1/Wr1tCOJBTIn9eMzncQXP0eUye5RR6Z85
         LuqSc1Olu8pR4ucIVUaWvTlZPOaVBKThOibDWHfCJzrYn2QLuLp6Tgta/aAwympaqPdZ
         59Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5obwl2HLa2hJZGgN7+byxbis29C9PE5dIA5hYQvye+A=;
        b=r+UlSz+SwKwsm+eOfkvtLTyFJxfCoAafl76wpwOUCKuEI/JUzxoYsthdYMmRZ66S8X
         p1/Ee9Ie13dS4kQrBssnVOY740hrWuX1oHHkiCppVjmIOWTlQjyzpCz1nS5/WFYrDPHo
         yu6e/AL/L06MmA5mVC0thENro1eogkAHbjwqtye3Ua6vBnVrqC+FYyrZkMPOdSyv+D/6
         EeoxqnT3YR/pOROID4QW1IhPu+l8wfYZ+WWNAzYrwrmyQhHw3vrB+liUswbyfBQLIKrl
         i5REjvak7jrzjJf4+nnWXdGRRgTFcnfyN1W+M6yqRJTXWGjqAfElCIIf1OeHaVteJa9d
         NTDg==
X-Gm-Message-State: AOAM533JEsieRRFAVlntlUFOdmqOHJhaNZMD5G9PyIJG8O2FJItVVxas
        YjYTBKFAsN8VeFRzUCxxUeAp4Q==
X-Google-Smtp-Source: ABdhPJx07SOqt9KWRMUyfJ1+GAfuKqqM57OQvbqX7ApkBIo/nwqUkubWztVTEBpNnZxx73TJJKtv3w==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr1116351wra.247.1605207677934;
        Thu, 12 Nov 2020 11:01:17 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        report to <xorg-driver-ati@lists.x.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 15/30] drm/amd/amdgpu/amdgpu_display: Remove pointless header
Date:   Thu, 12 Nov 2020 19:00:24 +0000
Message-Id: <20201112190039.2785914-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems only to repeat the function name.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:450: warning: Function parameter or member 'amdgpu_connector' not described in 'amdgpu_display_ddc_probe'
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:450: warning: Function parameter or member 'use_aux' not described in 'amdgpu_display_ddc_probe'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: report to <xorg-driver-ati@lists.x.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0b134598b3a65..f4de4b41adcfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -441,10 +441,6 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 	drm_connector_list_iter_end(&iter);
 }
 
-/**
- * amdgpu_display_ddc_probe
- *
- */
 bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 			      bool use_aux)
 {
-- 
2.25.1

