Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE32EF8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbhAHUQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbhAHUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76DC061247
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a6so8732464wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0meb7DEluI5lCKKHhFh+KkZgGQmTED8UYQgsHtPH9AI=;
        b=b+8BELUy6TYHrFE+ojlTD5o+vZ/tEQjDu8czZAvyrxub0pcI6chJUoZ2lCPjCPjABv
         9+quXXFHdgT6Fpuo23j3qGFJi++XkryIYAjEaiCDSGXtAvRT9g1+Br7tew2FKxP4QU07
         gLqxjq5/JKGeu+mhZHe5oN34VfOToSNyGQZvfc3QyL3AhJpOP2PyMwkzdeDcf3JXETdM
         +H/AiCaoEElkLOGti7xyPj7B/4lLWROEMkhiKh6Nzrryo1rOp18oWdsPR1pU6AukN/Qa
         Xukv2856sxNpzczu/PirBr3Ic93WgRUohpIWkUXjlu+/FzLwF2/0auSZoWOC7qcY0LVT
         IPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0meb7DEluI5lCKKHhFh+KkZgGQmTED8UYQgsHtPH9AI=;
        b=ima9TNXPVSpX6yt6gCCTQW96GIIG6TV0c42bcFWuFiwcGoUlcHCPykWJut50AChPJa
         cKyVLRmdDPp84CMWZCsyQOtRkt62H9a4r2ODDExIqCd/vmW948LyggimgAxIKzehELPy
         VuMs7dTDXVz5/LPM/TemsKRe3CeSspKy6D+edvEyeECSaRhj4BmwbJMr4RzCkUh/ZYAb
         MVIlS7MqCSjJ7PnqQZExQyVuCr/rDRQ2tJ5WlBO58arfCq9VyaZljMYPL3xbSmu3B3UB
         7X0spFmF6cq/YJ8gIkWCBSumjDtXbEkB8Yfvd+8sQ6vAz0MOdyrGYte46c6bpqJaSGcY
         3DTg==
X-Gm-Message-State: AOAM533rmVNRZi5yvxflwJezYbB0kRVvPBRaixQmwpszx9YvRun5/AY2
        yyviyXDs/pdEAl3DHcSl0Dm8Ug==
X-Google-Smtp-Source: ABdhPJypNc1DfLCl8VxEr0OvMckgJB9nFs1wGhAwDJWr8F5fydgjX/rVMxJA/ROmsyBPaHHuB4ie4w==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr4612278wmf.134.1610136952039;
        Fri, 08 Jan 2021 12:15:52 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 33/40] drm/nouveau/nvkm/subdev/volt/gk20a: Demote non-conformant kernel-doc headers
Date:   Fri,  8 Jan 2021 20:14:50 +0000
Message-Id: <20210108201457.3078600-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'temp' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 't_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_t_voltage'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
index ce5d83cdc7cf7..207e5278b37ed 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
@@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] = {
 	/* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
 };
 
-/**
+/*
  * cvb_mv = ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
  */
 static inline int
@@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, const struct cvb_coef *coef)
 	return mv;
 }
 
-/**
+/*
  * cvb_t_mv =
  * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
  * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
-- 
2.25.1

