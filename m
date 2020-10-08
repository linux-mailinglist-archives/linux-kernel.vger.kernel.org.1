Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1052875DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgJHORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgJHORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:17:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52120C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:17:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l11so6653989wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zJluAbiLYKXPtNojcpa58wSPE+smR+xHU3IRj+ib1Us=;
        b=UrL9DY8cY2lFuaXOufBSi5ViWUeBe5S6uSGJAnAp2WdUeOoKaPy2qaS+rANexdnV9K
         lYZ/Px77JgA5SG+qvaIim88I+J9flXuyZdXrqZFEC5Cd7kkFqMD+P9MUYejn2sBjqr+j
         JK2yyQTsTM1xSHH2ha8OWEbcXsuHHPJ9rFBT75vwDQw+gkcsaPUn82cIAZFYDFLKE1Ye
         xJM8Slmp1x2rJQtlsdcGzPPxMD5Nkjyk5EEFFKyi3AdypLEYV7ZqKlyMeP5yTUg3H7Af
         ESXMsRjSpPoCBjKieiaJd+2r4tQy+AB7gT6bdKxJZzewPRSrM98TRz3af4UGw/yMAyMK
         vsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJluAbiLYKXPtNojcpa58wSPE+smR+xHU3IRj+ib1Us=;
        b=QF3tSvOd/kcg6G7iVM4xjUe1QPG6mHLqWpctpYhMcXHjI5STBZhALX/8iqCQGFJvhT
         /VMIfdvTR64MG2HCU6VgPBgE1+X2wFN/i3pFRuMLQUYtzUq+S5MgIy4YkKYywcv2INNh
         1XIgLrlB+gGxBi8ww2wDwS00YV/zK9qTrgJuVfQYuHCaBn6RNueDVDtROs6CdoNO/o3E
         M+BZE9ijXZsnFdRq28ketvO9vB6tkOr6CEIFT3mN9sWEl5Ouugvp+YknOHC4YtASHm+6
         dMrYzR0bRi+T7DF3W//+S/VPGOChWfdYvGQHkVJegaTyFkrRDzH4JYjz11pR7J+5F/Kd
         eETw==
X-Gm-Message-State: AOAM5318YyHN+Ri8jxi7LLAaowIKIbimvTCa0qW4Iiv/dQHKKOuM1toy
        h7ycVVHjS++1ImC3xC5WV+k=
X-Google-Smtp-Source: ABdhPJxGaBAS7vhNVhl+YJzxwfGh3//smoQmnJlWI+XeaKkDm79BSomvewfKz4GXArhthgaSSFLcIQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr9215680wmj.150.1602166663999;
        Thu, 08 Oct 2020 07:17:43 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4sm7985982wrn.48.2020.10.08.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:17:42 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] drm/panfrost: increase readl_relaxed_poll_timeout values
Date:   Thu,  8 Oct 2020 14:17:38 +0000
Message-Id: <20201008141738.13560-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SoC devices report the following errors frequently causing excessive
dmesg log spam and early log rotataion, although the errors appear to be
harmless as everything works fine:

[    7.202702] panfrost ffe40000.gpu: error powering up gpu L2
[    7.203760] panfrost ffe40000.gpu: error powering up gpu shader

ARM staff have advised increasing the timeout values to eliminate the errors
in most normal scenarios, and testing with several different G31/G52 devices
shows 20000 to be a reliable value.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Suggested-by: Steven Price <steven.price@arm.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index e1b2a3376624..2aae636f1cf5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -325,13 +325,13 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	/* Just turn on everything for now */
 	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
-		val, val == pfdev->features.l2_present, 100, 1000);
+		val, val == pfdev->features.l2_present, 100, 20000);
 	if (ret)
 		dev_err(pfdev->dev, "error powering up gpu L2");
 
 	gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
-		val, val == pfdev->features.shader_present, 100, 1000);
+		val, val == pfdev->features.shader_present, 100, 20000);
 	if (ret)
 		dev_err(pfdev->dev, "error powering up gpu shader");
 
-- 
2.17.1

