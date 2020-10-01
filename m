Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDCF2805C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbgJARqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:46:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D7C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:46:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so6785096wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4X89ICg6LS0dHFVQkSUqAoV+hQlz/eq43PpADvUh29Q=;
        b=T3AeyqU7xkY2nJbeE9ox+8W8WTr+v/MvS0TOtz0WBwvoAfbOn3b23v+aC6OV5Z9qeC
         X9jf8YhWtYireUwIaP6Fo5z0IP4R2VZWBAW0KGnfdqLiYw5dD4q20u6LJntLwPO2d/+7
         XOXsMz6pqvfVRKFW17eyZZ4IpPEEgwVUI6iij7/zGPUm00u50UVij6kacWy/cS1P2Phz
         rHFKDa+ee27rxnrBM0CO9BgU+GZU+w3h5lGnJ8u1soUKKpvBU9BBm4J5pAonhtShRNbr
         JJ5ZWCy5oIeD1G28gPNx1qthN/D5OWxATs4qG7nCLWNEhVAirocoPYkaxNjxv5BhzUHi
         +91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4X89ICg6LS0dHFVQkSUqAoV+hQlz/eq43PpADvUh29Q=;
        b=W8/cJh4XoD4CYYHJuqh/grCX84rVCvmsgr5fzMPy8oTS68SsaaxiV6qXuSqJwVV5QB
         XyKgf3PhFk6Q32vPOW9hUcVmvJFadQf9bVgXKtTqqACqZodJ9USHg20CufgLA8mbkcYK
         uyBZr9UlRqxiGSSZsjVuKyZPEWqX1g/3+0nfXOS077+AoBZ63o0axVAPjeD4TnxwJrIH
         J9TADWZXMaoW01RS3vvLIgHx/qlMBgSGtwzI2ocCF4IZvLLZkjI81cjh07uRalK9+KwB
         CfhDFU+Rzc5v0kP0bQqYLBi3PRLjMpgz5JcFvW/uQ9q2OIBefyr3fLXZbnBjue1y2HJL
         KSjQ==
X-Gm-Message-State: AOAM532NA/sXVbanoGdy4NTx/qDquOOvR3Lk14i6EVT+fSdHOAnVK6x5
        GshqAfT5aVBwISWUp8gulixHCA==
X-Google-Smtp-Source: ABdhPJwgVoEbDG6cvTnMMQikPDpiTvYKZ5GZ/vqyc675l6eTSpho1m29kdZjBfyxcUZWkPeR+KBgFw==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr9870455wrw.190.1601574360526;
        Thu, 01 Oct 2020 10:46:00 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k6sm888277wmf.30.2020.10.01.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:45:59 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:45:54 +0200
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
Subject: Re: [PATCH v3 17/39] kasan: rename print_shadow_for_address to
 print_memory_metadata
Message-ID: <20201001174554.GM4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <8580d4945df57614053084eee8f318edb64712d3.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8580d4945df57614053084eee8f318edb64712d3.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> this function. Rename "shadow" to implementation-neutral "metadata".
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I18397dddbed6bc6d365ddcaf063a83948e1150a5
> ---
>  mm/kasan/report.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 145b966f8f4d..9e4d539d62f4 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -250,7 +250,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
>  		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
>  }
>  
> -static void print_shadow_for_address(const void *addr)
> +static void print_memory_metadata(const void *addr)
>  {
>  	int i;
>  	const void *shadow = kasan_mem_to_shadow(addr);
> @@ -311,7 +311,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>  	pr_err("\n");
>  	print_address_description(object, tag);
>  	pr_err("\n");
> -	print_shadow_for_address(object);
> +	print_memory_metadata(object);
>  	end_report(&flags);
>  }
>  
> @@ -347,7 +347,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>  	if (addr_has_metadata(untagged_addr)) {
>  		print_address_description(untagged_addr, get_tag(tagged_addr));
>  		pr_err("\n");
> -		print_shadow_for_address(info.first_bad_addr);
> +		print_memory_metadata(info.first_bad_addr);
>  	} else {
>  		dump_stack();
>  	}
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
