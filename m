Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619432805B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbgJARoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:44:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8552C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:44:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so4038655wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4KTP5PPBXPQCQ9o0Du3pwA+7Doqcit+qoPcV04ur9Bc=;
        b=Z+hew0WZ6GUBf2hLGi7vdHwpITWv4ut+dwhjNWtEMv+VZ2Gs+yatGc3bkcimTSKId5
         CfvhToTXZ2fWtBiOrulVDvUO6wiJATyBCgpZ4L/vA1kgvIQNis0pauh9Lsn61SuOuBcD
         aNFQ/lx2SGU99HXrS00wAWbpo7crqIYaiRW67zcwgOKF89rDgtjXRb/qZ7S6iCYNRfo4
         4mzKOS8RiAVay44Ju+flxep9y42QkGgBLdPOoP3JJjPCAm7rc+xhD3JRBH0PN7d63jRc
         dNjUzRj8nn3K6/DyfYaTtTgnNxfyte7jaPOcDv5fAZAm3SfPLPi/6EodpLttQbntgY1v
         tksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4KTP5PPBXPQCQ9o0Du3pwA+7Doqcit+qoPcV04ur9Bc=;
        b=l1Ly+YhgRyqgMFC4l8OX15oiiaB4OZ19S6kXNAUJ5WsnKQuSeDggmzLPXkCM4aYiuk
         IhryVm/nT3fMZ7SEc05a2wSv7pEbhSuJBukENXuuQiZ9nUcrWrTTHBXOiuXTI/wBRdEb
         AfyXltYKvPeQ1qLgXcC9cfH11fx378sOsqGjEn+5OTcouakznU+xvfBUXnMJRZ1W3bCd
         aisCSX81GBqkh6DxAlNcWBK6TDEU6AVhhRpBPbKbby+MI07EFjKmjAnBlnCFNHc6KGpt
         a35JKQm4ddtdYKeLKpD4P9t5JukxVFy4zMD+6PlYYy7vYoShVxNg2jrFX9fuQCr1NRVm
         mOKA==
X-Gm-Message-State: AOAM533FxV3XGqq2UAsvnRQT1xo9dTMZ6sIxKQFutBA/qA/PUqQx8Wq0
        T669AqPFAtJLOUWALwp/yK5Mhg==
X-Google-Smtp-Source: ABdhPJz1vzQ0my7JLfV4HuXmQyg1yrHuK+fRBeamaEXJTjhkPeEJa+lLryOutAGpL6Pgw8j/0yY6rA==
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr1141258wmc.73.1601574246171;
        Thu, 01 Oct 2020 10:44:06 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id e13sm10909107wre.60.2020.10.01.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:44:05 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:43:59 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/39] kasan: decode stack frame only with
 KASAN_STACK_ENABLE
Message-ID: <20201001174359.GK4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <4f2a790cc95d2ab6400e5f75fa78ff0a0fdd9593.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2a790cc95d2ab6400e5f75fa78ff0a0fdd9593.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Decoding routines aren't needed when CONFIG_KASAN_STACK_ENABLE is not
> enabled. Currently only generic KASAN mode implements stack error
> reporting.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I084e3214f2b40dc0bef7c5a9fafdc6f5c42b06a2
> ---
>  mm/kasan/kasan.h          |   6 ++
>  mm/kasan/report.c         | 162 --------------------------------------
>  mm/kasan/report_generic.c | 161 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+), 162 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3eff57e71ff5..8dfacc0f73ea 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -169,6 +169,12 @@ bool check_invalid_free(void *addr);
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>  
> +#ifdef CONFIG_KASAN_STACK_ENABLE
> +void print_address_stack_frame(const void *addr);
> +#else
> +static inline void print_address_stack_frame(const void *addr) { }
> +#endif
> +
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
>  void kasan_report_invalid_free(void *object, unsigned long ip);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5961dbfba080..f28eec5acdf6 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -209,168 +209,6 @@ static inline bool init_task_stack_addr(const void *addr)
>  			sizeof(init_thread_union.stack));
>  }
>  
> -static bool __must_check tokenize_frame_descr(const char **frame_descr,
> -					      char *token, size_t max_tok_len,
> -					      unsigned long *value)
> -{
> -	const char *sep = strchr(*frame_descr, ' ');
> -
> -	if (sep == NULL)
> -		sep = *frame_descr + strlen(*frame_descr);
> -
> -	if (token != NULL) {
> -		const size_t tok_len = sep - *frame_descr;
> -
> -		if (tok_len + 1 > max_tok_len) {
> -			pr_err("KASAN internal error: frame description too long: %s\n",
> -			       *frame_descr);
> -			return false;
> -		}
> -
> -		/* Copy token (+ 1 byte for '\0'). */
> -		strlcpy(token, *frame_descr, tok_len + 1);
> -	}
> -
> -	/* Advance frame_descr past separator. */
> -	*frame_descr = sep + 1;
> -
> -	if (value != NULL && kstrtoul(token, 10, value)) {
> -		pr_err("KASAN internal error: not a valid number: %s\n", token);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void print_decoded_frame_descr(const char *frame_descr)
> -{
> -	/*
> -	 * We need to parse the following string:
> -	 *    "n alloc_1 alloc_2 ... alloc_n"
> -	 * where alloc_i looks like
> -	 *    "offset size len name"
> -	 * or "offset size len name:line".
> -	 */
> -
> -	char token[64];
> -	unsigned long num_objects;
> -
> -	if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> -				  &num_objects))
> -		return;
> -
> -	pr_err("\n");
> -	pr_err("this frame has %lu %s:\n", num_objects,
> -	       num_objects == 1 ? "object" : "objects");
> -
> -	while (num_objects--) {
> -		unsigned long offset;
> -		unsigned long size;
> -
> -		/* access offset */
> -		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> -					  &offset))
> -			return;
> -		/* access size */
> -		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> -					  &size))
> -			return;
> -		/* name length (unused) */
> -		if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> -			return;
> -		/* object name */
> -		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> -					  NULL))
> -			return;
> -
> -		/* Strip line number; without filename it's not very helpful. */
> -		strreplace(token, ':', '\0');
> -
> -		/* Finally, print object information. */
> -		pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
> -	}
> -}
> -
> -static bool __must_check get_address_stack_frame_info(const void *addr,
> -						      unsigned long *offset,
> -						      const char **frame_descr,
> -						      const void **frame_pc)
> -{
> -	unsigned long aligned_addr;
> -	unsigned long mem_ptr;
> -	const u8 *shadow_bottom;
> -	const u8 *shadow_ptr;
> -	const unsigned long *frame;
> -
> -	BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> -
> -	/*
> -	 * NOTE: We currently only support printing frame information for
> -	 * accesses to the task's own stack.
> -	 */
> -	if (!object_is_on_stack(addr))
> -		return false;
> -
> -	aligned_addr = round_down((unsigned long)addr, sizeof(long));
> -	mem_ptr = round_down(aligned_addr, KASAN_GRANULE_SIZE);
> -	shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
> -	shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
> -
> -	while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
> -		shadow_ptr--;
> -		mem_ptr -= KASAN_GRANULE_SIZE;
> -	}
> -
> -	while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
> -		shadow_ptr--;
> -		mem_ptr -= KASAN_GRANULE_SIZE;
> -	}
> -
> -	if (shadow_ptr < shadow_bottom)
> -		return false;
> -
> -	frame = (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
> -	if (frame[0] != KASAN_CURRENT_STACK_FRAME_MAGIC) {
> -		pr_err("KASAN internal error: frame info validation failed; invalid marker: %lu\n",
> -		       frame[0]);
> -		return false;
> -	}
> -
> -	*offset = (unsigned long)addr - (unsigned long)frame;
> -	*frame_descr = (const char *)frame[1];
> -	*frame_pc = (void *)frame[2];
> -
> -	return true;
> -}
> -
> -static void print_address_stack_frame(const void *addr)
> -{
> -	unsigned long offset;
> -	const char *frame_descr;
> -	const void *frame_pc;
> -
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> -		return;
> -
> -	if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
> -					  &frame_pc))
> -		return;
> -
> -	/*
> -	 * get_address_stack_frame_info only returns true if the given addr is
> -	 * on the current task's stack.
> -	 */
> -	pr_err("\n");
> -	pr_err("addr %px is located in stack of task %s/%d at offset %lu in frame:\n",
> -	       addr, current->comm, task_pid_nr(current), offset);
> -	pr_err(" %pS\n", frame_pc);
> -
> -	if (!frame_descr)
> -		return;
> -
> -	print_decoded_frame_descr(frame_descr);
> -}
> -
>  static void print_address_description(void *addr, u8 tag)
>  {
>  	struct page *page = kasan_addr_to_page(addr);
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 7d5b9e5c7cfe..42b2b5791733 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -122,6 +122,167 @@ const char *get_bug_type(struct kasan_access_info *info)
>  	return get_wild_bug_type(info);
>  }
>  
> +#ifdef CONFIG_KASAN_STACK_ENABLE
> +static bool __must_check tokenize_frame_descr(const char **frame_descr,
> +					      char *token, size_t max_tok_len,
> +					      unsigned long *value)
> +{
> +	const char *sep = strchr(*frame_descr, ' ');
> +
> +	if (sep == NULL)
> +		sep = *frame_descr + strlen(*frame_descr);
> +
> +	if (token != NULL) {
> +		const size_t tok_len = sep - *frame_descr;
> +
> +		if (tok_len + 1 > max_tok_len) {
> +			pr_err("KASAN internal error: frame description too long: %s\n",
> +			       *frame_descr);
> +			return false;
> +		}
> +
> +		/* Copy token (+ 1 byte for '\0'). */
> +		strlcpy(token, *frame_descr, tok_len + 1);
> +	}
> +
> +	/* Advance frame_descr past separator. */
> +	*frame_descr = sep + 1;
> +
> +	if (value != NULL && kstrtoul(token, 10, value)) {
> +		pr_err("KASAN internal error: not a valid number: %s\n", token);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void print_decoded_frame_descr(const char *frame_descr)
> +{
> +	/*
> +	 * We need to parse the following string:
> +	 *    "n alloc_1 alloc_2 ... alloc_n"
> +	 * where alloc_i looks like
> +	 *    "offset size len name"
> +	 * or "offset size len name:line".
> +	 */
> +
> +	char token[64];
> +	unsigned long num_objects;
> +
> +	if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +				  &num_objects))
> +		return;
> +
> +	pr_err("\n");
> +	pr_err("this frame has %lu %s:\n", num_objects,
> +	       num_objects == 1 ? "object" : "objects");
> +
> +	while (num_objects--) {
> +		unsigned long offset;
> +		unsigned long size;
> +
> +		/* access offset */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  &offset))
> +			return;
> +		/* access size */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  &size))
> +			return;
> +		/* name length (unused) */
> +		if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> +			return;
> +		/* object name */
> +		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +					  NULL))
> +			return;
> +
> +		/* Strip line number; without filename it's not very helpful. */
> +		strreplace(token, ':', '\0');
> +
> +		/* Finally, print object information. */
> +		pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
> +	}
> +}
> +
> +static bool __must_check get_address_stack_frame_info(const void *addr,
> +						      unsigned long *offset,
> +						      const char **frame_descr,
> +						      const void **frame_pc)
> +{
> +	unsigned long aligned_addr;
> +	unsigned long mem_ptr;
> +	const u8 *shadow_bottom;
> +	const u8 *shadow_ptr;
> +	const unsigned long *frame;
> +
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> +
> +	/*
> +	 * NOTE: We currently only support printing frame information for
> +	 * accesses to the task's own stack.
> +	 */
> +	if (!object_is_on_stack(addr))
> +		return false;
> +
> +	aligned_addr = round_down((unsigned long)addr, sizeof(long));
> +	mem_ptr = round_down(aligned_addr, KASAN_GRANULE_SIZE);
> +	shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
> +	shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
> +
> +	while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
> +		shadow_ptr--;
> +		mem_ptr -= KASAN_GRANULE_SIZE;
> +	}
> +
> +	while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
> +		shadow_ptr--;
> +		mem_ptr -= KASAN_GRANULE_SIZE;
> +	}
> +
> +	if (shadow_ptr < shadow_bottom)
> +		return false;
> +
> +	frame = (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
> +	if (frame[0] != KASAN_CURRENT_STACK_FRAME_MAGIC) {
> +		pr_err("KASAN internal error: frame info validation failed; invalid marker: %lu\n",
> +		       frame[0]);
> +		return false;
> +	}
> +
> +	*offset = (unsigned long)addr - (unsigned long)frame;
> +	*frame_descr = (const char *)frame[1];
> +	*frame_pc = (void *)frame[2];
> +
> +	return true;
> +}
> +
> +void print_address_stack_frame(const void *addr)
> +{
> +	unsigned long offset;
> +	const char *frame_descr;
> +	const void *frame_pc;
> +
> +	if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
> +					  &frame_pc))
> +		return;
> +
> +	/*
> +	 * get_address_stack_frame_info only returns true if the given addr is
> +	 * on the current task's stack.
> +	 */
> +	pr_err("\n");
> +	pr_err("addr %px is located in stack of task %s/%d at offset %lu in frame:\n",
> +	       addr, current->comm, task_pid_nr(current), offset);
> +	pr_err(" %pS\n", frame_pc);
> +
> +	if (!frame_descr)
> +		return;
> +
> +	print_decoded_frame_descr(frame_descr);
> +}
> +#endif /* CONFIG_KASAN_STACK_ENABLE */
> +
>  #define DEFINE_ASAN_REPORT_LOAD(size)                     \
>  void __asan_report_load##size##_noabort(unsigned long addr) \
>  {                                                         \
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
