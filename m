Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0E2F83E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbhAOSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E91C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 6so2903798wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fzZ9731GhrMXMJmVGpMkWndZV2lCJZqnwJ5TjxPTSs=;
        b=VLv18T//m35e1+2dIqkH1SvDm6ep+u85+YiYVoBayhkJq0Fo5kGhkzJednDi3CEhS7
         MQMCgq3ZXwij7qecAqGBES8zNlTtzDwbYxWmLwEVtInsV/7/5s8HK9SYgD0+YImGxUZa
         d4zqkA/OoYXoywIjLGYOiLiTdT/4vjUgOPBlhH+jOShM1ppshX1o44aHw0lgrwwS8R2b
         oSXF5ldU70vZ/ypBG955toEAbw+ie77kqQE90uSIs1cywTgldkiFsA8Isapd7EhNL2n7
         zsQg/SAPRlcjSRyJlBVIRYvUCkm3Cn0ipnW5cE3CWA0KLOnp18viSfxPwMGN1JZ3r3/O
         2M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fzZ9731GhrMXMJmVGpMkWndZV2lCJZqnwJ5TjxPTSs=;
        b=hdL92i3e6NKuuGfmYD9gCqPwFu2lRm04ViNNzxwpWcG5aoUl79mqP8pXw8vcUmQCJZ
         ZtMrFdT+0DroYR5mNk/UbAUOTjR32UpO2vkpvxCXsduDngIGhC9UFN4JePnWqkB75f+f
         L07wj3VsDSo/Wu+iBomlVKWfsUeQVmCW8QRDGmINKtIUNGwCjO1RnKUU1x9QCDKXIvR+
         DZxSf8V01LGmxm5murTpRAv9UPgmK13gg37Elhh6BPUlgcrFRm96pIMaU5KMqGeLVc2b
         5+gzrfo3++TKvkbUbcM9fiAKiCrmiU7OkLwujJ/ACoroDSMl06ElCdoH4RVceJoHr3v1
         0KNA==
X-Gm-Message-State: AOAM530E4QW5qBYqkCcwIDULfVPtL2VdBBnnrZ60j/OWB3dmEv/fM8Ia
        /KUrP5eN+f6ZWl8kPFEUJmL7nw==
X-Google-Smtp-Source: ABdhPJznA2Wl1YFrtzDKMYW3dwJozKm8ADSN2o2+NRpfU8ADN4jG/jJu9XTqYIIxlotvF69iQ1C55Q==
X-Received: by 2002:adf:ab56:: with SMTP id r22mr14631360wrc.351.1610734405570;
        Fri, 15 Jan 2021 10:13:25 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/vmwgfx/vmwgfx_kms: Mark vmw_{cursor,primary}_plane_formats as __maybe_unused
Date:   Fri, 15 Jan 2021 18:12:40 +0000
Message-Id: <20210115181313.3431493-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 03f3694015cec..6267ccf54944e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -245,7 +245,7 @@ struct vmw_framebuffer_bo {
 };
 
 
-static const uint32_t vmw_primary_plane_formats[] = {
+static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_RGB888,
@@ -253,7 +253,7 @@ static const uint32_t vmw_primary_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
-static const uint32_t vmw_cursor_plane_formats[] = {
+static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
-- 
2.25.1

