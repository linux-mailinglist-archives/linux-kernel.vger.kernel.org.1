Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33D02CFAAF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgLEItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:49:23 -0500
Received: from verein.lst.de ([213.95.11.211]:36902 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgLEIsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:48:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D673B6736F; Sat,  5 Dec 2020 09:48:04 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:48:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@lst.de,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc/mm: Fix KUAP warning by providing
 copy_from_kernel_nofault_allowed()
Message-ID: <20201205084804.GA25452@lst.de>
References: <e559e60c43f679195bfe4c7b0a301431c6f02c7a.1607157766.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e559e60c43f679195bfe4c7b0a301431c6f02c7a.1607157766.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 08:43:06AM +0000, Christophe Leroy wrote:
> Since commit c33165253492 ("powerpc: use non-set_fs based maccess
> routines"), userspace access is not granted anymore when using
> copy_from_kernel_nofault()
> 
> However, kthread_probe_data() uses copy_from_kernel_nofault()
> to check validity of pointers. When the pointer is NULL,
> it points to userspace, leading to a KUAP fault and triggering
> the following big hammer warning many times when you request
> a sysrq "show task":



> To avoid that, copy_from_kernel_nofault_allowed() is used to check
> whether the address is a valid kernel address. But the default
> version of it returns true for any address.
> 
> Provide a powerpc version of copy_from_kernel_nofault_allowed()
> that returns false when the address is below TASK_USER_MAX,
> so that copy_from_kernel_nofault() will return -ERANGE.

Looks good.  I wonder if we should just default to the TASK_SIZE_MAX
check in  copy_from_kernel_nofault_allowed for architectures that select
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?

> 
> Reported-by: Qian Cai <qcai@redhat.com>
> Fixes: c33165253492 ("powerpc: use non-set_fs based maccess routines")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> This issue was introduced in 5.10. I didn't mark it for stable, hopping it will go into 5.10-rc7
> ---
>  arch/powerpc/mm/Makefile  | 2 +-
>  arch/powerpc/mm/maccess.c | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/mm/maccess.c
> 
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 5e147986400d..55b4a8bd408a 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -5,7 +5,7 @@
>  
>  ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>  
> -obj-y				:= fault.o mem.o pgtable.o mmap.o \
> +obj-y				:= fault.o mem.o pgtable.o mmap.o maccess.o \
>  				   init_$(BITS).o pgtable_$(BITS).o \
>  				   pgtable-frag.o ioremap.o ioremap_$(BITS).o \
>  				   init-common.o mmu_context.o drmem.o
> diff --git a/arch/powerpc/mm/maccess.c b/arch/powerpc/mm/maccess.c
> new file mode 100644
> index 000000000000..56e97c0fb233
> --- /dev/null
> +++ b/arch/powerpc/mm/maccess.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/uaccess.h>
> +#include <linux/kernel.h>
> +
> +bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
> +{
> +	return (unsigned long)unsafe_src >= TASK_SIZE_MAX;
> +}
> -- 
> 2.25.0
---end quoted text---
