Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E294E2265AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgGTP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgGTP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A695C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:56:02 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTejVaczVZ4+w4L8i2iPGvYmmuPlo78b2DCMDOKBNPE=;
        b=lYFPP3k4u36S1kCMfdfAvF++/+hiaSOdrK/t1OyZ+qd5hUVxBN3r3Ni0d6pqH6I3LgqXYd
        UAiuisMsTooKVUdFRPQiAQ+sz0ip/Wepb0oKk1c2TPwqBdPuK32DgeUDv5UUNNfTeAcPij
        9TPrxqnSI9EyL8iecLZjacul0aLJdW0rwnM4LTNxSUEZ9+X9MXinObmFOUbDbk6GyueI3G
        Gu/51NmnMnjeZExiUeHwTmgcSf0Ed96FViVkU0b6IFio52eOQmtKJ+OlOR3jhgFkql88eW
        3Ft1hsSqHCHHzPJ+0hOX214kfxPNoF1/7EX4gN3PLYUKUEjACzKpp+Lk6PkJEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTejVaczVZ4+w4L8i2iPGvYmmuPlo78b2DCMDOKBNPE=;
        b=EjEp3oh2PwsfLThRtM9JrTA+oJeXpqs2Pjua5FH30R18ERPFNmxB2sDq8lLDNvL/L+0Rbi
        5C65eXeBUguf7oDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 06/24] seqlock: Implement raw_seqcount_begin() in terms of raw_read_seqcount()
Date:   Mon, 20 Jul 2020 17:55:12 +0200
Message-Id: <20200720155530.1173732-7-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raw_seqcount_begin() has the same code as raw_read_seqcount(), with the
exception of masking the sequence counter's LSB before returning it to
the caller.

Note, raw_seqcount_begin() masks the counter's LSB before returning it
to the caller so that read_seqcount_retry() can fail if the counter is
odd -- without the overhead of an extra branching instruction.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 85fb3ac93ffb..e885702d8b82 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -199,10 +199,11 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
  */
 static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
-	unsigned ret = READ_ONCE(s->sequence);
-	smp_rmb();
-	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
-	return ret & ~1;
+	/*
+	 * If the counter is odd, let read_seqcount_retry() fail
+	 * by decrementing the counter.
+	 */
+	return raw_read_seqcount(s) & ~1;
 }
 
 /**
-- 
2.20.1

