Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB48429F701
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJ2Vhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:37:53 -0400
Received: from z5.mailgun.us ([104.130.96.5]:54719 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJ2Vhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:37:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604007471; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=ixygKE6CUnjtQu995wq6xR81ScB+Tid8obYEPLMkRJQ=;
 b=TvWYtf2WAytt9EASZRTO0gI7kZJ0kP2Fpncvb8MrgjFzJJ0jCE8QtV+GllfAvI9N3xon4+ZP
 j143q+bk6Tz3tR9e000C3Gn0Lz//TlYVPAhFDbbo0+BAnnoXukMIHI2ThM+BPyIU4dIaCjpm
 cWC3alTpyPdXzzNoS6qCR0nJAEQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f9b361c8335df16572093ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 21:37:32
 GMT
Sender: eberman=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC37CC433FF; Thu, 29 Oct 2020 21:37:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.70] (cpe-76-167-231-33.san.res.rr.com [76.167.231.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAB4DC433C8;
        Thu, 29 Oct 2020 21:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAB4DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        linux-doc@vger.kernel.org
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
 <87v9f04n8r.fsf@nanos.tec.linutronix.de>
 <a6d7f84679240fcf580520230a88c058@codeaurora.org>
 <20201026171224.GV2611@hirez.programming.kicks-ass.net>
 <a9fa1f8d-52c7-adca-9087-160b1ecda6b8@codeaurora.org>
 <20201028145516.23lm66mora5b3wqr@e107158-lin>
 <20201028151558.odxwolnwbes2gihi@bogus>
Message-ID: <cb175d84-7a89-344d-0dd8-76bf4ece9e3b@codeaurora.org>
Date:   Thu, 29 Oct 2020 14:37:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201028151558.odxwolnwbes2gihi@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2020 8:15 AM, Sudeep Holla wrote:
>>>>> Hi Thomas and Peter,
>>>>>
>>>>> Based on my understanding with maxcpus option provides, maximum no of CPUs
>>>>> are brough up during the device boot up. There is a different case, in which
>>>>> we want to restrict which CPUs to be brough up.
>>>>> On a system with 8 cpus, if we set maxcpus as 3, cpu0, cpu1, and cpu2 are
>>>>> brough up during the bootup.  For example, if we want to bring core0, core3
>>>>> and core4 current maxcpu(as 3) setting would not help us.
>>>>> On some platform we want the flexibility on which CPUs to bring up during
>>>>> the device bootup. bootcpus command line is helping to bring specific CPUs
>>>>> and these patches are working downstream.
>>>>
> 
> Either offline "unwanted" CPUs from user space. If that is not possible
> for whatever thermal reasons, we need to check if we can disable them in
> the DT like ACPI does. IIUC, it is not supported for some reasons I need
> to recall/check, can't remember that now. If that is not possible, make
> those nodes disappear in the bootloader ?
> 

If I disappear the cpu nodes in bootloader, then I can't later online 
these cpus back up when policy permits. In our experience, there is a 
performance hit of ~100ms to modify any devicetree node in bootloader, 
which is significant on a commercial device wanting to disable bootup of 
certain cores for thermal.

>>>> That's a lot of words, but exactly 0 on _WHY_ you would want to do that.
>>>>
>>>
>>> We find the ability to limit the number of cpus brought online at bootup
>>> useful, and to possibly later enable those cores. One use case is when
>>> device is undergoing initial testing is to use bootcpus to limit bootup to
>>> only a couple cores and later bring up the other cores for a controlled
>>> stress test. A core brought up during boot is also running device
>>> initialization. Besides being useful for SoC vendor bringup which typically
>>> occurs downstream, this particular use case could be exercised by developer
>>> of upstream support for a SoC when initial CPU settings are being
>>> determined.
>>>
> 
> Why not try single core instead of couple of core and add the needed ones
> for the user-space ?

In some instances, we have seen that further debugging is needed from 
firmware or hardware teams. In these instances, we wanted device to 
still be able to do SMP boot, but with a few cores disabled.

In the case where commercial device is using feature for thermal, device 
should boot multiple small cores. Booting only one core means we would 
not be able to use all possible cores to maximum extent possible in this 
thermal case.

>>> Another use case is if user wishes to limit bootup only to the smaller or
>>> bigger cores. maxcpus= is not sufficient here to ensure that only those
>>> cores are booted since it limits only to the first N cores, which may not be
>>> the desired small or big cores. User may want to bring up only the smaller
>>> cores during bootup for thermal reasons. For instance, device may be later
>>> sufficiently charged such that boot up of the bigger cores is now
>>> permissible. Relying on thermal drivers to later take care of putting core
>>> into lower power idle may not occur until much later in boot (for instance,
>>> if the governor is a module).
>>
>> I would have thought that FW/SCP would have the power to block booting up the
>> CPUs if it deemed that to be unsafe.
>>
> 
> I think it is more like *desire* to run with whatever battery life is left
> rather than *unsafe* to bring up the core.
> 
> Also not sure if we can put such battery life related policies in the
> firmware. If there is a thermal constraint, I am sure f/w will and must
> refuse to boot the core. I doubt if we are talking about that here. It is
> more a policy to extract max out of the battery life left, at-least the way
> I see this issue. I may not have full context here, sorry.

This is correct, FW here does not actually prevent core from starting 
since it is not a significant enough thermal issue.
