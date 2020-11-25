Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F872C41D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKYOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbgKYOJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:09:41 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F5F206F9;
        Wed, 25 Nov 2020 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313380;
        bh=yrOjx1H0BOl7yqO9YN4z/PIF02I6g+lpmxV/KJQECTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+Hz6J02dmJiTCqC1LtylAV0E8sIZQR8qXZIyS2rYijCBCK3OdhRn2UXvk6WQdoVt
         h7B7URV1sMI4tK3zeJl8U94EZBbKLtkcCqBzIaBRo0LXqp7m0r8TIdioUZdzWskPy9
         2CzgBqKStENmNU+066s1Non2l7kR0N/CAKepSZJQ=
Received: by mail-lj1-f169.google.com with SMTP id t22so2451956ljk.0;
        Wed, 25 Nov 2020 06:09:40 -0800 (PST)
X-Gm-Message-State: AOAM533Sbs/ULdlgwBuNpx51pKEOyhfLYQ71IU1mDcAYwjyDN8qSZnCp
        RcYod/1aL8EsC1c47bwVhdeQd9ssbdjbwc8r2v8=
X-Google-Smtp-Source: ABdhPJzE2tKNM/HUqwllZoE0zX54dUjodWRa76hsIf5p2+6KmS+voJMh729PHrBQeWPYcFftbjgcW+xcjzc5kseyoLs=
X-Received: by 2002:a2e:8e6c:: with SMTP id t12mr1441948ljk.441.1606313378438;
 Wed, 25 Nov 2020 06:09:38 -0800 (PST)
MIME-Version: 1.0
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org> <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 25 Nov 2020 22:09:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQzDMwCALuZ05OAUdU7xZEijyHpOFpStiBQin3Y5RUDVg@mail.gmail.com>
Message-ID: <CAJF2gTQzDMwCALuZ05OAUdU7xZEijyHpOFpStiBQin3Y5RUDVg@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS supported
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
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

This can be concluded as the different effectiveness between cmpxchg
and xchg. For the arch which only has lr/sc instructions, the cmpxchg
& xchg are similar.

#if _Q_PENDING_BITS == 8

static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
{
        /*
         * We can use relaxed semantics since the caller ensures that the
         * MCS node is properly initialized before updating the tail.
         */
        return (u32)xchg_relaxed(&lock->tail,
                                 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
}

#else /* _Q_PENDING_BITS == 8 */

static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
{
        u32 old, new, val = atomic_read(&lock->val);

        for (;;) {
                new = (val & _Q_LOCKED_PENDING_MASK) | tail;
                /*
                 * We can use relaxed semantics since the caller ensures that
                 * the MCS node is properly initialized before updating the
                 * tail.
                 */
                old = atomic_cmpxchg_relaxed(&lock->val, val, new);
                if (old == val)
                        break;

                val = old;
        }
        return old;
}
#endif /* _Q_PENDING_BITS == 8 */


>
> If nothing else needs xchg() on a 16-bit value, maybe
> changing the #ifdef in the qspinlock code is enough.
>
> Only around half the architectures actually implement 8-bit
> and 16-bit cmpxchg() and xchg(), it might even be worth trying
> to eventually change the interface to not do it at all, but
> instead have explicit cmpxchg8() and cmpxchg16() helpers
> for the few files that do use them.
>
>      Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
