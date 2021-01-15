Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4472F8392
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbhAOSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE5C0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o10so2358692wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8jnXbYZh9fQLGbXGQ/O0REzwyF7YhVgi5AkTd6twPI=;
        b=uF/0vIlBVC846lYN4HISdxnnS7K8yJ+3K/lfoibQMwkvdkdW1pKP/jh6fQ3gVoS9DA
         VIwmyj5LSrRc/XtozbDaXoUExRLAfyrQOFdiV/o1k3v32UjqQXeZ02YrXYIwbJ418a7X
         KGMiWIg3PhKnYEnxeDp94ruSxvdzn1VRb2iUPR1NKnkGlOcnpOgbvmHn7jucnhF/CO1X
         Vv8mqhwmgXj78y3TC0NcSG6YV3Udw6VRK6/89Hp2/XetCnbN5nVwvc4e7racI41l8zAW
         Y3CFATlEdyGbecMlUCoVJ6U5yJMiFQvDwf/ziz8hJ0s/wpbJe6M9MEfGlReSz0+cFrDn
         q2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8jnXbYZh9fQLGbXGQ/O0REzwyF7YhVgi5AkTd6twPI=;
        b=ePjn0TUT+mM4R3Cr/psxLtEBcDUsj4RzvDEYcrLWwvx+JaDEkjGpttF6ihAyL/2qoZ
         +cIGVeZIw09Q+RyHRwgHbl717sifkuCxQy5c+ZAimr7OhJjIq5YvuFu4Xl7vTv7lRlRM
         VhYYKD04hmZYD0YhAbVTpgGO/otCcNrchOoKT5zJD/Wl3UMM2kNn7N08K4Vylh5qMHSr
         IGhmG3Jhs53Z6EiUw4WKhO3r/8G3rC9M1cDTVasFhaNJoA3LBI2TGidhvtH6vU3VIo0O
         vgcM1qwGDFeeBbMaoV4d6/ILvbkCizkdMf7Sn3TRPdh4EIeb49g5DqWx7mbZa/Cs8ehR
         MBNw==
X-Gm-Message-State: AOAM532aKDUGkVExDEKBVF0c/6EQV9a2psGRT0Hr0XrGvXyheFMXnmwP
        M4L1kZFVA4pMsaH5NQs9g9qSglIFmfkT3Om4
X-Google-Smtp-Source: ABdhPJwnCR0Nzz3e0c6LzffEGLK2o6EAODTUN633CFgBq6cZO9FrWPi92VhlIb0jckP0HwOwMQr3lQ==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr10045620wmg.189.1610734419371;
        Fri, 15 Jan 2021 10:13:39 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/40] drm/gma500/gem: Add and rename some function parameter descriptions
Date:   Fri, 15 Jan 2021 18:12:48 +0000
Message-Id: <20210115181313.3431493-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/gem.c:57:5: warning: no previous prototype for ‘psb_gem_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/gma500/gem.c:59: warning: Function parameter or member 'stolen' not described in 'psb_gem_create'
 drivers/gpu/drm/gma500/gem.c:59: warning: Function parameter or member 'align' not described in 'psb_gem_create'
 drivers/gpu/drm/gma500/gem.c:110: warning: Function parameter or member 'file' not described in 'psb_gem_dumb_create'
 drivers/gpu/drm/gma500/gem.c:110: warning: Excess function parameter 'drm_file' description in 'psb_gem_dumb_create'
 drivers/gpu/drm/gma500/gem.c:135: warning: Excess function parameter 'vma' description in 'psb_gem_fault'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index db827e591403c..5ef5480f999e9 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -49,6 +49,8 @@ const struct drm_gem_object_funcs psb_gem_object_funcs = {
  *	@dev: our device
  *	@size: the size requested
  *	@handlep: returned handle (opaque number)
+ *	@stolen: unused
+ *	@align: unused
  *
  *	Create a GEM object, fill in the boilerplate and attach a handle to
  *	it so that userspace can speak about it. This does the core work
@@ -97,7 +99,7 @@ int psb_gem_create(struct drm_file *file, struct drm_device *dev, u64 size,
 
 /**
  *	psb_gem_dumb_create	-	create a dumb buffer
- *	@drm_file: our client file
+ *	@file: our client file
  *	@dev: our device
  *	@args: the requested arguments copied from userspace
  *
@@ -116,7 +118,6 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 
 /**
  *	psb_gem_fault		-	pagefault handler for GEM objects
- *	@vma: the VMA of the GEM object
  *	@vmf: fault detail
  *
  *	Invoked when a fault occurs on an mmap of a GEM managed area. GEM
-- 
2.25.1

