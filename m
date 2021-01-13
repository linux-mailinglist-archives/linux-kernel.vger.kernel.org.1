Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC992F45F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbhAMIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbhAMIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A9C061384
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a6so693417wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAO678R3RtkgY9IPzmyb5UFyGCUGLlAwXrenaR2xREY=;
        b=n4HHJXja9efTgsY6gSGtpsDgEfkqFcI3Zk2w8ic/TG6PTg+1W5grCJIbuifEleQBPZ
         +27CrufSyUIL17ZLNP/BTz7Z2J4H2ueddAgeLSJtVPh6AMWSPZ9wFaZSizslJYKksV6v
         d3uWqiyUM7xUzIhGoRencnMz142jUwpfu0hfcSL3UywLJ+vBZ0NYSSP2nHBQqJbcJS8o
         deHY7DmgUSQvCFk/Lt05jaAxGT843B4s6fy56BFPCmDYGy1FYj/cvJQ2/CHecvPP2e1Z
         Szjpy6et/cTX4d0k69ZzZZStXiNPmrmvTi/3+5BxjaEgk/iJTz9OpeMSPJnzluieZpQN
         gu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAO678R3RtkgY9IPzmyb5UFyGCUGLlAwXrenaR2xREY=;
        b=YxMp559KTUZfNh/VB3K7e9gpT2Aq5QgSbBADIIxVL5s370/5Q4p2CmMI1IQZjRP26W
         EIvfX+yFimOWBB4nkZeql1DrTQ7nZPzuKR9EB1LL4z+3Dkg6P0F3JI7lUVhOxn2i/UDK
         kw3OfuAowoAxV3EnryokbG7q3dtn9S9XL0TKPKyJX96wh1/Bze4oBSCj3eYQYUFIcGkV
         0jzTC+gAfk+rP+d86laBE4rPKhTa0iZ517bus7P3AcXArEKFq8BDFsvDWWAHIuKN6vFH
         kDpsqkQ4B/cqZ0yFJ8p2rf79N52fpvayalk+DupWBSyorf8EGF5ZzsYJxx0F72kU3yRd
         Wvrg==
X-Gm-Message-State: AOAM531QlgInj3sjtlw0En6g0UH6F8DIF0nTkOl61U2UvffMfFsMScw6
        Rt8fU6NE4ho0QYI8+9+BXfwYaISSYwT1EXC0
X-Google-Smtp-Source: ABdhPJxHNyoXPfTlp5uRri1k1i0J2v1Wg0OxRoE+fajiSX23gEvASeYjGvrRnoPRxewhB2B/Gkmfkg==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr950377wmi.126.1610525304555;
        Wed, 13 Jan 2021 00:08:24 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 23/30] drm/nouveau/nvkm/engine/gr/gf100: Demote non-conformant kernel-doc header
Date:   Wed, 13 Jan 2021 08:07:45 +0000
Message-Id: <20210113080752.1003793-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:992: warning: Function parameter or member 'gr' not described in 'gf100_gr_wait_idle'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 749f73fc45a84..33541b4c01114 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -982,7 +982,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
 	}
 }
 
-/**
+/*
  * Wait until GR goes idle. GR is considered idle if it is disabled by the
  * MC (0x200) register, or GR is not busy and a context switch is not in
  * progress.
-- 
2.25.1

