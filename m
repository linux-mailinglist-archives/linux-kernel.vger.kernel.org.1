Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0932D1509
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLGPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:46:29 -0500
Received: from foss.arm.com ([217.140.110.172]:53942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:46:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CB1431B;
        Mon,  7 Dec 2020 07:45:43 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E4A3F68F;
        Mon,  7 Dec 2020 07:45:41 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
Date:   Mon, 7 Dec 2020 15:45:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2020 15:27, Peter Maydell wrote:
> On Mon, 7 Dec 2020 at 14:48, Steven Price <steven.price@arm.com> wrote:
>> Sounds like you are making good progress - thanks for the update. Have
>> you thought about how the PROT_MTE mappings might work if QEMU itself
>> were to use MTE? My worry is that we end up with MTE in a guest
>> preventing QEMU from using MTE itself (because of the PROT_MTE
>> mappings). I'm hoping QEMU can wrap its use of guest memory in a
>> sequence which disables tag checking (something similar will be needed
>> for the "protected VM" use case anyway), but this isn't something I've
>> looked into.
> 
> It's not entirely the same as the "protected VM" case. For that
> the patches currently on list basically special case "this is a
> debug access (eg from gdbstub/monitor)" which then either gets
> to go via "decrypt guest RAM for debug" or gets failed depending
> on whether the VM has a debug-is-ok flag enabled. For an MTE
> guest the common case will be guests doing standard DMA operations
> to or from guest memory. The ideal API for that from QEMU's
> point of view would be "accesses to guest RAM don't do tag
> checks, even if tag checks are enabled for accesses QEMU does to
> memory it has allocated itself as a normal userspace program".

Sorry, I know I simplified it rather by saying it's similar to protected 
VM. Basically as I see it there are three types of memory access:

1) Debug case - has to go via a special case for decryption or ignoring 
the MTE tag value. Hopefully this can be abstracted in the same way.

2) Migration - for a protected VM there's likely to be a special method 
to allow the VMM access to the encrypted memory (AFAIK memory is usually 
kept inaccessible to the VMM). For MTE this again has to be special 
cased as we actually want both the data and the tag values.

3) Device DMA - for a protected VM it's usual to unencrypt a small area 
of memory (with the permission of the guest) and use that as a bounce 
buffer. This is possible with MTE: have an area the VMM purposefully 
maps with PROT_MTE. The issue is that this has a performance overhead 
and we can do better with MTE because it's trivial for the VMM to 
disable the protection for any memory.

The part I'm unsure on is how easy it is for QEMU to deal with (3) 
without the overhead of bounce buffers. Ideally there'd already be a 
wrapper for guest memory accesses and that could just be wrapped with 
setting TCO during the access. I suspect the actual situation is more 
complex though, and I'm hoping Haibo's investigations will help us 
understand this.

Thanks,

Steve
