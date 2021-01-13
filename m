Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D72F4602
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhAMIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbhAMIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABAC061388
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c124so682612wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKXxaEbbFVJtyOGef7aTveS2Qs30U+5wi8mm0q9i1ys=;
        b=fJmqSS0s+ZCugqp77ZDbXeNmyUS4QE3cEElAx+aIv/Cd/Nr6WJYGC7miWkQh+j40FF
         VXsLUJnSZyP5anEZOJCrNI2IiNpoEQBlQQL73PfE86lwfsWpL6967bOlcsi5gShkskAX
         Ol+YdxVaRV+2wR/7kxHONQGmXUfLDIHx+qXsHVn+PZ+JKvvEOYMEhrcJ3nlmx+uPZ93k
         kL7FH18RKGzeI499n5RBDYrhbNxk6yvXSGFn+UWOu7PvBUogw3e2c3AN4PLy4Di6q8oT
         WMnsmGX/2N7ruDDReZJ5S/Oe6cPlLrMBE0WvNuAN0aK2SlVnHayrpCCrFlQSEhKwx/J3
         PcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKXxaEbbFVJtyOGef7aTveS2Qs30U+5wi8mm0q9i1ys=;
        b=Kumug6PhXD45OHW5qkxnAdMdudgqH+xTwNa69CmF1ceSaTB+H3Cs0ASVSnPqkG7q8y
         soYaAz/SX+ym7xaU1oZAs7/scSjN1UqzBilogvj1VfQ9hh9HV2hV1alXiyeOhDpJzwWm
         1wa/VGnyW19kmia+1K4qw8P14l6fErOSAVIkPeKpA0RgH/x6rOuPm2NxeO5330QdnNvT
         1kYDZuUpdU9Kj6zPzquHFO5NLqYWVdJR0To1psyWCrDj8/laE/R2GVSbG448JABwfTvT
         qNAsDSEfn4dR1OvD4K5DIRxGa5uwGk7aC9QzPsL2iMfJCJFV0D24i4mSZe16etg/mpWD
         foNw==
X-Gm-Message-State: AOAM530KM+lw8nQb2w+ZJSBF6/C8eXM06x3aCu4Z26gKR/pAufbSGJHk
        MmmDhUNM2v9bIQhv6+lEoENHCQ==
X-Google-Smtp-Source: ABdhPJxrRCDR3uTrCjqrsFhzJ7gLc7caS9t8BTeezg1WGdGoice/2AUCNFahT3jIo+v0hjWgN59P5w==
X-Received: by 2002:a1c:a707:: with SMTP id q7mr695188wme.15.1610525308042;
        Wed, 13 Jan 2021 00:08:28 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 26/30] drm/nouveau/dispnv04/crtc: Demote non-conforming kernel-doc headers
Date:   Wed, 13 Jan 2021 08:07:48 +0000
Message-Id: <20210113080752.1003793-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'adjusted_mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'x' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'y' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'old_fb' not described in 'nv_crtc_mode_set'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f9e962fd94d0d..f9a276ea5a9e0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	regp->Attribute[NV_CIO_AR_CSEL_INDEX] = 0x00;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
@@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
 	return ret;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
-- 
2.25.1

