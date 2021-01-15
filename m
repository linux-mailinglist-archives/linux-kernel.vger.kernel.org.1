Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5512F8395
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbhAOSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbhAOSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BDEC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:37 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so6747155wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvyHS8XiQc1oAzz859zgo3XkDd1Co0kNwC7up5M68+w=;
        b=XhjjfcqbMACLLu1UbUwoqoD/8t48q+La60pp5xe4eCTr0EMZJnWkSTnd6IyBDzec+Q
         RHflyw7Qx5MObqDYdfUNRRhZb5tcQlDS93CBk9n8BvSp//3B3HXS7yDQ20yIBhpDjm7J
         CJecEL0ZPE8v+KQyGPehSrFI59nJ68dHfp6WhLpKaprgpNczqjT2o6uR2IhUfx7Oi11t
         SHGVxSBkHz1lL/PVJIlI2NtCTuHfxTPAzO+7XDJYkI017xs7WIYnJz9Of+IQrLWENyS9
         LWVqRaqiy+jGvXeOmpQa99Xoe8wK0qekcEgWyk62TXSV6S75tLeGP5zkpNenv8umJU4L
         rIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvyHS8XiQc1oAzz859zgo3XkDd1Co0kNwC7up5M68+w=;
        b=t4ONHYboMJXPX/C10TazL1Lan96KC6HMW8bBGpZXu61DtbmVtu1YrHSnXyf+66IFaA
         cddtIiKEQQb75a1+I5aKvkoJZGycEekgghphiT5CNmQZ6nPuoXcPH64ooHXMyS7odbJP
         R1WWKWo4LFr6rGDbxVaSI6yEYPS/OOt/7o71E0lNXq117urTFg1+A8x7OdIDKYl8JcDm
         zH6aAlG65eBevWsEm/BVnqSBDpYYPpmu2/nw3msILqFKf/+S6UyfHpUOiznZyBAu0Ysp
         97vkV7y1S8PBvhRBuUFlRGNbxxvjHl1VVlU7axvYwsJlSCGRYrgxpxYQeml4zBeJF6FX
         SWUw==
X-Gm-Message-State: AOAM531v5iF3n3AMlhbRaxe/JKX+4xHVidlgNS13+6QoerflNBj0cWRL
        X3k3ZzZSF2BVjqr874UAC+MpLg==
X-Google-Smtp-Source: ABdhPJzM3pePojoBobuolex7+uztZaeYfeUOxi34s4vdEqInkukJV1C7p5vxVqa/UR1IIxgjiE02JQ==
X-Received: by 2002:adf:902a:: with SMTP id h39mr14398191wrh.147.1610734415837;
        Fri, 15 Jan 2021 10:13:35 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/40] drm/vmwgfx/vmwgfx_ldu: Supply descriptions for 'state' function parameter
Date:   Fri, 15 Jan 2021 18:12:46 +0000
Message-Id: <20210115181313.3431493-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:55: warning: cannot understand function prototype: 'struct vmw_legacy_display_unit '
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:218: warning: Function parameter or member 'state' not described in 'vmw_ldu_crtc_atomic_enable'
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:228: warning: Function parameter or member 'state' not described in 'vmw_ldu_crtc_atomic_disable'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 9a9508edbc9ed..acae92a07f4f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -49,7 +49,7 @@ struct vmw_legacy_display {
 	struct vmw_framebuffer *fb;
 };
 
-/**
+/*
  * Display unit using the legacy register interface.
  */
 struct vmw_legacy_display_unit {
@@ -206,6 +206,7 @@ static void vmw_ldu_crtc_mode_set_nofb(struct drm_crtc *crtc)
  * vmw_ldu_crtc_atomic_enable - Noop
  *
  * @crtc: CRTC associated with the new screen
+ * @state: Unused
  *
  * This is called after a mode set has been completed.  Here's
  * usually a good place to call vmw_ldu_add_active/vmw_ldu_del_active
@@ -221,6 +222,7 @@ static void vmw_ldu_crtc_atomic_enable(struct drm_crtc *crtc,
  * vmw_ldu_crtc_atomic_disable - Turns off CRTC
  *
  * @crtc: CRTC to be turned off
+ * @state: Unused
  */
 static void vmw_ldu_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_atomic_state *state)
-- 
2.25.1

