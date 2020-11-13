Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E12B230F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:55:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3937C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:55:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so10868137wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+PMzrqEXwIpHSYqiZIonnkK0eqVZnv5ws8C/JpM2Ro=;
        b=FE1+mMH0UYMQRcQQs7KpXFA4j/4+C7+LWdthCcraI4GjvHoVSq5egSXJ6dIWT52Tb/
         VZbrsdVzeK7nkCczjAWhm1H4Rs3HIouuOPKj119ajegykHfj7CUteydCStxrj5x0hlnH
         XBDM6HOeJ8jwSjZEujY/i83583kf7woW21nDuLJmd6Epr58dbZeqVHYAkTmaAMgrJ/RM
         eBW4eIJ91niVQFmmNXKF7hfKI9w+QGuPppUGZ1Yr7Atxmji3ZgrN0xT7N1i1zsqbi6FY
         mQEzwScKiSGV5hZDxk0wTMrdRZg9UyCKaj0ThbUezV0lN9IMsEX9k9DCpqaAQlpiY3Vr
         13ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+PMzrqEXwIpHSYqiZIonnkK0eqVZnv5ws8C/JpM2Ro=;
        b=c3Oyg7PvFT2/XV8tmFKfJVV1cNx0D9xsc/2BQIY0l3suLxAviVsbL+1poaKEb8AQDi
         ILOtzXyFZL1VcbKgVnt/2/XwNDI1/w7VsKPQaRN+cEWhvMxOa2hfqLzXZwQ1N4+HzbSi
         FJ3H8yJnvXOdxu6L2OKCITR+114Jiilso0HaKPZdsYrJhzL2dn0dbF+SrQW+yzDLt2TU
         8jhnl2cRAr8GBhOgp8WO1tYe/uzrcjVV8IJXgdBuSMKr913mM3PpGKYeLqsz7tNkekL8
         94vQCCr3wTcgWTZEWyfKpdH0Oo55EfbtDtAGjLc4n/U8bMIIydct61WGDerpuO/F4xJh
         UPSQ==
X-Gm-Message-State: AOAM533Xdpp4cBCy+JKy+wYJg313H/DUAXvjH95VkCHL44kdGRJwPw5a
        Va1knnBkZF75jkAN48GWS0K7CQ==
X-Google-Smtp-Source: ABdhPJy2CWSCtgMYhxtWZD2Bm08bwkJMMl3ksYfanoTA+WX4VeGO+SoCLrnlO7CMn2PoetaesDufLw==
X-Received: by 2002:adf:e607:: with SMTP id p7mr4796819wrm.93.1605290115315;
        Fri, 13 Nov 2020 09:55:15 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c185sm11477158wma.44.2020.11.13.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:55:14 -0800 (PST)
Date:   Fri, 13 Nov 2020 18:55:08 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
Message-ID: <20201113175508.GB3175464@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
 <20201113175254.GA3175464@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113175254.GA3175464@elver.google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:52PM +0100, Marco Elver wrote:
> On Tue, Nov 10, 2020 at 11:20PM +0100, 'Andrey Konovalov' via kasan-dev wrote:
> [...]
> > +/* kasan.mode=off/prod/full */
> > +static int __init early_kasan_mode(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	if (!strcmp(arg, "off"))
> > +		kasan_arg_mode = KASAN_ARG_MODE_OFF;
> > +	else if (!strcmp(arg, "prod"))
> > +		kasan_arg_mode = KASAN_ARG_MODE_PROD;
> > +	else if (!strcmp(arg, "full"))
> > +		kasan_arg_mode = KASAN_ARG_MODE_FULL;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +early_param("kasan.mode", early_kasan_mode);
> > +
> > +/* kasan.stack=off/on */
> > +static int __init early_kasan_flag_stacktrace(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	if (!strcmp(arg, "off"))
> > +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
> > +	else if (!strcmp(arg, "on"))
> > +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
> > +
> > +/* kasan.fault=report/panic */
> > +static int __init early_kasan_fault(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	if (!strcmp(arg, "report"))
> > +		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> > +	else if (!strcmp(arg, "panic"))
> > +		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> [...]
> 
> The above could be simplified, see suggestion below.
> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index c91f2c06ecb5..71fc481ad21d 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -64,10 +64,8 @@ static int __init early_kasan_mode(char *arg)
>  		kasan_arg_mode = KASAN_ARG_MODE_PROD;
>  	else if (!strcmp(arg, "full"))
>  		kasan_arg_mode = KASAN_ARG_MODE_FULL;
> -	else
> -		return -EINVAL;
>  
> -	return 0;
> +	return -EINVAL;

Ah that clearly doesn't work. Hmm, never mind this suggestion, sorry.

Thanks,
-- Marco
