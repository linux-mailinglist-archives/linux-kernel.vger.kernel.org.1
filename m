Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436442866D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJGSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:20:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5224DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:20:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d6so1399578plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5q1mkem07H8Ft+Xbkac3QH7U1U4PTRmUXcm4ZQ/v9FM=;
        b=VNKeTK7zHJF6+X2eOrSRKIuojJ63hohCmMz/vlj6m1JcBFxP+dLAZ10vxL8rZCHAJQ
         Tiac7HW3AFZUU5J8s4UsZm5IvqQnuniESW6saHdxaUukh73KOok+xuY3I9Twcvv9Hsnn
         ZSX51TqQs4hphqfPuY4zgoKbbR+KMVnVnPuAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5q1mkem07H8Ft+Xbkac3QH7U1U4PTRmUXcm4ZQ/v9FM=;
        b=gMVcuSjRJc5Qhzz5iqCWwMGK6EaoCKvWlpqJMCXHXufvNkcaaUxSCQKh+whjFPw5bg
         1dqQoAs3E9mSg9mKITIuTRP3Qd+aPsWmqxUdD/NwCG3MqYPT+91Hz3BNCVvKeFF44C5j
         qy4Cfs7A7qikQsce0Puye11YXQTTk9QMAbFmfKqjlmzGIHsELxogZ/NmBu5696ESv/kr
         m6E+1fyTBMbKkKJdJaZAvQ8/fXX2QBfJn4VpiUEIzaIPSsTGhORvRS3GxdwiDP9hP1BS
         WiEGMb994En9Tgv8FNDQk3AA2wWhY0azlnOSwPmogzQJE6CJQG8SLGoyyN0q03AHdrVs
         aEsA==
X-Gm-Message-State: AOAM532dC1zBkWcuOX8SsCLNzTAofZiaDFZCKXKkn2CtIOLmJaNVcxLB
        I/5sNVwiBLULr++EbKZIUR8Dmw==
X-Google-Smtp-Source: ABdhPJytI8S0ylF92xO+QtqqcxVb2t5ate4wepbxVrTBVldSJYIFpg4BxOAMRISqnSvwQ/D93qRpyg==
X-Received: by 2002:a17:902:7896:b029:d3:7768:1eb with SMTP id q22-20020a1709027896b02900d3776801ebmr4033216pll.17.1602094855805;
        Wed, 07 Oct 2020 11:20:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s67sm4034679pfb.35.2020.10.07.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:20:54 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:20:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drivers/base/test/test_async_driver_probe:
 convert to use counter_atomic32
Message-ID: <202010071119.0D23F28@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <7a259f1710f621a95d6e683308e55bd74bba2a2f.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a259f1710f621a95d6e683308e55bd74bba2a2f.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:39PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used to count errors, warns, keep track of timeout,
> and async completion are counters.
> 
> Unsure overflow is a concern for timeout and async completion, and there
> are no checks for overflow to hold them to upper bounds. Overflow and
> wrap around doesn't impact errors, and warns.
> 
> Convert them to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/base/test/test_async_driver_probe.c | 23 ++++++++++++---------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
> index 3bb7beb127a9..e969c1b09426 100644
> --- a/drivers/base/test/test_async_driver_probe.c
> +++ b/drivers/base/test/test_async_driver_probe.c
> @@ -14,11 +14,12 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> +#include <linux/counters.h>
>  
>  #define TEST_PROBE_DELAY	(5 * 1000)	/* 5 sec */
>  #define TEST_PROBE_THRESHOLD	(TEST_PROBE_DELAY / 2)
>  
> -static atomic_t warnings, errors, timeout, async_completed;
> +static struct counter_atomic32 warnings, errors, timeout, async_completed;

While it's currently harmless, this should likely be using
COUNTER_ATOMIC_INIT(0)s...

>  
>  static int test_probe(struct platform_device *pdev)
>  {
> @@ -29,9 +30,9 @@ static int test_probe(struct platform_device *pdev)
>  	 * have then report it as an error, otherwise we wil sleep for the
>  	 * required amount of time and then report completion.
>  	 */
> -	if (atomic_read(&timeout)) {
> +	if (counter_atomic32_read(&timeout)) {
>  		dev_err(dev, "async probe took too long\n");
> -		atomic_inc(&errors);
> +		counter_atomic32_inc(&errors);
>  	} else {
>  		dev_dbg(&pdev->dev, "sleeping for %d msecs in probe\n",
>  			 TEST_PROBE_DELAY);
> @@ -48,10 +49,10 @@ static int test_probe(struct platform_device *pdev)
>  		    dev_to_node(dev) != numa_node_id()) {
>  			dev_warn(dev, "NUMA node mismatch %d != %d\n",
>  				 dev_to_node(dev), numa_node_id());
> -			atomic_inc(&warnings);
> +			counter_atomic32_inc(&warnings);
>  		}
>  
> -		atomic_inc(&async_completed);
> +		counter_atomic32_inc(&async_completed);
>  	}
>  
>  	return 0;
> @@ -244,11 +245,12 @@ static int __init test_async_probe_init(void)
>  	 * Otherwise if they completed without errors or warnings then
>  	 * report successful completion.
>  	 */
> -	if (atomic_read(&async_completed) != async_id) {
> +	if (counter_atomic32_read(&async_completed) != async_id) {
>  		pr_err("async events still pending, forcing timeout\n");
> -		atomic_inc(&timeout);
> +		counter_atomic32_inc(&timeout);
>  		err = -ETIMEDOUT;
> -	} else if (!atomic_read(&errors) && !atomic_read(&warnings)) {
> +	} else if (!counter_atomic32_read(&errors) &&
> +		   !counter_atomic32_read(&warnings)) {
>  		pr_info("completed successfully\n");
>  		return 0;
>  	}
> @@ -271,12 +273,13 @@ static int __init test_async_probe_init(void)
>  	 * errors or warnings being reported by the probe routine.
>  	 */
>  	if (err)
> -		atomic_inc(&errors);
> +		counter_atomic32_inc(&errors);
>  	else
>  		err = -EINVAL;
>  
>  	pr_err("Test failed with %d errors and %d warnings\n",
> -	       atomic_read(&errors), atomic_read(&warnings));
> +	       counter_atomic32_read(&errors),
> +	       counter_atomic32_read(&warnings));
>  
>  	return err;
>  }
> -- 
> 2.25.1
> 

But yeah, this is otherwise just reporting and simple one-time synchronization.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
