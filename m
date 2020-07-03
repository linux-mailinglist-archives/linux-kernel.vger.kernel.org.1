Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67547213B57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGCNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 09:49:49 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42991 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgGCNtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:49:46 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 2EAF420646DD9;
        Fri,  3 Jul 2020 15:49:45 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/amdgpu: Change type of module param `ppfeaturemask` to hexint
Date:   Fri,  3 Jul 2020 15:49:40 +0200
Message-Id: <20200703134940.27054-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
References: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added hexint helper is more convenient for bitmasks.

Before:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    4294950911

After:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    0xffffbfff

Cc: amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Use new name hexint

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 126e74758a34..5c4263335cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -391,12 +391,12 @@ MODULE_PARM_DESC(sched_hw_submission, "the max number of HW submissions (default
 module_param_named(sched_hw_submission, amdgpu_sched_hw_submission, int, 0444);
 
 /**
- * DOC: ppfeaturemask (uint)
+ * DOC: ppfeaturemask (hexint)
  * Override power features enabled. See enum PP_FEATURE_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
  * The default is the current set of stable power features.
  */
 MODULE_PARM_DESC(ppfeaturemask, "all power features enabled (default))");
-module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, uint, 0444);
+module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, hexint, 0444);
 
 /**
  * DOC: forcelongtraining (uint)
-- 
2.26.2

