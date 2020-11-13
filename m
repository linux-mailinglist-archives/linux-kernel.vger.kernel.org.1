Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EED2B2308
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:53:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B574EC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:53:03 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so10841107wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuo3X1dUSZS5dZ8jl01PZiwsfvErikn3kiTlWYen878=;
        b=PDEdUPWc7YyVIg3Th+DIE6NoE2WAMuqAu9fM45HMRdj0lXPDGNKLcCyrkkeH6nW1oV
         bkyC+jfadDn+VRAA+1YMjmozcPoMKNyuyuFo58Rbe1Fm95uHf+OObYzsUueI87+2GTy1
         mX7oAZmLT6dT8cN5G4dMLEpjh1bVhCUH/qvYCs1cxqhvBQot6qH1yFjxkdDUmDI5a9V4
         yASHI1ag0Gd2ZJHgxGtCPX4o2uXbjFaXLXFeLB4mrYa+kB74GUSbEf30OSpRhP45fXHm
         NQ7sz7TIz+O/61FIG4IFAdyokMshSG8AoLRxztH3Q6V8GjbfKrnL757YAzYJTSJexrX8
         DEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuo3X1dUSZS5dZ8jl01PZiwsfvErikn3kiTlWYen878=;
        b=nPkbgTqoco++8tUidD2O0qvs01QdcH40C3jxlXuZeiKg/EJY61flrJVMfFJ4BJKkyV
         9wfg3bN5a1JhQRVzfzDMcNSgw+TSpFaEgTWhMZWgoCIiGt4kfQ9p3FBhdSW7PYitg0hC
         AcWXtWYEFUKC8kyXDypoZdgckyimJ/pfz2qsYLzSGjsFZPZTSIVqA4ZIuTsbJw+I/wMt
         lKRN1GCx5IcGfykn21jz2bnaaLH2BLnGW6y3ib8PebUbSX/AGrOxhIPZNtoCs5j49Eol
         BMAeXBRb4vRRfJtk4Pmx3cUTw6T5sU+BjP3g0TP1nObdpKDSPDQjIPJM+fac1CuVq5ff
         NYHw==
X-Gm-Message-State: AOAM533JsJP2wtNIGWBNE5j1lrAlI5yExq0sX4tBFiVtpT//9SkpoRYH
        fjF7K8RXkMJYzy0iV40eTST6cw==
X-Google-Smtp-Source: ABdhPJyy3j3c0nQwCUqaxX+Yji7YWkR4PFHt86kgu+OkmAeluHcJ0MZ7sl7fPzDdZOXBpU20INn55w==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr4844283wrq.151.1605289981187;
        Fri, 13 Nov 2020 09:53:01 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c6sm12676849wrh.74.2020.11.13.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:53:00 -0800 (PST)
Date:   Fri, 13 Nov 2020 18:52:54 +0100
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
Message-ID: <20201113175254.GA3175464@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, 'Andrey Konovalov' via kasan-dev wrote:
[...]
> +/* kasan.mode=off/prod/full */
> +static int __init early_kasan_mode(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "off"))
> +		kasan_arg_mode = KASAN_ARG_MODE_OFF;
> +	else if (!strcmp(arg, "prod"))
> +		kasan_arg_mode = KASAN_ARG_MODE_PROD;
> +	else if (!strcmp(arg, "full"))
> +		kasan_arg_mode = KASAN_ARG_MODE_FULL;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.mode", early_kasan_mode);
> +
> +/* kasan.stack=off/on */
> +static int __init early_kasan_flag_stacktrace(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "off"))
> +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
> +	else if (!strcmp(arg, "on"))
> +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
> +
> +/* kasan.fault=report/panic */
> +static int __init early_kasan_fault(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "report"))
> +		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> +	else if (!strcmp(arg, "panic"))
> +		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
[...]

The above could be simplified, see suggestion below.

Thanks,
-- Marco

------ >8 ------

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index c91f2c06ecb5..71fc481ad21d 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -64,10 +64,8 @@ static int __init early_kasan_mode(char *arg)
 		kasan_arg_mode = KASAN_ARG_MODE_PROD;
 	else if (!strcmp(arg, "full"))
 		kasan_arg_mode = KASAN_ARG_MODE_FULL;
-	else
-		return -EINVAL;
 
-	return 0;
+	return -EINVAL;
 }
 early_param("kasan.mode", early_kasan_mode);
 
@@ -81,10 +79,8 @@ static int __init early_kasan_flag_stacktrace(char *arg)
 		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
 	else if (!strcmp(arg, "on"))
 		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
-	else
-		return -EINVAL;
 
-	return 0;
+	return -EINVAL;
 }
 early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
 
@@ -98,10 +94,8 @@ static int __init early_kasan_fault(char *arg)
 		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
 	else if (!strcmp(arg, "panic"))
 		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
-	else
-		return -EINVAL;
 
-	return 0;
+	return -EINVAL;
 }
 early_param("kasan.fault", early_kasan_fault);

