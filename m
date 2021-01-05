Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FB2EB4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbhAEVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAEVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:14:33 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16668C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:13:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b24so1134348otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TyYwTxr/bbnMT2s7IdFCyHWoGv5IHohnF+0y9xw1Hc0=;
        b=oYJOXj4hukhixP9Lp/YhX+mrGoOHmENKZCqb5QXf59taNEzoNQn4gNUnioiQnzAEap
         TcggBrhAkzaXrtSTxORkZUQzkdbrNe56JJ3eNfUnwEYtex/25bhVgWYNGfXrb2R3wdQQ
         lffdB8IQcpQ9rSRvbaAyp5aaobUey7vMJD6gO5gyACTZs5S1Tm8X6HG1xJ9m2UCcd9lb
         CZTOVn+N5NDQWxiqwPRKnfPTsmZikOE68OO6wq61gOL7moVBG+YPuhXpaQRZMUPFzrjt
         stvVct+vEbFTfkgN/WkeLklNqzJC/bokB+1fWDw78BKH6qw9a+FbAqeeRhiXUQYFJFhD
         kmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TyYwTxr/bbnMT2s7IdFCyHWoGv5IHohnF+0y9xw1Hc0=;
        b=NKehCHUsOo18XLQ1Ja1tzrYPhS+lIlS2bNvEOjgOsn5ftoHuWXLRHjrDgpJqc643VC
         vyy+cfQwXtHtPjo6xpRykR7ugqVJiGfN26h2U0JPABlBh76kxlXCwNNU2GHlCDfFdyHQ
         SKH41BanOhWUxwHsyvg/SlpvZG605TYRbfA1Dh1oNWS+hINwQNlSNMWm1qzDdmTwgm2O
         iK9QfbcylERzlwWjVL6fXgyKtaAe6hH9ievwiatu6Au4edRbjRz1zdy/2JguyX2v2Q7s
         NyitmRxwK9pFmT/GFeIbpYhxucgOvB4EF4yRIMnONZZcMKWJ3EuHa25XuGMC1kFVUUja
         6i8w==
X-Gm-Message-State: AOAM5331j+6tsycWKJMtsXdTP8XTyczyQ/D+q3CmliywMkDFqnpeWx1o
        TkN7wBoV2DXlJ70DZgt7opABpA==
X-Google-Smtp-Source: ABdhPJzOGDZpxf1G0r4cHJ2IbaH+Q/Dk5K73HNI5Jsp+DgiUBa1UsMa84YXwrZkQhLFfVPuTRFBurA==
X-Received: by 2002:a9d:650f:: with SMTP id i15mr1013648otl.347.1609881232257;
        Tue, 05 Jan 2021 13:13:52 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i16sm87516otc.61.2021.01.05.13.13.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 13:13:51 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:13:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
In-Reply-To: <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2101051235500.5906@eggly.anvils>
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org> <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com> <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
 <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com> <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021, Linus Torvalds wrote:
> On Tue, Jan 5, 2021 at 11:31 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Jan 4, 2021 at 7:29 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > > So the one-liner of changing the "if" to "while" in
> > > > wait_on_page_writeback() should get us back to what we used to do.
> > >
> > > I think that is the realistic way to go.
> >
> > Yeah, that's what I'll do.
> 
> I took your "way to go" statement as an ack, and made it all be commit
> c2407cf7d22d ("mm: make wait_on_page_writeback() wait for multiple
> pending writebacks").

Great, thanks, I see it now.

I was going to raise a question, whether you should now revert
073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)"):
which would not have gone in like that if c2407cf7d22d were already in.

But if it were reverted, we'd need some other fix for the PageTail part
of it; and I still cannot think of anywhere else where we knowingly
operated on a struct page without holding a reference; and there have
been no adverse reports on its extra get_page+put_page.

So I think it's safest to leave it in.

Hugh
