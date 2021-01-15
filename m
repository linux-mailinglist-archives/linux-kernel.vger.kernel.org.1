Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389F82F83D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhAOSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbhAOSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D0C061383
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m187so1959074wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUllZlLn2aeKUdYiVAeIic/5IUxXot0e1d7nGV4+J9E=;
        b=xHzJWvUBBvuWc4Xl5VACsWf7N/b0v4PM+Qxj0aEVX4T/Ialsfqoba2uENutm20zcbe
         SaHvLTlmH58mQ6cFwjcCCodq/QHt72Iu43Xb329LXWojJa7oAy5FXhy2ROEXFtld/q0I
         6Bkq0aU2nuUl1WAISSsKA03rO1HtN7OS/vQAo0Mu59atH1sWKQ0BOJRGdqbbI/AxDYJa
         mKMP7dh/5SkXbKhLTNWDNw72XJlZ69B4cfYOT2tlqPa+14eFXTZ3+232t6Gh/e4fD3UI
         5beVeeQ+z6ZFxtKsL6isJU1T08spSkRPfoQeca1f2M5VIPsgFuCTmP1gzibzEXNMEy+/
         sPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUllZlLn2aeKUdYiVAeIic/5IUxXot0e1d7nGV4+J9E=;
        b=SJYfABakZ5yqRtbiIdGwvm7S3qzc4a+4EwC2zkzcVSM83KFoWSILsZn+r2egIJPxiR
         5FuyfcksFxgIFl7qnbzvNMKQ76vkzckyvjGCBs/SSbFWljhBtm5V18Tc1pLEWmlK2Jra
         Fj0sP1z8PMaQBBJw08ReFZbVf2XpniyGu4xUR2WuDsNIClPLdHbnvmA4yWp8jMDs8+ir
         vRHBrvTw9T9FPpHJTDv3r8mSrsg5TqxfDgIWqFQBq9XToUqre1fy16Lq6y4PIgKnD+3/
         AT1ZTyESU991sccdyq7VQ2LEGzVrkk284yGZq2Tmg+NlsDQ1z6uWEaUmuWKsAV1qo3kc
         s5aw==
X-Gm-Message-State: AOAM532grQeZPbzmpFhtNd7z8ZfqUN/aNCzSJ8kzQHcTXKl3Uq+cdh9s
        cxjsnmRHMgJt+8LmlYPDnJ4oNA==
X-Google-Smtp-Source: ABdhPJynbLDNvhU7p2qnSMtIi5F12pD7Q5un3SKOf86x40VZpdtU+jnB7rT+88JShOlhxgtI/k3xDw==
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr9844691wmg.144.1610734452136;
        Fri, 15 Jan 2021 10:14:12 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Defnet <benjamin.r.defnet@intel.com>,
        Rajesh Poornachandran <rajesh.poornachandran@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 38/40] drm/gma500/power: Remove excess param description 'state'
Date:   Fri, 15 Jan 2021 18:13:11 +0000
Message-Id: <20210115181313.3431493-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/power.c:190: warning: Excess function parameter 'state' description in 'gma_power_suspend'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Benjamin Defnet <benjamin.r.defnet@intel.com>
Cc: Rajesh Poornachandran <rajesh.poornachandran@intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
index 89842e09cd2aa..56ef88237ef66 100644
--- a/drivers/gpu/drm/gma500/power.c
+++ b/drivers/gpu/drm/gma500/power.c
@@ -180,7 +180,6 @@ static bool gma_resume_pci(struct pci_dev *pdev)
 /**
  *	gma_power_suspend		-	bus callback for suspend
  *	@_dev: our device
- *	@state: suspend type
  *
  *	Called back by the PCI layer during a suspend of the system. We
  *	perform the necessary shut down steps and save enough state that
-- 
2.25.1

