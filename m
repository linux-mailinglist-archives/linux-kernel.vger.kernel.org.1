Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206282B1C71
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKMNuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKMNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:09 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24801C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so8207708wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGQ7i9boPClQe1oyR8utsPB6lLJWRf0r7to87NlJAVY=;
        b=tq3YEaY/3TDVCn8qdDXnhOaaOrrxOH5BxxOKr+wdKm7kChxUnNxuggo9rpj/reOkjV
         y2Vq9KREeLPXJ2WPiKYB3kyRIdXpbfStNqg8NRiCJGsQPIv4MByCZaHm49tkAMEe2wBs
         cfNqUTziP7ShG4PEJp8SzklYk/xeH3dDelLf/Wx2lp+x31i3n0JZoW9dx2eYNwmEwAKm
         RnODfEx3Pa5h79269T7DHlX6YJwhZRbTZBp1deopMe5/QXVB7d6soWsuO75rkZsRYhPk
         kqtEpTC9r9eMqE13Rg74gHGz0LWVhWtVR/MoppqMCXKEF4pTzRd7lbijMk2oOz7YZdp7
         hjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGQ7i9boPClQe1oyR8utsPB6lLJWRf0r7to87NlJAVY=;
        b=WYZ0RmLlM1tl2K6Xkbyaa4SF7rEPXykoiMzOEE93I5d4ZUHD2kzREAsYywuqDSs6Rw
         4IboCf/vSSdAeRXHOxSYaUKMq6qS2sbj2uhKkfNTSsgLwL403LB5YD7aLJ+fcjqd8gZ5
         NnVmRXUPYxMm8sw3KYq/bLMplfnpyNkJ5Z4RqudNxq9Rt0SfxmMZsmuvt4ieSq1H1/ZP
         UoZNE8L3Mxnjwi1y9wnJkUlINVG4U7VmE3FcXoHjtajUmRBNgrwBVFGz2Wi+ysZ8xbTz
         fwBrOUUbMCOvDZ2UWW41xKREpiWv9YaWs8/UVolCDuHKZFtBdvW1ZOJYc7PMpu649CPs
         YqbA==
X-Gm-Message-State: AOAM532mGSfW7quW9PhZ8sM+eKaz1CSdokvxSe8PQCtiQ+tunUdYv8OZ
        EhkpDo19Uc4PKo5YcC3858qy+Q==
X-Google-Smtp-Source: ABdhPJwD0bDR7huq2ppkbFkSvCBisuFBCTTr0W+eZnfRWOkea8mefvO6GAjT1RzC0ZQfM0qVBMnLmw==
X-Received: by 2002:a1c:bb02:: with SMTP id l2mr2555867wmf.166.1605275407774;
        Fri, 13 Nov 2020 05:50:07 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/40] drm/amd/amdgpu/amdgpu_virt: Make local function 'amdgpu_virt_update_vf2pf_work_item()' static
Date:   Fri, 13 Nov 2020 13:49:19 +0000
Message-Id: <20201113134938.4004947-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:560:6: warning: no previous prototype for ‘amdgpu_virt_update_vf2pf_work_item’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8aff6ef50f918..905b85391e64a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -557,7 +557,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
+static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
 
-- 
2.25.1

