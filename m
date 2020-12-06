Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD42D05E7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLFQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLFQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:22:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA186C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 08:21:50 -0800 (PST)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607271708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05nHgWwtp0N+HFTkoQLQ0IgvJ5N2F0IpdO6il+rMAK4=;
        b=Xh2qfihE4EfwcxSePcrwHMOhoKYN6JElVqvGl7BInvyXDaFYFlCVyt58VqSEx82+Qk34B2
        7+mYZPWjw9nQWINTyX9D39WGkF2z5wPL7Blh9r2bdGOxVHfxzr7awbOHcxLOTDKjPJV9qY
        BSprf1zbHznIQNWckq8pi4HEBNJACbCvHABaGvf1ijewPsaKDRlIZy2glOS3OphW+6uUnP
        gksSIozPRD+RZ7qK6PghdHhi80C+YlhixJ3lyLGQsmXD+Zg0H89NRqZ6lywDflLa1dcULU
        cxJXUxZU0J+lxH1+6zBfva4Rm57jMNT49RWv5A2GiR3h/n1xsH4cBdvfiaRPaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607271708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05nHgWwtp0N+HFTkoQLQ0IgvJ5N2F0IpdO6il+rMAK4=;
        b=b9LDZSgmySlh/b9Uc/JHMbNrExAes5AuHP8EOi5iOoDpB/NWas9L/4FpO7ZwN/zQzEG26k
        ABIApsNZq5OYJvBg==
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
Subject: [PATCH -tip v1 1/3] Documentation: seqlock: s/LOCKTYPE/LOCKNAME/g
Date:   Sun,  6 Dec 2020 17:21:41 +0100
Message-Id: <20201206162143.14387-2-a.darwish@linutronix.de>
In-Reply-To: <20201206162143.14387-1-a.darwish@linutronix.de>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence counters with an associated write serialization lock are called
seqcount_LOCKNAME_t. Fix the documentation accordingly.

While at it, remove a paragraph that inappropriately discussed a
seqlock.h implementation detail.

Fixes: 6dd699b13d53 ("seqlock: seqcount_LOCKNAME_t: Standardize naming convention")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Cc: stable@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/locking/seqlock.rst | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index a334b584f2b3..64405e5da63e 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -89,7 +89,7 @@ Read path::
 
 .. _seqcount_locktype_t:
 
-Sequence counters with associated locks (``seqcount_LOCKTYPE_t``)
+Sequence counters with associated locks (``seqcount_LOCKNAME_t``)
 -----------------------------------------------------------------
 
 As discussed at :ref:`seqcount_t`, sequence count write side critical
@@ -115,27 +115,26 @@ The following sequence counters with associated locks are defined:
   - ``seqcount_mutex_t``
   - ``seqcount_ww_mutex_t``
 
-The plain seqcount read and write APIs branch out to the specific
-seqcount_LOCKTYPE_t implementation at compile-time. This avoids kernel
-API explosion per each new seqcount LOCKTYPE.
+The sequence counter read and write APIs can take either a plain
+seqcount_t or any of the seqcount_LOCKNAME_t variants above.
 
-Initialization (replace "LOCKTYPE" with one of the supported locks)::
+Initialization (replace "LOCKNAME" with one of the supported locks)::
 
 	/* dynamic */
-	seqcount_LOCKTYPE_t foo_seqcount;
-	seqcount_LOCKTYPE_init(&foo_seqcount, &lock);
+	seqcount_LOCKNAME_t foo_seqcount;
+	seqcount_LOCKNAME_init(&foo_seqcount, &lock);
 
 	/* static */
-	static seqcount_LOCKTYPE_t foo_seqcount =
-		SEQCNT_LOCKTYPE_ZERO(foo_seqcount, &lock);
+	static seqcount_LOCKNAME_t foo_seqcount =
+		SEQCNT_LOCKNAME_ZERO(foo_seqcount, &lock);
 
 	/* C99 struct init */
 	struct {
-		.seq   = SEQCNT_LOCKTYPE_ZERO(foo.seq, &lock),
+		.seq   = SEQCNT_LOCKNAME_ZERO(foo.seq, &lock),
 	} foo;
 
 Write path: same as in :ref:`seqcount_t`, while running from a context
-with the associated LOCKTYPE lock acquired.
+with the associated write serialization lock acquired.
 
 Read path: same as in :ref:`seqcount_t`.
 
-- 
2.29.2

