Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149972CE59C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLDCTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgLDCTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:19:37 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688A22250F;
        Fri,  4 Dec 2020 02:18:56 +0000 (UTC)
Date:   Thu, 3 Dec 2020 21:18:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: tracer_init_tracefs really slow
Message-ID: <20201203211854.7e5caa49@oasis.local.home>
In-Reply-To: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the really late reply, but I received this while I was on
vacation, and my backlog was so big when I got back that I left most of
it unread. :-/  And to make matters worse, my out-of-office script
wasn't working, to let people know I was on vacation.

On Mon, 07 Sep 2020 18:16:52 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Hi all,
> 
> one of my colleagues has taken a look at device boot times and stumbled
> across a pretty big amount of kernel boot time being spent in
> tracer_init_tracefs(). On this particular i.MX6Q based device the
> kernel spends more than 1 second in this function, which is a
> significant amount of the overall kernel inititalization time. While
> this machine is no rocket with its Cortex A9 @ 800MHz, the amount of
> CPU time being used there is pretty irritating.
> 
> Specifically the issue lies within trace_event_eval_update where ~1100
> trace_event_calls get updated with ~500 trace_eval_maps. I haven't had
> a chance yet to dig any deeper or try to understand more of what's
> going on there, but I wanted to get the issue out there in case anyone
> has some cycles to spare to help us along.

OK, that makes sense. The macro TRACE_DEFINE_ENUM() will make a mapping
of enums into their values. This is needed because if an enum is used
in tp_printk() of a TRACE_EVENT(), the name of the ENUM is passed to
user space. The enum name is useless to user space, so this function
will scan the strings that are exported to user space and convert the
enum name to the enum values.

> 
> The obvious questions for now are:
> 1. Why is this function so damn expensive (at least on this whimpy ARM
> machine)? and

Well, it's doing a string substitution for thousands of events.


> 2. Could any of this be done asynchronously, to not block the kernel in
> early init?

Yes :-)

We could make a thread that does this, that the init wakes up and runs,
letting the kernel to move forward. Would you like to make that patch
or shall I?

-- Steve
