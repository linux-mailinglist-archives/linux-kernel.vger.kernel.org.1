Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1821E287249
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgJHKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbgJHKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:12:16 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8312145D;
        Thu,  8 Oct 2020 10:12:12 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:12:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jann Horn <jannh@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
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
Message-ID: <20201008101209.GD7661@gaia>
References: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> arch_validate_prot() is a hook that can validate whether a given set of
> protection flags is valid in an mprotect() operation. It is given the set
> of protection flags and the address being modified.
> 
> However, the address being modified can currently not actually be used in
> a meaningful way because:
> 
> 1. Only the address is given, but not the length, and the operation can
>    span multiple VMAs. Therefore, the callee can't actually tell which
>    virtual address range, or which VMAs, are being targeted.
> 2. The mmap_lock is not held, meaning that if the callee were to check
>    the VMA at @addr, that VMA would be unrelated to the one the
>    operation is performed on.
> 
> Currently, custom arch_validate_prot() handlers are defined by
> arm64, powerpc and sparc.
> arm64 and powerpc don't care about the address range, they just check the
> flags against CPU support masks.
> sparc's arch_validate_prot() attempts to look at the VMA, but doesn't take
> the mmap_lock.
> 
> Change the function signature to also take a length, and move the
> arch_validate_prot() call in mm/mprotect.c down into the locked region.

For arm64 mte, I noticed the arch_validate_prot() issue with multiple
vmas and addressed this in a different way:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/mte&id=c462ac288f2c97e0c1d9ff6a65955317e799f958
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/mte&id=0042090548740921951f31fc0c20dcdb96638cb0

Both patches queued for 5.10.

Basically, arch_calc_vm_prot_bits() returns a VM_MTE if PROT_MTE has
been requested. The newly introduced arch_validate_flags() will check
the VM_MTE flag against what the system supports and this covers both
mmap() and mprotect(). Note that arch_validate_prot() only handles the
latter and I don't think it's sufficient for SPARC ADI. For arm64 MTE we
definitely wanted mmap() flags to be validated.

In addition, there's a new arch_calc_vm_flag_bits() which allows us to
set a VM_MTE_ALLOWED on a vma if the conditions are right (MAP_ANONYMOUS
or shmem_mmap():

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/mte&id=b3fbbea4c00220f62e6f7e2514466e6ee81f7f60

-- 
Catalin
