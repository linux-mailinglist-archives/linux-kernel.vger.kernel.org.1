Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E430428396D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgJEPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:22:20 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36983 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726727AbgJEPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:22:19 -0400
Received: (qmail 380154 invoked by uid 1000); 5 Oct 2020 11:22:18 -0400
Date:   Mon, 5 Oct 2020 11:22:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
Message-ID: <20201005152218.GF376584@rowland.harvard.edu>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:08:11PM +0200, Andrey Konovalov wrote:
> Dear USB and USB/IP maintainers,
> 
> While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.
> 
> Currently kcov (the subsystem that is used for coverage collection)
> USB-related callbacks assume that usb_hcd_giveback_urb() can only be
> called from interrupt context, as indicated by the comment before the
> function definition.

The primary reason for this restriction (as far as I'm aware) is because 
the routine uses spin_lock/spin_unlock rather than the 
_irqsave/_irqrestore variants.  There's also a small efficiency issue: 
In the vast majority of cases involving real host controllers, the 
routine _will_ be called in interrupt context.  So we optimized for that 
case.

>  In the USB/IP code, however, it's called from the
> task context (see the stack trace below).
> 
> Is this something that is allowed and we need to fix kcov? Or is this
> a bug in USB/IP?

It's a bug in USB/IP.  Interrupts should be disabled when it calls 
usb_hcd_giveback_urb().

Alan Stern
