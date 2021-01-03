Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D22E8C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhACNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhACNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:52:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09EF6208C7;
        Sun,  3 Jan 2021 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609681923;
        bh=fXJteWwKPcvYb6lpdOnO34DEgCFpdo7x5opOVSvacyA=;
        h=From:To:Cc:Subject:Date:From;
        b=c2It6IiNUywAUqc2Wbrh9DYinEIocdBARj1O8wMGCaQzFTzYJ2tDYUkhSxBGZUJzK
         PLy1wLaoXsQTSTVJ7rgQQuzY+ygFcola2F3nHH948AMf69o0Rw+jHeyHB/BQSWFyTU
         wHVH7oPeadg7wkXClFJI2sebl1UldkYvFXSPE9A1nKSm1f8DPbxrwOQr7UpDDUGkAs
         wg0nazETESUpM9bMGQspjt2YEKCPEkR3X2MsyeFLxs3krVlF0fg4SzKD8HG8RzZmKA
         jPG4Zj+GUTs59Z+1NZCbISIgCt2iKh7pRwFshqgY9WtsVhOaJ6neu+hYbZ69OZiXjh
         JmipMujqQGpbw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] i915: fix shift warning
Date:   Sun,  3 Jan 2021 14:51:44 +0100
Message-Id: <20210103135158.3591442-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds on 32-bit machines show lots of warnings for
the i915 driver for passing a 32-bit value into __const_hweight64():

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2584:9: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
        return hweight64(VDBOX_MASK(&i915->gt));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
 #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))

Change it to hweight_long() to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index bcc80f428172..43164a0b0023 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2581,7 +2581,7 @@ static int eb_submit(struct i915_execbuffer *eb, struct i915_vma *batch)
 
 static int num_vcs_engines(const struct drm_i915_private *i915)
 {
-	return hweight64(VDBOX_MASK(&i915->gt));
+	return hweight_long(VDBOX_MASK(&i915->gt));
 }
 
 /*
-- 
2.29.2

