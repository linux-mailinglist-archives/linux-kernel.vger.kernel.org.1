Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E42F45FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAMIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbhAMIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:10:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFEC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a12so1053787wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4npnZBZUdB9VpRylBzLja8pV22PiHGoMVGeBjYnlKk=;
        b=ITSzPdTHABER1VheL/3HTMsa+peAOHNXWe9qQVNaliJwdCllNgkrjqNGUnnUoW1L8f
         TdK83gGX3FP7vDXmcFOgJx7vm9TGReb81hw6E4oTH2UM1IL3zW+q4gHPxvPDvd5AjKLm
         Gs+Fq4hVcFU/+NCK9s027XGyClxfE7KC/iXRoIU7sHz+fsTZAVPw6tV+wEsphAIL4kdI
         vHHXbjRGuiWVqmI3Q42dhbmNicEJpdsE38hcFJOwBPnn4jEboyFgMChQtAy+mNGDRQjX
         oTNmSqc/Gg8k9NpklmMiKL/QTj+29a6HQsHmlyC25nwS1XH3rQt7Qi7xdVTyOam0d9fo
         bzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4npnZBZUdB9VpRylBzLja8pV22PiHGoMVGeBjYnlKk=;
        b=S9KtJ9siT3VB16tuWdp+sgP/rCk2Lxtl/KkLiDL5ifqs5ktO8GpiIHnaYHFitIz4gw
         snr1qFx2V+M5Vm3vOMrSnqfoTgNwl3RLEo5m8wp5zhGbXpSYTO7Qri0rPx+SqqRM2C4y
         GFzdYXqSH/hYslFQy6FkPCo6GkM2AKRfhDn+3eIcMhxONkEebc3sR1Ro7x0D8pHW/RYn
         kWK7Ls9VBI7jhLJtycdTO8zvr2Td4rci/b99VwK5dNsIWOhxoUq/NYmKUe4oa64HI7Mq
         kgpQLQCV9q/2OIE0l+F8bPTub3PL872WsqMIcN+r5VxUhBwzAaU7Ej9YrYwFVGdLaT1Q
         Dwkg==
X-Gm-Message-State: AOAM5332hhm6m59BgzUC8fw6sQNpGgS9iacj+sCsE+pRrJNN5HPE/GR/
        R585NvTP5ysYtzqfkdqoPUUo91YX7JSNjeaz
X-Google-Smtp-Source: ABdhPJyl/Qhbk6jkk5C3J8WRijqVE/SpDxKAue04bKado0wqe6IdXSv6///j096igmmNz7SjwqECMQ==
X-Received: by 2002:adf:f989:: with SMTP id f9mr1164742wrr.299.1610525312650;
        Wed, 13 Jan 2021 00:08:32 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 30/30] drm/nouveau/dispnv50/disp: Include header containing our prototypes
Date:   Wed, 13 Jan 2021 08:07:52 +0000
Message-Id: <20210113080752.1003793-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c:2599:1: warning: no previous prototype for ‘nv50_display_create’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 809a9b20a6899..d82965893b6bc 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -68,6 +68,8 @@
 
 #include <subdev/bios/dp.h>
 
+#include "nv50_display.h"
+
 /******************************************************************************
  * EVO channel
  *****************************************************************************/
-- 
2.25.1

