Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2612F83F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbhAOSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbhAOSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:18:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF32C0617B1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u14so4198886wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0MKcaQJg4qBHpqlKLqhoArao/P8hSXgM/s3rj7VTt0=;
        b=J172cC3Uyma0VckyFc9AxWG25drY1eDR3/CO7zKGtLnvPXc3QRyYBEZTk3wr/Oojdt
         MkXBZReGLj4d5du5UEuPAIX7iFhOX6Vp/xqc5CaimCjZSRf3tu+X2lx0zRUVU0sd/VqE
         J7k689wvnQ9GOfnh2QIXAOotKN4qzk9cE78Zs+gHvwX6sealI/MJlNafXOsJUNEO6q6q
         joQ57rLYh0mr85db9y/WWYUIMrefeocZ7Rixa1rmjqqOxJ2UUyHLrmCeBsDOkMWRXBJb
         MdaAdsRDDvgLImIUSWBGUW54fPXMROaN4hPMMy8GnqvniwL3os7PGOxpxKELQxSNQv4O
         jXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0MKcaQJg4qBHpqlKLqhoArao/P8hSXgM/s3rj7VTt0=;
        b=ch5m65vve62EdtpV7PEAagEkkMdiazoxMb//2W9VOcEZAoqppr0g/BFVMey2BFR8r3
         mcg7uaIW2F6O6niAWICWHbdTyN/u/2raQd8UHlvLFd+XJgPWZPuum68V5oQGi0XfrSjK
         p1txRXLVZrkwN+WvF5n0mY0wlxdeypfQeGDhp0hM6ZYUEQv3In4evpDTIgS3rPUu1e/e
         u9hCe+2UdBoPZqLUfPJj/P+ERzYFypoXG7ftWaYeImcNLWg4FO6fzG0T3H8zcdvYUkwI
         4pd9grj7eCFNN0z4zlouWSCX0EClFwOYcfMmecv0NixweYfwang/svGsHZ3wpnElG6bM
         H/rA==
X-Gm-Message-State: AOAM5324NqCBJ1t6A6BUWEy9Af3jVhhyrtWcwTLgh4vu/qchxDNnYQB8
        Bm9hbpVSjZ3dMum4mYJMCqM8W0oDxoI+atms
X-Google-Smtp-Source: ABdhPJypKKRUbRWYCHxMnXoeZXHc/KsmeR5j7hQzz6Ji0P/sOn9WdxZugDa5oe2vQNPvr7o3cVICrg==
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr10051589wmn.100.1610734599295;
        Fri, 15 Jan 2021 10:16:39 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Eddie Dong <eddie.dong@intel.com>,
        Zhiyuan Lv <zhiyuan.lv@intel.com>, Min He <min.he@intel.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Pei Zhang <pei.zhang@intel.com>, Niu Bing <bing.niu@intel.com>,
        Ping Gao <ping.a.gao@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 24/29] drm/i915/gvt/handlers: Remove kernel-doc formatting from non-kernel-doc header
Date:   Fri, 15 Jan 2021 18:15:56 +0000
Message-Id: <20210115181601.3432599-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/i915/gvt/handlers.c:1666: warning: Function parameter or member 'vgpu' not described in 'bxt_ppat_low_write'
 drivers/gpu/drm/i915/gvt/handlers.c:1666: warning: Function parameter or member 'offset' not described in 'bxt_ppat_low_write'
 drivers/gpu/drm/i915/gvt/handlers.c:1666: warning: Function parameter or member 'p_data' not described in 'bxt_ppat_low_write'
 drivers/gpu/drm/i915/gvt/handlers.c:1666: warning: Function parameter or member 'bytes' not described in 'bxt_ppat_low_write'

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Eddie Dong <eddie.dong@intel.com>
Cc: Zhiyuan Lv <zhiyuan.lv@intel.com>
Cc: Min He <min.he@intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>
Cc: Pei Zhang <pei.zhang@intel.com>
Cc: Niu Bing <bing.niu@intel.com>
Cc: Ping Gao <ping.a.gao@intel.com>
Cc: intel-gvt-dev@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/i915/gvt/handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index eaba80975f42a..0d124ced5f940 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -1651,7 +1651,7 @@ static int edp_psr_imr_iir_write(struct intel_vgpu *vgpu,
 	return 0;
 }
 
-/**
+/*
  * FixMe:
  * If guest fills non-priv batch buffer on ApolloLake/Broxton as Mesa i965 did:
  * 717e7539124d (i965: Use a WC map and memcpy for the batch instead of pwrite.)
-- 
2.25.1

