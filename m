Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5662D3317
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgLHUSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgLHUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:18:46 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43305C06138C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:18:06 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s75so17703123oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QM0TFRE6AVNtHrI8EMn+wfFtbFRWS+o2/YwdmBd/how=;
        b=R2laiT5q5xvgCqalQi2NNapgd2uv+sxqtRfNK/TjCmNUakvyp1lchzqQAmxnlf7Z7W
         2nesgr0k1l3jE8ysPwTqdIFq/am7E3TIIKEKrU0kOOQ6mo9hgZRIHfVaIuNG8kocHh3W
         YvJua+vgkFQCrNo4dsxVY7PlYe7S8Qf1K+zaJSklzFhSJ5ozSdnEO0X4U6DmkffFydvo
         dVobsMiekTLbwcHbYKU2CQKtAWs0Yl5kTqUo7H4UTIUD8Njn+kswjF40vZHzd0Lr4C0E
         HpZEVYqzmIxI09zTRMU/o9w1ZeFSqHST+3i9VgMUIj+PyUzS/is3Y8GuTzrEbu0s3lkt
         jYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM0TFRE6AVNtHrI8EMn+wfFtbFRWS+o2/YwdmBd/how=;
        b=YCLh938PD1DIsXET88WUG3/iJ1RBFbL8o1jFYzPF9JAViMpgavYh+2ogaMR04QqDH1
         c3+ttNXbL8Y/BjtfpKLuEBTaTIbYtZTyx4geCgF3Z6+x8LL+oisQA1L7TKQquWOPLO99
         uyjZLMdiMX7+Kk0loZYWmUtcPiQCu70AqPqBYLUJhAqSk019J0eklLYlpFuXEd/npTem
         /L/UOhnry/OizzZ77XqBQ1JmAn6qqZyFu/7bKaeBg6RthMPoo1AMj8bv0mjBDaCG6yzS
         2gmed30Unzbh2RRAzguEWN4rw6TrBiNNKu+5crm927o6X316fhz8E26D3JZ/wm0rg6qg
         8zmA==
X-Gm-Message-State: AOAM533PXWrinBySNkuDPgZX3n996GMeZM8ndjmI//U3ntABwQN/eQyV
        PlGzI9M6IJxTgHXJSFAG3EMVE4pBL8nIIRh/o5YnUbJu/eI=
X-Google-Smtp-Source: ABdhPJyGPpdKJ3Mv/rwSax73GEYLVDC/h9hkosSZO4I/dom58hJMIvZNK/cx+bt+1jfCxwdt46v+Z+xjG4rr/4Wt3t8=
X-Received: by 2002:aca:3192:: with SMTP id x140mr3947083oix.172.1607454377933;
 Tue, 08 Dec 2020 11:06:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b4862805b54ef573@google.com> <X8kLG5D+j4rT6L7A@elver.google.com>
 <CANn89iJWD5oXPLgtY47umTgo3gCGBaoy+XJfXnw1ecES_EXkCw@mail.gmail.com>
 <CANpmjNOaWbGJQ5Y=qC3cA31-R-Jy4Fbe+p=OBG5O2Amz8dLtLA@mail.gmail.com>
 <CANn89iKWf1EVZUuAHup+5ndhxvOqGopq53=vZ9yeok=DnRjggg@mail.gmail.com>
 <X8kjPIrLJUd8uQIX@elver.google.com> <af884a0e-5d4d-f71b-4821-b430ac196240@gmail.com>
In-Reply-To: <af884a0e-5d4d-f71b-4821-b430ac196240@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Dec 2020 20:06:06 +0100
Message-ID: <CANpmjNNDKm_ObRnO_b3gH6wDYjb6_ex-KhZA5q5BRzEMgo+0xg@mail.gmail.com>
Subject: Re: WARNING in sk_stream_kill_queues (5)
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>, Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        syzbot <syzbot+7b99aafdcc2eedea6178@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 at 19:01, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 12/3/20 6:41 PM, Marco Elver wrote:
>
> > One more experiment -- simply adding
> >
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -207,7 +207,21 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
> >        */
> >       size = SKB_DATA_ALIGN(size);
> >       size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +     size = 1 << kmalloc_index(size); /* HACK */
> >       data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> >
> >
> > also got rid of the warnings. Something must be off with some value that
> > is computed in terms of ksize(). If not, I don't have any explanation
> > for why the above hides the problem.
>
> Maybe the implementations of various macros (SKB_DATA_ALIGN and friends)
> hae some kind of assumptions, I will double check this.

If I force kfence to return 4K sized allocations for everything, the
warnings remain. That might suggest that it's not due to a missed
ALIGN.

Is it possible that copies or moves are a problem? E.g. we copy
something from kfence -> non-kfence object (or vice-versa), and
ksize() no longer matches, then things go wrong?

Thanks,
-- Marco
