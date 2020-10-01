Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A802805F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbgJARyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:54:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51880C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:54:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so4081303wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MD/fcatPT9QjaIWjzyQ070sd24blgVyHZ+oxa+kxMTk=;
        b=vJCzAYSDA+c4VyCnPj8jykQ4FACEGqCA5jTK8DRNoYLonrMRaEF5fm7W4VpYgy41jy
         eKMjqSz4l4DshmrAiGfOk/xaaihHLpg6yKQYKPBTScDTzhCEVUtwHkpD+iECGcZ95ER5
         xcviNjQSh9jpgJLL4eKkPCdI3rBdhiYnqSdVZ+PXmEu5qqU1LX+Vs8CbSSBTE2OKcJZv
         6rkM1hHYuPaQJfOQTnPnHBUv6+BMEnNOTC0Kbz4qPZMbE7TFnDgoz21gAmpXnpp2AAbt
         SbBnmVBSkvLdIFsneOUB3DUhjdXxA452jHtotK6lxu+RkwT7FgSSjV2BJhSxU2e4ny2N
         Bfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MD/fcatPT9QjaIWjzyQ070sd24blgVyHZ+oxa+kxMTk=;
        b=JaVZql6GvreObw5lZElNSYOxU9xntNSzVRmSL/gbEYECZ5C9A+7aM+atP/EapXYdXu
         69MH1glAv9DI1Q/X4WJ1VVFqa/G57/chzC8AWEBCzknSJivGkBFQwGvYs5NHRpwmXjyZ
         YsPwWSNXwsJnM7zjQy4dfWfOpRuAlpgVvLmSP/9Anx5cD+61QjJZw5Vsic41Hw5MoeIF
         INkGCz1m0o8jrwICP1zmVQ0VWGelEYu8vMHnZ/jchdGZDa7gFR2p1HTJCyxndfSgaaHH
         5XPrm0m5sUqc/eroPit+BHpkYMCpzRKENMCAhWHBChuZ9Yef8dDgdaZfUiIG+tByOmcl
         99lw==
X-Gm-Message-State: AOAM531ot7UIt7K93VjYk0lcwrAQzHYgttRRn1EMPMjex+bYRbIygMkg
        fq4JpSDAX2Ojp6MjABSGGefUQQ==
X-Google-Smtp-Source: ABdhPJwca8xkBHKNqYId8jPN3Jc/UIrfiPQr2+UiqiCHPdLfSt1cdFWDhebA3zEweP01EGBaMraV8A==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr1143592wma.111.1601574848674;
        Thu, 01 Oct 2020 10:54:08 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id q20sm1008470wmj.5.2020.10.01.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:54:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:54:02 +0200
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
Subject: Re: [PATCH v3 20/39] kasan: separate metadata_fetch_row for each mode
Message-ID: <20201001175402.GP4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <494045645c31b7f9298851118cb0b7f8964ac0f4.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494045645c31b7f9298851118cb0b7f8964ac0f4.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.

Not sure why I've only noticed this now, but all these patches seem to
say "This is a preparatory commit" -- I don't think "commit" is
applicable, and "This .. patch" is discouraged.

Maybe just change it to say "This is to prepare for the upcoming ..."
after the below paragraph?

> Rework print_memory_metadata() to make it agnostic with regard to the
> way metadata is stored. Allow providing a separate metadata_fetch_row()
> implementation for each KASAN mode. Hardware tag-based KASAN will provide
> its own implementation that doesn't use shadow memory.

(i.e. move it here)

> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Other than that,

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I5b0ed1d079ea776e620beca6a529a861e7dced95
> ---
>  mm/kasan/kasan.h          |  8 ++++++
>  mm/kasan/report.c         | 56 +++++++++++++++++++--------------------
>  mm/kasan/report_generic.c |  5 ++++
>  mm/kasan/report_sw_tags.c |  5 ++++
>  4 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 0bf669fad345..50b59c8f8be2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -57,6 +57,13 @@
>  #define KASAN_ABI_VERSION 1
>  #endif
>  
> +/* Metadata layout customization. */
> +#define META_BYTES_PER_BLOCK 1
> +#define META_BLOCKS_PER_ROW 16
> +#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> +#define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
> +#define META_ROWS_AROUND_ADDR 2
> +
>  struct kasan_access_info {
>  	const void *access_addr;
>  	const void *first_bad_addr;
> @@ -168,6 +175,7 @@ bool check_invalid_free(void *addr);
>  
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
> +void metadata_fetch_row(char *buffer, void *row);
>  
>  #ifdef CONFIG_KASAN_STACK_ENABLE
>  void print_address_stack_frame(const void *addr);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 13b27675a696..3924127b4786 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -31,12 +31,6 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> -/* Metadata layout customization. */
> -#define META_BYTES_PER_BLOCK 1
> -#define META_BLOCKS_PER_ROW 16
> -#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> -#define META_ROWS_AROUND_ADDR 2
> -
>  static unsigned long kasan_flags;
>  
>  #define KASAN_BIT_REPORTED	0
> @@ -236,55 +230,59 @@ static void print_address_description(void *addr, u8 tag)
>  	print_address_stack_frame(addr);
>  }
>  
> -static bool row_is_guilty(const void *row, const void *guilty)
> +static bool meta_row_is_guilty(const void *row, const void *addr)
>  {
> -	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
> +	return (row <= addr) && (addr < row + META_MEM_BYTES_PER_ROW);
>  }
>  
> -static int shadow_pointer_offset(const void *row, const void *shadow)
> +static int meta_pointer_offset(const void *row, const void *addr)
>  {
> -	/* The length of ">ff00ff00ff00ff00: " is
> -	 *    3 + (BITS_PER_LONG/8)*2 chars.
> +	/*
> +	 * Memory state around the buggy address:
> +	 *  ff00ff00ff00ff00: 00 00 00 05 fe fe fe fe fe fe fe fe fe fe fe fe
> +	 *  ...
> +	 *
> +	 * The length of ">ff00ff00ff00ff00: " is
> +	 *    3 + (BITS_PER_LONG / 8) * 2 chars.
> +	 * The length of each granule metadata is 2 bytes
> +	 *    plus 1 byte for space.
>  	 */
> -	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
> -		(shadow - row) / META_BYTES_PER_BLOCK + 1;
> +	return 3 + (BITS_PER_LONG / 8) * 2 +
> +		(addr - row) / KASAN_GRANULE_SIZE * 3 + 1;
>  }
>  
>  static void print_memory_metadata(const void *addr)
>  {
>  	int i;
> -	const void *shadow = kasan_mem_to_shadow(addr);
> -	const void *shadow_row;
> +	void *row;
>  
> -	shadow_row = (void *)round_down((unsigned long)shadow,
> -					META_BYTES_PER_ROW)
> -		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
> +	row = (void *)round_down((unsigned long)addr, META_MEM_BYTES_PER_ROW)
> +			- META_ROWS_AROUND_ADDR * META_MEM_BYTES_PER_ROW;
>  
>  	pr_err("Memory state around the buggy address:\n");
>  
>  	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
> -		const void *kaddr = kasan_shadow_to_mem(shadow_row);
> -		char buffer[4 + (BITS_PER_LONG/8)*2];
> -		char shadow_buf[META_BYTES_PER_ROW];
> +		char buffer[4 + (BITS_PER_LONG / 8) * 2];
> +		char metadata[META_BYTES_PER_ROW];
>  
>  		snprintf(buffer, sizeof(buffer),
> -			(i == 0) ? ">%px: " : " %px: ", kaddr);
> +				(i == 0) ? ">%px: " : " %px: ", row);
> +
>  		/*
>  		 * We should not pass a shadow pointer to generic
>  		 * function, because generic functions may try to
>  		 * access kasan mapping for the passed address.
>  		 */
> -		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
> +		metadata_fetch_row(&metadata[0], row);
> +
>  		print_hex_dump(KERN_ERR, buffer,
>  			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> -			shadow_buf, META_BYTES_PER_ROW, 0);
> +			metadata, META_BYTES_PER_ROW, 0);
>  
> -		if (row_is_guilty(shadow_row, shadow))
> -			pr_err("%*c\n",
> -				shadow_pointer_offset(shadow_row, shadow),
> -				'^');
> +		if (meta_row_is_guilty(row, addr))
> +			pr_err("%*c\n", meta_pointer_offset(row, addr), '^');
>  
> -		shadow_row += META_BYTES_PER_ROW;
> +		row += META_MEM_BYTES_PER_ROW;
>  	}
>  }
>  
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index ff067071cd28..de7a85c83106 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -122,6 +122,11 @@ const char *get_bug_type(struct kasan_access_info *info)
>  	return get_wild_bug_type(info);
>  }
>  
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
> +}
> +
>  #ifdef CONFIG_KASAN_STACK_ENABLE
>  static bool __must_check tokenize_frame_descr(const char **frame_descr,
>  					      char *token, size_t max_tok_len,
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index c87d5a343b4e..add2dfe6169c 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -80,6 +80,11 @@ void *find_first_bad_addr(void *addr, size_t size)
>  	return p;
>  }
>  
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
> +}
> +
>  void print_tags(u8 addr_tag, const void *addr)
>  {
>  	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
