Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871912843C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJFBXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:23:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48333 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725922AbgJFBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:23:34 -0400
Received: (qmail 399907 invoked by uid 1000); 5 Oct 2020 21:23:33 -0400
Date:   Mon, 5 Oct 2020 21:23:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
Message-ID: <20201006012333.GA399825@rowland.harvard.edu>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
 <20201005151857.GA2309511@kroah.com>
 <CAAeHK+zes2Y00+EJ6SVtOHj8YCADw5WSXUEFHWCRgxi=H42+4w@mail.gmail.com>
 <20201005152540.GG376584@rowland.harvard.edu>
 <65b4ff62-f9c8-b9cf-50bb-c9b08cce7230@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b4ff62-f9c8-b9cf-50bb-c9b08cce7230@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:38:22PM -0600, Shuah Khan wrote:
> On 10/5/20 9:25 AM, Alan Stern wrote:
> > On Mon, Oct 05, 2020 at 05:21:30PM +0200, Andrey Konovalov wrote:
> > No, no -- it won't work right if it's called in process context.  Not
> > only do the spinlock calls leave the interrupt flag unchanged, also the
> > driver callback routines may expect to be invoked with interrupts
> > disabled.  (We have tried to fix this, but I'm not at all certain that
> > all the cases have been updated.)
> > 
> 
> In the case of vhci case, usb_hcd_giveback_urb() is called from vhci's
> urb_enqueue, when it determines it doesn't need to xmit the urb and can give
> it back. This path runs in task context.
> 
> Do you have any recommendation on how this case can be handled?

Just call local_irq_disable() before usb_hcd_giveback_urb(), and 
local_irq_enable() afterward.

Alan Stern
