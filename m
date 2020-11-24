Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DF2C3114
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKXTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKXTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:42 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93585C061A52
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so23564501wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea+MZ4SETfT4WFr3DgwI9kjy4D+XbqEDvpGgUqZKcMo=;
        b=HDVEve22PQjQLPJNjH06mAipBi1w1c7FoGv7APARQFJEB8Lr7iNE1bZmbMz/vKKHML
         MQbRNDETI8MJrbuDGnUlheO5oFIYvZhdgDkHAWeSfRGV1g30bzYvMQC0uEsTFezPno+9
         UfEdVjcFhZTiVurEuXLqw5ZwLN5D4ZJ7ZS3kLSvAEnWM2zOsNvbeT9xnwv53Fi3X9pHC
         a7tn66AwHqo1Sj+a3BtoVJKB/w0noZKMEJQGi2O4xjUktRfbFIY/yWoLkJgvzDOnwNsz
         WfchD4urO01qtQaCsZzEiMMD1eTjxmLWUBlzX04sdihIgMKaIKJu5vEY/dxR3jXH12Hf
         yHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea+MZ4SETfT4WFr3DgwI9kjy4D+XbqEDvpGgUqZKcMo=;
        b=TpoM2yjTfxDGmTJ3eNBYAeXs9GCSjnnaq60CH+z2iHyjcGxsBQjRoGJRrOJM/l+9sS
         qUYEOBDI1IJ5fKVLsH/DYh3j8R+tHCPIOKiRsKWRqivtTN6xv2YKP/z8nrD4QRrsFwY/
         Xb7Drt1X1BUgzvS6Fw6bNDYeXuj/76fyUTFTSGyFWxOJlLkRf/eLKZ0dDzpbZfRXhTgz
         L2bLdmJqJQDg/58O2sxSW3ohz90KsufoSdMgQkBx4r270ksVbTX1OIZ/8uBI2SRuZIvP
         /ycvwZrZkmaFdqZSL/sAaJjiLMzvlqbYfUSbKTQRSv8lb/QappdoqmnJlQX+zJkJAxGU
         zIOw==
X-Gm-Message-State: AOAM532JGeB4FXtlmIW5jBjG9PhgmcG/7jypebxafoDBI9XXySrhYBix
        PxGOCigk9tlhSNlAfyu373+Gag==
X-Google-Smtp-Source: ABdhPJzJscRsPSjrCdloGZX4iKtODDfMRSxXemQOx5ZBCJc8vyH6N4DZpRSGqUy0OS0ELBbGEslFew==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr66630wrh.205.1606247080372;
        Tue, 24 Nov 2020 11:44:40 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 33/40] drm/amd/amdgpu/vcn_v3_0: Remove unused variable 'direct_poll' from 'vcn_v3_0_start_sriov()'
Date:   Tue, 24 Nov 2020 19:38:17 +0000
Message-Id: <20201124193824.1118741-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: In function ‘vcn_v3_0_start_sriov’:
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1242:3: warning: variable ‘direct_poll’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c5e0a531cabaf..e05af69651723 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1238,8 +1238,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
 		direct_rd_mod_wt = { {0} };
-	struct mmsch_v3_0_cmd_direct_polling
-		direct_poll = { {0} };
 	struct mmsch_v3_0_cmd_end end = { {0} };
 	struct mmsch_v3_0_init_header header;
 
@@ -1247,8 +1245,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
 	direct_rd_mod_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
-	direct_poll.cmd_header.command_type =
-		MMSCH_COMMAND__DIRECT_REG_POLLING;
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
-- 
2.25.1

