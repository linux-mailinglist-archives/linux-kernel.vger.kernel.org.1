Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0202CDEDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgLCT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgLCT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607023487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxyrHWJOsmfjpDDJjvbpfuq1IKoXs24Zs2aC+OePWR8=;
        b=B72hUV2lIvdDvUo0f9YNFm9w9eQ30wfz2bkwnc5y22U1xIT3gJRQkIlqma7gyrXmrSxma4
        j6HZufHAtZpAg/eB+8ZtscFQrksDlreaNE6mMg0V2ebbAlBFzKeYXcVfLUinVHjoOKom93
        h0rBmYaSbCQTwZUZjGszp0X71Gqp2cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-bz9-6GunP-yvFOefD-ptDA-1; Thu, 03 Dec 2020 14:24:45 -0500
X-MC-Unique: bz9-6GunP-yvFOefD-ptDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA0D1005504;
        Thu,  3 Dec 2020 19:24:42 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 262256085A;
        Thu,  3 Dec 2020 19:24:38 +0000 (UTC)
Date:   Thu, 3 Dec 2020 20:24:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/25] bpf: Add size arg to build_id_parse function
Message-ID: <20201203192438.GA3613628@krava>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-3-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 06:00:03PM +0100, Jiri Olsa wrote:
> It's possible to have other build id types (other than default SHA1).
> Currently there's also ld support for MD5 build id.
> 
> Adding size argument to build_id_parse function, that returns (if defined)
> size of the parsed build id, so we can recognize the build id type.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>

Alexei, Song,
could you guys please check on this one?

thanks,
jirka


> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/buildid.h |  3 ++-
>  kernel/bpf/stackmap.c   |  2 +-
>  lib/buildid.c           | 29 +++++++++++++++++++++--------
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3be5b49719f1..72639d433873 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -6,6 +6,7 @@
>  
>  #define BUILD_ID_SIZE 20
>  
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +		   __u32 *size);
>  
>  #endif
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 7df08f8af5a1..a05fac2cbb05 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -199,7 +199,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  
>  	for (i = 0; i < trace_nr; i++) {
>  		vma = find_vma(current->mm, ips[i]);
> -		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
> +		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>  			/* per entry fall back to ips */
>  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>  			id_offs[i].ip = ips[i];
> diff --git a/lib/buildid.c b/lib/buildid.c
> index e8d5feb7ef20..dbe1b7e247f3 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -12,6 +12,7 @@
>   */
>  static inline int parse_build_id(void *page_addr,
>  				 unsigned char *build_id,
> +				 __u32 *size,
>  				 void *note_start,
>  				 Elf32_Word note_size)
>  {
> @@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
>  			       nhdr->n_descsz);
>  			memset(build_id + nhdr->n_descsz, 0,
>  			       BUILD_ID_SIZE - nhdr->n_descsz);
> +			if (size)
> +				*size = nhdr->n_descsz;
>  			return 0;
>  		}
>  		new_offs = note_offs + sizeof(Elf32_Nhdr) +
> @@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
>  }
>  
>  /* Parse build ID from 32-bit ELF */
> -static int get_build_id_32(void *page_addr, unsigned char *build_id)
> +static int get_build_id_32(void *page_addr, unsigned char *build_id,
> +			   __u32 *size)
>  {
>  	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
>  	Elf32_Phdr *phdr;
> @@ -65,7 +69,7 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id)
>  
>  	for (i = 0; i < ehdr->e_phnum; ++i) {
>  		if (phdr[i].p_type == PT_NOTE &&
> -		    !parse_build_id(page_addr, build_id,
> +		    !parse_build_id(page_addr, build_id, size,
>  				    page_addr + phdr[i].p_offset,
>  				    phdr[i].p_filesz))
>  			return 0;
> @@ -74,7 +78,8 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id)
>  }
>  
>  /* Parse build ID from 64-bit ELF */
> -static int get_build_id_64(void *page_addr, unsigned char *build_id)
> +static int get_build_id_64(void *page_addr, unsigned char *build_id,
> +			   __u32 *size)
>  {
>  	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
>  	Elf64_Phdr *phdr;
> @@ -89,7 +94,7 @@ static int get_build_id_64(void *page_addr, unsigned char *build_id)
>  
>  	for (i = 0; i < ehdr->e_phnum; ++i) {
>  		if (phdr[i].p_type == PT_NOTE &&
> -		    !parse_build_id(page_addr, build_id,
> +		    !parse_build_id(page_addr, build_id, size,
>  				    page_addr + phdr[i].p_offset,
>  				    phdr[i].p_filesz))
>  			return 0;
> @@ -97,8 +102,16 @@ static int get_build_id_64(void *page_addr, unsigned char *build_id)
>  	return -EINVAL;
>  }
>  
> -/* Parse build ID of ELF file mapped to vma */
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
> +/*
> + * Parse build ID of ELF file mapped to vma
> + * @vma:      vma object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Returns 0 on success, otherwise error (< 0).
> + */
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +		   __u32 *size)
>  {
>  	Elf32_Ehdr *ehdr;
>  	struct page *page;
> @@ -126,9 +139,9 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
>  		goto out;
>  
>  	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
> -		ret = get_build_id_32(page_addr, build_id);
> +		ret = get_build_id_32(page_addr, build_id, size);
>  	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
> -		ret = get_build_id_64(page_addr, build_id);
> +		ret = get_build_id_64(page_addr, build_id, size);
>  out:
>  	kunmap_atomic(page_addr);
>  	put_page(page);
> -- 
> 2.26.2
> 

