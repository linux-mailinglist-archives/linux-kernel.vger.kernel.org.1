Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55251E4EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgE0ULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgE0ULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:11:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F40C03E96E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:11:29 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je2Od-0005ku-Du; Wed, 27 May 2020 22:11:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 7/7] zram: Use local lock to protect per-CPU data
Date:   Wed, 27 May 2020 22:11:19 +0200
Message-Id: <20200527201119.1692513-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527201119.1692513-1-bigeasy@linutronix.de>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The zcomp driver uses per-CPU compression. The per-CPU data pointer is
acquired with get_cpu_ptr() which implicitly disables preemption.
It allocates memory inside the preempt disabled region which conflicts
with the PREEMPT_RT semantics.

Replace the implicit preemption control with an explicit local lock.
This allows RT kernels to substitute it with a real per CPU lock, which
serializes the access but keeps the code section preemptible. On non RT
kernels this maps to preempt_disable() as before, i.e. no functional
change.

[bigeasy: Use local_lock(), description, drop reordering]

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zcomp.c | 7 +++++--
 drivers/block/zram/zcomp.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 912e3e63d8a09..5ee8e3fae5516 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -110,12 +110,13 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf)
=20
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return get_cpu_ptr(comp->stream);
+	local_lock(&comp->stream->lock);
+	return this_cpu_ptr(comp->stream);
 }
=20
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	local_unlock(&comp->stream->lock);
 }
=20
 int zcomp_compress(struct zcomp_strm *zstrm,
@@ -159,6 +160,8 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist=
_node *node)
 	int ret;
=20
 	zstrm =3D per_cpu_ptr(comp->stream, cpu);
+	local_lock_init(&zstrm->lock);
+
 	ret =3D zcomp_strm_init(zstrm, comp);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 72c2ee4d843ed..40f6420f4b2e9 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,8 +5,11 @@
=20
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
+#include <linux/local_lock.h>
=20
 struct zcomp_strm {
+	/* The members ->buffer and ->tfm are protected by ->lock. */
+	local_lock_t lock;
 	/* compression/decompression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
--=20
2.27.0.rc0

