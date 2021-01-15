Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315A2F83F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbhAOSSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbhAOSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:18:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1AC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 6so2912388wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TV73dkbBvGhpYcqV/fsQZ4aFFzm9GQ9Ij+MCJ8e6uM=;
        b=i/zt/gQYv4HPTEgigDPbzK2Sb8SUJRL7IwqdD7hFPeO2qkLDu/24pIG70vd9ZuU+W0
         Lrt1mvkOYDRxnyF/lyOXZQb0rzpNTrg6ZveP1TgBgt9kmvke+hgoBO32HxZxumR4YCZa
         zUZGTIO9HG1xj882ENS2TIHmY9+A2zxLK8Ye1lrhQmT883lWNnk0R1tNA017KP0nJYMP
         j+8q3slLwIBZGqMuVQ9zi3yXZpQY2ku7RCQbe0r7xY0TpuA4JzdpR/34xFJ2uYQ3fFmY
         jjnb9vOYAlekN9XmQOLpqaJXHBX+y5de9746UbCjrPQOVtvNU/D+bACTMJ6JcRGL6Mwj
         0P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TV73dkbBvGhpYcqV/fsQZ4aFFzm9GQ9Ij+MCJ8e6uM=;
        b=inezFpZL1DUObmH8bhZsmLuh45UkIVtPTFsywUiYPmDzHPK4Otn55MxuK4qLwsXb6O
         9SfARBZx1zZ7HQwfKfi96TxgwTfwY3ElFn82Ym0AQoGtk5kWkoF2RThT4uWZslTIE5RC
         +iTauqKXxLPTy7VaO42hbSnhX54Dh2/6yfXE4FW3WhtXnESY/vdRZBwh1Poz3DAhqlKy
         XjiFiHpOATuloAGSuapX1LaEeLjwSeihYNw/5r8es4C4unaRrg4A6scqmty1rojfviaU
         9tCi5J6RHZCa6s5x++AcSXLxUMrqEilOApFLPSbOB6mDJDDICGTIdQAY0HKhF7nU7iDJ
         sDPQ==
X-Gm-Message-State: AOAM533Mo+oZYfYGulfWzExBLXLJ5hFyVPDWXaiLguQPW/7ibmo2Vt9x
        57J7V7LuwAk+O6A5/EU1tQPDlQ==
X-Google-Smtp-Source: ABdhPJwK2z9xj2/F+s3rA1SnN2if5sf5QYP+Lg9GwrBJGP1CMAO9YHgp3NNc8Tx34w+6hNana7B4QA==
X-Received: by 2002:adf:e512:: with SMTP id j18mr14339992wrm.52.1610734596426;
        Fri, 15 Jan 2021 10:16:36 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/29] drm/gma500/mdfld_intel_display: Demote three kernel-doc formatting abuses
Date:   Fri, 15 Jan 2021 18:15:54 +0000
Message-Id: <20210115181601.3432599-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/mdfld_intel_display.c:103: warning: Function parameter or member 'dev' not described in 'psb_intel_panel_fitter_pipe'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:273: warning: Function parameter or member 'crtc' not described in 'mdfld_crtc_dpms'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:273: warning: Function parameter or member 'mode' not described in 'mdfld_crtc_dpms'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:609: warning: Function parameter or member 'crtc' not described in 'mdfldFindBestPLL'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:609: warning: Function parameter or member 'target' not described in 'mdfldFindBestPLL'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:609: warning: Function parameter or member 'refclk' not described in 'mdfldFindBestPLL'
 drivers/gpu/drm/gma500/mdfld_intel_display.c:609: warning: Function parameter or member 'best_clock' not described in 'mdfldFindBestPLL'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/mdfld_intel_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
index aae2d358364cc..462aba8f75288 100644
--- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
+++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
@@ -95,7 +95,7 @@ void mdfldWaitForPipeEnable(struct drm_device *dev, int pipe)
 	}
 }
 
-/**
+/*
  * Return the pipe currently connected to the panel fitter,
  * or -1 if the panel fitter is not present or not in use
  */
@@ -263,7 +263,7 @@ void mdfld_disable_crtc(struct drm_device *dev, int pipe)
 
 }
 
-/**
+/*
  * Sets the power management mode of the pipe and plane.
  *
  * This code should probably grow support for turning the cursor off and back
@@ -599,7 +599,7 @@ static void mdfld_clock(int refclk, struct mrst_clock_t *clock)
 	clock->dot = (refclk * clock->m) / clock->p1;
 }
 
-/**
+/*
  * Returns a set of divisors for the desired target clock with the given refclk,
  * or FALSE.  Divisor values are the actual divisors for
  */
-- 
2.25.1

