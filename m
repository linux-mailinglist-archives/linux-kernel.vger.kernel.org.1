Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9929BFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816666AbgJ0RIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:08:40 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:55722 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793558AbgJ0RGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:06:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603818409; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5pG35uJKp6em/LcuBe+x/98128f/lxYBlQLa1lAR/rI=; b=d5K55sgVRIfYV1dOToYrr5wVNLAytocGidH1ddFFoSra3wU4fqKFlmeBkXzi79b2W9rWtQ4h
 jcrWFSrpH4vZohw8APgZt1Ah8KhrDFecoDCUVosNdy30sd5PBxg5jWaA+7J7mZZBpB9S13IY
 d3ltksOlYZo2h9KKY4bBASnrKBQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f9853a8b317790c806aea54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 17:06:48
 GMT
Sender: eberman=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEEB6C38523; Tue, 27 Oct 2020 17:06:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.70] (cpe-76-167-231-33.san.res.rr.com [76.167.231.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02277C4A61D;
        Tue, 27 Oct 2020 17:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02277C4A61D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=eberman@codeaurora.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        linux-doc@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
 <87v9f04n8r.fsf@nanos.tec.linutronix.de>
 <a6d7f84679240fcf580520230a88c058@codeaurora.org>
 <20201026171224.GV2611@hirez.programming.kicks-ass.net>
From:   Elliot Berman <eberman@codeaurora.org>
Message-ID: <a9fa1f8d-52c7-adca-9087-160b1ecda6b8@codeaurora.org>
Date:   Tue, 27 Oct 2020 10:06:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026171224.GV2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/2020 10:12 AM, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 10:08:47AM -0700, psodagud@codeaurora.org wrote:
>> On 2020-10-23 14:59, Thomas Gleixner wrote:
>>> On Thu, Oct 22 2020 at 15:04, Elliot Berman wrote:
>>>> In a heterogeneous multiprocessor system, specifying the 'maxcpus'
>>>> parameter on kernel command line does not provide sufficient control
>>>> over which CPUs are brought online at kernel boot time, since CPUs may
>>>> have nonuniform performance characteristics. Thus, add bootcpus kernel
>>>> parameter to control which CPUs should be brought online during kernel
>>>> boot. When both maxcpus and bootcpus is set, the more restrictive of
>>>> the
>>>> two are booted.
>>>
>>> What for? 'maxcpus' is a debug hack at best and outright dangerous on
>>> certain architectures. Why do we need more of that? Just let the machine
>>> boot and offline the CPUs from user space.
>>
>> Hi Thomas and Peter,
>>
>> Based on my understanding with maxcpus option provides, maximum no of CPUs
>> are brough up during the device boot up. There is a different case, in which
>> we want to restrict which CPUs to be brough up.
>> On a system with 8 cpus, if we set maxcpus as 3, cpu0, cpu1, and cpu2 are
>> brough up during the bootup.  For example, if we want to bring core0, core3
>> and core4 current maxcpu(as 3) setting would not help us.
>> On some platform we want the flexibility on which CPUs to bring up during
>> the device bootup. bootcpus command line is helping to bring specific CPUs
>> and these patches are working downstream.
> 
> That's a lot of words, but exactly 0 on _WHY_ you would want to do that.
> 

We find the ability to limit the number of cpus brought online at bootup 
useful, and to possibly later enable those cores. One use case is when 
device is undergoing initial testing is to use bootcpus to limit bootup 
to only a couple cores and later bring up the other cores for a 
controlled stress test. A core brought up during boot is also running 
device initialization. Besides being useful for SoC vendor bringup which 
typically occurs downstream, this particular use case could be exercised 
by developer of upstream support for a SoC when initial CPU settings are 
being determined.

Another use case is if user wishes to limit bootup only to the smaller 
or bigger cores. maxcpus= is not sufficient here to ensure that only 
those cores are booted since it limits only to the first N cores, which 
may not be the desired small or big cores. User may want to bring up 
only the smaller cores during bootup for thermal reasons. For instance, 
device may be later sufficiently charged such that boot up of the bigger 
cores is now permissible. Relying on thermal drivers to later take care 
of putting core into lower power idle may not occur until much later in 
boot (for instance, if the governor is a module).
