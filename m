Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED56F2C2A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgKXPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388979AbgKXPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:00:32 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B6420897;
        Tue, 24 Nov 2020 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606230031;
        bh=jrkhRJAQ6WX9jUTFzUQ9ZskOIfBQw4WD0MUtGWKbkbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZPWtNM1Wg/Ge59qS+TzcYQZgVm+SyaZC8VJhc+aSPEU0VYpi/Ecm8PG2QQ9XCgfIf
         fDUGbvmWq41UYivUC/q/d55pTMHpvYknrEaa2ajJsGa9qwI5DaAecJX4CAC3CcDQ+t
         M47y5q41NFbHfus2nZaBVxVPvJvTW2pekhQJXs64=
Received: by mail-oi1-f178.google.com with SMTP id w15so862587oie.13;
        Tue, 24 Nov 2020 07:00:31 -0800 (PST)
X-Gm-Message-State: AOAM5307sTvUR+3NgHcLa+M4GoqOnTg/8DVI9EBS4iBxjh5ucRnYyUmV
        CqPNppx1STFOPPANddvAhmiKiqSrVeXjkChvGCA=
X-Google-Smtp-Source: ABdhPJyXhaM6qPmBM6ocwvecSvtLK4YjCoo/ko4z8+MS1WzfLOppPY8CpkPDtOQ+dtRUJNaah5BbhpxRPGAzDRXMxjE=
X-Received: by 2002:aca:180a:: with SMTP id h10mr2843518oih.4.1606230030889;
 Tue, 24 Nov 2020 07:00:30 -0800 (PST)
MIME-Version: 1.0
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org> <20201124143931.GI2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201124143931.GI2414@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 16:00:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
Message-ID: <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS supported
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Tue, Nov 24, 2020 at 3:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Nov 24, 2020 at 01:43:54PM +0000, guoren@kernel.org wrote:
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild

> > +             if (align) {                                            \
> > +             __asm__ __volatile__ (                                  \
> > +                     "0:     lr.w %0, 0(%z4)\n"                      \
> > +                     "       move %1, %0\n"                          \
> > +                     "       slli %1, %1, 16\n"                      \
> > +                     "       srli %1, %1, 16\n"                      \
> > +                     "       move %2, %z3\n"                         \
> > +                     "       slli %2, %2, 16\n"                      \
> > +                     "       or   %1, %2, %1\n"                      \
> > +                     "       sc.w %2, %1, 0(%z4)\n"                  \
> > +                     "       bnez %2, 0b\n"                          \
> > +                     "       srli %0, %0, 16\n"                      \
> > +                     : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
> > +                     : "rJ" (__new), "rJ"(addr)                      \
> > +                     : "memory");                                    \
>
> I'm pretty sure there's a handfull of implementations like this out
> there... if only we could share.

Isn't this effectively the same as the "_Q_PENDING_BITS != 8"
version of xchg_tail()?

If nothing else needs xchg() on a 16-bit value, maybe
changing the #ifdef in the qspinlock code is enough.

Only around half the architectures actually implement 8-bit
and 16-bit cmpxchg() and xchg(), it might even be worth trying
to eventually change the interface to not do it at all, but
instead have explicit cmpxchg8() and cmpxchg16() helpers
for the few files that do use them.

     Arnd
