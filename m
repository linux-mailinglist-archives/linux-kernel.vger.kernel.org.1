Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03FF2B9734
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgKSP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:57:48 -0500
Received: from foss.arm.com ([217.140.110.172]:33278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKSP5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:57:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407571478;
        Thu, 19 Nov 2020 07:57:47 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E23D33F719;
        Thu, 19 Nov 2020 07:57:44 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b434977d-08d7-f753-f95c-81fc533cae0a@arm.com>
Date:   Thu, 19 Nov 2020 15:57:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2020 15:45, Peter Maydell wrote:
> On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
>> This series adds support for Arm's Memory Tagging Extension (MTE) to
>> KVM, allowing KVM guests to make use of it. This builds on the existing
>> user space support already in v5.10-rc1, see [1] for an overview.
> 
>> The change to require the VMM to map all guest memory PROT_MTE is
>> significant as it means that the VMM has to deal with the MTE tags even
>> if it doesn't care about them (e.g. for virtual devices or if the VMM
>> doesn't support migration). Also unfortunately because the VMM can
>> change the memory layout at any time the check for PROT_MTE/VM_MTE has
>> to be done very late (at the point of faulting pages into stage 2).
> 
> I'm a bit dubious about requring the VMM to map the guest memory
> PROT_MTE unless somebody's done at least a sketch of the design
> for how this would work on the QEMU side. Currently QEMU just
> assumes the guest memory is guest memory and it can access it
> without special precautions...

I agree this needs some investigation - I'm hoping Haibo will be able to 
provide some feedback here as he has been looking at the QEMU support. 
However the VMM is likely going to require some significant changes to 
ensure that migration doesn't break, so either way there's work to be done.

Fundamentally most memory will need a mapping with PROT_MTE just so the 
VMM can get at the tags for migration purposes, so QEMU is going to have 
to learn how to treat guest memory specially if it wants to be able to 
enable MTE for both itself and the guest.

I'll also hunt down what's happening with my attempts to fix the 
set_pte_at() handling for swap and I'll post that as an alternative if 
it turns out to be a reasonable approach. But I don't think that solve 
the QEMU issue above.

The other alternative would be to implement a new kernel interface to 
fetch tags from the guest and not require the VMM to maintain a PROT_MTE 
mapping. But we need some real feedback from someone familiar with QEMU 
to know what that interface should look like. So I'm holding off on that 
until there's a 'real' PoC implementation.

Thanks,

Steve
