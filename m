Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8412BB384
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgKTSfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgKTSfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:17 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51BF22470;
        Fri, 20 Nov 2020 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897316;
        bh=ngeBODGo2GPXp3evyyN8Eya/GUTZDBHqW9NJDeiZO2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFaLNXjT+9H+Of+9nZ1sT6PgL3Jv8+toQtC3fHAPALZKRKUnXUjg/F5ugYDPAve+w
         q0oYfAfIUFIByvWZWyyo4el94AKu9TuX2qo6tqnbH2qKgJ1OJvuz8mt9fQ6aOaUXvP
         Kin4mVeA4nYGV9xWXOEM/37XxDWxMvmVIMT6IiqM=
Date:   Fri, 20 Nov 2020 12:35:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 080/141] drm/i915/gem: Fix fall-through warnings for Clang
Message-ID: <0e5ab2becd7f06cd1e7629d8dd6297585619d669.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a return statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index dc8f052a0ffe..b699c1adb106 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -59,6 +59,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
 	switch (obj->mm.madv) {
 	case I915_MADV_DONTNEED:
 		i915_gem_object_truncate(obj);
+		return;
 	case __I915_MADV_PURGED:
 		return;
 	}
-- 
2.27.0

