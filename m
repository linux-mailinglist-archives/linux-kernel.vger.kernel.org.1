Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE42EF8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbhAHUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbhAHUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809BC06129D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so8712165wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2u/LayQzAWY4TNKfG7PHD7/3//FK6Zy4l1U89GrL1AU=;
        b=C8oQ5FPceqRzS1vcOvfKUF5XvX1ZAR7TWwHJd/zeta8nGuC7Y8Rxdc1VrQ9hg3sTj9
         Z+AJxpC37ZuIHfp6IEGutLehSN1RS71qWCfc41gtEvSu44qkydWWUx6irE68vDUaj6ZN
         KyBk+FsGVTte1VzCr0gEuPR3jZfzmd/zGs36S9ssPC/9rmfbEV+h70t+i20ZbGr54lwk
         uE29yLlehTcswauyv6jRU2EZHCGseExxnpFbO+bid4hzfxJw2Y30IwaAUdHkaryLylZV
         OfDWoiXw8s05ynAKqCBvqi9ekzulnXtGu2ZGD2K5Jj4VEs8GNOW/3H56k+mIelFljEN6
         VScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2u/LayQzAWY4TNKfG7PHD7/3//FK6Zy4l1U89GrL1AU=;
        b=SLeSpo5mam3spL0JuFyOIoPd6q+q7v56qh/qyZLSoeTokCDIBp5EltAh4ulYzJqSyH
         fdC+jY7O9bDfKFSnNn2x2P+CJqetgdpZ91f4c6QKCjHRXau2p5w1StICSLkjDCedN6li
         1kgpKIs4dflI94M9/hUZcgYnbdyALcDBfnCgOZwPZaXyGcSMPELpcqCv3ghGfG1Otkw2
         Xi681448TQ5sEut2ByPCDPUihjt4Y3iLrA30B+kBpSsvkHDbUL3xK1KUaEzTi7HboYC1
         cDOBHEzmMkLziwcMzyDhkuwo7zy227M13MhTSnEFqTJXA6cDSbnsSgsFiqGiI8ZED+56
         KakQ==
X-Gm-Message-State: AOAM530GqMrhPfQ0BcPnX7aSM/nzN6BMUg6+thmtk+znLgFg/X/E8pyC
        fQDFbGpTCegS5568ZgSmvuQK8A==
X-Google-Smtp-Source: ABdhPJzHrgMiBuwS2VLTNxDpoDF74KuwkC8RlBXayLHMw9O0W3OoeJfOF68jv0qbe6mhmH6A4tCDwg==
X-Received: by 2002:a1c:3b46:: with SMTP id i67mr4349396wma.108.1610136910141;
        Fri, 08 Jan 2021 12:15:10 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/amdgpu/amdgpu_ih: Update 'amdgpu_ih_decode_iv_helper()'s function header
Date:   Fri,  8 Jan 2021 20:14:21 +0000
Message-Id: <20210108201457.3078600-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:220: warning: Function parameter or member 'ih' not described in 'amdgpu_ih_decode_iv_helper'
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:220: warning: Function parameter or member 'entry' not described in 'amdgpu_ih_decode_iv_helper'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 725a9c73d51f0..dc852af4f3b76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -209,6 +209,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * amdgpu_ih_decode_iv_helper - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: ih ring to process
+ * @entry: IV entry
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position for for Vega10
-- 
2.25.1

