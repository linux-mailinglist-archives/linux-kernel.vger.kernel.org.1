Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23523298174
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415402AbgJYLX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 07:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415395AbgJYLXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 07:23:25 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5205E222E8;
        Sun, 25 Oct 2020 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603625004;
        bh=wsyWi0whkTqHhXLDxOJJ5R69Qo3xgR/xs/zAJvhAmm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5/5E1gYP0gcNcUMnlMimgW0cncit8L8M4+u7oLANwVVnyuDQsCS7AP3xnKg4bW/W
         61gfWW4S6WpPYXWkCwRp2Ws5Z1Ve+jqtaLGapdYlZJYE0RkRfncrVaDukL0dXUNInk
         y6Cqg/97uoPHs+41euzYx6CV0IrfK1SXNS2iC6C8=
Date:   Sun, 25 Oct 2020 13:23:16 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201025112316.GF392079@kernel.org>
References: <20201002110917.4227-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002110917.4227-1-toiwoton@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:09:17PM +0300, Topi Miettinen wrote:
> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> enables full randomization of memory mappings created with mmap(NULL,
> ...). With 2, the base of the VMA used for such mappings is random,
> but the mappings are created in predictable places within the VMA and
> in sequential order. With 3, new VMAs are created to fully randomize
> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> even if not necessary.
> 
> On 32 bit systems this may cause problems due to increased VM
> fragmentation if the address space gets crowded.
> 
> In this example, with value of 2, ld.so.cache, libc, an anonymous mmap
> and locale-archive are located close to each other:
> $ strace /bin/sync
> ...
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
> mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e7f2000
> ...
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7d9c1e7f0000
> mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7d9c1e62b000
> ...
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
> mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e0c9000
> 
> With 3, they are located in unrelated addresses:
> $ echo 3 > /proc/sys/kernel/randomize_va_space
> $ /bin/sync
> ...
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
> mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0xeda4fbea000
> ...
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb8fb9c1d000
> mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xaabd8598000
> ...
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
> mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbe351ab8000

Nit: this can be better illustrated with /proc/$pid/maps

> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> v2: also randomize mremap(..., MREMAP_MAYMOVE)
> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst |  6 +++---
>  Documentation/admin-guide/sysctl/kernel.rst   | 11 +++++++++++
>  init/Kconfig                                  |  2 +-
>  mm/mmap.c                                     |  7 ++++++-
>  mm/mremap.c                                   | 15 +++++++++++++++
>  5 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index e05e581af5cf..9ea250522077 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -254,7 +254,7 @@ Spectre variant 2
>     left by the previous process will also be cleared.
>  
>     User programs should use address space randomization to make attacks
> -   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
> +   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
>  
>  3. A virtualized guest attacking the host
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -499,8 +499,8 @@ Spectre variant 2
>     more overhead and run slower.
>  
>     User programs should use address space randomization
> -   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
> -   difficult.
> +   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
> +   more difficult.
>  
>  3. VM mitigation
>  ^^^^^^^^^^^^^^^^
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index d4b32cc32bb7..acd0612155d9 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1060,6 +1060,17 @@ that support this feature.
>      Systems with ancient and/or broken binaries should be configured
>      with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
>      address space randomization.
> +
> +3   Additionally enable full randomization of memory mappings created
> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
> +    mappings is random, but the mappings are created in predictable
> +    places within the VMA and in sequential order. With 3, new VMAs
> +    are created to fully randomize the mappings. Also mremap(...,
> +    MREMAP_MAYMOVE) will move the mappings even if not necessary.
> +
> +    On 32 bit systems this may cause problems due to increased VM
> +    fragmentation if the address space gets crowded.
> +
>  ==  ===========================================================================
>  
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index d6a0b31b13dc..c5ea2e694f6a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1859,7 +1859,7 @@ config COMPAT_BRK
>  	  also breaks ancient binaries (including anything libc5 based).
>  	  This option changes the bootup default to heap randomization
>  	  disabled, and can be overridden at runtime by setting
> -	  /proc/sys/kernel/randomize_va_space to 2.
> +	  /proc/sys/kernel/randomize_va_space to 2 or 3.
>  
>  	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 40248d84ad5f..489368f43af1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
> +#include <linux/elf-randomize.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
> @@ -206,7 +207,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  #ifdef CONFIG_COMPAT_BRK
>  	/*
>  	 * CONFIG_COMPAT_BRK can still be overridden by setting
> -	 * randomize_va_space to 2, which will still cause mm->start_brk
> +	 * randomize_va_space to >= 2, which will still cause mm->start_brk
>  	 * to be arbitrarily shifted
>  	 */
>  	if (current->brk_randomized)
> @@ -1407,6 +1408,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (mm->map_count > sysctl_max_map_count)
>  		return -ENOMEM;
>  
> +	/* Pick a random address even outside current VMAs? */
> +	if (!addr && randomize_va_space >= 3)
> +		addr = arch_mmap_rnd();
> +
>  	/* Obtain the address to map to. we verify (or select) it and ensure
>  	 * that it represents a valid section of the address space.
>  	 */
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 138abbae4f75..c7fd1ab5fb5f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -24,6 +24,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/mm-arch-hooks.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/elf-randomize.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> @@ -720,6 +721,20 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>  
> +	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
> +		/*
> +		 * Caller is happy with a different address, so let's
> +		 * move even if not necessary!
> +		 */
> +		new_addr = arch_mmap_rnd();
> +
> +		ret = mremap_to(addr, old_len, new_addr, new_len,
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
> +		goto out;
> +	}
> +
> +
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..
> -- 
> 2.28.0
> 
> 

-- 
Sincerely yours,
Mike.
