Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904532C4215
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgKYOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbgKYOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:18:58 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5AF206D9;
        Wed, 25 Nov 2020 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313937;
        bh=G3pKsUj3Y7MzqCMy07442BtCwg0kgd1c+eqGkdIkBxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OUtK1yZsKr9EB20Zas0QOukq2U6zpaeI2GvRrIIQ5YC5S4xbuePa5FwwfzJSJqfrJ
         YDAjz8XGY35WDLfV62iggl4nIAcd/ePRlRfv0wVlCbwA8sSrqWxEMcPuS5SYAywpkb
         q5goHjwXwNiI/RLabD6ffkrD0uPYctaL33eLGHV4=
Received: by mail-lj1-f182.google.com with SMTP id 142so2436422ljj.10;
        Wed, 25 Nov 2020 06:18:56 -0800 (PST)
X-Gm-Message-State: AOAM533plg6UIwwwEMYGpCCbpJnuyWPto51DomC0HtXV9mWKGEaNZb+I
        YUmA354RRFIdJpp67Pu+aAPF+4SY1d6thw0wVqQ=
X-Google-Smtp-Source: ABdhPJxgFfiVO1tJMw+IlkBm+qpJtZ+m45Hz5edm98uNAaCgEFTkb8waAwCmWT0iq+PBDrL5/XItcg8ywCZ/q0v9zAM=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr1404910ljn.250.1606313934732;
 Wed, 25 Nov 2020 06:18:54 -0800 (PST)
MIME-Version: 1.0
References: <1606225437-22948-1-git-send-email-guoren@kernel.org> <20201124142905.GH2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201124142905.GH2414@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 25 Nov 2020 22:18:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT1_mP-wiK2HsCpTeU61NqZVKZX1A5ye=TwqvGN4TPmrA@mail.gmail.com>
Message-ID: <CAJF2gTT1_mP-wiK2HsCpTeU61NqZVKZX1A5ye=TwqvGN4TPmrA@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: Coding convention for xchg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 24, 2020 at 01:43:53PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This is prepare for QUEUED_SPINLOCKS which need xchg support short
> > type value.
> >  - Remove unused codes (xchg32, xchg64, cmpxchg32 ...)
> >  - Combine xchg_relaxed, xchg_acquire, xchg_release into one asm
> >  - Make atomic.aq/rl with seperated fence acquire & release
>
> Every time you find yourself doing multiple things, make it multiple
> patches.
Ok.

>
> > @@ -242,58 +239,58 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
> >   * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
> >   * {cmp,}xchg and the operations that return, so they need a full barrier.
> >   */
> > +#define ATOMIC_OP(c_t, prefix)                                               \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)              \
> >  {                                                                    \
> > +     return xchg_relaxed(&(v->counter), n);                          \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)              \
> >  {                                                                    \
> > +     return xchg_acquire(&(v->counter), n);                          \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)              \
> >  {                                                                    \
> > +     return xchg_release(&(v->counter), n);                          \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)                      \
> >  {                                                                    \
> > +     return xchg(&(v->counter), n);                                  \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,          \
> >                                    c_t o, c_t n)                      \
> >  {                                                                    \
> > +     return cmpxchg_relaxed(&(v->counter), o, n);                    \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,          \
> >                                    c_t o, c_t n)                      \
> >  {                                                                    \
> > +     return cmpxchg_acquire(&(v->counter), o, n);                    \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,          \
> >                                    c_t o, c_t n)                      \
> >  {                                                                    \
> > +     return cmpxchg_release(&(v->counter), o, n);                    \
> >  }                                                                    \
> >  static __always_inline                                                       \
> >  c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)    \
> >  {                                                                    \
> > +     return cmpxchg(&(v->counter), o, n);                            \
> >  }
>
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 262e5bb..5609185 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -44,118 +44,31 @@
> >                                           _x_, sizeof(*(ptr)));       \
> >  })
> >
> >  #define xchg_acquire(ptr, x)                                         \
> >  ({                                                                   \
> > +     __typeof__(*(ptr)) _x_ = (x);                                   \
> > +     __ret = __xchg_relaxed((ptr), _x_, sizeof(*(ptr)));             \
> > +     __acquire_fence();                                              \
> >       __ret;                                                          \
> >  })
> >
> >  #define xchg_release(ptr, x)                                         \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> > +     __release_fence();                                              \
> > +     (__typeof__(*(ptr))) __xchg_relaxed((ptr),                      \
> >                                           _x_, sizeof(*(ptr)));       \
> >  })
> >
> >  #define xchg(ptr, x)                                                 \
> >  ({                                                                   \
> > +     __typeof__(*(ptr)) __ret;                                       \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> > +     __smp_mb();                                                     \
> > +     __ret = __xchg_relaxed((ptr), _x_, sizeof(*(ptr)));             \
> > +     __smp_mb();                                                     \
> > +     __ret;                                                          \
> >  })
> >
> >  /*
>
> Why are you defining *{,_acquire,_release}() at all, doesn't
> atomic-fallback.h DTRT for you?
Yes, you are right. I could reuse that. Thx

#define cmpxchg_acquire(...) \
        __atomic_op_acquire(cmpxchg, __VA_ARGS__)
#endif

#define __atomic_op_acquire(op, args...)                                \
({                                                                      \
        typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);         \
        __atomic_acquire_fence();                                       \
        __ret;                                                          \
})


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
