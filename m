Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB6303AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404442AbhAZKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbhAZC0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:26:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:25:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x71so17002705oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QTI5b42V0A8vj4208NQlI6X3gQobyu3oQbk5w8E64Sg=;
        b=PtblCenTUcRuIlvgjFbMc5BvGrk/TH+9J4nkyErFhv8iynso2MPPygokYJeOi5EchS
         xXcbbuT2o+/XtXa3PiS2Oyz0NzAnpswIdGHPlBCsF8BRbNz8c56CHVMAhl7TDMs5YRTo
         lF38HtI8+j2CgE23smfb3Zn1ZQSMnOb8u3Pr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTI5b42V0A8vj4208NQlI6X3gQobyu3oQbk5w8E64Sg=;
        b=r8vJSGLMFZqsfASTbGWr1uZB8oPIeeiBO4JEPCA9keilN0GwFdj8ilapQhSK0kDfDE
         1JXafB+deALZAwEU/n4DqXmt5iUw8vNWiwiMoTRErmozblwU40dLJveWEpAF6Z1X5dYG
         OAvwKQxxOt8f8rlXsxStr4ayGwKlBvAzAz+KQtKy+siYzSVNsqlzPMQ6JRANYDKTowHD
         WNL1Lmtv2M3YPZCcfC9bkQlbUE/BUjm79QCGl7Z7aZV+1YQ3IuUImXmAuC9ZJd3R5Lp/
         5QjyKQzaS+nsGPwkuRwzncikYQcAv4alhuuto8pyXbkLvVLJV9evfJWS9N+xV1kRcs+J
         NwgQ==
X-Gm-Message-State: AOAM533ieu15sL2/3hO8YJ1GGTuaDlBsXmFMmt+alaoMI5Aicda5HTK1
        Kx3GVPnfEF/J10xGoBTvfDw98ReSzs+3kA==
X-Google-Smtp-Source: ABdhPJwG4hrC06OlBCvem6IXGkt20RTIn473stlTWux8ljmOgZdaOqCw921WN/3Gzlm9Uh29CFPwig==
X-Received: by 2002:aca:4f4d:: with SMTP id d74mr1910140oib.21.1611627950040;
        Mon, 25 Jan 2021 18:25:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l4sm1572995oou.8.2021.01.25.18.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:25:49 -0800 (PST)
Subject: Re: [PATCH v4 04/17] selftests/resctrl: Fix printed messages
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <20201130202010.178373-5-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <88836a02-6b3a-1a22-7652-e2a361f59d5a@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:25:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-5-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> Fix one instance where "not" (without a space) is printed on test
> failure resulting in output of "notok" on test failure.
> 
> Add a missing newline to the printed help text to improve readability.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/cmt_test.c      | 2 +-
>   tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 05a180d85e93..188b73b5a2cc 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -53,7 +53,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
>   	else
>   		res = false;
>   
> -	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
> +	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not ",
>   	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
>   

I noticed show_cache_info() is a duplicate of the one in cqm_test.c
Let's make this a common function.

I would make this a separate patch and before 2/7

>   	printf("# diff: %ld\n", avg_diff);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 2dceff59e245..d92b0b32a349 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -37,8 +37,8 @@ void detect_amd(void)
>   static void cmd_help(void)
>   {
>   	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> -	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
> -	printf("\t default benchmark is builtin fill_buf\n");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
> +	printf("\t   default benchmark is builtin fill_buf\n");
>   	printf("\t-t test list: run tests specified in the test list, ");
>   	printf("e.g. -t mbm, mba, cmt, cat\n");
>   	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
> 

thanks,
-- Shuah
