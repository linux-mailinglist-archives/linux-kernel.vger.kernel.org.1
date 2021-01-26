Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE430415D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbhAZPDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391566AbhAZPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:02:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ADEC061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:02:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j13so20141037edp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PmHpHVYbvaI2vdfD1yqNwoWG7t7iJr68+JLvkv+4zDI=;
        b=bdf7EeLCGKhNUHopjRxzUn3ScxngRMfoPzPtLzEPDyxGmt6500Qx6lnfS4qYxNXpHF
         K/3d1Qq/FsTlwo4Uq/5uIChwGvHeZp6Q3yXWWBkbuccfHs4WWNgqAmhzV7gzwptIoYYW
         ob1MMOm5NotozHO2n6o8vy+kig6mAx75HWfRvaJgmiDASxfwcizyN5YfmO3dhEDsyjK+
         CijbdNGvhHNQry/92MeZv7XksYqzQT578R4/QTxsqnoFGjOe1E+ejUJN7rj+dPrb2vnM
         8hFrI7yOBlPEt5DUTYym71rbyeNzOq2YfoGi3nB3KoOgONg8AAgVnnmjkKkaSsioBVRp
         dYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PmHpHVYbvaI2vdfD1yqNwoWG7t7iJr68+JLvkv+4zDI=;
        b=R/VDqUbcNz7sv0zlqR5OYD3iiVOG+V1PmGbrH2ye/sVh9Tj60ksD4Me2eUJ7L/XKkQ
         JiiGlrjWkyUACZ9xifY4jfYWtgewquPcZEYmpjZAvUp7yvH2hg3aI7MvXJt3dZXU7E8t
         QCThHCsMnU5oZOrtqWxUrqD+kh2ZXDDxJpjj0WKixPuHLMlq94PBUFGdN3IJtbCPWczf
         3hJ/yMNMHI0Nh+RKCQ3FHppVYD7r3zikZXba2Ft2UyRxsymwJkodN3uMHakUF1MYiVXl
         Gs3S7jYT6+teBaGLH75icff9Uuq5VmUCPKy4ftAia+YPvz36xqBSPMTProJtHsQmS5aZ
         4Okw==
X-Gm-Message-State: AOAM530cp4xc2p/GZG660mJqDZuqWD2QIyN5I/49Z4ewVQUqg9/MEq8j
        7oBDoqiFvC3S7yHdarcrdLw=
X-Google-Smtp-Source: ABdhPJyAUYlT/ae42NrtlkM2In3O74/ddo57FZ4ysdt70bg+r4DlCrOIzh+r+YrXxsD4SocM1apXpQ==
X-Received: by 2002:a50:8387:: with SMTP id 7mr4683813edi.131.1611673323617;
        Tue, 26 Jan 2021 07:02:03 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:4d1f:a80:1d37:b028])
        by smtp.gmail.com with ESMTPSA id ke7sm9899773ejc.7.2021.01.26.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:02:03 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     intel-gfx@lists.freedesktop.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/gt: use new tasklet API for execution list
Date:   Tue, 26 Jan 2021 16:01:55 +0100
Message-Id: <20210126150155.1617-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the driver to use the new tasklet API introduced in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

---
v2: Rebased on drm-intel-next

Tested on my Dell XPS 13 9300.
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  4 +--
 .../drm/i915/gt/intel_execlists_submission.c  | 25 ++++++++-----------
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c |  9 +++----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index fa76602f9852..48a8caa28f65 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1234,14 +1234,14 @@ void __intel_engine_flush_submission(struct intel_engine_cs *engine, bool sync)
 {
 	struct tasklet_struct *t = &engine->execlists.tasklet;
 
-	if (!t->func)
+	if (!t->callback)
 		return;
 
 	local_bh_disable();
 	if (tasklet_trylock(t)) {
 		/* Must wait for any GPU reset in progress. */
 		if (__tasklet_is_enabled(t))
-			t->func(t->data);
+			t->callback(t);
 		tasklet_unlock(t);
 	}
 	local_bh_enable();
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index d7d5a58990bb..3dfae03c6d6a 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2376,9 +2376,9 @@ static bool preempt_timeout(const struct intel_engine_cs *const engine)
  * Check the unread Context Status Buffers and manage the submission of new
  * contexts to the ELSP accordingly.
  */
-static void execlists_submission_tasklet(unsigned long data)
+static void execlists_submission_tasklet(struct tasklet_struct *t)
 {
-	struct intel_engine_cs * const engine = (struct intel_engine_cs *)data;
+	struct intel_engine_cs * const engine = from_tasklet(engine, t, execlists.tasklet);
 	struct i915_request *post[2 * EXECLIST_MAX_PORTS];
 	struct i915_request **inactive;
 
@@ -2956,9 +2956,9 @@ static void execlists_reset_rewind(struct intel_engine_cs *engine, bool stalled)
 	rcu_read_unlock();
 }
 
-static void nop_submission_tasklet(unsigned long data)
+static void nop_submission_tasklet(struct tasklet_struct *t)
 {
-	struct intel_engine_cs * const engine = (struct intel_engine_cs *)data;
+	struct intel_engine_cs * const engine = from_tasklet(engine, t, execlists.tasklet);
 
 	/* The driver is wedged; don't process any more events. */
 	WRITE_ONCE(engine->execlists.queue_priority_hint, INT_MIN);
@@ -3043,7 +3043,7 @@ static void execlists_reset_cancel(struct intel_engine_cs *engine)
 	execlists->queue = RB_ROOT_CACHED;
 
 	GEM_BUG_ON(__tasklet_is_enabled(&execlists->tasklet));
-	execlists->tasklet.func = nop_submission_tasklet;
+	execlists->tasklet.callback = nop_submission_tasklet;
 
 	spin_unlock_irqrestore(&engine->active.lock, flags);
 	rcu_read_unlock();
@@ -3104,7 +3104,7 @@ static void execlists_set_default_submission(struct intel_engine_cs *engine)
 {
 	engine->submit_request = execlists_submit_request;
 	engine->schedule = i915_schedule;
-	engine->execlists.tasklet.func = execlists_submission_tasklet;
+	engine->execlists.tasklet.callback = execlists_submission_tasklet;
 
 	engine->reset.prepare = execlists_reset_prepare;
 	engine->reset.rewind = execlists_reset_rewind;
@@ -3228,8 +3228,7 @@ int intel_execlists_submission_setup(struct intel_engine_cs *engine)
 	struct intel_uncore *uncore = engine->uncore;
 	u32 base = engine->mmio_base;
 
-	tasklet_init(&engine->execlists.tasklet,
-		     execlists_submission_tasklet, (unsigned long)engine);
+	tasklet_setup(&engine->execlists.tasklet, execlists_submission_tasklet);
 	timer_setup(&engine->execlists.timer, execlists_timeslice, 0);
 	timer_setup(&engine->execlists.preempt, execlists_preempt, 0);
 
@@ -3471,9 +3470,9 @@ static intel_engine_mask_t virtual_submission_mask(struct virtual_engine *ve)
 	return mask;
 }
 
-static void virtual_submission_tasklet(unsigned long data)
+static void virtual_submission_tasklet(struct tasklet_struct *t)
 {
-	struct virtual_engine * const ve = (struct virtual_engine *)data;
+	struct virtual_engine * const ve = from_tasklet(ve, t, base.execlists.tasklet);
 	const int prio = READ_ONCE(ve->base.execlists.queue_priority_hint);
 	intel_engine_mask_t mask;
 	unsigned int n;
@@ -3683,9 +3682,7 @@ intel_execlists_create_virtual(struct intel_engine_cs **siblings,
 
 	INIT_LIST_HEAD(virtual_queue(ve));
 	ve->base.execlists.queue_priority_hint = INT_MIN;
-	tasklet_init(&ve->base.execlists.tasklet,
-		     virtual_submission_tasklet,
-		     (unsigned long)ve);
+	tasklet_setup(&ve->base.execlists.tasklet, virtual_submission_tasklet);
 
 	intel_context_init(&ve->context, &ve->base);
 
@@ -3713,7 +3710,7 @@ intel_execlists_create_virtual(struct intel_engine_cs **siblings,
 		 * layering if we handle cloning of the requests and
 		 * submitting a copy into each backend.
 		 */
-		if (sibling->execlists.tasklet.func !=
+		if (sibling->execlists.tasklet.callback !=
 		    execlists_submission_tasklet) {
 			err = -ENODEV;
 			goto err_put;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 23dc0aeaa0ab..5dd41014e896 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -238,9 +238,9 @@ static void __guc_dequeue(struct intel_engine_cs *engine)
 	execlists->active = execlists->inflight;
 }
 
-static void guc_submission_tasklet(unsigned long data)
+static void guc_submission_tasklet(struct tasklet_struct *t)
 {
-	struct intel_engine_cs * const engine = (struct intel_engine_cs *)data;
+	struct intel_engine_cs * const engine = from_tasklet(engine, t, execlists.tasklet);
 	struct intel_engine_execlists * const execlists = &engine->execlists;
 	struct i915_request **port, *rq;
 	unsigned long flags;
@@ -610,7 +610,7 @@ static void guc_set_default_submission(struct intel_engine_cs *engine)
 {
 	engine->submit_request = guc_submit_request;
 	engine->schedule = i915_schedule;
-	engine->execlists.tasklet.func = guc_submission_tasklet;
+	engine->execlists.tasklet.callback = guc_submission_tasklet;
 
 	engine->reset.prepare = guc_reset_prepare;
 	engine->reset.rewind = guc_reset_rewind;
@@ -702,8 +702,7 @@ int intel_guc_submission_setup(struct intel_engine_cs *engine)
 	 */
 	GEM_BUG_ON(INTEL_GEN(i915) < 11);
 
-	tasklet_init(&engine->execlists.tasklet,
-		     guc_submission_tasklet, (unsigned long)engine);
+	tasklet_setup(&engine->execlists.tasklet, guc_submission_tasklet);
 
 	guc_default_vfuncs(engine);
 	guc_default_irqs(engine);
-- 
2.30.0

