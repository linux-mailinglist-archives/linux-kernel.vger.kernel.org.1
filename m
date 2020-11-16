Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF82B4D72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgKPRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbgKPRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8A8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so30288wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
        b=wN846j+j1t9h9fPa28Onu7GZYXmQoYRLOxLBMdsgxmd2qjwO/2SHbYJ4aaZPTOwNwI
         Ie150qvycEdxzYdE6ALo/tJp0eHb8s/iM39uIWYiZQDcB4VODCCA6qx2PL3x1IxOyEzm
         pL94h3zfHi2M8NAko8DKtXEINUpu2UL/DlQGS7Zk5gfFe80wLQ5orA+eTl3yaAh0r6VC
         KFIJU5Qe6Hc25f0CT+oHuz4AYsncg/BtVJ0gYQz16eTW0QE8347rmKKa7A+A6aAKLWLK
         g+FRI4hv2PhqAzly5Q9dVAuFaGxdjBHlsW1nFIlcbHXoOuBALWhGlG+j2fgjcbRPY70Y
         evIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
        b=O69JhclRfQjyteeaP7MAoC9MczEw++t/NuZ20KCktUeZBDATnNu5XWDBYio+z5Wuzw
         gkMwtpNBtsCGFzQ5vVzK8bfnKuOLgVN5nzj0aLtKxiPm7MyI8g/FG4FSRCC5f0mdatRt
         vR1L4wx9ebAwjEY8NQTW6LPojo3nXwnp8IRnBKZNAHfEEkZOXwdwOFvJR49QhglSJMCG
         sVpAJqhL3qUixIRimnmRry+10xfmwSMW9MsfcrWao0m7JEk1YdMa80uvxe16y3eJ4NYd
         NhXdLe+yXY3v0m/tcyRLuJkM3DqYeLVHmP1Y83ivwhqHKsvX4pLiG+1t12+jFiJRFQO1
         LzAA==
X-Gm-Message-State: AOAM532IoMRPEFq4B3M8QXuIR3R6zFS/u0FuM3VtWOShfvgT7cVsZJBx
        JxnLUxtexlH91nmEY1ru0FzkBw==
X-Google-Smtp-Source: ABdhPJxnW5vVWKO5IKiS8AJDMKtmOdtkHQWn7yrRtegS0lejzK4gfrcvcn+KCja9gLQX70R+jn+t2w==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr24711wmb.54.1605548260732;
        Mon, 16 Nov 2020 09:37:40 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/43] drm/radeon/radeon_atombios: Move 'radeon_add_atom_encoder()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:43 +0000
Message-Id: <20201116173700.1830487-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/atombios_encoders.c:2721:1: warning: no previous prototype for ‘radeon_add_atom_encoder’ [-Wmissing-prototypes]
 2721 | radeon_add_atom_encoder(struct drm_device *dev,
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ----
 drivers/gpu/drm/radeon/radeon_atombios.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index cc80651b25773..be96d9b64e43b 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -37,10 +37,6 @@
 #include "radeon_atombios.h"
 #include "radeon_legacy_encoders.h"
 
-extern void
-radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
-			uint32_t supported_device, u16 caps);
-
 union atom_supported_devices {
 	struct _ATOM_SUPPORTED_DEVICES_INFO info;
 	struct _ATOM_SUPPORTED_DEVICES_INFO_2 info_2;
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/radeon/radeon_atombios.h
index b7c76920feb7d..a895a7002c3d3 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.h
+++ b/drivers/gpu/drm/radeon/radeon_atombios.h
@@ -28,10 +28,14 @@
 #ifndef __RADEON_ATOMBIOS_H__
 #define __RADEON_ATOMBIOS_H__
 
+struct drm_device;
 struct drm_display_mode;
 struct radeon_device;
 
 bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 				struct drm_display_mode *mode);
+void radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
+			     uint32_t supported_device, u16 caps);
+
 
 #endif                         /* __RADEON_ATOMBIOS_H__ */
-- 
2.25.1

