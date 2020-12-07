Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129CD2D1400
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLGOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:49:11 -0500
Received: from foss.arm.com ([217.140.110.172]:52788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGOtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:49:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A000F11D4;
        Mon,  7 Dec 2020 06:48:24 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26E63F774;
        Mon,  7 Dec 2020 06:48:22 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Haibo Xu <haibo.xu@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
Date:   Mon, 7 Dec 2020 14:48:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2020 08:25, Haibo Xu wrote:
> On Fri, 20 Nov 2020 at 17:51, Steven Price <steven.price@arm.com> wrote:
>>
>> On 19/11/2020 19:11, Marc Zyngier wrote:
>>> On 2020-11-19 18:42, Andrew Jones wrote:
>>>> On Thu, Nov 19, 2020 at 03:45:40PM +0000, Peter Maydell wrote:
>>>>> On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
>>>>>> This series adds support for Arm's Memory Tagging Extension (MTE) to
>>>>>> KVM, allowing KVM guests to make use of it. This builds on the
>>>>> existing
>>>>>> user space support already in v5.10-rc1, see [1] for an overview.
>>>>>
>>>>>> The change to require the VMM to map all guest memory PROT_MTE is
>>>>>> significant as it means that the VMM has to deal with the MTE tags
>>>>> even
>>>>>> if it doesn't care about them (e.g. for virtual devices or if the VMM
>>>>>> doesn't support migration). Also unfortunately because the VMM can
>>>>>> change the memory layout at any time the check for PROT_MTE/VM_MTE has
>>>>>> to be done very late (at the point of faulting pages into stage 2).
>>>>>
>>>>> I'm a bit dubious about requring the VMM to map the guest memory
>>>>> PROT_MTE unless somebody's done at least a sketch of the design
>>>>> for how this would work on the QEMU side. Currently QEMU just
>>>>> assumes the guest memory is guest memory and it can access it
>>>>> without special precautions...
>>>>>
>>>>
>>>> There are two statements being made here:
>>>>
>>>> 1) Requiring the use of PROT_MTE when mapping guest memory may not fit
>>>>     QEMU well.
>>>>
>>>> 2) New KVM features should be accompanied with supporting QEMU code in
>>>>     order to prove that the APIs make sense.
>>>>
>>>> I strongly agree with (2). While kvmtool supports some quick testing, it
>>>> doesn't support migration. We must test all new features with a migration
>>>> supporting VMM.
>>>>
>>>> I'm not sure about (1). I don't feel like it should be a major problem,
>>>> but (2).
>>
>> (1) seems to be contentious whichever way we go. Either PROT_MTE isn't
>> required in which case it's easy to accidentally screw up migration, or
>> it is required in which case it's difficult to handle normal guest
>> memory from the VMM. I get the impression that probably I should go back
>> to the previous approach - sorry for the distraction with this change.
>>
>> (2) isn't something I'm trying to skip, but I'm limited in what I can do
>> myself so would appreciate help here. Haibo is looking into this.
>>
> 
> Hi Steven,
> 
> Sorry for the later reply!
> 
> I have finished the POC for the MTE migration support with the assumption
> that all the memory is mapped with PROT_MTE. But I got stuck in the test
> with a FVP setup. Previously, I successfully compiled a test case to verify
> the basic function of MTE in a guest. But these days, the re-compiled test
> can't be executed by the guest(very weird). The short plan to verify
> the migration
> is to set the MTE tags on one page in the guest, and try to dump the migrated
> memory contents.

Hi Haibo,

Sounds like you are making good progress - thanks for the update. Have 
you thought about how the PROT_MTE mappings might work if QEMU itself 
were to use MTE? My worry is that we end up with MTE in a guest 
preventing QEMU from using MTE itself (because of the PROT_MTE 
mappings). I'm hoping QEMU can wrap its use of guest memory in a 
sequence which disables tag checking (something similar will be needed 
for the "protected VM" use case anyway), but this isn't something I've 
looked into.

> I will update the status later next week!

Great, I look forward to hearing how it goes.

Thanks,

Steve
