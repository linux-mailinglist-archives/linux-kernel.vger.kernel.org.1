Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5658295190
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503544AbgJURcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:32:09 -0400
Received: from z5.mailgun.us ([104.130.96.5]:58433 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503534AbgJURcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:32:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603301526; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EcqTO31xMrs/OBAzDnSsJ48CkOQQ/LxYvl/FImj2B20=; b=epJN8I792tRkO2OItqIYKALxjiAqAmtLxgr2ddrbwplrz0EdS/i0ZOA5RHyY5xUVe9yRY31x
 jxQ2GNLYDTqJ5orNHpBRptOMka9JatRjcBq5wdD4w5wYwtr10RxvPtn/UcsCbzOQ1YGVjjd2
 xrenE53GeM9J+xuo1bFKYs0sCoI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f907082d6d00c7a9e10a177 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Oct 2020 17:31:46
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94C14C433F0; Wed, 21 Oct 2020 17:31:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.102] (unknown [124.123.181.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84610C433C9;
        Wed, 21 Oct 2020 17:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84610C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: Queries on ARM SDEI Linux kernel code
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
References: <af00fba0-7d1f-6655-906d-1e6a5ae45ede@codeaurora.org>
 <1dcda05c-5235-fd0d-087e-a32772e05f97@arm.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <f5cecf94-0c80-a37d-98a2-0596e2f0dd2e@codeaurora.org>
Date:   Wed, 21 Oct 2020 23:01:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1dcda05c-5235-fd0d-087e-a32772e05f97@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Sorry for late reply. Thanks for your comments!

On 10/16/2020 9:57 PM, James Morse wrote:
> Hi Neeraj,
> 
> On 15/10/2020 07:07, Neeraj Upadhyay wrote:
>> 1. Looks like interrupt bind interface (SDEI_1_0_FN_SDEI_INTERRUPT_BIND) is not available
>> for clients to use; can you please share information on
>> why it is not provided?
> 
> There is no compelling use-case for it, and its very complex to support as the driver can
> no longer hide things like hibernate.
> 
> Last time I looked, it looked like the SDEI driver would need to ask the irqchip to
> prevent modification while firmware re-configures the irq. I couldn't work out how this
> would work if the irq is in-progress on another CPU.
> 

Got it. I will think in this direction, on how to achieve this.

> The reasons to use bound-interrupts can equally be supported with an event provided by
> firmware.
> 
> 
Ok, I will explore in that direction.

>> While trying to dig information on this, I saw  that [1] says:
>>    Now the hotplug callbacks save  nothing, and restore the OS-view of registered/enabled.
>> This makes bound-interrupts harder to work with.
> 
>> Based on this comment, the changes from v4 [2], which I could understand is, cpu down path
>> does not save the current event enable status, and we rely on the enable status
>> `event->reenable', which is set, when register/unregister, enable/disable calls are made;
>> this enable status is used during cpu up path, to decide whether to reenable the interrupt.
> 
>> Does this make, bound-interrupts harder to work with? how? Can you please explain? Or
>> above save/restore is not the reason and you meant something else?
> 
> If you bind a level-triggered interrupt, how does firmware know how to clear the interrupt
> from whatever is generating it?
> 
> What happens if the OS can't do this either, as it needs to allocate memory, or take a
> lock, which it can't do in nmi context?
> 
> Ok, makes sense.
> The people that wrote the SDEI spec's answer to this was that the handler can disable the
> event from inside the handler... and firmware will do, something, to stop the interrupt
> screaming.
> 
> So now an event can become disabled anytime its registered, which makes it more
> complicated to save/restore.
> 
> 
>> Also, does shared bound interrupts
> 
> Shared-interrupts as an NMI made me jump. But I think you mean a bound interrupt as a
> shared event. i.e. and SPI not a PPI.
> 
> 
Sorry I should have worded properly; yes I meant SPI as shared event.

>> also have the same problem, as save/restore behavior
>> was only for private events?
> 
> See above, the problem is the event disabling itself.
> 
This makes sense now.

> Additionally those changes to unregister the private-event mean the code can't tell the
> difference between cpuhp and hibernate... only hibernate additionally loses the state in
> firmware.
> 
> 
Got it!
>> 2. SDEI_EVENT_SIGNAL api is not provided? What is the reason for it? Its handling has the
>> same problems, which are there for bound interrupts?
> 
> Its not supported as no-one showed up with a use-case.
> While firmware is expected to back it with a PPI, its doesn't have the same problems as
> bound-interrupts as its not an interrupt the OS ever knows about.
> 
> 
>> Also, if it is provided, clients need to register event 0 ? Vendor events or other event
>> nums are not supported, as per spec.
> 
> Ideally the driver would register the event, and provide a call_on_cpu() helper to trigger
> it. This should fit in with however the GIC's PMR based NMI does its PPI based
> crash/stacktrace call so that the caller doesn't need to know if its back by IRQ, pNMI or
> SDEI.
> 
> 
Ok; I will explore how PMR based NMIs work; I thought it was SGI based. 
But will recheck.

>> 3. Can kernel panic() be triggered from sdei event handler?
> 
> Yes,
> 
> 
>> Is it a safe operation?
> 
> panic() wipes out the machine... did you expect it to keep running?

I wanted to check the case where panic triggers kexec/kdump path into 
capture kernel.

> What does safe mean here?
> I think I didn't put it correctly; I meant what possible scenarios can 
happen in this case and you explained one below, thanks!

> You should probably call nmi_panic() if there is the risk that the event occurred during
> panic() on the same CPU, as it would otherwise just block.
> 
> 
>> The spec says, synchronous exceptions should not be triggered; I think panic
>> won't do it; but anything which triggers a WARN
>> or other sync exception in that path can cause undefined behavior. Can you share your
>> thoughts on this?
> 
> What do you mean by undefined behaviour?
> 
I was thinking, if SDEI event preempts EL1, at the point, where EL1 has 
just entered an exception, and hasn't captured the registers like 
spsr_el1, elr_el1 and other registers, what will be the behavior?

> SDEI was originally to report external abort to the OS in regions where the OS can't take
> an exception because the exception-registers are live, just after and exception and just
> before eret.
> 
> If you take another exception from the NMI handler, chances are you're going to go back
> round the loop again, only this time firmware can't inject the SDEI event, so it has to
> reboot.
> 
Got it.
> If you know it might cause an exception, you shouldn't do it in NMI context.
> 
> 
Ok, I understand now.

>> "The handler code should not enable asynchronous exceptions by clearing any of the
>> PSTATE.DAIF bits, and should not cause synchronous exceptions to the client Exception level."
> 
> 
> What are you using this thing for?
> 
> 
Usecase is, a watchdog SPI interrupt, which we want to bound to a SDEI 
event. Below is the flow:

wdog expiry -> SDEI event -> HLOS panic -> trigger kexec/kdump


Thanks
Neeraj

> Thanks,
> 
> James
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
