Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57A42A63FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgKDMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:15:41 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC71C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 04:15:40 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so17144688pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=R1J0AH9WgS50lM8FwPFZLpnnKAWRIzjyzvCVb6eH6q8=;
        b=LffQLyBZWSLKygNLU7+9ISrE6hdj+29LZSoL0kyavnd4iP2nJS5rzih3teg/MmzDOI
         etr9Q6zhdypa6G6uLRqZBItq/2pMojDYu/CjACz7rP2vKA08T9L6dplm4GqhxaeoSY+J
         q7A4ff/S0+SJj7ElQ1+sCmHfqiIomlZ7Uh9pFY538e3Gy+H9qrVIaS7Gu+ISrp8Nieuc
         7kK9PMUcSJrQRJga18KcWxpYaSOs4aRxa4vy/N9y+HEsHvbifQuMhP3qoKO2AAYyJqmD
         hVSFOZfs6WeKCLsj9Y4JnYmNy4Sl74UFf/0uRlPfAmStzyzR2/gCTW6FHEYmvU3hJlgJ
         6KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R1J0AH9WgS50lM8FwPFZLpnnKAWRIzjyzvCVb6eH6q8=;
        b=bN0aocH10WCXopCjA1FhlbRdulQTj5kWKI8VpFnDwQm4Xrqr++Do/VxrvNoA1mzWPp
         nhcZdovK2Ri4hg1NuyjN+twLEgIpFHrPOSsXRL5aGD0pEyOMeVYeCWTaEdLuEOnGkdSe
         ehDjSaTABidRzMV7JhoJygkulNuMNRmMGlJlhizAziAKPJ/T9oiSH9fJcsHbA+Oh1Gge
         6baEKJFEsSC9ahhK+y/9qoVKTgDJaoOHoxnJ1icnBssCrhoEGkdEO5sB7Gzt57woFEN3
         zZLAjcCGQ2sqHigzGFR+ieOiETDRZywKHtUgk3BdiVHbyPSWbB09VcJpyPaRviKwCxRw
         wTNw==
X-Gm-Message-State: AOAM533Wcu2bId9Hra4xSlWJkp1BhEWnytn+HEH5f9naGWpVCYHYASc1
        EwjX9EfwcqrVYpJMPcMGnwI=
X-Google-Smtp-Source: ABdhPJw8errMDs0Q21bOu5QpwF/Z3BYb7nDU4hdkJcP574gWqsGLZYHxZtFlddpR0ij7IWk1qxo48A==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr3973377pji.7.1604492139788;
        Wed, 04 Nov 2020 04:15:39 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id x4sm2288322pfm.98.2020.11.04.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:15:39 -0800 (PST)
Date:   Wed, 4 Nov 2020 17:45:32 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com
Subject: [PATCH] drm/i915/gvt: replace idr_init() by idr_init_base()
Message-ID: <20201104121532.GA48202@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier. The new function
idr_init_base allows IDR to set the ID lookup from base 1. This avoids
all lookups that otherwise starts from 0 since 0 is always unused.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/i915/gvt/gvt.c  | 2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index c7c561237883..45b492edbb19 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -312,7 +312,7 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 
 	gvt_dbg_core("init gvt device\n");
 
-	idr_init(&gvt->vgpu_idr);
+	idr_init_base(&gvt->vgpu_idr, 1);
 	spin_lock_init(&gvt->scheduler.mmio_context_lock);
 	mutex_init(&gvt->lock);
 	mutex_init(&gvt->sched_lock);
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index f6d7e33c7099..1c8e63f84134 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -393,7 +393,7 @@ static struct intel_vgpu *__intel_gvt_create_vgpu(struct intel_gvt *gvt,
 	mutex_init(&vgpu->dmabuf_lock);
 	INIT_LIST_HEAD(&vgpu->dmabuf_obj_list_head);
 	INIT_RADIX_TREE(&vgpu->page_track_tree, GFP_KERNEL);
-	idr_init(&vgpu->object_idr);
+	idr_init_base(&vgpu->object_idr, 1);
 	intel_vgpu_init_cfg_space(vgpu, param->primary);
 	vgpu->d3_entered = false;
 
-- 
2.25.1

