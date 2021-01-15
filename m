Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777662F83F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbhAOSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbhAOSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:18:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7376C0617BA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k10so8220680wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2fukyLsotnyIO21hCJ1A0IUQV1SfrYh5wzz8JhsiiM=;
        b=gkPe4zQRnTIJ91SOxape8cRj/kO69GrgNLCMZTar3f1vt1Iv3INiFfoVT/oT69muaj
         rHbC4MoocQB7oWOMyPqd0PhTRoQrUybhIJLleeThAjJh18c5LtKtkskEoMwL6Wuee68F
         689gPeMLG2RIQCe4fo9R31pkp70ba6oPxfJqOwx6qAR47rC48hB4caKDT8H94DTWCTFM
         uxAQaIEviR4XWvzlJzuwiKcqwWIPfU3snEV7oGmY4Rjl/jAiKFLgX3o1KUw1MBF8HqeI
         HhcEfG6nCehTgn+SEwB9xYOy+m3bHhHzLpxfoK07S+mnsD04ZA9qMElbH3zWxlJrVoLZ
         eLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2fukyLsotnyIO21hCJ1A0IUQV1SfrYh5wzz8JhsiiM=;
        b=D16EB31pd5AJw5HfPYuU1qRkXEU6HzyGYnoC6MESwXRd3eJrw+g3i0Zv9zkoMyOZu9
         z+yAAB3JaMLWlg8e/fvX8hCPG27m1qFOVgGvHI3kt66l9JIuNB9y7QP7v2fbLf4VYwHO
         qxwreRhCItT18vGpXDQfAuuCUtaYofEq6/VpwUI3vYOfAIYI5UJ23kPw61SHAsq42rSb
         aQK0R5u3t12zPU7YkqAf+BVlaqrVeC2S7W1yxrApWuvUZn2LD8kBV7vNEm4hGikVXkq3
         sT8Ym1UgVtDMegNU7poKI+hqHpGhjwj1eVZOmzZFNo4CJexQzuqsOaibC76aAUW0h4J5
         vJJQ==
X-Gm-Message-State: AOAM532NcSPHMwSKHbft/vuOiobeRZ4xak/4efM0UCxQzj3FPIR5SRLy
        9TdcJy5h82z3H5nTg47qqGE5gg==
X-Google-Smtp-Source: ABdhPJwzAFS7Be8VkrVoNQgvyVh8GdN8DIxgBCBCbQEv+K0i2fq9aZe2mXAbWJUOB6yMre/SnSy8Gg==
X-Received: by 2002:a05:600c:2742:: with SMTP id 2mr9826336wmw.94.1610734600647;
        Fri, 15 Jan 2021 10:16:40 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 25/29] drm/nouveau/nouveau_ioc32: File headers are not good candidates for kernel-doc
Date:   Fri, 15 Jan 2021 18:15:57 +0000
Message-Id: <20210115181601.3432599-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot understand  * file mga_ioc32.c

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
index adf01ca9e035d..8ddf9b2325a42 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file mga_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the MGA DRM.
-- 
2.25.1

