Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8C2FFA53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbhAVCRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:17:19 -0500
Received: from m12-16.163.com ([220.181.12.16]:60041 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbhAVCRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=FUpAD7mi2xl59ZcPW1
        4M9M2HliTKwesJrNAhCSn/9vo=; b=ZMBKAimrzBI5kDL2jdY3K/DOjJ8tNCtJxD
        ai2RcnzVY9tRD7/Nub/O57WOCJVN00fYRjF0T4tBRuaza70Iagx1cntXj0DUBRSB
        RoEoMvLUsd9YstaFzNmS3A7oAtSfTUm3saOMQCiCDN7ebMGvKNzRSFNvGRXQt4S9
        6nXeKiufk=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp12 (Coremail) with SMTP id EMCowAC3GSziMApgmL4iYQ--.52373S4;
        Fri, 22 Jan 2021 09:56:54 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] drm/i915/selftest: Fix potential memory leak
Date:   Thu, 21 Jan 2021 17:56:40 -0800
Message-Id: <20210122015640.16002-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAC3GSziMApgmL4iYQ--.52373S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUAFyxKrW7KrW5Cw4xXrb_yoWfWrbEg3
        y7Zr97WrWDCFn0vFn8uwsxAFyIkF1rZr4xtw1xta1ftr13Aa1DWFZ7ZFyUXr4xWayUXF9F
        qF1kZFsIvrnrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbw0etUUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNgYiclWBlvTBgwAAsU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Object out is not released on path that no VMA instance found. The root
cause is jumping to an unexpected label on the error path.

Fixes: a47e788c2310 ("drm/i915/selftests: Exercise CS TLB invalidation")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index c53a222e3dec..713770fb2b92 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1880,7 +1880,7 @@ static int igt_cs_tlb(void *arg)
 	vma = i915_vma_instance(out, vm, NULL);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
-		goto out_put_batch;
+		goto out_put_out;
 	}
 
 	err = i915_vma_pin(vma, 0, 0,
-- 
2.17.1


