Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F62C4200
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgKYORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgKYORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:17:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BDC0613D4;
        Wed, 25 Nov 2020 06:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkWlv6t4WmjLGS6BqQLJ1YdqQ5r2KJGPeyZd9P+/K3I=; b=t2+hx07dz3fM5ILEquHQ3WSlOG
        zx4bO8nA6nNTtmzt6RzF7fmj59fl7Bjce5sFilgM/DnvUvrh57JHoMFbYSxDYQAMXORQHqF6eVCGJ
        1zmGCE+0sWqI1Eitk3POVdh9UOueg+DA8X27py/kvkvszY7Hszr64BbV8nthZF7NfFLPPB5W6DOcc
        gd2x4atBTFql+DFqlennoZ5dCetw1DwtBzsnh9QzvmMecz8uWSCg5jNVe2RfQWg30p0ox3M6p7SON
        UWWojAzcQKj9YKThyaDdpV0CnNPJc4Gcn+epiaAPy3G1iBbF1b62ehofFhFJ3B4DpIVi0UiNCPkUA
        xZgli/5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khvbC-0001jV-Qa; Wed, 25 Nov 2020 14:16:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A40C6306E0C;
        Wed, 25 Nov 2020 15:16:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E33D20D6FE66; Wed, 25 Nov 2020 15:16:45 +0100 (CET)
Date:   Wed, 25 Nov 2020 15:16:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS
 supported
Message-ID: <20201125141645.GB2414@hirez.programming.kicks-ass.net>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org>
 <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 04:00:14PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 24, 2020 at 3:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Nov 24, 2020 at 01:43:54PM +0000, guoren@kernel.org wrote:
> > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> 
> > > +             if (align) {                                            \
> > > +             __asm__ __volatile__ (                                  \
> > > +                     "0:     lr.w %0, 0(%z4)\n"                      \
> > > +                     "       move %1, %0\n"                          \
> > > +                     "       slli %1, %1, 16\n"                      \
> > > +                     "       srli %1, %1, 16\n"                      \
> > > +                     "       move %2, %z3\n"                         \
> > > +                     "       slli %2, %2, 16\n"                      \
> > > +                     "       or   %1, %2, %1\n"                      \
> > > +                     "       sc.w %2, %1, 0(%z4)\n"                  \
> > > +                     "       bnez %2, 0b\n"                          \
> > > +                     "       srli %0, %0, 16\n"                      \
> > > +                     : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
> > > +                     : "rJ" (__new), "rJ"(addr)                      \
> > > +                     : "memory");                                    \
> >
> > I'm pretty sure there's a handfull of implementations like this out
> > there... if only we could share.
> 
> Isn't this effectively the same as the "_Q_PENDING_BITS != 8"
> version of xchg_tail()?

Pretty much I suppose.

> If nothing else needs xchg() on a 16-bit value, maybe
> changing the #ifdef in the qspinlock code is enough.

Like the below? I think the native LL/SC variant is slightly better than
the cmpxchg loop. The problem is that cmpxchg() is ll/sc and then we
loop that, instead of only having the ll/sc loop.

> Only around half the architectures actually implement 8-bit
> and 16-bit cmpxchg() and xchg(), it might even be worth trying
> to eventually change the interface to not do it at all, but
> instead have explicit cmpxchg8() and cmpxchg16() helpers
> for the few files that do use them.

Yeah, many RISCs don't have sub-word atomics. Not sure how many other
users there are. qspinlock certainly is the most popular I suppose.

---


diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..7049fb2af0b2 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
 #else /* _Q_PENDING_BITS == 8 */
 
 /**
@@ -207,6 +187,32 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
 }
 
+#endif /* _Q_PENDING_BITS == 8 */
+
+#if _Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16
+
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else /* !(_Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16) */
+
 /**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
  * @lock : Pointer to queued spinlock structure
@@ -236,7 +242,8 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	}
 	return old;
 }
-#endif /* _Q_PENDING_BITS == 8 */
+
+#endif /* _Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16 */
 
 /**
  * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
