Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB82D05E9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgLFQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:22:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58914 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLFQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:22:40 -0500
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607271718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU0kdttfnudUEJiKpFCgtr9uIFUJ/R19T/3hCU2kwXc=;
        b=I5UtT+4OPdtq5fyJ9N8nsHEHGzcZ/sQnwD/I8fDsVlLTjbBoARYNPJubCuFAM/o5lEN1oR
        vmFkegRJnhBzP16R7ix80S73Muja8EsK9xj46kgUXmbchxMqYAQcMfP9Ag9ZSZQ+cWdEUD
        2mw46ynhvZX+fDC1sJfCkPbwv2lvLwlnbaRKRmwHB5SXTs/qyWWJK9m5N2H7ayn7iYmmlc
        q/Qc1o8wMPzQVz236ecDLit6Mqvk98NuNKB8iWKhDZNNoG6TeAdhaldlvG1Hmu+fT+l+BO
        NnI1rAWMv1p1G8t9oR8K+3UNoWbtGo4CMtqO/ZugPp+t2oWBAeKWg35kDM1jOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607271718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU0kdttfnudUEJiKpFCgtr9uIFUJ/R19T/3hCU2kwXc=;
        b=joAAR5eD6RptGGKR669ENDAGXOyCS3fm0Rz6f/V8dTVVtgWAc94rZiADRFbpdWkETlVCja
        S7UcOGcLlyg0NUBQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH -tip v1 3/3] seqlock: kernel-doc: Specify when preemption is automatically altered
Date:   Sun,  6 Dec 2020 17:21:43 +0100
Message-Id: <20201206162143.14387-4-a.darwish@linutronix.de>
In-Reply-To: <20201206162143.14387-1-a.darwish@linutronix.de>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc annotations for sequence counters write side functions
are incomplete: they do not specify when preemption is automatically
disabled and re-enabled.

This has confused a number of call-site developers. Fix it.

Link: https://lkml.kernel.org/r/20201030235121.GQ2620339@nvidia.com
Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/seqlock.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 235cbc65fd71..2f7bb92b4c9e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -456,6 +456,8 @@ static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_begin()
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
@@ -475,6 +477,8 @@ static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_end()
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
@@ -498,6 +502,7 @@ static inline void do_raw_write_seqcount_end(seqcount_t *s)
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
+ * Context: check write_seqcount_begin()
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
@@ -519,11 +524,10 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
  * write_seqcount_begin() - start a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * write_seqcount_begin opens a write side critical section of the given
- * seqcount_t.
- *
- * Context: seqcount_t write side critical sections must be serialized and
- * non-preemptible. If readers can be invoked from hardirq or softirq
+ * Context: sequence counter write side sections must be serialized and
+ * non-preemptible. Preemption will be automatically disabled if and
+ * only if the seqcount write serialization lock is associated, and
+ * preemptible.  If readers can be invoked from hardirq or softirq
  * context, interrupts or bottom halves must be respectively disabled.
  */
 #define write_seqcount_begin(s)						\
@@ -545,7 +549,8 @@ static inline void do_write_seqcount_begin(seqcount_t *s)
  * write_seqcount_end() - end a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * The write section must've been opened with write_seqcount_begin().
+ * Context: Preemption will be automatically re-enabled if and only if
+ * the seqcount write serialization lock is associated, and preemptible.
  */
 #define write_seqcount_end(s)						\
 do {									\
-- 
2.29.2

