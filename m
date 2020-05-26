Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D431D4578
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEOFzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:55:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgEOFzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589522120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+aB1CA1Otl268pO9Az/r7NFdoYXk7JXT4NW4PKxozs=;
        b=Y8jOUBhhP81UFNz5Tm3S5c1+ji7+BPVh/83HH4UuFhp7Y7ahLRbutG5HzqopRGpBkN3H10
        N1mNLo3hoUKoZdoifZe7KetJb/8IYg5w+vlHpyuG8eLqQdpENYGi8wYn/z1zHSBlMhu3wC
        7XRFPbjZg0MIluGEbvHtgs2clAzlaeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-WogNCXuSNt2yBD9bCkrbwA-1; Fri, 15 May 2020 01:55:16 -0400
X-MC-Unique: WogNCXuSNt2yBD9bCkrbwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D8BC464;
        Fri, 15 May 2020 05:55:14 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD27360BE2;
        Fri, 15 May 2020 05:55:12 +0000 (UTC)
Date:   Fri, 15 May 2020 13:55:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        x86@kernel.org, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecomb@intel.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/9] x86: Add support for function granular KASLR
Message-ID: <20200515055509.GA31243@MiWiFi-R3L-srv>
References: <20200415210452.27436-1-kristen@linux.intel.com>
 <20200415210452.27436-8-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415210452.27436-8-kristen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/20 at 02:04pm, Kristen Carlson Accardi wrote:
...
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 9652d5c2afda..2e108fdc7757 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -26,9 +26,6 @@
>   * it is not safe to place pointers in static structures.
>   */
>  
> -/* Macros used by the included decompressor code below. */
> -#define STATIC		static
> -

Here removing STATIC definition might be the reason why the LKP
reported build error to patch 7/9.

>  /*
>   * Use normal definitions of mem*() from string.c. There are already
>   * included header files which expect a definition of memset() and by
> @@ -49,6 +46,8 @@ struct boot_params *boot_params;
>  
>  memptr free_mem_ptr;
>  memptr free_mem_end_ptr;
> +unsigned long malloc_ptr;
> +int malloc_count;
>  
>  static char *vidmem;
>  static int vidport;
> @@ -203,10 +202,20 @@ static void handle_relocations(void *output, unsigned long output_len,
>  	if (IS_ENABLED(CONFIG_X86_64))
>  		delta = virt_addr - LOAD_PHYSICAL_ADDR;
>  
> -	if (!delta) {
> -		debug_putstr("No relocation needed... ");
> -		return;
> +	/*
> +	 * it is possible to have delta be zero and
> +	 * still have enabled fg kaslr. We need to perform relocations
> +	 * for fgkaslr regardless of whether the base address has moved.
> +	 */
> +	if (!IS_ENABLED(CONFIG_FG_KASLR) || nokaslr) {
> +		if (!delta) {
> +			debug_putstr("No relocation needed... ");
> +			return;
> +		}
>  	}
> +
> +	pre_relocations_cleanup(map);
> +
>  	debug_putstr("Performing relocations... ");

I testes this patchset on x86_64 machine, it works well. Seems the
debug printing need a little bit adjustment.

-  	debug_putstr("Performing relocations... ");
+  	debug_putstr("\nPerforming relocations... ");

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Decompressing Linux... Parsing ELF... 
Parsing ELF section headers... 
Looking for symbols... 
Re-sorting kallsyms ...Performing relocations... 
                       ~~~~~~~~^
Updating exception table...

Re-sorting exception table...

>  
>  	/*
> @@ -230,35 +239,106 @@ static void handle_relocations(void *output, unsigned long output_len,
>  	 */
>  	for (reloc = output + output_len - sizeof(*reloc); *reloc; reloc--) {
>  		long extended = *reloc;
> +		long value;
> +
> +		/*
> +		 * if using fgkaslr, we might have moved the address
> +		 * of the relocation. Check it to see if it needs adjusting
> +		 * from the original address.
> +		 */
> +		(void) adjust_address(&extended);
> +
>  		extended += map;
>  
>  		ptr = (unsigned long)extended;
>  		if (ptr < min_addr || ptr > max_addr)
>  			error("32-bit relocation outside of kernel!\n");
>  
> -		*(uint32_t *)ptr += delta;
> +		value = *(int32_t *)ptr;
> +
> +		/*
> +		 * If using fgkaslr, the value of the relocation
> +		 * might need to be changed because it referred
> +		 * to an address that has moved.
> +		 */
> +		adjust_address(&value);
> +
> +		value += delta;
> +
> +		*(uint32_t *)ptr = value;
>  	}
>  #ifdef CONFIG_X86_64
>  	while (*--reloc) {
>  		long extended = *reloc;
> +		long value;
> +		long oldvalue;
> +		Elf64_Shdr *s;
> +
> +		/*
> +		 * if using fgkaslr, we might have moved the address
> +		 * of the relocation. Check it to see if it needs adjusting
> +		 * from the original address.
> +		 */
> +		s = adjust_address(&extended);
> +
>  		extended += map;
>  
>  		ptr = (unsigned long)extended;
>  		if (ptr < min_addr || ptr > max_addr)
>  			error("inverse 32-bit relocation outside of kernel!\n");
>  
> -		*(int32_t *)ptr -= delta;
> +		value = *(int32_t *)ptr;
> +		oldvalue = value;
> +
> +		/*
> +		 * If using fgkaslr, these relocs will contain
> +		 * relative offsets which might need to be
> +		 * changed because it referred
> +		 * to an address that has moved.
> +		 */
> +		adjust_relative_offset(*reloc, &value, s);
> +
> +		/*
> +		 * only percpu symbols need to have their values adjusted for
> +		 * base address kaslr since relative offsets within the .text
> +		 * and .text.* sections are ok wrt each other.
> +		 */
> +		if (is_percpu_addr(*reloc, oldvalue))
> +			value -= delta;
> +
> +		*(int32_t *)ptr = value;
>  	}
>  	for (reloc--; *reloc; reloc--) {
>  		long extended = *reloc;
> +		long value;
> +
> +		/*
> +		 * if using fgkaslr, we might have moved the address
> +		 * of the relocation. Check it to see if it needs adjusting
> +		 * from the original address.
> +		 */
> +		(void) adjust_address(&extended);
> +
>  		extended += map;
>  
>  		ptr = (unsigned long)extended;
>  		if (ptr < min_addr || ptr > max_addr)
>  			error("64-bit relocation outside of kernel!\n");
>  
> -		*(uint64_t *)ptr += delta;
> +		value = *(int64_t *)ptr;
> +
> +		/*
> +		 * If using fgkaslr, the value of the relocation
> +		 * might need to be changed because it referred
> +		 * to an address that has moved.
> +		 */
> +		(void) adjust_address(&value);
> +
> +		value += delta;
> +
> +		*(uint64_t *)ptr = value;
>  	}
> +	post_relocations_cleanup(map);
>  #endif
>  }
>  #else
> @@ -296,6 +376,15 @@ static void parse_elf(void *output)
>  
>  	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
>  
> +	if (IS_ENABLED(CONFIG_FG_KASLR)) {
> +		if (!nokaslr) {
> +			parse_sections_headers(output, &ehdr, phdrs);
> +			return;
> +		} else {
> +			warn("FG_KASLR disabled: 'nokaslr' on cmdline.");
> +		}
> +	}
> +
>  	for (i = 0; i < ehdr.e_phnum; i++) {
>  		phdr = &phdrs[i];
>  
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 726e264410ff..f68f7fc39543 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -39,7 +39,12 @@
>  /* misc.c */
>  extern memptr free_mem_ptr;
>  extern memptr free_mem_end_ptr;
> +#define STATIC
> +#define STATIC_RW_DATA extern
> +#include <linux/decompress/mm.h>
> +
>  extern struct boot_params *boot_params;
> +extern int nokaslr;
>  void __putstr(const char *s);
>  void __puthex(unsigned long value);
>  #define error_putstr(__x)  __putstr(__x)
> @@ -74,6 +79,32 @@ struct mem_vector {
>  	unsigned long long size;
>  };
>  
> +#ifdef CONFIG_X86_64
> +#define Elf_Ehdr Elf64_Ehdr
> +#define Elf_Phdr Elf64_Phdr
> +#define Elf_Shdr Elf64_Shdr
> +#else
> +#define Elf_Ehdr Elf32_Ehdr
> +#define Elf_Phdr Elf32_Phdr
> +#define Elf_Shdr Elf32_Shdr
> +#endif
> +
> +#if CONFIG_FG_KASLR
> +void parse_sections_headers(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs);
> +void pre_relocations_cleanup(unsigned long map);
> +void post_relocations_cleanup(unsigned long map);
> +Elf_Shdr *adjust_address(long *address);
> +void adjust_relative_offset(long pc, long *value, Elf_Shdr *section);
> +bool is_percpu_addr(long pc, long offset);
> +#else
> +static inline void parse_sections_headers(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs) { }
> +static inline void pre_relocations_cleanup(unsigned long map) { }
> +static inline void post_relocations_cleanup(unsigned long map) { }
> +static inline Elf_Shdr *adjust_address(long *address) { return NULL; }
> +static inline void adjust_relative_offset(long pc, long *value, Elf_Shdr *section) { }
> +static inline bool is_percpu_addr(long pc, long offset) { return true; }
> +#endif /* CONFIG_FG_KASLR */
> +
>  #if CONFIG_RANDOMIZE_BASE
>  /* kaslr.c */
>  void choose_random_location(unsigned long input,
> diff --git a/arch/x86/boot/compressed/utils.c b/arch/x86/boot/compressed/utils.c
> new file mode 100644
> index 000000000000..ceefc58d7c71
> --- /dev/null
> +++ b/arch/x86/boot/compressed/utils.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * utils.c
> + *
> + * This contains various libraries that are needed for fgkaslr
> + */
> +#define __DISABLE_EXPORTS
> +#define _LINUX_KPROBES_H
> +#define NOKPROBE_SYMBOL(fname)
> +#include "../../../../lib/sort.c"
> +#include "../../../../lib/bsearch.c"
> +
> diff --git a/arch/x86/boot/compressed/vmlinux.symbols b/arch/x86/boot/compressed/vmlinux.symbols
> new file mode 100644
> index 000000000000..f48a4c396966
> --- /dev/null
> +++ b/arch/x86/boot/compressed/vmlinux.symbols
> @@ -0,0 +1,18 @@
> +kallsyms_offsets
> +kallsyms_addresses
> +kallsyms_num_syms
> +kallsyms_relative_base
> +kallsyms_names
> +kallsyms_token_table
> +kallsyms_token_index
> +kallsyms_markers
> +__start___ex_table
> +__stop___ex_table
> +_sinittext
> +_einittext
> +_stext
> +_etext
> +__start_orc_unwind_ip
> +__stop_orc_unwind_ip
> +__stop_orc_unwind
> +__start_orc_unwind
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index 680c320363db..6918d33eb5ef 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -26,8 +26,19 @@
>  
>  #ifdef CONFIG_KERNEL_BZIP2
>  # define BOOT_HEAP_SIZE		0x400000
> -#else /* !CONFIG_KERNEL_BZIP2 */
> -# define BOOT_HEAP_SIZE		 0x10000
> +#elif CONFIG_FG_KASLR
> +/*
> + * We need extra boot heap when using fgkaslr because we make a copy
> + * of the original decompressed kernel to avoid issues with writing
> + * over ourselves when shuffling the sections. We also need extra
> + * space for resorting kallsyms after shuffling. This value could
> + * be decreased if free() would release memory properly, or if we
> + * could avoid the kernel copy. It would need to be increased if we
> + * find additional tables that need to be resorted.
> + */
> +# define BOOT_HEAP_SIZE		0x4000000
> +#else /* !CONFIG_KERNEL_BZIP2 && !CONFIG_FG_KASLR */
> +# define BOOT_HEAP_SIZE		0x10000
>  #endif
>  
>  #ifdef CONFIG_X86_64
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 34c02e4290fe..a85d1792d5a8 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -298,6 +298,7 @@ typedef struct elf64_phdr {
>  #define SHN_LIVEPATCH	0xff20
>  #define SHN_ABS		0xfff1
>  #define SHN_COMMON	0xfff2
> +#define SHN_XINDEX	0xffff
>  #define SHN_HIRESERVE	0xffff
>   
>  typedef struct elf32_shdr {
> -- 
> 2.20.1
> 

