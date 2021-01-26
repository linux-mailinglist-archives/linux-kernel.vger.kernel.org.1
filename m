Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45489304FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhA0DZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbhAZU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:59:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB9C061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:59:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id l9so25023791ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkWc8jdaLg/m0l0bUIXMZoNlWUmtThzXolrQWgPDX9A=;
        b=SFgx+1jwDHwJl5/pYtVEUsFV+wBy/bBhSy0FXJgKgD+ttppOw8/W/4THhlOgTHHSjW
         5LV23rvCou1k0Vl3fhFTbbFDO6sPwRbDQOu73Yfdvo8i4hzlBH2dU8kyAJzcnnyryHDC
         CxKjBL+GGf/k33tub7BYkHJzDr9CSoVSkePsFaT/rjhT++hqA33QE2CwyKgfHjk2G9Nd
         cWGLm7Jh/Qs3kbVDKsurij+3rxco0k9O67c7e0f0v3sOf63I452GqmLfROKpbkUn7keW
         ZntnhN/MSqUTcje+Z2rZ2pGKDovVxUpzFu590X9P06W9Ef/YBFm34vMp0/bN/TBwd9C3
         72wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LkWc8jdaLg/m0l0bUIXMZoNlWUmtThzXolrQWgPDX9A=;
        b=BnLxhmZlCbZbQcfjZB0APvKoTY41yoAXPj3SDms8tPdA5pP+Z8kbO9RMU62U5NSbft
         95jx6ehKTaSyHY6WLq0DOYko77eHzjNpDbkkUcAHReLR67j5FKWKmGDe3YAAd/vs15Ac
         hOfFLn/Z333iFjThgL+KBlhKGostZXqHp47h0cGa4FKPdqhse2WYDwCCkHcPW2eUqOaR
         wDBo19HHSVCXYGZ6ZPeJ1D7gMpqfxbsfw6u+d9GyONEAylNLQOWzvDc62VDR6aFYUS/D
         n5KvRVIkGwg52u77VumBEEUUZ3XwRFCyvvqeErOZacdVpJK09NK34dv4secU4TdRq6y0
         2bvQ==
X-Gm-Message-State: AOAM532qzWKB+1QpuKQ0atU4945CpWxufMi0JmYlsTLB127306NzdnVO
        kNPPGCdbPLb/1msPy8YXerw=
X-Google-Smtp-Source: ABdhPJxFRsDnpx0/61JI/BZ8ao9iHInjvmWiWg+yTrONOjF/ZpTZgSOaez4fYwoHjCfeEeLRCb967Q==
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr3044930ejp.436.1611694748684;
        Tue, 26 Jan 2021 12:59:08 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:9ff1:8caf:ad1a:a1f7])
        by smtp.gmail.com with ESMTPSA id bd5sm12660434edb.86.2021.01.26.12.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:59:08 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gt: use new tasklet API in execlist selftest
Date:   Tue, 26 Jan 2021 21:59:02 +0100
Message-Id: <20210126205902.5584-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the execlist selftest to use the new tasklet API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
Hi Chris,

I seem to have missed some tasklist manipulation in the execlist
selftest.  Feel free to squash this into my previous patch
("drm/i915/gt: use new tasklet API for execution list")
or leave it like this. Whatever is fine by me.

/Emil
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 264b5ebdb021..ba55cd018f5b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -609,7 +609,7 @@ static int live_hold_reset(void *arg)
 		}
 		tasklet_disable(&engine->execlists.tasklet);
 
-		engine->execlists.tasklet.func(engine->execlists.tasklet.data);
+		engine->execlists.tasklet.callback(&engine->execlists.tasklet);
 		GEM_BUG_ON(execlists_active(&engine->execlists) != rq);
 
 		i915_request_get(rq);
@@ -4610,7 +4610,7 @@ static int reset_virtual_engine(struct intel_gt *gt,
 	}
 	tasklet_disable(&engine->execlists.tasklet);
 
-	engine->execlists.tasklet.func(engine->execlists.tasklet.data);
+	engine->execlists.tasklet.callback(&engine->execlists.tasklet);
 	GEM_BUG_ON(execlists_active(&engine->execlists) != rq);
 
 	/* Fake a preemption event; failed of course */
-- 
2.30.0

