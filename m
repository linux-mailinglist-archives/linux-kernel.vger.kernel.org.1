Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B428397B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgJEPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:25:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42135 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727032AbgJEPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:25:41 -0400
Received: (qmail 380341 invoked by uid 1000); 5 Oct 2020 11:25:40 -0400
Date:   Mon, 5 Oct 2020 11:25:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
Message-ID: <20201005152540.GG376584@rowland.harvard.edu>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
 <20201005151857.GA2309511@kroah.com>
 <CAAeHK+zes2Y00+EJ6SVtOHj8YCADw5WSXUEFHWCRgxi=H42+4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zes2Y00+EJ6SVtOHj8YCADw5WSXUEFHWCRgxi=H42+4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:21:30PM +0200, Andrey Konovalov wrote:
> On Mon, Oct 5, 2020 at 5:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 05, 2020 at 05:08:11PM +0200, Andrey Konovalov wrote:
> > > Dear USB and USB/IP maintainers,
> > >
> > > While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.
> > >
> > > Currently kcov (the subsystem that is used for coverage collection)
> > > USB-related callbacks assume that usb_hcd_giveback_urb() can only be
> > > called from interrupt context, as indicated by the comment before the
> > > function definition. In the USB/IP code, however, it's called from the
> > > task context (see the stack trace below).
> > >
> > > Is this something that is allowed and we need to fix kcov? Or is this
> > > a bug in USB/IP?
> >
> > It's a bug in kcov, and is not true as you have found out :)
> 
> OK, I see, I'll work on a fix, thanks!
> 
> Should I also update the comment above usb_hcd_giveback_urb() to
> mention that it can be called in_task()? Or is this redundant and is
> assumed in general?

No, no -- it won't work right if it's called in process context.  Not 
only do the spinlock calls leave the interrupt flag unchanged, also the 
driver callback routines may expect to be invoked with interrupts 
disabled.  (We have tried to fix this, but I'm not at all certain that 
all the cases have been updated.)

Alan Stern
