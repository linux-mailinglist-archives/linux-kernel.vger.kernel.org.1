Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0075F2D162B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgLGQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgLGQec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:32 -0500
Date:   Mon, 7 Dec 2020 16:34:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201207163405.GD1526@gaia>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0eb6da6a11f76d10e532c157181985@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:05:55PM +0000, Marc Zyngier wrote:
> On 2020-12-07 15:45, Steven Price wrote:
> > On 07/12/2020 15:27, Peter Maydell wrote:
> > > On Mon, 7 Dec 2020 at 14:48, Steven Price <steven.price@arm.com>
> > > wrote:
> > > > Sounds like you are making good progress - thanks for the
> > > > update. Have
> > > > you thought about how the PROT_MTE mappings might work if QEMU itself
> > > > were to use MTE? My worry is that we end up with MTE in a guest
> > > > preventing QEMU from using MTE itself (because of the PROT_MTE
> > > > mappings). I'm hoping QEMU can wrap its use of guest memory in a
> > > > sequence which disables tag checking (something similar will be
> > > > needed
> > > > for the "protected VM" use case anyway), but this isn't
> > > > something I've
> > > > looked into.
> > > 
> > > It's not entirely the same as the "protected VM" case. For that
> > > the patches currently on list basically special case "this is a
> > > debug access (eg from gdbstub/monitor)" which then either gets
> > > to go via "decrypt guest RAM for debug" or gets failed depending
> > > on whether the VM has a debug-is-ok flag enabled. For an MTE
> > > guest the common case will be guests doing standard DMA operations
> > > to or from guest memory. The ideal API for that from QEMU's
> > > point of view would be "accesses to guest RAM don't do tag
> > > checks, even if tag checks are enabled for accesses QEMU does to
> > > memory it has allocated itself as a normal userspace program".
> > 
> > Sorry, I know I simplified it rather by saying it's similar to
> > protected VM. Basically as I see it there are three types of memory
> > access:
> > 
> > 1) Debug case - has to go via a special case for decryption or
> > ignoring the MTE tag value. Hopefully this can be abstracted in the
> > same way.
> > 
> > 2) Migration - for a protected VM there's likely to be a special
> > method to allow the VMM access to the encrypted memory (AFAIK memory
> > is usually kept inaccessible to the VMM). For MTE this again has to be
> > special cased as we actually want both the data and the tag values.
> > 
> > 3) Device DMA - for a protected VM it's usual to unencrypt a small
> > area of memory (with the permission of the guest) and use that as a
> > bounce buffer. This is possible with MTE: have an area the VMM
> > purposefully maps with PROT_MTE. The issue is that this has a
> > performance overhead and we can do better with MTE because it's
> > trivial for the VMM to disable the protection for any memory.
> > 
> > The part I'm unsure on is how easy it is for QEMU to deal with (3)
> > without the overhead of bounce buffers. Ideally there'd already be a
> > wrapper for guest memory accesses and that could just be wrapped with
> > setting TCO during the access. I suspect the actual situation is more
> > complex though, and I'm hoping Haibo's investigations will help us
> > understand this.
> 
> What I'd really like to see is a description of how shared memory
> is, in general, supposed to work with MTE. My gut feeling is that
> it doesn't, and that you need to turn MTE off when sharing memory
> (either implicitly or explicitly).

The allocation tag (in-memory tag) is a property assigned to a physical
address range and it can be safely shared between different processes as
long as they access it via pointers with the same allocation tag (bits
59:56). The kernel enables such tagged shared memory for user processes
(anonymous, tmpfs, shmem).

What we don't have in the architecture is a memory type which allows
access to tags but no tag checking. To access the data when the tags
aren't known, the tag checking would have to be disabled via either a
prctl() or by setting the PSTATE.TCO bit.

The kernel accesses the user memory via the linear map using a match-all
tag 0xf, so no TCO bit toggling. For user, however, we disabled such
match-all tag and it cannot be enabled at run-time (at least not easily,
it's cached in the TLB). However, we already have two modes to disable
tag checking which Qemu could use when migrating data+tags.

-- 
Catalin
