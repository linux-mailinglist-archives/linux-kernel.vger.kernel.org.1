Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92B2DB080
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgLOPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgLOPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:49:41 -0500
Date:   Tue, 15 Dec 2020 12:49:12 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047339;
        bh=hQWBfb34VwAQSKPBybevZ59zA41jZn9n/gugqJlTxeM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=X23lY88NAT8rfsuIQBggXbe0YCb/RgF81KAZlGYqnNz2iJ71OxyWdt3orRYa6mavB
         6dQ5YUjOtIJQAUmXzKCRz1f+y3QIp9vlV9ispxlyxsuYEPttMAVt4SQOklcgcqz/Up
         2UWzmGQZrULNsef2a48eQkhdL570H1nm2CIj0kc/TVXoNtTOKLKoedg3+52HFpzl2L
         PSfTMxTBQeh1FdpYfqT12KMK0z8sE8lZ/jwvJlDI+fN+/OXIsd1Aqn0cSLSbMQSVSo
         Gj1H/4l18aGkg2pFLhgFak0QNo8MGNPjwmFX1i5PiOLavbStcVHh8+UBVNJTdjDm3z
         L9YxaFOJy/fRA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 01/15] bpf: Move stack_map_get_build_id into lib
Message-ID: <20201215154912.GJ258566@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214105457.543111-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 11:54:43AM +0100, Jiri Olsa escreveu:
> Moving stack_map_get_build_id into lib with
> declaration in linux/buildid.h header:
> 
>   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> 
> This function returns build id for given struct vm_area_struct.
> There is no functional change to stack_map_get_build_id function.

Alexei, if you're ok with this, can you please process it? Linus will
find strange if I send kernel bits, as we agreed that my tools pull
requests would be just for tooling.

- Arnaldo
 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/buildid.h |  11 ++++
>  kernel/bpf/stackmap.c   | 143 ++--------------------------------------
>  lib/Makefile            |   3 +-
>  lib/buildid.c           | 136 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+), 140 deletions(-)
>  create mode 100644 include/linux/buildid.h
>  create mode 100644 lib/buildid.c
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> new file mode 100644
> index 000000000000..08028a212589
> --- /dev/null
> +++ b/include/linux/buildid.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_BUILDID_H
> +#define _LINUX_BUILDID_H
> +
> +#include <linux/mm_types.h>
> +
> +#define BUILD_ID_SIZE_MAX 20
> +
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> +
> +#endif
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 06065fa27124..d21512fbfa9a 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -7,10 +7,9 @@
>  #include <linux/kernel.h>
>  #include <linux/stacktrace.h>
>  #include <linux/perf_event.h>
> -#include <linux/elf.h>
> -#include <linux/pagemap.h>
>  #include <linux/irq_work.h>
>  #include <linux/btf_ids.h>
> +#include <linux/buildid.h>
>  #include "percpu_freelist.h"
>  
>  #define STACK_CREATE_FLAG_MASK					\
> @@ -153,140 +152,6 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
>  	return ERR_PTR(err);
>  }
>  
> -#define BPF_BUILD_ID 3
> -/*
> - * Parse build id from the note segment. This logic can be shared between
> - * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
> - * identical.
> - */
> -static inline int stack_map_parse_build_id(void *page_addr,
> -					   unsigned char *build_id,
> -					   void *note_start,
> -					   Elf32_Word note_size)
> -{
> -	Elf32_Word note_offs = 0, new_offs;
> -
> -	/* check for overflow */
> -	if (note_start < page_addr || note_start + note_size < note_start)
> -		return -EINVAL;
> -
> -	/* only supports note that fits in the first page */
> -	if (note_start + note_size > page_addr + PAGE_SIZE)
> -		return -EINVAL;
> -
> -	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> -		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
> -
> -		if (nhdr->n_type == BPF_BUILD_ID &&
> -		    nhdr->n_namesz == sizeof("GNU") &&
> -		    nhdr->n_descsz > 0 &&
> -		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
> -			memcpy(build_id,
> -			       note_start + note_offs +
> -			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
> -			       nhdr->n_descsz);
> -			memset(build_id + nhdr->n_descsz, 0,
> -			       BPF_BUILD_ID_SIZE - nhdr->n_descsz);
> -			return 0;
> -		}
> -		new_offs = note_offs + sizeof(Elf32_Nhdr) +
> -			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
> -		if (new_offs <= note_offs)  /* overflow */
> -			break;
> -		note_offs = new_offs;
> -	}
> -	return -EINVAL;
> -}
> -
> -/* Parse build ID from 32-bit ELF */
> -static int stack_map_get_build_id_32(void *page_addr,
> -				     unsigned char *build_id)
> -{
> -	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
> -	Elf32_Phdr *phdr;
> -	int i;
> -
> -	/* only supports phdr that fits in one page */
> -	if (ehdr->e_phnum >
> -	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> -		return -EINVAL;
> -
> -	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
> -
> -	for (i = 0; i < ehdr->e_phnum; ++i) {
> -		if (phdr[i].p_type == PT_NOTE &&
> -		    !stack_map_parse_build_id(page_addr, build_id,
> -					      page_addr + phdr[i].p_offset,
> -					      phdr[i].p_filesz))
> -			return 0;
> -	}
> -	return -EINVAL;
> -}
> -
> -/* Parse build ID from 64-bit ELF */
> -static int stack_map_get_build_id_64(void *page_addr,
> -				     unsigned char *build_id)
> -{
> -	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
> -	Elf64_Phdr *phdr;
> -	int i;
> -
> -	/* only supports phdr that fits in one page */
> -	if (ehdr->e_phnum >
> -	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
> -		return -EINVAL;
> -
> -	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
> -
> -	for (i = 0; i < ehdr->e_phnum; ++i) {
> -		if (phdr[i].p_type == PT_NOTE &&
> -		    !stack_map_parse_build_id(page_addr, build_id,
> -					      page_addr + phdr[i].p_offset,
> -					      phdr[i].p_filesz))
> -			return 0;
> -	}
> -	return -EINVAL;
> -}
> -
> -/* Parse build ID of ELF file mapped to vma */
> -static int stack_map_get_build_id(struct vm_area_struct *vma,
> -				  unsigned char *build_id)
> -{
> -	Elf32_Ehdr *ehdr;
> -	struct page *page;
> -	void *page_addr;
> -	int ret;
> -
> -	/* only works for page backed storage  */
> -	if (!vma->vm_file)
> -		return -EINVAL;
> -
> -	page = find_get_page(vma->vm_file->f_mapping, 0);
> -	if (!page)
> -		return -EFAULT;	/* page not mapped */
> -
> -	ret = -EINVAL;
> -	page_addr = kmap_atomic(page);
> -	ehdr = (Elf32_Ehdr *)page_addr;
> -
> -	/* compare magic x7f "ELF" */
> -	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
> -		goto out;
> -
> -	/* only support executable file and shared object file */
> -	if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN)
> -		goto out;
> -
> -	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
> -		ret = stack_map_get_build_id_32(page_addr, build_id);
> -	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
> -		ret = stack_map_get_build_id_64(page_addr, build_id);
> -out:
> -	kunmap_atomic(page_addr);
> -	put_page(page);
> -	return ret;
> -}
> -
>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  					  u64 *ips, u32 trace_nr, bool user)
>  {
> @@ -327,18 +192,18 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  		for (i = 0; i < trace_nr; i++) {
>  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>  			id_offs[i].ip = ips[i];
> -			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
> +			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>  		}
>  		return;
>  	}
>  
>  	for (i = 0; i < trace_nr; i++) {
>  		vma = find_vma(current->mm, ips[i]);
> -		if (!vma || stack_map_get_build_id(vma, id_offs[i].build_id)) {
> +		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
>  			/* per entry fall back to ips */
>  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>  			id_offs[i].ip = ips[i];
> -			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
> +			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>  			continue;
>  		}
>  		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a..f4858f5e9215 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -36,7 +36,8 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 flex_proportions.o ratelimit.o show_mem.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
> -	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
> +	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
> +	 buildid.o
>  
>  lib-$(CONFIG_PRINTK) += dump_stack.o
>  lib-$(CONFIG_SMP) += cpumask.o
> diff --git a/lib/buildid.c b/lib/buildid.c
> new file mode 100644
> index 000000000000..4a4f520c0e29
> --- /dev/null
> +++ b/lib/buildid.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/buildid.h>
> +#include <linux/elf.h>
> +#include <linux/pagemap.h>
> +
> +#define BUILD_ID 3
> +/*
> + * Parse build id from the note segment. This logic can be shared between
> + * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
> + * identical.
> + */
> +static inline int parse_build_id(void *page_addr,
> +				 unsigned char *build_id,
> +				 void *note_start,
> +				 Elf32_Word note_size)
> +{
> +	Elf32_Word note_offs = 0, new_offs;
> +
> +	/* check for overflow */
> +	if (note_start < page_addr || note_start + note_size < note_start)
> +		return -EINVAL;
> +
> +	/* only supports note that fits in the first page */
> +	if (note_start + note_size > page_addr + PAGE_SIZE)
> +		return -EINVAL;
> +
> +	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> +		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
> +
> +		if (nhdr->n_type == BUILD_ID &&
> +		    nhdr->n_namesz == sizeof("GNU") &&
> +		    nhdr->n_descsz > 0 &&
> +		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
> +			memcpy(build_id,
> +			       note_start + note_offs +
> +			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
> +			       nhdr->n_descsz);
> +			memset(build_id + nhdr->n_descsz, 0,
> +			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +			return 0;
> +		}
> +		new_offs = note_offs + sizeof(Elf32_Nhdr) +
> +			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
> +		if (new_offs <= note_offs)  /* overflow */
> +			break;
> +		note_offs = new_offs;
> +	}
> +	return -EINVAL;
> +}
> +
> +/* Parse build ID from 32-bit ELF */
> +static int get_build_id_32(void *page_addr, unsigned char *build_id)
> +{
> +	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
> +	Elf32_Phdr *phdr;
> +	int i;
> +
> +	/* only supports phdr that fits in one page */
> +	if (ehdr->e_phnum >
> +	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> +		return -EINVAL;
> +
> +	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
> +
> +	for (i = 0; i < ehdr->e_phnum; ++i) {
> +		if (phdr[i].p_type == PT_NOTE &&
> +		    !parse_build_id(page_addr, build_id,
> +				    page_addr + phdr[i].p_offset,
> +				    phdr[i].p_filesz))
> +			return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +/* Parse build ID from 64-bit ELF */
> +static int get_build_id_64(void *page_addr, unsigned char *build_id)
> +{
> +	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
> +	Elf64_Phdr *phdr;
> +	int i;
> +
> +	/* only supports phdr that fits in one page */
> +	if (ehdr->e_phnum >
> +	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
> +		return -EINVAL;
> +
> +	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
> +
> +	for (i = 0; i < ehdr->e_phnum; ++i) {
> +		if (phdr[i].p_type == PT_NOTE &&
> +		    !parse_build_id(page_addr, build_id,
> +				    page_addr + phdr[i].p_offset,
> +				    phdr[i].p_filesz))
> +			return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +/* Parse build ID of ELF file mapped to vma */
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
> +{
> +	Elf32_Ehdr *ehdr;
> +	struct page *page;
> +	void *page_addr;
> +	int ret;
> +
> +	/* only works for page backed storage  */
> +	if (!vma->vm_file)
> +		return -EINVAL;
> +
> +	page = find_get_page(vma->vm_file->f_mapping, 0);
> +	if (!page)
> +		return -EFAULT;	/* page not mapped */
> +
> +	ret = -EINVAL;
> +	page_addr = kmap_atomic(page);
> +	ehdr = (Elf32_Ehdr *)page_addr;
> +
> +	/* compare magic x7f "ELF" */
> +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
> +		goto out;
> +
> +	/* only support executable file and shared object file */
> +	if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN)
> +		goto out;
> +
> +	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
> +		ret = get_build_id_32(page_addr, build_id);
> +	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
> +		ret = get_build_id_64(page_addr, build_id);
> +out:
> +	kunmap_atomic(page_addr);
> +	put_page(page);
> +	return ret;
> +}
> -- 
> 2.26.2
> 

-- 

- Arnaldo
