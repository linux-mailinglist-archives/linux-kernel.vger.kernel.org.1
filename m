Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8722F83CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbhAOSPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388129AbhAOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4FC061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so4192639wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAMyYaaj1VFxGbNOafp+nzJ0Q2eH0I8k2Xo9CJpOSL4=;
        b=yVjWmOGvJzeDni3tCIMOzMmMGeotfx0zrqnDbf4Clmyd04/rjS+q0vmqap5y7zg4Io
         7h1D4HYxOw/emRxXYKSS0UPCw+YELiJjQhMGu6Fy0Uj+H1b1v6SEx18+huC92+skY/oE
         ysSeaM6p0n4eY95XH9EEsl1HIJT0gd5ayHE8di3BTOfP4imM+Ivsp8UyOqj7f4SECp8T
         naf24hYPEYQWtTPW3tTd4cbe0Y1G8nanx71tnqR/WsoDLa2c2NVoI7n/nf+Yv+wa5XPc
         CImYGw6BvnacySDNght925HnYU893MxmOQbdVzZhvA0BUaQXeAuUjkStV7Rn3CMAm7HK
         t/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAMyYaaj1VFxGbNOafp+nzJ0Q2eH0I8k2Xo9CJpOSL4=;
        b=V0U018jEPf7yge/5CmBj/KWLznARfa4CymnvHeg7qx6kfOOzE1mGs4/nKIe7Ucrkxc
         qX8SBxLiMSvluBdXkDEc5nYtvHZxq9QsvbV2eHS39RntqxkopThphkDPsUirim7RaNfE
         JPA0C6NSwHj3Yo9glzQLIoGcBoYD4CNn4p4DjBk/r0UMXANEqm8sfuOItJfELKtZLyhy
         z1pyZvm3JEJRaxQXR0urk3wtbf/axt+ucwDhthqH9cU28lVhrQ+pxjrC0z7ZwP1K4RRe
         AhFvpInqB6+YqYTtW4bEettY4despsz0Ps3PJkxDYZkY3Q71o/j29WjbLqDK0NeE8j+p
         69GA==
X-Gm-Message-State: AOAM530sXnLAqcc37KgmTV+gk5h9LFc0GVDwOdhhfYKtJYmjwYumTmqZ
        Qp5k3tbzaS7nSgjxYrVXfzorvw==
X-Google-Smtp-Source: ABdhPJwe9r4nkJlVMT4urFaM/FAN0HUOKO2Kd3dORP++jhEf8U1Dg6bSWhgp5TG+hNJ3w3cTCkA9Rw==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr10104491wmj.165.1610734439880;
        Fri, 15 Jan 2021 10:13:59 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/vmwgfx/vmwgfx_context: Demote kernel-doc abuses
Date:   Fri, 15 Jan 2021 18:13:01 +0000
Message-Id: <20210115181313.3431493-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:121: warning: Function parameter or member 'dev_priv' not described in 'vmw_context_cotables_unref'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:121: warning: Function parameter or member 'uctx' not described in 'vmw_context_cotables_unref'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:681: warning: Function parameter or member 'base' not described in 'vmw_user_context_base_to_res'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:707: warning: Function parameter or member 'p_base' not described in 'vmw_user_context_base_release'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
index 6f4d0da11ad87..4a5a3e246216d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
@@ -112,7 +112,7 @@ static const struct vmw_res_func vmw_dx_context_func = {
 	.unbind = vmw_dx_context_unbind
 };
 
-/**
+/*
  * Context management:
  */
 
@@ -672,7 +672,7 @@ static int vmw_dx_context_destroy(struct vmw_resource *res)
 	return 0;
 }
 
-/**
+/*
  * User-space context management:
  */
 
@@ -698,7 +698,7 @@ static void vmw_user_context_free(struct vmw_resource *res)
 			    vmw_user_context_size);
 }
 
-/**
+/*
  * This function is called when user space has no more references on the
  * base object. It releases the base-object's reference on the resource object.
  */
-- 
2.25.1

