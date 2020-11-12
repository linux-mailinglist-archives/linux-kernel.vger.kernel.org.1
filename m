Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F532B01EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKLJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgKLJ0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:26:05 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180BF221FE;
        Thu, 12 Nov 2020 09:26:00 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:25:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
Message-ID: <20201112092558.GC29613@gaia>
References: <20201014081857.3288-1-ardb@kernel.org>
 <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
 <a330440d-803b-5aa2-0092-a18317819850@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a330440d-803b-5aa2-0092-a18317819850@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, Nov 11, 2020 at 09:18:56AM +0530, Anshuman Khandual wrote:
> On 11/11/20 12:44 AM, Catalin Marinas wrote:
> > On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
> >> As a hardening measure, we currently randomize the placement of
> >> physical memory inside the linear region when KASLR is in effect.
> >> Since the random offset at which to place the available physical
> >> memory inside the linear region is chosen early at boot, it is
> >> based on the memblock description of memory, which does not cover
> >> hotplug memory. The consequence of this is that the randomization
> >> offset may be chosen such that any hotplugged memory located above
> >> memblock_end_of_DRAM() that appears later is pushed off the end of
> >> the linear region, where it cannot be accessed.
> >>
> >> [...]
> > 
> > Applied to arm64 (for-next/mem-hotplug), thanks!
> > 
> > [1/1] arm64: mm: account for hotplug memory when randomizing the linear region
> >       https://git.kernel.org/arm64/c/97d6786e0669
> 
> Got delayed and never made here in time, sorry about that. Nonetheless,
> I have got something working with respect to the generic mechanism that
> David Hildenbrand had asked for earlier.
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/

There was a lot of discussion around this patch but I haven't seen any
new version posted.

> I am wondering if we could instead consider merging the above patch with
> a small change that Ard had pointed out earlier [1], I will send out a
> revision if required.

If your patch fixes the randomisation issue that Ard addressed, I'm
happy to replace that with your patch. But please post a new version and
get some acks in place from the parties involved in the discussion.

Thanks.

-- 
Catalin
