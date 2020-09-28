Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104C927AE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1Mub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgI1Mua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:50:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A02721974;
        Mon, 28 Sep 2020 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601297429;
        bh=vSqcP0mrbe2L8WpJdc6NrNWXS4Vn2KXk5nRMn8lrgno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITBZ71/NgZ1h+xb0un8m22k/zxMtWnd/2/U/Se+o4QHj2dYSBb36uZH0QhgIRPKhu
         A8K/urinr3oiq6DXrYZe5VZRnUpdPdhL0zQsmVj6P02/FxOqWBEayS3AR8UwRNS8jR
         a0POInjIWcV3H5lDsIvmAjkve/MHFnZ+Uhy8f0XE=
Date:   Mon, 28 Sep 2020 14:50:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     psodagud@codeaurora.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200928125037.GA1661095@kroah.com>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
 <20200924063352.GB592892@kroah.com>
 <87wo0j6nos.fsf@nanos.tec.linutronix.de>
 <4c4a2534824eb69d41753d2e3b2773de@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4a2534824eb69d41753d2e3b2773de@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 07:05:34PM -0700, psodagud@codeaurora.org wrote:
> On 2020-09-24 11:21, Thomas Gleixner wrote:
> > On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
> > > On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
> > > > +config CONSOLE_FLUSH_ON_HOTPLUG
> > > > +	bool "Enable console flush configurable in hot plug code path"
> > > > +	depends on HOTPLUG_CPU
> > > > +	def_bool n
> > > 
> > > n is the default, no need to list it.
> > > 
> > > > +	help
> > > > +	In cpu hot plug path console lock acquire and release causes the
> > > > +	console to flush. If console lock is not free hot plug latency
> > > > +	increases. So make console flush configurable in hot plug path
> > > > +	and default disabled to help in cpu hot plug latencies.
> > > 
> > > Why would you not want this option?
> > > 
> > > Why isn't this just a bugfix?
> > 
> > Because it's the normal behaviour of console lock and there are
> > gazillion other ways to delay stuff in the hotplug path.
> > 
> > CPU hotplug is not meant to be a high speed operation and if people
> > think they need it to be fast then its pretty much guaranteed that they
> > want it for the completely wrong reasons.
> > 
> > This #ifdef tinkering is just digusting especially as it just tackles an
> > obvious way how to delay timer migration, but does not address the
> > underlying root cause.
> > 
> 
> Hi tglx,
> 
> Yes. I agree with you that there are other conditions, which could delay the
> hotplug operation. But this console
> flushing is not needed in the hotplug path.  In the hotplug path, a core is
> trying printing messages
> from other core(by design of printk), delays the whole hotplug operation and
> timers migration.  As timers
> migration gets delayed, it would impact the systems stability in device
> stability testing.
> To avoid timers delay in the timer migration in  debug builds has to choose
> this option.
> 
> I thought of changing the timers and irq migration as priority callbacks in
> the hotplug out operation
> but I observed some comments like shown below. I was under impression that,
> it is hard to find all this
> type of conditions, so started tinkering hotplug path by changing the log
> levels.
> These changes helped on Qualcomm platforms testing.
>         /*
>          * On the tear-down path, timers_dead_cpu() must be invoked
>          * before blk_mq_queue_reinit_notify() from notify_dead(),
>          * otherwise a RCU stall occurs.
>          */
>         [CPUHP_TIMERS_PREPARE] = {
>                 .name                   = "timers:prepare",
>                 .startup.single         = timers_prepare_cpu,
>                 .teardown.single        = timers_dead_cpu,
>         },
> 
> Another reason for adding #ifdef is that, I was not clear why console flush
> is need cpuhp callback and thought
> there might be some use cases and console flush use case might not be valid
> for all the users of cpu hotplug.
> I will try to explore the changing the callback order to complete the timers
> and irq migration early in the hotplug operation.
> 
> Let me put some use cases of hotplug  and why hotplug and hotplug latency is
> important from testing point of view.
> 1)	Secondary cpus are hotplug out during the device suspend and hotplug in
> during the resume.  So cpu hotplug operation is important production devices
> point of view as user presses the power key many times.

But what does suspend/resume have to do with this?  Why not do just an
offline operation instead of unplugging the whole cpu?

> 2)	sysfs nodes (/sys/devices/ststem/cpu/cpu4/oneline) are present from linux
> kernel, so  test team wants to test cpu hotplug. There could be issues with
> in generic kernel, device drivers or firmware(psci calls handling from
> firmware).  There could be issues with device drivers or firmware and test
> teams can not leave the hotplug untested in builds.

Your change isn't for testing things, speed doesn't matter when writing
to sysfs nodes, right?

> 3)	Linux kernel also gave provision to register call backs with cpu hotplug
> framework(CPUHP_AP_ONLINE_DYN) dynamic callbacks.
> 3002         ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> "printk:online",
> 3003                                         console_cpu_notify, NULL);
> 	So test team wants to test if any in tree or out of tree modules have any
> issues with registered call backs or not.

Again, how is this a speed issue?

> 4)	Tracing of the cpuhp operation is important to find whether upstream
> changes or out of tree modules(or firmware changes) caused latency
> regression or not.

But cpu hotplug is not deterministic, so how does latency matter here?

confused as to the real problem here...

greg k-h
