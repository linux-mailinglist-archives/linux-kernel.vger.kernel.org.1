Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3CD2805D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbgJARtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbgJARs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:48:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B57C0613E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:48:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so6792147wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxWceFBJemERUVJXLpe5M4H3KWrtmYrogpYMra7Mtm0=;
        b=GQIN6BicP4OClk7wJaA8cFCNYhEDhUzoKei/bEj4NOdqsD0reNrtLvUpWv65sqOKEa
         7X8NwQm5ArcLJxyPf0Q+kYSrlZ8niYaCUe2skLkrvt7fgh52yFsCml94CqWZkNkf73p2
         1qZgr19pIDutjUSOifXzmoZkgGfJgEmd4d13V49qZFqyIBUVS1MrdMrrzzqavpjrRMyR
         kMTHjegSoOsjuFH2c/xz0wpF3urnMh7EDOsjB1ohFgdkL7NWO/14iL4qDjfEd480cy0/
         zzeazIDAn+VG/Wz+99CQPLuwnUPq3foaYxABWXuQ7A5rSjsYkdb87L6dmVoT1qayyzrn
         Va+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxWceFBJemERUVJXLpe5M4H3KWrtmYrogpYMra7Mtm0=;
        b=Pmb/BrdnrspTY2GiHPy5CP6q4CVT8hOR7J75egeAHEeRKD4jeNqDUBxMIU5Epx1Yct
         Z3Nw+DGYL1+Mex2uZv0tKfsfS20HI0SfmIY+ZPMGXXnp7yKoMIbjlk1BV/UKkGtLdXTZ
         FkAkQWRu6d+O4k+pWUKs4TQXAZnmEGQTOnYeO2aNkwuO8EiDLghcwmKVz6438un9FfQE
         jToXNvGYVu3V/ZLFis4kW8Vjn4sKSutdZqLTSk+hrvW/d/uOQCCr78BgDw6jA87dsO0k
         q6fV8epnW0QK14MJWg4TA7noYq66kQnhN0ddscjII6jwVSjcfLUkd+RGdCh7nbfjpvBK
         Libg==
X-Gm-Message-State: AOAM532Xu75C4S44Q+I7tYGd1ttce1nI8AAuOYjjIEmO/9cPHHKj3dWl
        xUnwne2PHhVVCwHi71wfi+J2dg==
X-Google-Smtp-Source: ABdhPJw0CxrIMWSohPctixufME9pzCUW6uA4XtaXT94EQt7SLLifwCJj9Nh9P+FikfnoOomO9lQBJQ==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr11001000wrc.71.1601574537863;
        Thu, 01 Oct 2020 10:48:57 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id u66sm6396017wme.1.2020.10.01.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:56 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:48:51 +0200
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
Subject: Re: [PATCH v3 19/39] kasan: rename SHADOW layout macros to META
Message-ID: <20201001174851.GO4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <cac8b9713e5d3ac1ab767a9cc42c61b04c46bdfc.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac8b9713e5d3ac1ab767a9cc42c61b04c46bdfc.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> these macros. Rename "SHADOW" to implementation-neutral "META".
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: Id2d836bf43b401bce1221cc06e745185f17b1cc
> ---
>  mm/kasan/report.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 67aa30b45805..13b27675a696 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -31,11 +31,11 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> -/* Shadow layout customization. */
> -#define SHADOW_BYTES_PER_BLOCK 1
> -#define SHADOW_BLOCKS_PER_ROW 16
> -#define SHADOW_BYTES_PER_ROW (SHADOW_BLOCKS_PER_ROW * SHADOW_BYTES_PER_BLOCK)
> -#define SHADOW_ROWS_AROUND_ADDR 2
> +/* Metadata layout customization. */
> +#define META_BYTES_PER_BLOCK 1
> +#define META_BLOCKS_PER_ROW 16
> +#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> +#define META_ROWS_AROUND_ADDR 2
>  
>  static unsigned long kasan_flags;
>  
> @@ -238,7 +238,7 @@ static void print_address_description(void *addr, u8 tag)
>  
>  static bool row_is_guilty(const void *row, const void *guilty)
>  {
> -	return (row <= guilty) && (guilty < row + SHADOW_BYTES_PER_ROW);
> +	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
>  }
>  
>  static int shadow_pointer_offset(const void *row, const void *shadow)
> @@ -247,7 +247,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
>  	 *    3 + (BITS_PER_LONG/8)*2 chars.
>  	 */
>  	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
> -		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
> +		(shadow - row) / META_BYTES_PER_BLOCK + 1;
>  }
>  
>  static void print_memory_metadata(const void *addr)
> @@ -257,15 +257,15 @@ static void print_memory_metadata(const void *addr)
>  	const void *shadow_row;
>  
>  	shadow_row = (void *)round_down((unsigned long)shadow,
> -					SHADOW_BYTES_PER_ROW)
> -		- SHADOW_ROWS_AROUND_ADDR * SHADOW_BYTES_PER_ROW;
> +					META_BYTES_PER_ROW)
> +		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
>  
>  	pr_err("Memory state around the buggy address:\n");
>  
> -	for (i = -SHADOW_ROWS_AROUND_ADDR; i <= SHADOW_ROWS_AROUND_ADDR; i++) {
> +	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
>  		const void *kaddr = kasan_shadow_to_mem(shadow_row);
>  		char buffer[4 + (BITS_PER_LONG/8)*2];
> -		char shadow_buf[SHADOW_BYTES_PER_ROW];
> +		char shadow_buf[META_BYTES_PER_ROW];
>  
>  		snprintf(buffer, sizeof(buffer),
>  			(i == 0) ? ">%px: " : " %px: ", kaddr);
> @@ -274,17 +274,17 @@ static void print_memory_metadata(const void *addr)
>  		 * function, because generic functions may try to
>  		 * access kasan mapping for the passed address.
>  		 */
> -		memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
> +		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
>  		print_hex_dump(KERN_ERR, buffer,
> -			DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
> -			shadow_buf, SHADOW_BYTES_PER_ROW, 0);
> +			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> +			shadow_buf, META_BYTES_PER_ROW, 0);
>  
>  		if (row_is_guilty(shadow_row, shadow))
>  			pr_err("%*c\n",
>  				shadow_pointer_offset(shadow_row, shadow),
>  				'^');
>  
> -		shadow_row += SHADOW_BYTES_PER_ROW;
> +		shadow_row += META_BYTES_PER_ROW;
>  	}
>  }
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
