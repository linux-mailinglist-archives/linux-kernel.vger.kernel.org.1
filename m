Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B52EB41E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbhAEUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbhAEUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:23:07 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 12:22:27 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h19so615068qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SRfCUh4MRhybAEQ9/+GMU/8+t4gXrLcq9Kpvuz0GiVQ=;
        b=M7Nmn5jW8bYjWhttNtTEgslGyI+UnqFTO6qbYf96CtDwO9qHaGM4j0zGynQEXJWTi6
         smwtiLfPDppAXsMKeP6maWCDVg41d7HQ002s8reSyFO1A+4deVC/NLs8Qo3FRDaICqby
         j7cUSxm0626VSD+3mg86bWJrGyGrhsrl/aNkjaJ06pFe0eONvmRyPY8bnRDxWoUEfGmt
         Axy19we7YvpduLlml8YWtz42is//PDwdIwvEMRLqOyI60cpqYfeJdfUVOkfmoKjrY6+e
         ouTdOSNXNSH/DyTPkUfBJw8J6R1vqgvuxReeORr+0Zg6r7kC/szsBi0yLjKKVXevJCRM
         vFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=SRfCUh4MRhybAEQ9/+GMU/8+t4gXrLcq9Kpvuz0GiVQ=;
        b=szLKAbiKtKjHcJsALX4BoBPm0iR9cln0LvCVJLYq1HRNfsPGeL1vICx9D7UuZ9V0hE
         tiLj6tbjt+QOziU2hK+t5G7XTqArSxD+iKazle9pD82v//AteD/ynIxR1fYhxDD5sxdo
         LhfzJTdA1t3v3/NFJuarQHLLbAb7uGfh9OeSJABW9nawk9EDQFYZWlyjfWpHry+Vz7+7
         9u75hzTypmEZupKrOiY5O37MatnGA3gPOQDWrMismyQ31BO67gedKXunmL1U9Ocuc2w5
         OUaGatsmn1TK84iScTbvOmf4BTCD6UnikwX7ta2Fu5Lkfo02z+f29Gs/JChIEst3rlob
         4CGA==
X-Gm-Message-State: AOAM532liGlIiNQ3eVn6YZJ2AwUPH60p4aSd2A+sHVReZP3kIZ2ew37W
        gvwDrGrhjIXAi100bIclrss=
X-Google-Smtp-Source: ABdhPJw8tHKmQz3IKI2oNdEouBDR+n9F6E4NvF7TwgksuOFPpGoV2m3k6fN5sWhnDl0gsKwzDGYxKQ==
X-Received: by 2002:aed:2123:: with SMTP id 32mr1162365qtc.325.1609878146142;
        Tue, 05 Jan 2021 12:22:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t5sm129936qte.20.2021.01.05.12.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 12:22:25 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 5 Jan 2021 15:22:23 -0500
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nivedita@alum.mit.edu, keescook@chromium.org,
        jroedel@suse.de, hushiyuan@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kaslr: support separate multiple memmaps parameter
 parsing
Message-ID: <X/TKfx57U1zWKzXz@rani.riverdale.lan>
References: <20201222113124.35367-1-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222113124.35367-1-zhangpan26@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 07:31:24PM +0800, Pan Zhang wrote:
> When the kernel is loading,
> the load address of the kernel needs to be calculated firstly.
> 
> If the kernel address space layout randomization(`kaslr`) is enabled,
> the memory range reserved by the memmap parameter will be excluded
> to avoid loading the kernel address into the memmap reserved area.
> 
> Currently, this is what the manual says:
> 	`memmap = nn [KMG] @ss [KMG]
> 		[KNL] Force usage of a specific region of memory.
>     	Region of memory to be used is from ss to ss + nn.
>    		If @ss [KMG] is omitted, it is equivalent to mem = nn [KMG],
>     	which limits max address to nn [KMG].
> 		Multiple different regions can be specified,
> 		comma delimited.
> 		Example:
> 		memmap=100M@2G, 100M#3G, 1G!1024G
> 	`
> 
> Can we relax the use of memmap?
> In our production environment we see many people who use it like this:
> Separate multiple memmaps parameters to reserve memory,
> memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx memmap=xx\$xxx
> 
> If this format is used, and the reserved memory segment is greater than 4,
> there is no way to parse the 5th and subsequent memmaps and the kaslr cannot be disabled by `memmap_too_large`
> so the kernel loading address may fall within the memmap range
> (reserved memory area from memmap after fourth segment),
> which will have bad consequences for use of reserved memory.
> 
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index d7408af..24a2778 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -203,9 +203,6 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
>  {
>  	static int i;
>  
> -	if (i >= MAX_MEMMAP_REGIONS)
> -		return;
> -
>  	while (str && (i < MAX_MEMMAP_REGIONS)) {
>  		int rc;
>  		unsigned long long start, size;
> @@ -233,7 +230,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
>  	}
>  
>  	/* More than 4 memmaps, fail kaslr */
> -	if ((i >= MAX_MEMMAP_REGIONS) && str)
> +	if ((i >= MAX_MEMMAP_REGIONS) && !memmap_too_large)

I think this should stay the way it was, otherwise KASLR will be
disabled even if exactly MAX_MEMMAP_REGIONS were specified. Removing the
early return as you did above should be enough to cause the flag to be
set if a 5th memmap is specified in a separate parameter, right?

>  		memmap_too_large = true;
>  }
>  
> -- 
> 2.7.4
> 
