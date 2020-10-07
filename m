Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA522868CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgJGUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:07:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49265 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726105AbgJGUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:07:56 -0400
Received: (qmail 471050 invoked by uid 1000); 7 Oct 2020 16:07:55 -0400
Date:   Wed, 7 Oct 2020 16:07:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Subject: Re: [PATCH] kcov, usb, vhost: specify contexts for remote coverage
 sections
Message-ID: <20201007200755.GD468921@rowland.harvard.edu>
References: <8c71349c3cd9698b8edcfbfc9631c5dcc3b29a37.1602091732.git.andreyknvl@google.com>
 <20201007192945.GB468921@rowland.harvard.edu>
 <CAAeHK+yV=mmrgyor=AeYq6SpLaqvpieHP51iTMrjNHLBhKDzyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yV=mmrgyor=AeYq6SpLaqvpieHP51iTMrjNHLBhKDzyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:54:57PM +0200, Andrey Konovalov wrote:
> On Wed, Oct 7, 2020 at 9:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Oct 07, 2020 at 07:30:51PM +0200, Andrey Konovalov wrote:
> > > Currently there's a KCOV remote coverage collection section in
> > > __usb_hcd_giveback_urb(). Initially that section was added based on the
> > > assumption that usb_hcd_giveback_urb() can only be called in interrupt
> > > context as indicated by a comment before it.
> > >
> > > As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
> > > context, provided that the caller turned off the interrupts; USB/IP actually
> > > does that. This can lead to a nested KCOV remote coverage collection
> > > sections both trying to collect coverage in task context. This isn't
> > > supported by KCOV, and leads to a WARNING.
> > >
> > > The approach this patch takes is to annotate every call of kcov_remote_*()
> > > callbacks with the context those callbacks are supposed to be executed in.
> > > If the current context doesn't match the mask provided to a callback,
> > > that callback is ignored. KCOV currently only supports collecting remote
> > > coverage in two contexts: task and softirq.
> > >
> > > As the result, the coverage from USB/IP related usb_hcd_giveback_urb() calls
> > > won't be collected, but the WARNING is fixed.
> > >
> > > A potential future improvement would be to support nested remote coverage
> > > collection sections, but this patch doesn't address that.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> >
> > > --- a/drivers/usb/core/hcd.c
> > > +++ b/drivers/usb/core/hcd.c
> > > @@ -1646,9 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> > >
> > >       /* pass ownership to the completion handler */
> > >       urb->status = status;
> > > -     kcov_remote_start_usb((u64)urb->dev->bus->busnum);
> > > +     kcov_remote_start_usb((u64)urb->dev->bus->busnum, KCOV_CONTEXT_SOFTIRQ);
> > >       urb->complete(urb);
> > > -     kcov_remote_stop();
> > > +     kcov_remote_stop(KCOV_CONTEXT_SOFTIRQ);
> >
> > This isn't right.  __usb_hcd_giveback_urb() can execute in pretty much
> > any context; its constraint is that interrupts must be disabled.
> 
> You're right, but here we constraint kcov to only collect coverage in
> case __usb_hcd_giveback_urb() is  executed in softirq context. This is
> what happens when we're fuzzing USB with the dummy driver, which is
> the case we currently take care of. Whenever someone has a desire to
> collect coverage in other contexts, it will need to be implemented
> separately.

Oh, sorry.  I thought the constraint meant that it would be an error
if kcov observed __usb_hcd_giveback_urb() executing in anything other
than softirq context.

Alan Stern
