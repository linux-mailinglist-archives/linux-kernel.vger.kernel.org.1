Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0022B0D27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKLTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgKLTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:00:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF45C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so7144118wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyM5JNiQS/TCpKPZ3DWBp4SZS9wc27h4cJ1y7RFnvhI=;
        b=lIeJaH1sJ0c1LM26yrpDKAxEDYUbG4Qz2oeYJNpP6jReLdw9bluHNlUYAurtH3+wsq
         NNLobHm0u3kMZifdyt7HVxNMh8ClFEpk7lZdlMqhV4NsDXQp+aMYGZvvAUCv88iApJRZ
         zPXG2q0tNCfjV65gUknv9dKZnvakZ8LZ1wZkIPd9xKW7yER+zLd4QsQXkjuBzEZhAxxJ
         Wd2LU2rsnVOericwQUFs5I8hMGbi4uT29ojkij6DG1ECBTuIC7g8iP5+sZfK2hN7iYoU
         F3VaOJhuXUHVIIIBlpBi3UdK0haK9+clEPTrM/j6F7oR2Nk9A81IgWvpeUXtJSoE+Sjc
         V0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyM5JNiQS/TCpKPZ3DWBp4SZS9wc27h4cJ1y7RFnvhI=;
        b=lzvn/vte+mJOs0c3rApBL+24y/tmq0V/DxB9kORlz5vZWgptqAjoWhujie1hziGv7t
         K/XHLuB42ApSi5gNHoGw4DMYnUe+4sPR6Qst0VvvPH2wp0oat8jMbXKlNDw2vEQaBd97
         9k8xLesyFIFDtv6WT9NJS2B19lA59ACvdPrI2X6X5JXl8GnD5k/qMAYu4I/XIXM00SuK
         PDugknS/IuUh9d7KEu2oSXldMAMTVn40qop8C+etkNnAd8yGu4O3GkJ/fk/41jioTg/A
         W/N42g8UcUSEgGSTFJVWwj76NvxbmM7xEKuaXC9WoNMj5Qe5qcADzg6ojGMLZt/6BP3I
         oqzg==
X-Gm-Message-State: AOAM5338l1eAwIDJhInmQoE5rKrIhn9FMD+QQMMj3RHCe/XAOr9NHeEe
        gxTdsVBkK6I9TbdZCkCoSUtQaQ==
X-Google-Smtp-Source: ABdhPJwSRZIkH2Y83W1FBYnIo2XNuRGD8z4oivnX35wQOzKxv1BtQkwajygZFWf5i4ucEUmssSFqgg==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr1117972wrv.266.1605207646576;
        Thu, 12 Nov 2020 11:00:46 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:00:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc' to avoid 'not used' warning
Date:   Thu, 12 Nov 2020 19:00:11 +0000
Message-Id: <20201112190039.2785914-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The precedent has already been set by other macros in the same file.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’ set but not used [-Wunused-but-set-variable]
 55 | struct drm_crtc *crtc;
 | ^~~~

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/drm/drm_atomic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 413fd0ca56a8f..dc5e0fbecc04e 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -802,6 +802,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
+			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_crtc_state) = (__state)->crtcs[__i].old_state, 1))
 
 /**
-- 
2.25.1

