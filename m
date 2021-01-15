Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803E42F83E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbhAOSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388568AbhAOSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B55C0617BD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c5so10209167wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uVp68mdiDdBXS5aeK/400FDUtXHrGa18qKz0SHB/q8Y=;
        b=FZ8N+MseSySo4v1ZYJtrG+RSruEOZbWyzJ1DhpH1v0o9O26kSKf9zYaVCXBCYmJ+EC
         VoxYOA5ngWznxOD7xhM2a0Pkaizwwul9w7Rfjcea5PZaJm1aoa0R4crh+20jESbp1kdK
         umz/oOgofPJ5OhfLo6ROYuKEi8ubJWt7mD7CclpQig1hod1srd6KCwkwIc7FESEoj9il
         zDkA2g6rDRYYmoOHUF5t8Lvf5nek8ri3xn0b2lRsszC/PWDWrDpS9axdl2fnukKBGjXd
         5BhHxJV9fsMGGK2Pu3BvSUx0NH1avx4aYo88U1gblimRQ9gQnqZLnM3IMbWIRhg4VHl7
         KkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uVp68mdiDdBXS5aeK/400FDUtXHrGa18qKz0SHB/q8Y=;
        b=a9z3GMmWVJx5KUYHGL51A0yMJ1F+hV7dEroXfItCHrkZn45QcpZhQNyvbJMrk8eP/g
         S3VIlElVRUy4rTI9F3By/BEQEqcjWeiJbtqS0apjuOiphBywMJcuxTh5LCfIyMZ2Byxr
         7LgP0/CcMG8Y+H+8TvxJSjWIO+R7btmfFGWvJcvycy+Ke+8ylpleliJG9uEC1E9jeDf4
         FxAxmNnIQ2yK5cU70RQbSoUTJkyQ/aDFYJyp6GsmPoi3nzwFP2B1fy3kVw+o2BIbmBYv
         78clJoz18IZhLncIAmQEtQ2V2NdQeNvCB/wAaSr+fW0SrcRR+N4XCf/FduWLvhypKovl
         PatA==
X-Gm-Message-State: AOAM530ED8Tzg4r8mGd5HuFpLwm2/JuhUWSgSiKnNN1/E5kVsfhrvlff
        Bw/NAVqHCwZ86axPGkgSRMjhhw==
X-Google-Smtp-Source: ABdhPJwrZlGGrGjAf3GMC7apd31gRe5Dhy4mYcG3vGI74Rt7B8oSthJtP0F4vFDP74WcZg3XO1aKvg==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr14103236wrw.323.1610734604791;
        Fri, 15 Jan 2021 10:16:44 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 28/29] drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse to standard comment block
Date:   Fri, 15 Jan 2021 18:16:00 +0000
Message-Id: <20210115181601.3432599-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
index 8ddf9b2325a42..2af3615c5205c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -38,7 +38,7 @@
 
 #include "nouveau_ioctl.h"
 
-/**
+/*
  * Called whenever a 32-bit process running under a 64-bit kernel
  * performs an ioctl on /dev/dri/card<n>.
  *
-- 
2.25.1

