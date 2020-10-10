Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E328A308
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgJJW7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731615AbgJJTyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:15 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E49B22227;
        Sat, 10 Oct 2020 11:09:52 +0000 (UTC)
Date:   Sat, 10 Oct 2020 12:09:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
Message-ID: <20201010110949.GA32545@gaia>
References: <20201007073932.865218-1-jannh@google.com>
 <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khalid,

On Wed, Oct 07, 2020 at 02:14:09PM -0600, Khalid Aziz wrote:
> On 10/7/20 1:39 AM, Jann Horn wrote:
> > arch_validate_prot() is a hook that can validate whether a given set of
> > protection flags is valid in an mprotect() operation. It is given the set
> > of protection flags and the address being modified.
> > 
> > However, the address being modified can currently not actually be used in
> > a meaningful way because:
> > 
> > 1. Only the address is given, but not the length, and the operation can
> >    span multiple VMAs. Therefore, the callee can't actually tell which
> >    virtual address range, or which VMAs, are being targeted.
> > 2. The mmap_lock is not held, meaning that if the callee were to check
> >    the VMA at @addr, that VMA would be unrelated to the one the
> >    operation is performed on.
> > 
> > Currently, custom arch_validate_prot() handlers are defined by
> > arm64, powerpc and sparc.
> > arm64 and powerpc don't care about the address range, they just check the
> > flags against CPU support masks.
> > sparc's arch_validate_prot() attempts to look at the VMA, but doesn't take
> > the mmap_lock.
> > 
> > Change the function signature to also take a length, and move the
> > arch_validate_prot() call in mm/mprotect.c down into the locked region.
[...]
> As Chris pointed out, the call to arch_validate_prot() from do_mmap2()
> is made without holding mmap_lock. Lock is not acquired until
> vm_mmap_pgoff(). This variance is uncomfortable but I am more
> uncomfortable forcing all implementations of validate_prot to require
> mmap_lock be held when non-sparc implementations do not have such need
> yet. Since do_mmap2() is in powerpc specific code, for now this patch
> solves a current problem.

I still think sparc should avoid walking the vmas in
arch_validate_prot(). The core code already has the vmas, though not
when calling arch_validate_prot(). That's one of the reasons I added
arch_validate_flags() with the MTE patches. For sparc, this could be
(untested, just copied the arch_validate_prot() code):

static inline bool arch_validate_flags(unsigned long vm_flags)
{
	if (!(vm_flags & VM_SPARC_ADI))
		return true;

	if (!adi_capable())
		return false;

	/* ADI can not be enabled on PFN mapped pages */
	if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
		return false;

	/*
	 * Mergeable pages can become unmergeable if ADI is enabled on
	 * them even if they have identical data on them. This can be
	 * because ADI enabled pages with identical data may still not
	 * have identical ADI tags on them. Disallow ADI on mergeable
	 * pages.
	 */
	if (vma->vm_flags & VM_MERGEABLE)
		return false;

	return true;
}

> That leaves open the question of should
> generic mmap call arch_validate_prot and return EINVAL for invalid
> combination of protection bits, but that is better addressed in a
> separate patch.

The above would cover mmap() as well.

The current sparc_validate_prot() relies on finding the vma for the
corresponding address. However, if you call this early in the mmap()
path, there's no such vma. It is only created later in mmap_region()
which no longer has the original PROT_* flags (all converted to VM_*
flags).

Calling arch_validate_flags() on mmap() has a small side-effect on the
user ABI: if the CPU is not adi_capable(), PROT_ADI is currently ignored
on mmap() but rejected by sparc_validate_prot(). Powerpc already does
this already and I think it should be fine for arm64 (it needs checking
though as we have another flag, PROT_BTI, hopefully dynamic loaders
don't pass this flag unconditionally).

However, as I said above, it doesn't solve the mmap() PROT_ADI checking
for sparc since there's no vma yet. I'd strongly recommend the
arch_validate_flags() approach and reverting the "start" parameter added
to arch_validate_prot() if you go for the flags route.

Thanks.

-- 
Catalin
