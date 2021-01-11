Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12162F1F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403869AbhAKTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391024AbhAKTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFB3C0617BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r4so278581wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqONQ/c46HwLlMHyZcb5Hym3CQTe21MZsvbjJWaglwo=;
        b=lI4dH5WM0yKxFmFhaUmduedrt7oA/k406RlSyI5Ux9gBEFO4EleT7ZFuBWV5XS+1Uj
         R3U7bK4Ji+8VXN0LERBhRByhIRpG+C6vM956Ma+xSCTIrAoR1O2FM28aFskCt/Fnj+Vx
         7eufP92JLw8Sk9JCBNs2DLL2sxbLv6yfDsgOUn4ykryXdDzJKKRT2VzKCylnLTs4uw4r
         qqrCUcssPkpjWaC6vlalD/+ZHCKR0lx8D18oxG0OJphSVNgHeBcP3REPGSX7D5UfdK3x
         bnSxjYILquF4ENw9PQjcKw2uqlhAdFYCkScuD/D5eFatHWunb/HPllVFf7QiU2EZxdg0
         P1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqONQ/c46HwLlMHyZcb5Hym3CQTe21MZsvbjJWaglwo=;
        b=VyKIILpr98B2eFGm1SOu0LjgEmd2OI2NWv75j14uwusdoFJCldoPUx35Kxw6+hySrI
         X/AeUACwFJS24spyNphhh2qFcAVYUIO0E225ewhSq2pYeI8vxjuAg5LqEMwxw2jYaa8O
         frTqC7nNA2hANMqFjQa/xAX3jUvPO/a4oU+C120S5tFI6qhVlHeUfB7B1bhMpxuVVY3X
         Ngz3CwCodgaXmVo7w8WxxY780rANMmJCC41ZK+C4eFRkDyWzpLqDqq2KrHgUv/7antLE
         ouNEwt8i3j/vQfpu0OA4qhW7jz9a7BEusE4veikFdeAsdNMqwHrnig4kpC+9OphtIO4x
         A74A==
X-Gm-Message-State: AOAM5318WMWDGhupZqe1f9ByDnZltN1rGxIitH7bVj++LxszdxWMVouO
        OrBr4kMxKP4qFCcTisol47T3yw==
X-Google-Smtp-Source: ABdhPJwcejWZ3QjynlDyeajmM/VTRxNr70SOAS/JgDy/U0vHKvrxFUlgMFmn9SJw54FX5BWgWdPeIg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr293979wmj.52.1610392794010;
        Mon, 11 Jan 2021 11:19:54 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/40] drm/amd/display/dc/dce112/Makefile: Ignore -Woverride-init warning
Date:   Mon, 11 Jan 2021 19:19:04 +0000
Message-Id: <20210111191926.3688443-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file uses a complex abstracted set of hierarchical macros to
setup its applicable register lists within constant structures.
However in the case of TMDS_CNTL we wish to mark it as not applicable
for this use-case.

One method would be to de-const all of the definitions and users, then
manually zero out TMDS_CNTL from the list.  Another would be to create
a new set of hierarchical macros to omit TMDS_CNTL entirely.  Both
would entail a great deal of unnecessary changes and maintenance
burden.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:290:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[0].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:290:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:291:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[1].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:291:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:292:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[2].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:292:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:293:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[3].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:293:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:294:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[4].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:294:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:295:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15: note: (near initialization for ‘stream_enc_regs[5].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:295:2: note: in expansion of macro ‘stream_enc_regs’

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce112/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/Makefile b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
index 8e090446d5119..9de6501702d2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
@@ -23,6 +23,8 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
+CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o = $(call cc-disable-warning, override-init)
+
 DCE112 = dce112_compressor.o dce112_hw_sequencer.o \
 dce112_resource.o
 
-- 
2.25.1

