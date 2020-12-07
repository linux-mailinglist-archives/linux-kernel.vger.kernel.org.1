Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7F2D15E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLGQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgLGQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:25:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE28C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:25:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kmJJs-00045X-Bu; Mon, 07 Dec 2020 17:25:00 +0100
Message-ID: <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
Subject: Re: tracer_init_tracefs really slow
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Mon, 07 Dec 2020 17:24:58 +0100
In-Reply-To: <20201203211854.7e5caa49@oasis.local.home>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
         <20201203211854.7e5caa49@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Am Donnerstag, den 03.12.2020, 21:18 -0500 schrieb Steven Rostedt:
> Sorry for the really late reply, but I received this while I was on
> vacation, and my backlog was so big when I got back that I left most of
> it unread. :-/  And to make matters worse, my out-of-office script
> wasn't working, to let people know I was on vacation.

No problem, I already figured that this might have fallen through the
cracks. It's also not really a high prio issue for us.

> On Mon, 07 Sep 2020 18:16:52 +0200
> Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > Hi all,
> > 
> > one of my colleagues has taken a look at device boot times and stumbled
> > across a pretty big amount of kernel boot time being spent in
> > tracer_init_tracefs(). On this particular i.MX6Q based device the
> > kernel spends more than 1 second in this function, which is a
> > significant amount of the overall kernel inititalization time. While
> > this machine is no rocket with its Cortex A9 @ 800MHz, the amount of
> > CPU time being used there is pretty irritating.
> > 
> > Specifically the issue lies within trace_event_eval_update where ~1100
> > trace_event_calls get updated with ~500 trace_eval_maps. I haven't had
> > a chance yet to dig any deeper or try to understand more of what's
> > going on there, but I wanted to get the issue out there in case anyone
> > has some cycles to spare to help us along.
> 
> OK, that makes sense. The macro TRACE_DEFINE_ENUM() will make a mapping
> of enums into their values. This is needed because if an enum is used
> in tp_printk() of a TRACE_EVENT(), the name of the ENUM is passed to
> user space. The enum name is useless to user space, so this function
> will scan the strings that are exported to user space and convert the
> enum name to the enum values.
> 
> > 
> > The obvious questions for now are:
> > 1. Why is this function so damn expensive (at least on this whimpy ARM
> > machine)? and
> 
> Well, it's doing a string substitution for thousands of events.
> 
> 
> > 2. Could any of this be done asynchronously, to not block the kernel in
> > early init?
> 
> Yes :-)
> 
> We could make a thread that does this, that the init wakes up and runs,
> letting the kernel to move forward. Would you like to make that patch
> or shall I?

I guess you are much more likely to come up with a correct patch, as
I'm not really clear yet on when we would need to synchronize this
thread, to make sure things are available before they get used by
something. I likely won't have time in the near future to read enough
code in this particular spot of the kernel.

I would be happy to test a patch on our whimpy machines, though. :)

Regards,
Lucas

