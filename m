Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF02A1126
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJ3Wqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgJ3Wqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:46:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6AC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:46:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p15so8558297ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrhxrWCIONXWoPxsDWMRBR+W10EJDGZ7OkgmkAXhFNU=;
        b=NSjEistXDK7QrUisKBKyvvsUCTs8KpdALOTDGFQa3ZlxOrfYPgQ15P5Hp32THt3kZR
         cN7sjbd0KoMQ3npg9DHgup7Q9J8GXdmUQ8lIGjC/f9HFg6XaYw9GqJyObayLgtYOnfyC
         +DPogaxfsLaFCM9OrmD2eUZrIvZD8sMP/wXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrhxrWCIONXWoPxsDWMRBR+W10EJDGZ7OkgmkAXhFNU=;
        b=HKmfCte3YR1a5DE2MDxopD20YEMf2cl+sX0yLhUo9LO2yPnx/v5TH4xpvt9F6Fn7fZ
         XOJitFo4En56MGj2Y3V495DfmiCE4TXEwNvPvIR+tQI+vwsWk3TxSPeeCCk6IgRamP3r
         R0JX8qzEXCG42sZNhMFih7nA2YrDyYsUY5ZB+UdjPgH3nch7YLOVUYnAX6PxaFM6FtRp
         LHSXUNTWx5tEm99MNNgyMNwcDevfwyLL/+VOte118RXV/M+2nDDgbLn708FJurM3qlRf
         waxWjOve84qtKXPMJJLqNopdmXO8bI5GnnRyb+3xmi4yHCsUhhiczVPy+HQOkxpmyQHm
         d0WQ==
X-Gm-Message-State: AOAM5326kwi5yLBQGKlMWb9A57tVqBFFiX9wfenS6JyIiRayay3z+fOI
        T9BIIbFyJe8CPhIUa6RihaTejF5IFVhaLw==
X-Google-Smtp-Source: ABdhPJx0TPzYJmMBh43wT95siunPAhRZaisYowgEnsKrw6D/p2BvQPGofVtSjT5k4lIrhHSnjvTptQ==
X-Received: by 2002:a05:651c:96:: with SMTP id 22mr2086086ljq.76.1604098003717;
        Fri, 30 Oct 2020 15:46:43 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r5sm802043ljm.77.2020.10.30.15.46.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 15:46:43 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j30so9869602lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:46:43 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr1949766lfa.603.1604098002560;
 Fri, 30 Oct 2020 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de>
 <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com> <87sg9vl59i.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg9vl59i.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Oct 2020 15:46:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
Message-ID: <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 3:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> While at it I might have a look at that debug request from Willy in the
> other end of this thread. Any comment on that?
>
>  https://lore.kernel.org/r/87k0v7mrrd.fsf@nanos.tec.linutronix.de

I do think that it would be nice to have a debug mode, particularly
since over the last few years we've really lost a lot of HIGHMEM
coverage (to the point that I've wondered how worthwhile it really is
to support at all any more - I think it's Arnd who argued that it's
mainly some embedded ARM variants that will want it for the forseeable
future).

So I'm honestly somewhat torn. I think HIGHMEM is dying, and yes that
argues for "non-HIGHMEM had better have some debug coverage", but at
the same time I think it doesn't even really matter any more. At some
point those embedded ARM platforms just aren't even interesting - they
might as well use older kernels if they are the only thing really
arguing for HIGHMEM at all.

This is one reason why I'd like the new kmap_local() to be a no-op,
and I'd prefer for it to have no other side effects - because I want
to be ready to remove it entirely some day. And if we end up having
some transition where people start rewriting "kmap_atomic()" to be
"kmap_local() + explicit preemption disable", then I think that would
be a good step on that whole "kmap will eventually go away" path.

But I do *not* believe that we need to add _so_ much debug support
that we'd catch Willy's "more than one page" case. And I absolutely do
not believe for a second that we should start caring about compound
pages. NO. kmap() is almost dead already, we're not making it worse.

To me, your patch series has two big advantages:

 - more common code

 - kmap_local() becomes more of a no-op

and the last thing we want is to expand on kmap.

           Linus
