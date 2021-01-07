Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0A2EC998
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbhAGEqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbhAGEqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:46:13 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83112C0612F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 20:45:32 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id 17so1873253uaq.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 20:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FqBU0DzyxHE7rFaChTOl0+T3ooasosngTw/QRkuqug=;
        b=CZXxilFUsoVBDX44Kjfrzt9xXAty5ZhWzDyCfu4kVQ1Qo7a3UIOFlzJNPFs95RNjS0
         ZN10TTyBRYb1pGd42ZVV5Ye/gKqpiI1F1/ZYRe4zpZCRwURUzeK/vVrMEj3gTkBcL6UG
         X8k18HXjmGb6OQ8yhG0ja6Jihr8cO+X/QbbJ0GHHnz01kf020ABkEMGfVWK4uYwWeqg9
         S7jayEzgXB0rMOb4Zp1b+MDVvEVnFQSS6EWBjOqwPcp3GGDOxvZ2lVleaeKv0/UwwZSs
         tNS0H6biAIo1Z8ias28x1iHdU4MjG9lBmQ6jUuAqTA38xOKplbSbO4nFVyA9eamm66or
         hE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FqBU0DzyxHE7rFaChTOl0+T3ooasosngTw/QRkuqug=;
        b=oOVhI+Dq6ZY3Z8m9T4DlfOl9frURwXRwRJV5DgBiIk1TjEfoT6XDOzfg8F4OVal1fU
         Ngcik/+vXo/iOsCLsHpFxLeEgs5TgRerOp/JFh9lx9UjMHZ4zViGJt2Q51N8IeJndPK3
         Pq4kAOLbc2gxsTKKmiRCEUn8zjprAHxkIvXpfKBMKTblijslGJLK2R5Oiwl8fSLOMwPT
         0zz9ZDSZ7FTo5TrTqwZ6BI2cI96s9/+Bo3c0b1HCY0jsJpFgqu3QnpdydP2MyJgaBHAO
         PwIDGFzIaIhOShSM1nMkhqjFiuh68n7B2kMfDbpz9ug9OOR5uGurrq5zEM7o8NH2eqUS
         gxhQ==
X-Gm-Message-State: AOAM533T4RxEREkwmM+vg/7i3qoL31earJIoAkIHwIBxS9FF5hhslbLN
        SoIWLwHTUrW4jnL+dPqKC++nEhmm8NozC8GnJ9We8w==
X-Google-Smtp-Source: ABdhPJyDMe9TseuG/qIjyrE/SGPXVQo4rz/hxHrw+SPyifPGylrTHwJJ73DrnQGq6u9/vLT5zVMzVyS5VSmNBVCTiGk=
X-Received: by 2002:ab0:7386:: with SMTP id l6mr6184246uap.141.1609994731526;
 Wed, 06 Jan 2021 20:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.169209557@linutronix.de>
 <20210106180132.41dc249d@gandalf.local.home> <CAHk-=wh2895wXEXYtb70CTgW+UR7jfh6VFhJB_bOrF0L7UKoEg@mail.gmail.com>
 <20210106174917.3f8ad0d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CA+FuTSevLSxZkNLdJPHqRRksxZmnPc1qFBYJeBx26WsA4A1M7A@mail.gmail.com>
In-Reply-To: <CA+FuTSevLSxZkNLdJPHqRRksxZmnPc1qFBYJeBx26WsA4A1M7A@mail.gmail.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 6 Jan 2021 23:44:54 -0500
Message-ID: <CA+FuTScQ9afdnQ3E1mqdeyJ-sOq=2Dm9c1XDN8mnzbEig8iMXA@mail.gmail.com>
Subject: Re: [BUG] from x86: Support kmap_local() forced debugging
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Miller <davem@davemloft.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 9:11 PM Willem de Bruijn <willemb@google.com> wrote:
>
> On Wed, Jan 6, 2021 at 8:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 6 Jan 2021 17:03:48 -0800 Linus Torvalds wrote:
> > > I wonder whether there is other code that "knows" about kmap() only
> > > affecting PageHighmem() pages thing that is no longer true.
> > >
> > > Looking at some other code, skb_gro_reset_offset() looks suspiciously
> > > like it also thinks highmem pages are special.
> > >
> > > Adding the networking people involved in this area to the cc too.

But there are three other kmap_atomic callers under net/ that do not
loop at all, so assume non-compound pages. In esp_output_head,
esp6_output_head and skb_seq_read. The first two directly use
skb_page_frag_refill, which can allocate compound (but not
__GFP_HIGHMEM) pages, and the third can be inserted with
netfilter xt_string in the path of tcp transmit skbs, which can also
have compound pages. I think that these could similarly access
data beyond the end of the kmap_atomic mapped page. I'll take
a closer look.
