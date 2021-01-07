Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F802EC7F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbhAGCMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbhAGCMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:12:46 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC8C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:12:06 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h6so2859414vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QUKDV8GhR0Hal3SMjWQ+BvIoYteQVe/RM0xw5OztWs=;
        b=i4RKVO87xQDD+OHygS/7nJBRBxgtFlnBHuiJMdXRggb+7FIB9GFulzfuHXlTGOfyCQ
         lKVdCnLvycIAnj2agamwAe6A3DGtzF3hL5Mt3jWXGT/ys8+xXuU+3qLpeXzxx3TPrmOh
         ykGYRaOklikyjYiAw3nKv0s38DcRNOy627qPug6NpPA3RrOb1fra+XRhx8joUYwKYLcQ
         m4rByeYQBBqRfmTxySw7XY1/qtxAbk2OQHzVfr77kEu75OCfEq3uopLsQGqJhTI8RsWC
         Y7btRuv/pAr/eZSRLptQn5vCOk6ES+stdaon3n0b/wui/e4cfm4macRk4nH4PTID0bAI
         1ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QUKDV8GhR0Hal3SMjWQ+BvIoYteQVe/RM0xw5OztWs=;
        b=EE5FBC27PcwXfgsWDOfyf96MDd5SKBhcLg4KXdK3h3w19fAif/qvebz0ZChRZKrP4R
         JUEm7b4Rqb0BOES+Lh2uaCNoFpaQfTeV3z4yMYAib+XqUpzRtw8W43vMadiOLCZrFdEL
         wCDz8n/QEenITG0LzCU/6TMNx0/jFOOiCLetns8jmo+3vcSj/08TYJWIRJWzCov6M32s
         Z2tihMOX15CYPwS64KVZE7E+mK6TZ4q3fGSGV+ksF7FvhD9yLnuvOiIeFFT47yaOSOCa
         xu6P4qP0m2j5XAOMM/RPCtsBvocffJ890Bj0hLMZOl/SF0g1xJFBcafDIGRLerOSqRwE
         YUKw==
X-Gm-Message-State: AOAM531HIBQZWOcjgIwusSLfLVt3frOLuQF97z6zpLpU8AyyjV83vZiJ
        7I5CFtyHxy5HYUNc8VfCetemtgSyrzDI4UOOsOykhQ==
X-Google-Smtp-Source: ABdhPJzFX5Aa0HwKE/uKV7fWrYvU66XSjmQssphDz1+cqe0pd76y1FEU5PNhifPpd41zsw+1nazA0hu7T7iv1hroDSE=
X-Received: by 2002:a67:f043:: with SMTP id q3mr5511928vsm.14.1609985525023;
 Wed, 06 Jan 2021 18:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.169209557@linutronix.de>
 <20210106180132.41dc249d@gandalf.local.home> <CAHk-=wh2895wXEXYtb70CTgW+UR7jfh6VFhJB_bOrF0L7UKoEg@mail.gmail.com>
 <20210106174917.3f8ad0d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210106174917.3f8ad0d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 6 Jan 2021 21:11:27 -0500
Message-ID: <CA+FuTSevLSxZkNLdJPHqRRksxZmnPc1qFBYJeBx26WsA4A1M7A@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 8:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 6 Jan 2021 17:03:48 -0800 Linus Torvalds wrote:
> > I wonder whether there is other code that "knows" about kmap() only
> > affecting PageHighmem() pages thing that is no longer true.
> >
> > Looking at some other code, skb_gro_reset_offset() looks suspiciously
> > like it also thinks highmem pages are special.
> >
> > Adding the networking people involved in this area to the cc too.
>
> Thanks for the detailed analysis! skb_gro_reset_offset() checks if
> kernel can read data in the fragments directly as an optimization,
> in case the entire header is in a fragment.
>
> IIUC DEBUG_KMAP_LOCAL_FORCE_MAP only affects the mappings from
> explicit kmap calls, which GRO won't make - it will fall back to
> pulling the header out of the fragment and end up in skb_copy_bits(),
> i.e. the loop you fixed. So GRO should be good. I think..

Agreed. That code in skb_gro_reset_offset skips the GRO frag0
optimization in various cases, including if the first fragment is in
high mem.

That specific check goes back to the introduction of the frag0
optimization in commit 86911732d399 ("gro: Avoid copying headers of
unmerged packets"), at the time in helper skb_gro_header().

Very glad to hear that the fix addresses the crash in
skb_frag_foreach_page. Thanks!
