Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99FC2F8396
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbhAOSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbhAOSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1D6C0617B9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id h17so8029565wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkjVIWYW/KwOeSMeepZX/DgNoniQl+ISNQgSsOehQ7w=;
        b=e8cdNWXBmpQJjHdYaGaiiOV72MbqMOAfosJeSNF2+rOWE8iWHIL8KpTY/GJYgidnKE
         jj7e8KOn3o+IrhJJErokkJ6Nh7YalhwnOrzgXCHFsVgT7ZvATMqt5GiH/eQqypt57fof
         bHVB12h2oBpCsG8i6tABHi6sPliAU29Q5rjklZHnZYgGvYrdAT5kIJA/vjOp86Tq8GMo
         0PLTSpVqJsDh3evacDad2VliCH+v9s2Qwy6smrPGG46xrBI1yWNnhtVFBfjDa++xLgcA
         F5X7jbVQWJMHPG9tx8gotkTh8xa8ikP9QThNviQpccrExUvz+tq/kf+AYixxBEzTfBBv
         6vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkjVIWYW/KwOeSMeepZX/DgNoniQl+ISNQgSsOehQ7w=;
        b=XUiLGuf2NnMsZPN4X8KXmWaYvU+/dudNy+Pf6CfYo/ECLxM3OJ+CLCsDQx8iHgpF7D
         rdpfsErouu4EUG8C44jQkFYYLVNCc7T2VBZVsYX+Mw7w0LCpUJmuOR5Em5mOZkCujCR2
         8T+RpTjzDXau1EvdXnTKOyemwuBOYpDX/9kBuJDr8fLmLtWGc6PbPyKPUIiFgnBGrwua
         hpcXn8Euv/2dm3p4/I2MzPPhoLPdsqhk3NnZwUctcc8F2kSxVRhcsAYK4UWLzgho8JKS
         /9nF6PYItqWgr1oFlCQ1R6QEQ1r7bTQ5lSZBXxcMN7qfpM/tmpQJ3wLFEeJrp39qv5+Y
         LStA==
X-Gm-Message-State: AOAM533fEz0afFh1CvRq2ktCCpfFlAwwU6AY210Csg2xtxfRbtH2F12s
        Cjhrf45PFpcpIJoruquB2K48nA==
X-Google-Smtp-Source: ABdhPJxFzNsNFSsSnvoi1hcE7mQAkrSmJha8bR1Hw+CmHAFQ6ayTeWQ9uEK39Q3r/nueb1EHW6SMwA==
X-Received: by 2002:a1c:df85:: with SMTP id w127mr10178071wmg.166.1610734435308;
        Fri, 15 Jan 2021 10:13:55 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/40] drm/gma500/psb_intel_display: Demote kernel-doc formatting abuse
Date:   Fri, 15 Jan 2021 18:12:57 +0000
Message-Id: <20210115181313.3431493-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/psb_intel_display.c:79: warning: Function parameter or member 'dev' not described in 'psb_intel_panel_fitter_pipe'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/psb_intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index 531c5485be172..9c3cb1b80bbdb 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -71,7 +71,7 @@ static void psb_intel_clock(int refclk, struct gma_clock_t *clock)
 	clock->dot = clock->vco / clock->p;
 }
 
-/**
+/*
  * Return the pipe currently connected to the panel fitter,
  * or -1 if the panel fitter is not present or not in use
  */
-- 
2.25.1

