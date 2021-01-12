Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FE2F2870
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbhALGnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbhALGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:43:25 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960FC061786;
        Mon, 11 Jan 2021 22:42:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p187so1865953iod.4;
        Mon, 11 Jan 2021 22:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzQDoKieRWjb9Oo3b8L2/tnj6Z9GSRsyxzx9Q4knxlg=;
        b=s9lXI/isxUg9fOOOTK7v3Fe2AfUuHy7sNxFCRk47FQIBN19Kt2TsKtDFw0V9IDNJoU
         zICUaEYKakF8VZscWGIfYRNifWBao6QqSHI3exXqK1rRcF+h2Pch+QVR0iTmBqWFuWci
         AJnKlUOCDu2hKP4RYL3D/wr11tgP4F2o6xiA3o6Xd91+6DKCwC941hMQWO7nraq5CZMY
         IeV5kw7LLNBDiFMv5nFUfur0YZLzXo7qo7A5YvS5r+CSYl74MIxjLGztWqL4LBejjbs1
         yvLxUg5Hb85T3MZevU7aTe4zSF32Nk/DTXmHFE86McJwCivZJWmz1Jjb0JkBTWamPd1I
         Yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzQDoKieRWjb9Oo3b8L2/tnj6Z9GSRsyxzx9Q4knxlg=;
        b=P60+VDZoFgMmYwdsI6OAiElFg7aryQXQWQC8vahWWngvV4yyW8Ri3orWv+1s1kDgVK
         BcCPS1KVex63DRilQ6b980W7Nkj3EIVWw8L7olIcxLVvmedbnHn5fimU8G6t+FCGbn9E
         Omk5G97mNa+7dm64MOds1KfjXNP6+scJb7VAnWZr827pCWWvGxHpVArhGEJY2amULVeG
         7LkWGOtqVS2oTqGWU3HvPyGJZCualPHQl0T6uL4OBrrOatsGa++V76/Fq7uLCih1wOmJ
         /BmHLZiiOUcozZ/q2kXFTb6fjUTTp1fusZ2xRAuAEysMnG2qtAT46UEnTqGVwrrI4ePf
         6dgA==
X-Gm-Message-State: AOAM531HqB58NTai+yTb94fIVLDjzahVptuUrrsNex90Rzfp2+Yv6Jzt
        WypfXyKOP9aaO3suf3hrBz+uukC9qxwcRDnAnOY=
X-Google-Smtp-Source: ABdhPJxF/DgVB4iihPD4eX+IDDS8yEeLdAguj2QPVdJCwDG+681NBiyEC5Hch0SLUvynq/YW+1gQz1OSYBnqxMurbqI=
X-Received: by 2002:a02:b709:: with SMTP id g9mr3027995jam.90.1610433764709;
 Mon, 11 Jan 2021 22:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20210111104927.2561-1-minhquangbui99@gmail.com>
 <7d6dc09fedc84f9fce942d85c34d5cd41931bbf6.camel@suse.de> <20210111143120.GA2769@minh>
In-Reply-To: <20210111143120.GA2769@minh>
From:   =?UTF-8?Q?Minh_B=C3=B9i_Quang?= <minhquangbui99@gmail.com>
Date:   Tue, 12 Jan 2021 13:42:33 +0700
Message-ID: <CACtPs=FB_=JMEymLHE0_ko4ZF5zj9NBCHkRC7O3tj6pkSp3oiA@mail.gmail.com>
Subject: Re: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
To:     Oliver Neukum <oneukum@suse.de>
Cc:     linux-usb@vger.kernel.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 9:31 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 01:00:31PM +0100, Oliver Neukum wrote:
> > Am Montag, den 11.01.2021, 10:49 +0000 schrieb Bui Quang Minh:
> > > In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
> > > resubmit the urb, we need to deallocate the transfer buffer that is
> > > allocated in mcba_usb_start().
> > >
> > > Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > v1: add memory leak fix when not resubmitting urb
> > > v2: add memory leak fix when failing to resubmit urb
> > >
> > >  drivers/net/can/usb/mcba_usb.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> > > index df54eb7d4b36..30236e640116 100644
> > > --- a/drivers/net/can/usb/mcba_usb.c
> > > +++ b/drivers/net/can/usb/mcba_usb.c
> > > @@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
> > >     case -EPIPE:
> > >     case -EPROTO:
> > >     case -ESHUTDOWN:
> > > +           usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > > +                             urb->transfer_buffer, urb->transfer_dma);
> > >             return;
> > >
> >
> > Can you call usb_free_coherent() in what can be hard IRQ context?
>
> You are right, I digged in the code and saw some comments that on some
> architectures, usb_free_coherent() cannot be called in hard IRQ context.
> I see the usb_free_coherent() is called in write_bulk_callback too. I will
> send a patch that uses usb_anchor to keep track of these urbs and cleanup
> the transfer buffer later in disconnect().

Hi, I have sent a version 3 patch. However, I found out that usb_free_coherent()
is ok in this situation. In usb_free_coherent(), if the buffer is allocated via
dma_alloc_coherent() in usb_alloc_coherent(), dma_free_coherent() is called.
In dma_free_coherent(), ops->free() may be called in some cases which may
contains calls to vunmap() that is not permitted in interrupt context. However,
in usb_alloc_coherent(), buffer can be allocated from dma pool if the
size is less
than 2048 and the buffer size in mcba_usb is obviously less than 2048.
As a result,
usb_free_coherent() will at most fall in the path that calls
dma_pool_free(), which is
safe. Am I right?

Thanks,
Quang Minh.
