Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5B2B1C72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKMNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgKMNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96EC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so8243424wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fbx/i6xkdl5U3TCyGHC7OwtokMdU84+FveVergF6/Ok=;
        b=R1shnNVetX4luA2olSUjEUcn8RXbxoyUmnCpZ4pRXk8LujJR/7t/PmhuT/jdLA0YG8
         xdD0sDqtV4pG7nM8HQoEmSLcyNOcnklXEXFWPprk1HzH6oLPRMe5Fr9o0dn+a7JVklBJ
         AOTs4bmp6IjZ4AfdE8x0MIOIsH8NcoCqCq/sRmde2nuqAllLptX0ST7D4MjQoyp6LwXf
         98S1AE24vbzy5BEPTalNeNPn8kzE1W1M1RMP1zwRYbvH1oAKvH6IrHr3iLcroO7PnjzQ
         peUSjRSdghyuoehDuQU18l3Ps2p3pKevRGrvwtdEJPWnF8CIpwUpgVqVQRjVjzMciRnM
         WqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fbx/i6xkdl5U3TCyGHC7OwtokMdU84+FveVergF6/Ok=;
        b=Gdcz3JEalOd0opUtN2D7QuVzf2ZbNIpYGimb5/cQNKoE6F2W4E2S099qbMW1FkKGGM
         OMnU0Hu8nmDVmwsTxh8TMFPye8TJNeaWS16bADZSHCXfC98aNObLvMTyBxJjH0BBk2nV
         MIgSid2iaEnhvCYTVQOJRlKyz4mVK/gR9M8XqwA2wE1yEj7rpYYVvgu1nmFUxJ+/+7Vm
         XO/SsiKnsGya44Ju1KIOl3cWTRMgb1BZAktoo6PdHN8HmCp2Y8OuPYr888Wq+t77kdzA
         ErwRB5N0a126Ms/P6Rk4fln+A7nMadwB1fb0482NH0ZfIjufn3AkQUBVEVYiLqOeiyuK
         zj7A==
X-Gm-Message-State: AOAM530a0xm6JECIonKqUdjpchhcT8m4IXtkRQ/Z3A+/fpp5rGVUZnDG
        Soo0WX/zc7kNd1D2zV0UWzMsHA==
X-Google-Smtp-Source: ABdhPJwb2YkE98pyU3fex6KmUTxG2VWK5VdMpzDRBejv+5JxJWIng0MFvboFaeU2oxPsca91cfjeeA==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr2536234wml.57.1605275408939;
        Fri, 13 Nov 2020 05:50:08 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Andres Rodriguez <andresx7@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amd/amdgpu/amdgpu_sched: Consume our own header containing prototypes
Date:   Fri, 13 Nov 2020 13:49:20 +0000
Message-Id: <20201113134938.4004947-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c:35:5: warning: no previous prototype for ‘amdgpu_to_sched_priority’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c:122:5: warning: no previous prototype for ‘amdgpu_sched_ioctl’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Andres Rodriguez <andresx7@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 0da0a0d986720..b7d861ed52849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -29,7 +29,7 @@
 #include <drm/amdgpu_drm.h>
 
 #include "amdgpu.h"
-
+#include "amdgpu_sched.h"
 #include "amdgpu_vm.h"
 
 int amdgpu_to_sched_priority(int amdgpu_priority,
-- 
2.25.1

