Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FDE2F83C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbhAOSPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbhAOSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351EC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o10so2358819wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yMxGlPEfyzvXa2UJQqEx7ekNRCoKDflK8zni2fkeUs=;
        b=Si13WZnjdkXdJogyfDIMI1YTp5PsWFLMpQMp5+G1UHdeypDKUAtv7h1aQEV+fImecK
         ivSNlCJIoBYyFxMYvF1bmuFw1vIxMuj4SR40JJeDLZlAs6g64j6LnFt4NvHwvcgEXMOW
         ENqxiXMpECNBXjjUQGYMobSUGV+OaIWcCeoOlBdlJpAxvfKp84rV1MLqS6vr6wlsWtm7
         PejC1um/TxCI8YN3jCuYMgatzgnru0/ZU+o1W4uLWLXLXZKw/076lH/ZMRK7Kw4kbqY8
         Afdk/FKH7TM76838J/DvbxysuQMyJrWeU70SfyL19qyQhEy0/8EKcpxgfbdtvNqDOrL9
         F5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yMxGlPEfyzvXa2UJQqEx7ekNRCoKDflK8zni2fkeUs=;
        b=U4/tX8H/kfTR2tBv17bcy7sv/3UV9i6V/6Nqmu8MZZpohMjCyinbdZLMgtgOtG9+1P
         uxhmI0grB18qLq5iMW2FYqf2gB4bosvLbALNjQRlzAi3x7HWA61V9aD0eG+Uw8PxYqPL
         I7SKN56dsaO0IILlVNb9YC0ZNzGpqlpStElez/mpGZ3GslQDu5NKsFTMYEgWQ4gGLOLe
         SPmr77YhBqSEsVHKLxQU/wiUkpkIklZ+O84ZW3oq2RTEOGavAaFZ/Akt58rVveB96VbS
         UWlb7Mu1Q8Auw80oERAoKCG5xoCzIAUibB53VZYgKwHNCt+G6Uxlrkm4BlqNdKPDtfZ0
         JU5g==
X-Gm-Message-State: AOAM530ot/JvSuI0TrDWmeFAL9O61uqKS+4j5dU/F2NEzEoC3QHnw5Y3
        U5iZ9lgqo1hF6jVEzGd7bM2TOFlACJ1H+gIv
X-Google-Smtp-Source: ABdhPJwvrXbHb+AjgLmUtqHU2FArfA74YAGB6r+5CFCOegLEs12lu6XvOUjwl+crbP8tjV88Jwb4gg==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr9861675wmc.178.1610734424527;
        Fri, 15 Jan 2021 10:13:44 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/40] drm/gma500/mmu: Make local function 'psb_mmu_pt_alloc_map_lock()' static
Date:   Fri, 15 Jan 2021 18:12:51 +0000
Message-Id: <20210115181313.3431493-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/gma500/mmu.c:316:20: warning: no previous prototype for ‘psb_mmu_pt_alloc_map_lock’ [-Wmissing-prototypes]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 505044c9a6732..42b53c01b79f4 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -313,8 +313,8 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 	return pt;
 }
 
-struct psb_mmu_pt *psb_mmu_pt_alloc_map_lock(struct psb_mmu_pd *pd,
-					     unsigned long addr)
+static struct psb_mmu_pt *psb_mmu_pt_alloc_map_lock(struct psb_mmu_pd *pd,
+						    unsigned long addr)
 {
 	uint32_t index = psb_mmu_pd_index(addr);
 	struct psb_mmu_pt *pt;
-- 
2.25.1

