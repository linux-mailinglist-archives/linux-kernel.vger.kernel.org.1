Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1810207595
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbgFXOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 10:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388115AbgFXOVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:21:37 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D89A2072E;
        Wed, 24 Jun 2020 14:21:34 +0000 (UTC)
Date:   Wed, 24 Jun 2020 15:21:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Maydell <Peter.Maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
Message-ID: <20200624142131.GA27945@gaia>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200623174807.GD5180@gaia>
 <e04696b6-63de-1e25-f6f3-1da63f791754@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04696b6-63de-1e25-f6f3-1da63f791754@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:16:28PM +0100, Steven Price wrote:
> On 23/06/2020 18:48, Catalin Marinas wrote:
> > On Wed, Jun 17, 2020 at 01:38:42PM +0100, Steven Price wrote:
> > > These patches add support to KVM to enable MTE within a guest. It is
> > > based on Catalin's v4 MTE user space series[1].
> > > 
> > > [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
> > > 
> > > Posting as an RFC as I'd like feedback on the approach taken. First a
> > > little background on how MTE fits within the architecture:
> > > 
> > > The stage 2 page tables have limited scope for controlling the
> > > availability of MTE. If a page is mapped as Normal and cached in stage 2
> > > then it's the stage 1 tables that get to choose whether the memory is
> > > tagged or not. So the only way of forbidding tags on a page from the
> > > hypervisor is to change the cacheability (or make it device memory)
> > > which would cause other problems.  Note this restriction fits the
> > > intention that a system should have all (general purpose) memory
> > > supporting tags if it support MTE, so it's not too surprising.
> > > 
> > > However, the upshot of this is that to enable MTE within a guest all
> > > pages of memory mapped into the guest as normal cached pages in stage 2
> > > *must* support MTE (i.e. we must ensure the tags are appropriately
> > > sanitised and save/restore the tags during swap etc).
> > > 
> > > My current approach is that KVM transparently upgrades any pages
> > > provided by the VMM to be tag-enabled when they are faulted in (i.e.
> > > sets the PG_mte_tagged flag on the page) which has the benefit of
> > > requiring fewer changes in the VMM. However, save/restore of the VM
> > > state still requires the VMM to have a PROT_MTE enabled mapping so that
> > > it can access the tag values. A VMM which 'forgets' to enable PROT_MTE
> > > would lose the tag values when saving/restoring (tags are RAZ/WI when
> > > PROT_MTE isn't set).
> > > 
> > > An alternative approach would be to enforce the VMM provides PROT_MTE
> > > memory in the first place. This seems appealing to prevent the above
> > > potentially unexpected gotchas with save/restore, however this would
> > > also extend to memory that you might not expect to have PROT_MTE (e.g. a
> > > shared frame buffer for an emulated graphics card).
> > 
> > As you mentioned above, if memory is mapped as Normal Cacheable at Stage
> > 2 (whether we use FWB or not), the guest is allowed to turn MTE on via
> > Stage 1. There is no way for KVM to prevent a guest from using MTE other
> > than the big HCR_EL2.ATA knob.
> > 
> > This causes potential issues since we can't guarantee that all the
> > Cacheable memory slots allocated by the VMM support MTE. If they do not,
> > the arch behaviour is "unpredictable". We also can't trust the guest to
> > not enable MTE on such Cacheable mappings.
> 
> Architecturally it seems dodgy to export any address that isn't "normal
> memory" (i.e. with tag storage) to the guest as Normal Cacheable. Although
> I'm a bit worried this might cause a regression in some existing case.

What I had in mind is some persistent memory that may be given to the
guest for direct access. This is allowed to be cacheable (write-back)
but may not have tag storage.

> > On the host kernel, mmap'ing with PROT_MTE is only allowed for anonymous
> > mappings and shmem. So requiring the VMM to always pass PROT_MTE mapped
> > ranges to KVM, irrespective of whether it's guest RAM, emulated device,
> > virtio etc. (as long as they are Cacheable), filters unsafe ranges that
> > may be mapped into guest.
> 
> That would be an easy way of doing the filtering, but it's not clear whether
> PROT_MTE is actually what the VMM wants (it most likely doesn't want to have
> tag checking enabled on the memory in user space).

From the other sub-thread, yeah, we probably don't want to mandate
PROT_MTE because of potential inadvertent tag check faults in the VMM
itself.

> > Note that in the next revision of the MTE patches I'll drop the DT
> > memory nodes checking and rely only on the CPUID information (arch
> > updated promised by the architects).
> > 
> > I see two possible ways to handle this (there may be more):
> > 
> > 1. As in your current patches, assume any Cacheable at Stage 2 can have
> >     MTE enabled at Stage 1. In addition, we need to check whether the
> >     physical memory supports MTE and it could be something simple like
> >     pfn_valid(). Is there a way to reject a memory slot passed by the
> >     VMM?
> 
> Yes pfn_valid() should have been in there. At the moment pfn_to_page() is
> called without any checks.
> 
> The problem with attempting to reject a memory slot is that the memory
> backing that slot can change. So checking at the time the slot is created
> isn't enough (although it might be a useful error checking feature).

But isn't the slot changed as a result of another VMM call? So we could
always have such check in place.

> It's not clear to me what we can do at fault time when we discover the
> memory isn't tag-capable and would have been mapped cacheable other than
> kill the VM.

Indeed, I don't have a better idea other than trying not to get in this
situation.

> > 2. Similar to 1 but instead of checking whether the pfn supports MTE, we
> >     require the VMM to only pass PROT_MTE ranges (filtering already done
> >     by the host kernel). We need a way to reject the slot and return an
> >     error to the VMM.
> > 
> > I think rejecting a slot at the Stage 2 fault time is very late. You
> > probably won't be able to do much other than killing the guest.
> 
> As above, we will struggle to catch all cases during slot creation, so I
> think we're going to have to deal with this late detection as well.

We can leave it in place as a safety check, killing the VM. My hope is
that we can detect slot creation subsequent changes.

> > Both 1 and 2 above risk breaking existing VMMs just because they happen
> > to start on an MTE-capable machine. So, can we also require the VMM to
> > explicitly opt in to MTE support in guests via some ioctl()? This in
> > turn would enable the additional checks in KVM for the MTE capability of
> > the memory slots (1 or 2 above).
> 
> Patch 2 introduces a VCPU feature which must be explicitly enabled for the
> guest to have MTE. So it won't break existing VMMs. However clearly simply
> setting that bit will likely break some configurations where not all memory
> is MTE capable.

Ah, I missed that. At least we won't break current, unaware VMMs. I
suspect the CPUID is also conditioned by this explicit enabling.

> > An alternative to an MTE enable ioctl(), if all the memory slots are set
> > up prior to the VM starting, KVM could check 1 or 2 above and decide
> > whether to expose MTE to guests (HCR_EL2.ATA).
> 
> The VMM needs to be fully aware of MTE before it's enabled by KVM otherwise
> it could lose the tags (e.g. during migration). So my preference is to make
> it an explicit opt-in.

I agree.

-- 
Catalin
