Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082B2F83DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbhAOSRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbhAOSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1ACC0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c124so8211283wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xb1YCvw4kaZw9lo4k2diSP0ZRuU7Xd8WppcxAl/MiDA=;
        b=uXazNko3Ye2A1AYNrjCLLq6bpwOE4mQ3fhAnSbVRy3tPzywmhYFHem+yunqZ87yneH
         s8CtKFvBmI7Fv4kX+gFnj6sm144bKSbUTSVopB6LjjLuc+F9IyhdfMRL/ldkxzbTX6ii
         ARDQ+2r+b+kRMKDqhpvG3RjtrfU+GaSZGcwOMnaxOh9zyRuyAbjk6ZFPwodt5Pzvan/a
         4sE5ZdYFPgmgjqpSgG6kntQdsVdXRIx8/IVLyOPHWHzRE82z9E8B7FWWDecj6jllHJ50
         O5qzM/Z9Bv+xVV72ain840kaDl2JAFSXhWAaAz+U6ciAzzdkyNrgZgbgK1CJ+zzRZCGd
         VF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xb1YCvw4kaZw9lo4k2diSP0ZRuU7Xd8WppcxAl/MiDA=;
        b=jcgMpVr9oRcpPjZ6gS9fHIqWENfT34ATuH4IykqivyeDqe0hzVKWu/hMlAKOwGILJO
         KZNDhMdVes5v4GhSx9ABdOAbNSV6yCZ46J69kdwdKI3r4r8LCwHele4toN9HkD/c19Eq
         bO0O1C/eTkZEnrKm7vEzTDxsbwMyPC5mBUufyK0C6UnDsyijHZGoHW90D0IUeV6M51oc
         L625WEZcfLF5ZnJdA3qpCdyhc749ZD5wpb641aQGsLR7djUXAUS7uW7ArifCOQTO+Swe
         0FYj+EGfUlfUcvMp8WJsc49cri9+tNzdY5s4yiLbP2OFc6uZJfo9PPjhJd0tqUG+G3KQ
         UiTg==
X-Gm-Message-State: AOAM532IQP/RhGi1JFfh2r/2A8wda/zY4aT95JCgIHZja1vxdPfU8n1W
        njEhVzYkyL7aMmO0+EiIsZw1Fw==
X-Google-Smtp-Source: ABdhPJxW/+bf0aOgWlZYDE1g3TAxNc01NP5C9reyjW+xsDu0vazbM2CsWTjG8T7jj6kcJW2nFm5fZg==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr10147012wmd.2.1610734585915;
        Fri, 15 Jan 2021 10:16:25 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/29] drm/gma500/cdv_intel_crt: Demote kernel-doc abuse in 'cdv_intel_crt_detect_hotplug()'s header
Date:   Fri, 15 Jan 2021 18:15:46 +0000
Message-Id: <20210115181601.3432599-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'connector' not described in 'cdv_intel_crt_detect_hotplug'
 drivers/gpu/drm/gma500/cdv_intel_crt.c:138: warning: Function parameter or member 'force' not described in 'cdv_intel_crt_detect_hotplug'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/cdv_intel_crt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index fc58a73ed11d6..c48c9d322dfbd 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -127,7 +127,7 @@ static void cdv_intel_crt_mode_set(struct drm_encoder *encoder,
 }
 
 
-/**
+/*
  * Uses CRT_HOTPLUG_EN and CRT_HOTPLUG_STAT to detect CRT presence.
  *
  * \return true if CRT is connected.
-- 
2.25.1

