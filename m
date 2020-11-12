Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ACF2B0D47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKLTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B04C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so6456812wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=TYYnc+JTtX+7g5eq1yvtLhuta3frJKaGjJnmhpp9ssLYcLhSlYVMBIOWVkhID5dXhy
         s0fOBHL3PKNm6fWy6QXiAIvJgwepaT9f6/pLhP1CntWD8Qpb1yak3htNpVOHksCcu2C9
         t4Qtnlq8kSQMdGxnccItE49u5fTKpnXDivlcqvMyqj8OHuw5Y3paAtOYRb36Kmbrev9o
         Ys/VjaGC/LobEWcR+ODlkmq67ao4FjFVmrEWhiWfRf5fIaJWwSc7GZLiSkb+Bf+hM1lp
         1T2eUHPmvgHaMIcY1zz6E/B0c96U35SHIq7MT4ptq4uwr0uYFsiChoj6PBePbph19uqo
         uASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=eTEw27C/OpcLoMUJbZrT0yxrvEVvnlu/Rcs742jEmZcsDAORN2LpUY/Ee47RwNS/lV
         BU4nzG2BOSjnt8kXscnq5+gxXIQHKEIV6oeYiRgjqDpjdDBxL9BYogkeFM3+IZ3CEm6B
         ryykXWzdSMPPD+UARz1aYdT4peEgnG0CVVmkZSF/t6Xd1phNi9noGPO00fuSxvmSsLlZ
         haGheyLk+LXK/ZP120FZDxmbX8ohdvLaIeRT8yhfyjTSfZrE2wTkRQtFWM2RPm4hN7AJ
         ksPNzk5KSDrMEu1Z9kNMKZGNgINDKVr9CaVYzc9Wa2karTmn5wnMqadDrq0qJw1DZvsW
         mA4w==
X-Gm-Message-State: AOAM530/fOkrepJJF3pGJfd95VHuJ5ZEtQi+A9b4c/D8jGbOifOaUQNf
        voGruJFfS7DcTYh+THUUsDL27w==
X-Google-Smtp-Source: ABdhPJxxev4s6ztnVeA+0oHxTPfVxqcUuFCI3sPqtBHdpGw4gIT6p7WtbJE0l4F6u2036vpndLL48Q==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr1060841wmm.186.1605207696742;
        Thu, 12 Nov 2020 11:01:36 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/30] drm/armada/armada_overlay: Staticify local function 'armada_overlay_duplicate_state'
Date:   Thu, 12 Nov 2020 19:00:29 +0000
Message-Id: <20201112190039.2785914-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/armada/armada_overlay.c:329:1: warning: no previous prototype for ‘armada_overlay_duplicate_state’ [-Wmissing-prototypes]

Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/armada/armada_overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 30e01101f59ed..6346b890279a0 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -325,7 +325,7 @@ static void armada_overlay_reset(struct drm_plane *plane)
 	}
 }
 
-struct drm_plane_state *
+static struct drm_plane_state *
 armada_overlay_duplicate_state(struct drm_plane *plane)
 {
 	struct armada_overlay_state *state;
-- 
2.25.1

