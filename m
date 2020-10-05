Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30056283A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgJEPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgJEPem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:34:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56443207BC;
        Mon,  5 Oct 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601912081;
        bh=mF2qM+6mrTEqba8z30D+KHTocD0MO7WUZFPMHbfyAHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKd5HdT+CahXqJNJmbyW0ZVxWv35HGrt0Htw3b9urf1y2lKSM+FprzeHoBaLF4xul
         YAQK3bIf0MVlrh7Uo9Dh2VXoq/cyPHVc2U4nDrfZVaTxhphgBeNAZVj5WfwJhUA9ib
         5SOkFhrFWYcqG6Xbq5aJ/kntyowaaQNeQqxiU9To=
Date:   Mon, 5 Oct 2020 17:28:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
Message-ID: <20201005152840.GA2372768@kroah.com>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
 <20201005152218.GF376584@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005152218.GF376584@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:22:18AM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 05:08:11PM +0200, Andrey Konovalov wrote:
> > Dear USB and USB/IP maintainers,
> > 
> > While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.
> > 
> > Currently kcov (the subsystem that is used for coverage collection)
> > USB-related callbacks assume that usb_hcd_giveback_urb() can only be
> > called from interrupt context, as indicated by the comment before the
> > function definition.
> 
> The primary reason for this restriction (as far as I'm aware) is because 
> the routine uses spin_lock/spin_unlock rather than the 
> _irqsave/_irqrestore variants.  There's also a small efficiency issue: 
> In the vast majority of cases involving real host controllers, the 
> routine _will_ be called in interrupt context.  So we optimized for that 
> case.
> 
> >  In the USB/IP code, however, it's called from the
> > task context (see the stack trace below).
> > 
> > Is this something that is allowed and we need to fix kcov? Or is this
> > a bug in USB/IP?
> 
> It's a bug in USB/IP.  Interrupts should be disabled when it calls 
> usb_hcd_giveback_urb().

But that's not always the case when we have host controllers running
with threaded interrupts, right?  Or do they still disable interrupts?

thanks,

greg k-h
