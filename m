Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B512FEE31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbhAUPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbhAUPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:11:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E09C061786;
        Thu, 21 Jan 2021 07:11:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t6so1461750plq.1;
        Thu, 21 Jan 2021 07:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7I/jnjEzyYr5dUH24L9xu8d18K7Iyc5bqKRlqdETLLk=;
        b=NGuPnDgqNmS0J1jH/SXbrRdUrrgeujfYehvKhTAoibP7KRII0jIpxi20R+QbgqyzW/
         nA44pchI405CPXdx4bHJ94bPHSh2nQ5R3t0FwkczqB+OuTWF7hMWFd2Yt7YIgtPIR7z6
         77ZKOHEikVwdRBIJF8QQh+Wx7tZZY7/NDr80N/RggagowumAU2ka0eUiDsF4M+Gz/xjw
         TF2E2xByNDuUKA6Q3+dDY6hRAdq7EXJFgZ+0pRYy7FJCKjtYkVtnm0DOKaJBvC/cx3hp
         4ChsF/f24zhvVhgEW4ichg9v5BTq64b2HtVxKrhwh1jLMmNP6gLyRak3/q10CNpwRUqS
         zfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7I/jnjEzyYr5dUH24L9xu8d18K7Iyc5bqKRlqdETLLk=;
        b=QZ2iIljD5+cvbtxZa2vMzew7fOn5a8zpyQnGuzJJUDg9V29Vvwq5wX3kzKdxgO0yLQ
         FCboTa4wxJNpNP65leN0W2V/UmJJ9jrmyfGxJVVR3sTUtjvr+7d4dMYiKOSjjrzGVejT
         PV0TJWVwHvaaW07BMHYL8bBDbJ/IS36dWAtTbUIss03duFoDEcclV2oHylcSzsEDa6ft
         3jq007BntbG4B1SeH8tMJlm6tCLwKJVaMTDXGblUEXCRt9P7rN4kMH5Ga1o7Q0+l2WqB
         VAKP7TRBj0M2GQ03ISBbV9dGVMbsd1uf7TzHS0Vk1FRZyrmIuqabtmaxjIHwX9a7LqMP
         hn4A==
X-Gm-Message-State: AOAM531M6vFHOqjJlAOInHCl2YsUlS+urSBkZS1eWYIbv9wjwEi1hfVa
        KXJdJ9cM8kZIp4Scywz+h+iJ3U//+d9pROXGDeA=
X-Google-Smtp-Source: ABdhPJyIRY49hFioEOC8Di93A0EXso6ZHkQn+L6Pr3eBBm1Tb6OqNa9b9uSUF6uEggraogThR51BSw==
X-Received: by 2002:a17:90a:1057:: with SMTP id y23mr12409234pjd.97.1611241870275;
        Thu, 21 Jan 2021 07:11:10 -0800 (PST)
Received: from minh ([113.173.125.143])
        by smtp.gmail.com with ESMTPSA id y6sm5859075pfn.123.2021.01.21.07.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 07:11:09 -0800 (PST)
Date:   Thu, 21 Jan 2021 22:10:53 +0700
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
Message-ID: <20210121151053.GA3377@minh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [PATCH v2] can: mcba_usb: Fix memory leak when cancelling urb
Reply-To: 
In-Reply-To: <CACtPs=FB_=JMEymLHE0_ko4ZF5zj9NBCHkRC7O3tj6pkSp3oiA@mail.gmail.com>

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

Thanks,
Quang Minh.
