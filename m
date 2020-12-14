Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99352D9472
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439466AbgLNI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgLNI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:59:15 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:58:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so12023069pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFrxUJ2+3DxqruW/vfemtxiKuJAN5bbNqUiktWTQp2Y=;
        b=tMTk1D6iJ+/oRV9cjcLelYnSoO+4js04/uVFG7Su1vTfxYye+vAK91XNJwWyEKM0sr
         CCHxTwi/z9g1FN2s/DMxRmyHgdqqFAYDRVatsQfu0ua7bOpUJo02nE/z5fchZjmGs9sd
         ZX5t7fwy5QLMWiCa+FCUDyRV/Rs6UA7HgDbsxsIAjTioKesxWhRfKK56F8LUz2WJtx0z
         as50v8c/k6BGXqylOc4jUis0YgSPxKKCs3R5c38X1JQtxlK/K5CYeIwntJjDYvjuIrey
         yoZ8dU0oZdUn+P1CQJ3zfWNQa6vAT4nGifwDtH5i0vXX6FDVcgDZ50Kq2Xo3qdpoNBQQ
         T8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFrxUJ2+3DxqruW/vfemtxiKuJAN5bbNqUiktWTQp2Y=;
        b=Wy2XUsJi31XUPiFYJ9CnSxoh6xCGdQH0p9mMiE0V5k/32Q710UEEPBwxC5lQBS8Vp/
         hyHS4SPI1ktxqHtWrgoz1G/5JBoQChjXaZU8qLb64k5j4XWhmD1RaBEvuwp7TMRrIuTp
         g7tWkGR0ZIUwZD8EGAi+VCcDxDKX5UvuAWLuewSipgOsOzAD2KtMtUM26fE6YHUMwhE0
         Xf+U1j9Szsoi0pk0116cIptR0jHLnBqbQ50I3/BhyyciFJB447Crz/3+LUfMnDCdfivL
         MZkef0Au+kXH/XmpDKMYbAEQ4I0faa8HYLIHm/JaMtUz5mWOY4sU5X3vTi6ORWS10HDu
         UlPg==
X-Gm-Message-State: AOAM531gpV7RA1gpnXmZO7BEioKGUC/d/EUHuPbp9moJc2LW4lafuml9
        inl/0w75vqb6xqEIKRNAtgLUN6Ks/D6bhbC2+bM=
X-Google-Smtp-Source: ABdhPJySyVCTs0X4q0LDZcyNPCCXc6o0dRfJ3mMubOr8kLAtzdl7+UFRbMMRzM31RCCsgm/F2HB6IbPZXsD9X4uYXQE=
X-Received: by 2002:a63:802:: with SMTP id 2mr23627036pgi.292.1607936314469;
 Mon, 14 Dec 2020 00:58:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ8uoz3wQ=mtPUsyQsgHPHcMNT55aayAQ+JmmL7VAz3KJEOtpw@mail.gmail.com>
 <1607762670.6417274-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1607762670.6417274-1-xuanzhuo@linux.alibaba.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Mon, 14 Dec 2020 09:58:23 +0100
Message-ID: <CAJ8uoz2TYFcDLE0ObnSeEBUGGFq=dquiTxCtk323LBNj6twZpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: save the undone skb
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "open list:XDP SOCKETS <netdev@vger.kernel.org>, open list:XDP SOCKETS
        <bpf@vger.kernel.org>, open list" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 9:47 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Fri, 11 Dec 2020 16:32:06 +0100, Magnus Karlsson <magnus.karlsson@gmail.com> wrote:
> > On Fri, Dec 11, 2020 at 2:12 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > We can reserve the skb. When sending fails, NETDEV_TX_BUSY or
> > > xskq_prod_reserve fails. As long as skb is successfully generated and
> > > successfully configured, we can reserve skb if we encounter exceptions
> > > later.
> > >
> > > Especially when NETDEV_TX_BUSY fails, there is no need to deal with
> > > the problem that xskq_prod_reserve has been updated.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  include/net/xdp_sock.h |  3 +++
> > >  net/xdp/xsk.c          | 36 +++++++++++++++++++++++++++---------
> > >  2 files changed, 30 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index 4f4e93b..fead0c9 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -76,6 +76,9 @@ struct xdp_sock {
> > >         struct mutex mutex;
> > >         struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> > >         struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
> > > +
> > > +       struct sk_buff *skb_undone;
> > > +       bool skb_undone_reserve;
> > >  };
> > >
> > >  #ifdef CONFIG_XDP_SOCKETS
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index e28c682..1051024 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -435,6 +435,19 @@ static int xsk_generic_xmit(struct sock *sk)
> > >         if (xs->queue_id >= xs->dev->real_num_tx_queues)
> > >                 goto out;
> > >
> > > +       if (xs->skb_undone) {
> > > +               if (xs->skb_undone_reserve) {
> > > +                       if (xskq_prod_reserve(xs->pool->cq))
> > > +                               goto out;
> > > +
> > > +                       xs->skb_undone_reserve = false;
> > > +               }
> > > +
> > > +               skb = xs->skb_undone;
> > > +               xs->skb_undone = NULL;
> > > +               goto xmit;
> > > +       }
> > > +
> > >         while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > >                 char *buffer;
> > >                 u64 addr;
> > > @@ -454,12 +467,7 @@ static int xsk_generic_xmit(struct sock *sk)
> > >                 addr = desc.addr;
> > >                 buffer = xsk_buff_raw_get_data(xs->pool, addr);
> > >                 err = skb_store_bits(skb, 0, buffer, len);
> > > -               /* This is the backpressure mechanism for the Tx path.
> > > -                * Reserve space in the completion queue and only proceed
> > > -                * if there is space in it. This avoids having to implement
> > > -                * any buffering in the Tx path.
> > > -                */
> > > -               if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
> > > +               if (unlikely(err)) {
> > >                         kfree_skb(skb);
> > >                         goto out;
> > >                 }
> > > @@ -470,12 +478,22 @@ static int xsk_generic_xmit(struct sock *sk)
> > >                 skb_shinfo(skb)->destructor_arg = (void *)(long)desc.addr;
> > >                 skb->destructor = xsk_destruct_skb;
> > >
> > > +               /* This is the backpressure mechanism for the Tx path.
> > > +                * Reserve space in the completion queue and only proceed
> > > +                * if there is space in it. This avoids having to implement
> > > +                * any buffering in the Tx path.
> > > +                */
> > > +               if (xskq_prod_reserve(xs->pool->cq)) {
> > > +                       xs->skb_undone_reserve = true;
> > > +                       xs->skb_undone = skb;
> > > +                       goto out;
> > > +               }
> > > +
> > > +xmit:
> >
> > This will not work in the general case since we cannot guarantee that
> > the application does not replace the packet in the Tx ring before it
> > calls send() again. This is fully legal. I also do not like to
> > introduce state between calls. Much simpler to have it stateless which
> > means less error prone.
> >
> > On the positive side, I will submit a patch that improves performance
> > of this transmit function by using the new batch interfaces I
> > introduced a month ago. With this patch I get a throughput improvement
> > of between 15 and 25% for the txpush benchmark in xdpsock. This is
> > much more than you will get from this patch. It also avoids the
> > problem you are addressing here completely. I will submit the patch
> > next week after the bug fix in this code has trickled down to
> > bpf-next. Hope you will like the throughput improvement that it
> > provides.
>
> In fact, we can also call xskq_cons_release before save the undone skb and
> exiting this function, so do not worry about the users modifying the data
> in tx. Of course, I understand that you want to have it stateless.
> I agree with this. I will give up this idea temporarily.
>
> But here in the case of NETDEV_TX_BUSY, xskq_prod_reserve has been called,
> but skb is released directly without xsk_destruct_skb, this should be a bug.

Yes, you are correct. In this case the reservation in the cq is not
rolled back and we really make the ring one entry smaller. After
enough of these errors, the ring will be of size zero and the socket
will stop working for transmit. Thank you so much for spotting this. I
believe this was introduced when I tried to make NETDEV_TX_BUSY not
drop packets and instead give the user a chance to just resend them.
This part seems to be in dire need of some solid tests contributed to
the new xsk selftests.

I will bundle this fix as patch 2 in a patch set with the other race
that you found. I need the locking of that one to be able to safely
back out the reservation.

> >
> > >                 err = __dev_direct_xmit(skb, xs->queue_id);
> > >                 if  (err == NETDEV_TX_BUSY) {
> > >                         /* Tell user-space to retry the send */
> > > -                       skb->destructor = sock_wfree;
> > > -                       /* Free skb without triggering the perf drop trace */
> > > -                       consume_skb(skb);
> > > +                       xs->skb_undone = skb;
> > >                         err = -EAGAIN;
> > >                         goto out;
> > >                 }
> > > --
> > > 1.8.3.1
> > >
