Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925A326A2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIOKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgIOKCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:02:23 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84B7208E4;
        Tue, 15 Sep 2020 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600164143;
        bh=bloC0DiaT8sXmuZq81VgrUSwH6mwHCWsuQgPOyMjmhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xmUbdUU/grhTqFr5DfQGzVSi/0/k/fNv8C5DHPeI3y3LX0bLTWWwOW3WMYFDif652
         cgynsQ1tLIaJjFqfWwkvJLfUQuIK/0Ah1bw6pTW/S/ACqpU53a72Vzv1WHPgIPH6J2
         EVs9QR48cbqno0F2EfMKGN9wo9S1NYSo+lCBeWqk=
Received: by mail-ot1-f52.google.com with SMTP id m12so2703944otr.0;
        Tue, 15 Sep 2020 03:02:22 -0700 (PDT)
X-Gm-Message-State: AOAM5308Ebya9d/ENzngAy07R6/W3Xf8NqR3ZMXFZDBdHNpifm67anqq
        smezAhHfe+jacGrxBnRPd+CrCSq9SyAajV4SUlE=
X-Google-Smtp-Source: ABdhPJyCLfuAZfgvdjiB3bwribA2IhelGEBildE1rSVUXwByVqbt5phlD5yN7BGpgfsIJMRUyR8612vf3ZLdujnXFAQ=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr13050883otk.77.1600164142207;
 Tue, 15 Sep 2020 03:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
 <20200915033024.GB25789@gondor.apana.org.au> <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
 <CAHk-=wie0Kb-+XOZNasoay7AKCaQ8Ew8=LyvWTBeiPXC3v2GSA@mail.gmail.com>
 <20200915070523.GA26629@gondor.apana.org.au> <878sdb5qp5.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878sdb5qp5.fsf@nanos.tec.linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 13:02:10 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHsqZzfJ2qmsrUWEU_XWxmR1PhY3zo-yz9Vau90-WphXg@mail.gmail.com>
Message-ID: <CAMj1kXHsqZzfJ2qmsrUWEU_XWxmR1PhY3zo-yz9Vau90-WphXg@mail.gmail.com>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - Set SG_MITER_ATOMIC unconditionally
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 12:34, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Sep 15 2020 at 17:05, Herbert Xu wrote:
> > On Mon, Sep 14, 2020 at 11:55:53PM -0700, Linus Torvalds wrote:
> >>
> >> Maybe we could hide it behind a debug option, at least.
> >>
> >> Or, alterantively, introduce a new "debug_preempt_count" that doesn't
> >> actually disable preemption, but warns about actual sleeping
> >> operations..
> >
> > I'm more worried about existing users of kmap_atomic relying on
> > the preemption disabling semantics.  Short of someone checking
> > on every single instance (and that would include derived cases
> > such as all users of sg miter), I think the safer option is to
> > create something brand new and then migrate the existing users
> > to it.  Something like
> >
> > static inline void *kmap_atomic_ifhigh(struct page *page)
> > {
> >       if (PageHighMem(page))
> >               return kmap_atomic(page);
> >       return page_address(page);
> > }
> >
> > static inline void kunmap_atomic_ifhigh(struct page *page, void *addr)
> > {
> >       if (PageHighMem(page))
> >               kunmap_atomic(addr);
> > }
>
> Hmm, that still has the issue that the code between map and unmap must
> not sleep and the conversion must carefully check whether anything in
> this region relies on preemption being disabled by kmap_atomic()
> regardless of highmem or not.
>
> kmap_atomic() is at least consistent vs. preemption, the above not so
> much.
>

But that is really the point. I don't *want* to be forced to disable
preemption in brand new code simply because some legacy highmem API
conflates being callable from atomic context with instantiating an
atomic context by disabling preemption for no good reason. IIUC, in
the past, you would really only call kmap_atomic() if you absolutely
had to, and so you would never rely on the preemption disabling
semantics accidentally. By making kmap_atomic() the preferred API even
for calls from non-atomic contexts, this line has blurred and we no
longer know why individual kmap_atomic() occurrences exist in the
first place.

> I'd rather go for a preemptible/sleepable version of highmem mapping
> which is in itself consistent for both highmen and not highmem.
>

I don't think we need to obsess about highmem, although we should
obviously take care not to regress its performance unnecessarily. What
I want to avoid is to burden a brand new subsystem with legacy highmem
baggage simply because we could not agree on how to avoid that.
