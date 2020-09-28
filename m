Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7F27A54F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgI1CFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 22:05:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:50614 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgI1CFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 22:05:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601258736; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dMpeKRRK5ChEBvPozaZ/OIZ/bmAipVaa/6ZB9gRgYkI=;
 b=qZcWWyrXvUtIxGrl29P9nB/ouV/BlLvEI7GmicL5Mj95fYJzy1FNz4XMH7BO+ho0AoWom/Gg
 zakNybmd8QSxCLkxb4ETv7JbNyq0EaNodWc7pbZMa1tRNvhcldIyTGSgGFCpltQs5Xh6vSC5
 y+7LaD1mZ7LaYNreJsSFPHqqfY8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f7144f089f51cb4f13e80e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 02:05:36
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C669C433F1; Mon, 28 Sep 2020 02:05:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 670EDC433CB;
        Mon, 28 Sep 2020 02:05:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 27 Sep 2020 19:05:34 -0700
From:   psodagud@codeaurora.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
In-Reply-To: <87wo0j6nos.fsf@nanos.tec.linutronix.de>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
 <20200924063352.GB592892@kroah.com> <87wo0j6nos.fsf@nanos.tec.linutronix.de>
Message-ID: <4c4a2534824eb69d41753d2e3b2773de@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-24 11:21, Thomas Gleixner wrote:
> On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
>> On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
>>> +config CONSOLE_FLUSH_ON_HOTPLUG
>>> +	bool "Enable console flush configurable in hot plug code path"
>>> +	depends on HOTPLUG_CPU
>>> +	def_bool n
>> 
>> n is the default, no need to list it.
>> 
>>> +	help
>>> +	In cpu hot plug path console lock acquire and release causes the
>>> +	console to flush. If console lock is not free hot plug latency
>>> +	increases. So make console flush configurable in hot plug path
>>> +	and default disabled to help in cpu hot plug latencies.
>> 
>> Why would you not want this option?
>> 
>> Why isn't this just a bugfix?
> 
> Because it's the normal behaviour of console lock and there are
> gazillion other ways to delay stuff in the hotplug path.
> 
> CPU hotplug is not meant to be a high speed operation and if people
> think they need it to be fast then its pretty much guaranteed that they
> want it for the completely wrong reasons.
> 
> This #ifdef tinkering is just digusting especially as it just tackles 
> an
> obvious way how to delay timer migration, but does not address the
> underlying root cause.
> 

Hi tglx,

Yes. I agree with you that there are other conditions, which could delay 
the hotplug operation. But this console
flushing is not needed in the hotplug path.  In the hotplug path, a core 
is trying printing messages
from other core(by design of printk), delays the whole hotplug operation 
and timers migration.  As timers
migration gets delayed, it would impact the systems stability in device 
stability testing.
To avoid timers delay in the timer migration in  debug builds has to 
choose this option.

I thought of changing the timers and irq migration as priority callbacks 
in the hotplug out operation
but I observed some comments like shown below. I was under impression 
that, it is hard to find all this
type of conditions, so started tinkering hotplug path by changing the 
log levels.
These changes helped on Qualcomm platforms testing.
         /*
          * On the tear-down path, timers_dead_cpu() must be invoked
          * before blk_mq_queue_reinit_notify() from notify_dead(),
          * otherwise a RCU stall occurs.
          */
         [CPUHP_TIMERS_PREPARE] = {
                 .name                   = "timers:prepare",
                 .startup.single         = timers_prepare_cpu,
                 .teardown.single        = timers_dead_cpu,
         },

Another reason for adding #ifdef is that, I was not clear why console 
flush is need cpuhp callback and thought
there might be some use cases and console flush use case might not be 
valid for all the users of cpu hotplug.
I will try to explore the changing the callback order to complete the 
timers and irq migration early in the hotplug operation.

Let me put some use cases of hotplug  and why hotplug and hotplug 
latency is important from testing point of view.
1)	Secondary cpus are hotplug out during the device suspend and hotplug 
in during the resume.  So cpu hotplug operation is important production 
devices point of view as user presses the power key many times.

2)	sysfs nodes (/sys/devices/ststem/cpu/cpu4/oneline) are present from 
linux kernel, so  test team wants to test cpu hotplug. There could be 
issues with in generic kernel, device drivers or firmware(psci calls 
handling from firmware).  There could be issues with device drivers or 
firmware and test teams can not leave the hotplug untested in builds.

3)	Linux kernel also gave provision to register call backs with cpu 
hotplug framework(CPUHP_AP_ONLINE_DYN) dynamic callbacks.
3002         ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, 
"printk:online",
3003                                         console_cpu_notify, NULL);
	So test team wants to test if any in tree or out of tree modules have 
any issues with registered call backs or not.

4)	Tracing of the cpuhp operation is important to find whether upstream 
changes or out of tree modules(or firmware changes) caused latency 
regression or not.

-Thanks, Prasad


>>> +#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
>> 
>> #ifdef in .c code is a mess to maintain.
>> 
>>>  	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", 
>>> NULL,
>>>  					console_cpu_notify);
>>>  	WARN_ON(ret < 0);
>>>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, 
>>> "printk:online",
>>>  					console_cpu_notify, NULL);
>>>  	WARN_ON(ret < 0);
>>> -	return 0;
>>> +#endif
>> 
>> What happens if we don't make these calls entirely?  Why not just 
>> remove
>> them as who wants extra latency for their system?
> 
> That's just wrong. If you don't want output, then adjust your loglevel,
> but delaying printks up to the point where by chance another printk
> happens is just silly.
> 
> CPU hotplug is not about latency. It's slow by design and again, the
> timer migration is simply happening at the wrong place. But fixing that
> needs more thoughts than modifying log levels and sprinkling a few
> #ifdefs into the code.
> 
> Thanks,
> 
>         tglx
