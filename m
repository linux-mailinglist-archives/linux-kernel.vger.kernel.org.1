Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C22F83CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbhAOSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbhAOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD75C0617BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q18so10221363wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hRh93h6Ap5slKiR2lojMOAMN9uOZEFE9uCUxTKVOZ0=;
        b=L0fqAYHr8HLZtGjdqMD143kc5XmQf/YmOSw8lmVA5+T5CRtjE9urWP4t6hYR+S6CAO
         ztAgllI0d8M0uqueieIkohfp9oCqK27wJMQhv8bkCxXCJ5RYYmhzJXcFdvWuFzxYHzzE
         GTz6bJ3ekyz3tyS+3yR/RaMYzkpnFo8ZVCJpPlczC6hiddMbhW+OxqJHAGqF04pnhtSv
         twSm+JNMxuLSqH0/7Bj4Uk0YgMHzX+eRqY3oaK8oNZIOhixgAZM1kuQV4o7B8BzC8epj
         HAwePLUZBut2Qg0JMkUIPR4Vc5VFau5RnU/7pha5iK+oPtgoqGMtP7QDgn45Wb55z8MT
         NhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hRh93h6Ap5slKiR2lojMOAMN9uOZEFE9uCUxTKVOZ0=;
        b=nGm6wDbEGE6EdX54+fZFXjTZpD/XPgd4c3+jpuQxC6OI2syvbnMa6xD6quQs3qlTrn
         cLidVnpbptTFDGpq+dVvaQnRtYeJtNZ9ZDnEV3CIGgmFLepltevnAMe6QpWEts0lImDm
         DgNVnuYR/uBlVlkOnng5sp3TmyJ9yeSifrLbLkJeMjMpiUYLtLOJkOVUs61AypZrXxIB
         z/KtSf9dmpP2gGtE5LcTf/MCzzY9ahF2SpmIZeQhnVJp98YsQmncTD92xBTPnW13uPUc
         F9eCDlJ/kKIEoc5/jDithPzddtvtenL9kSj5mNAW+AXOpx8BbQEGc4AoeBUVKHZTnHpH
         V7BQ==
X-Gm-Message-State: AOAM532u/dIf+Tf97eZcMurkI2+nhDuoKBztAjjFels+haQkff6o6Q2a
        YP9fhf6NQgJhrat2sYvKjJcf6Q==
X-Google-Smtp-Source: ABdhPJwC47WOemGmAPk2kis09Wl6b15wqaHG88CkeWRKRwzEE16uui9xQCF4DGMAYfV5I1KkHL5FtQ==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr14597082wrw.395.1610734441481;
        Fri, 15 Jan 2021 10:14:01 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/vmwgfx/vmwgfx_scrn: Demote unworthy kernel-doc headers and update others
Date:   Fri, 15 Jan 2021 18:13:02 +0000
Message-Id: <20210115181313.3431493-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:90: warning: cannot understand function prototype: 'struct vmw_screen_object_unit '
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'dev_priv' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'sou' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'x' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'y' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:122: warning: Function parameter or member 'mode' not described in 'vmw_sou_fifo_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:168: warning: Function parameter or member 'dev_priv' not described in 'vmw_sou_fifo_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:168: warning: Function parameter or member 'sou' not described in 'vmw_sou_fifo_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:283: warning: Function parameter or member 'state' not described in 'vmw_sou_crtc_atomic_enable'
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c:293: warning: Function parameter or member 'state' not described in 'vmw_sou_crtc_atomic_disable'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index b0db059b8cfbe..6feb61a1a3041 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -84,7 +84,7 @@ struct vmw_kms_sou_define_gmrfb {
 	SVGAFifoCmdDefineGMRFB body;
 };
 
-/**
+/*
  * Display unit using screen objects.
  */
 struct vmw_screen_object_unit {
@@ -112,7 +112,7 @@ static void vmw_sou_crtc_destroy(struct drm_crtc *crtc)
 	vmw_sou_destroy(vmw_crtc_to_sou(crtc));
 }
 
-/**
+/*
  * Send the fifo command to create a screen.
  */
 static int vmw_sou_fifo_create(struct vmw_private *dev_priv,
@@ -160,7 +160,7 @@ static int vmw_sou_fifo_create(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Send the fifo command to destroy a screen.
  */
 static int vmw_sou_fifo_destroy(struct vmw_private *dev_priv,
@@ -263,7 +263,7 @@ static void vmw_sou_crtc_mode_set_nofb(struct drm_crtc *crtc)
 /**
  * vmw_sou_crtc_helper_prepare - Noop
  *
- * @crtc: CRTC associated with the new screen
+ * @crtc:  CRTC associated with the new screen
  *
  * Prepares the CRTC for a mode set, but we don't need to do anything here.
  */
@@ -275,6 +275,7 @@ static void vmw_sou_crtc_helper_prepare(struct drm_crtc *crtc)
  * vmw_sou_crtc_atomic_enable - Noop
  *
  * @crtc: CRTC associated with the new screen
+ * @state: Unused
  *
  * This is called after a mode set has been completed.
  */
@@ -287,6 +288,7 @@ static void vmw_sou_crtc_atomic_enable(struct drm_crtc *crtc,
  * vmw_sou_crtc_atomic_disable - Turns off CRTC
  *
  * @crtc: CRTC to be turned off
+ * @state: Unused
  */
 static void vmw_sou_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
-- 
2.25.1

