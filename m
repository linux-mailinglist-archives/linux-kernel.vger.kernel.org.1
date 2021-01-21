Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2326E2FEE64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbhAUPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbhAUPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:20:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74678C06174A;
        Thu, 21 Jan 2021 07:20:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y205so1680078pfc.5;
        Thu, 21 Jan 2021 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=17KvraJzNRdjrYwPQoxY6CW4jRA/1iQCnE0aBjokmlU=;
        b=SjOiqGWeuGStl1nyx4FwEFhMBizLfAB4ruWAD4Qi1ph6c8DZ6tHOIhOV6cdy2lZbN3
         twNbQ00yelHEmH4M6BqAxk4pFN3oR9WUoQXA+aXpo1cm9mihFwpoJPeJsWnNXs3uWCHG
         hteJSdrsIdCxBfQsKXZu/lLnPgf9iBP6yLmTUVRIA5xYaIb90VzjMEr2cDBhsa3FJ1NE
         /GKC4BNrEB9eu2gqRqJ8nAQTzyaj1RSjzXn0ZorwyMXWuxTQPD/63KKz00ugTtQ8XOYY
         HFoTEbb7rOfHTtqc7rarNJsnlKUP0Ud/aVe3If1K5wLCIWwkk8diD/XFbwpjMH5ZSc3C
         F3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=17KvraJzNRdjrYwPQoxY6CW4jRA/1iQCnE0aBjokmlU=;
        b=YbHsqW8hG4Awd3R9l73MQ574hS0l17ZZBskxcpBJkFs+ZyE5ZnH4s3lX9MgHRKcKdG
         8xbvZ3o6JiA9KdqEWfejeHMq9psKkEb/0XTMvWM5QEH750WrShdJQ21GQCTqP2XzjDnL
         rjkdEdvJtMBPHjFBIBxjDwxXLFjRi8aNqv+v8lfLBtEPiiOZh6KeS1q8Yy56xTmrmsvv
         /KQIcV/ilRpEinUstxgpHygYI0Da6YrqpF3sFLyStd0ct1TlfQ0Wj/r8f43pJ0Zk1QnD
         jP2cK8bgE/2PFIKTIFeMkTjfk5LEdhurh3oi76sVqLzoyMNlNrkv4hbRZoL569BWXQvd
         XGCA==
X-Gm-Message-State: AOAM531/jDSoVeQ+YmhPhU68mNP6RQ3pUTT3rc/G/eVoyTqjNwOBNyje
        NOWHDTLMc3sEutq1/EyPcBlRAtYd1n3yWjyVHkE=
X-Google-Smtp-Source: ABdhPJwcVcFiWdMyynR3ZN1fs6rsTJq+vOi2ss4dGCgwHE7Bd1+AvpS37dAs+lgnoIjmolMg79lfTg==
X-Received: by 2002:aa7:83c2:0:b029:1a5:daa9:f22f with SMTP id j2-20020aa783c20000b02901a5daa9f22fmr14131113pfn.48.1611242407660;
        Thu, 21 Jan 2021 07:20:07 -0800 (PST)
Received: from minh ([113.173.125.143])
        by smtp.gmail.com with ESMTPSA id o20sm439309pgn.6.2021.01.21.07.20.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 07:20:06 -0800 (PST)
Date:   Thu, 21 Jan 2021 22:19:55 +0700
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Neukum <oneukum@suse.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
Message-ID: <20210121151955.GA3779@minh>
References: <20210111104927.2561-1-minhquangbui99@gmail.com>
 <7d6dc09fedc84f9fce942d85c34d5cd41931bbf6.camel@suse.de>
 <20210111143120.GA2769@minh>
 <CACtPs=FB_=JMEymLHE0_ko4ZF5zj9NBCHkRC7O3tj6pkSp3oiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACtPs=FB_=JMEymLHE0_ko4ZF5zj9NBCHkRC7O3tj6pkSp3oiA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:42:33PM +0700, Minh Bùi Quang wrote:
> On Mon, Jan 11, 2021 at 9:31 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 01:00:31PM +0100, Oliver Neukum wrote:
> > > Am Montag, den 11.01.2021, 10:49 +0000 schrieb Bui Quang Minh:
> > > > In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
> > > > resubmit the urb, we need to deallocate the transfer buffer that is
> > > > allocated in mcba_usb_start().
> > > >
> > > > Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
> > > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > > ---
> > > > v1: add memory leak fix when not resubmitting urb
> > > > v2: add memory leak fix when failing to resubmit urb
> > > >
> > > >  drivers/net/can/usb/mcba_usb.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> > > > index df54eb7d4b36..30236e640116 100644
> > > > --- a/drivers/net/can/usb/mcba_usb.c
> > > > +++ b/drivers/net/can/usb/mcba_usb.c
> > > > @@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
> > > >     case -EPIPE:
> > > >     case -EPROTO:
> > > >     case -ESHUTDOWN:
> > > > +           usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > > > +                             urb->transfer_buffer, urb->transfer_dma);
> > > >             return;
> > > >
> > >
> > > Can you call usb_free_coherent() in what can be hard IRQ context?
> >
> > You are right, I digged in the code and saw some comments that on some
> > architectures, usb_free_coherent() cannot be called in hard IRQ context.
> > I see the usb_free_coherent() is called in write_bulk_callback too. I will
> > send a patch that uses usb_anchor to keep track of these urbs and cleanup
> > the transfer buffer later in disconnect().
> 
> Hi, I have sent a version 3 patch. However, I found out that usb_free_coherent()
> is ok in this situation. In usb_free_coherent(), if the buffer is allocated via
> dma_alloc_coherent() in usb_alloc_coherent(), dma_free_coherent() is called.
> In dma_free_coherent(), ops->free() may be called in some cases which may
> contains calls to vunmap() that is not permitted in interrupt context. However,
> in usb_alloc_coherent(), buffer can be allocated from dma pool if the
> size is less
> than 2048 and the buffer size in mcba_usb is obviously less than 2048.
> As a result,
> usb_free_coherent() will at most fall in the path that calls
> dma_pool_free(), which is
> safe. Am I right?

Hi, I'm CC'ing CAN network driver maintainers so we can discuss the patch properly.

I'm so sorry for spamming emails.

Thanks,
Quang Minh.
