Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B92CD486
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgLCL0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 06:26:31 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35198 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgLCL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:26:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHP8Nnx_1606994743;
Received: from 30.27.144.231(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHP8Nnx_1606994743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 19:25:44 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <4f89671e080eb23b084c0e0942f111e6@kernel.org>
Date:   Thu, 3 Dec 2020 19:25:43 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
 <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
 <4513911D-77BF-4459-B8DF-9889395C16AC@linux.alibaba.com>
 <4f89671e080eb23b084c0e0942f111e6@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月3日 下午4:35，Marc Zyngier <maz@kernel.org> 写道：
> 
> On 2020-12-03 05:45, Rongwei Wang wrote:
>>> 2020年12月1日 下午11:37，Marc Zyngier <maz@kernel.org> 写道：
>>> On 2020-12-01 14:25, wangrongwei wrote:
>>>>> 2020年12月1日 下午4:12，Marc Zyngier <maz@kernel.org> 写道：
>>>>> On 2020-12-01 03:09, wangrongwei wrote:
>>>>>> Hi
>>>>>> We have validate this driver in vm and physical machine, and works fine.
>>>>> But what does "work fine" mean? None of these system registers are supposed
>>>>> to be accessible from userspace, so please explain *what* you are trying to
>>>>> do with this, other that introducing security holes and general system
>>>>> instability?
>>>> I think I know what you mean. Do you want me to describe how we achieved it?
>>>> In x86, the different registers can be accessed directly using the
>>>> rdmsr and wrmsr instructions, but in ARM, since these two instructions
>>>> are missing, so we modify the code segment during runtime, similar to
>>>> the principle of static_key.
>>> [...]
>>> These are implementation details, none of which answer my question:
>>> What makes you think this is a good idea? I cannot see any legitimate
>> In fact, I think this tool useful mainly in the following scenarios:
>> 	1. performance debug
>> 	2. Arm-core features test
>> 	3. Debug-tool for kernel developer
>> Also, for example, MSR-ARM is needed for chip verification and
>> system-level functional verification.
>> A simple example, perf stat can test pmu, but the overflow interrupt
>> function and forced overflow function of pmu is not covered.
> 
> But what does it mean to change random system registers while the kernel
> itself is using them in parallel? All you are introducing is a bunch of
> uncontrolled, unexpected, and possibly fatal side effects.
This problem exists when writing to a register, but it does not exist when reading a register.
> 
> Introducing such an interface makes the kernel unsafe, insecure, and
> and violates all the possible guarantees that we are trying hard to
> provide. After all, why would we even try to mitigate side channel
> vulnerabilities if we were to introduce such a thing?
> 
>> In both cases, we need a special interface to configure it, which can
>> be considered as testing requirements, so it can only be tested by
>> configuring (access) registers, e.g., devmem command for memmap
>> registers, MSR-ARM driver for system registers.
> 
> devmem was a terrible mistake. Unprivileged sysreg access is another
> instance of the same mistake.
> 
> The kernel is not a validation tool. It is designed to operate safely,
> securely, and reliably. What you propose is the negation of these goals
> for dubious purposes, and I think I represent a large number of kernel
> developers when I say that we really do not want it.
> 
> This will (hopefully) be my last message on this subject.
> 
> Thanks,
> 
>        M.
> -- 
> Jazz is not dead. It just smells funny…
Thanks,
Rongwei Wang.

