Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E70297A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757085AbgJXArb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757067AbgJXAra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:47:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D074C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:47:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s15so245100ejf.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nGBhSaBuMaImbsbpDD696OYT/ES8t/q7g+4eLy+bu8=;
        b=gOZhoV+6gGSXqS8XfN8jVsjRRRjofmjn+hpYzAmNvCrWy9I5g0qMUVR5e5R9NweGJ0
         ABDDLfGOiOVsu/LmVAo2oaVNbi03304MCep7p0yUlBcH13Q6UhLDnjwymy4mLmiWZhls
         3uHEGqYLM0eAJBn6cq3eglfA4U2IMp01rPZkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nGBhSaBuMaImbsbpDD696OYT/ES8t/q7g+4eLy+bu8=;
        b=n01t2JczsMdeWHJ8TjGwRzrcssIoKIKd43513c3dUkIVnqxxu8fYZeH9yJ1VvP2Gu+
         PWuKG55r5SEZHtzVHp9hahK72dit249XOxNLWrOdMiXOMP/q7pnnlmlPjlaGYUxwdxmZ
         wOMeVmtcDK3DOwcSXnAAp+eL5scztqxN+Rjicx0PSjtMfQlJKLmGzG03KCNLHniISP8E
         BUy9JcDLGccINh5sNp73+GqIhSXi6ry1qWawB0QoFMqzOq4wWrAUXq4q9mD7NHS4/Nka
         b1HCdDw78B2I55GzQM21KkaHul3zJd/gVQ/5cvfGhP1tr9wlkaL6Bsgmv3lHWBDJ04dw
         FHgA==
X-Gm-Message-State: AOAM531iMMxGEZYaU08RYU3UHP8Frwy3aZjLrRxgt/JTDjhnccg3GB5h
        0kXaS7xRYSDfoFkMTcrmi5ZqCA==
X-Google-Smtp-Source: ABdhPJwDurk4oHPdsox9A9z3dqzjWUY5yj8mDDqlIRq04fNZyTcZK1l9lEzo723x7M0+yR9UN4D2tg==
X-Received: by 2002:a17:906:3bd7:: with SMTP id v23mr4829055ejf.100.1603500449274;
        Fri, 23 Oct 2020 17:47:29 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id i14sm1527349ejp.2.2020.10.23.17.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 17:47:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: add __user annotation in radeon_ttm_vram_read
Date:   Sat, 24 Oct 2020 02:47:06 +0200
Message-Id: <20201024004706.24518-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep sparse happy by preserving the __user annotation when casting.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

kernel test robot has already started spamming me due to 9c5743dff. If
I don't fix those warnings I'll keep getting those emails for
months, so let me do the easy ones.


 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 36150b7f31a90aa1eece..ecfe88b0a35d8f317712 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -1005,7 +1005,7 @@ static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
 		value = RREG32(RADEON_MM_DATA);
 		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
 
-		r = put_user(value, (uint32_t *)buf);
+		r = put_user(value, (uint32_t __user *)buf);
 		if (r)
 			return r;
 
-- 
2.23.0

