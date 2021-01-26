Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113E4303CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbhAZKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbhAZCiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:50 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0025FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:38:09 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p72so30805313iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d9YYUjyIB4GGMnPEwa7CwHtQ1NRrD225KBJEU/zz65g=;
        b=UlrTLpjZriVDlVXUTeyDfXd3Oz02UoaNItJVJXf4uETCPWuCiFPU6B9e/JzY5U9GSJ
         BdHMHNhgpd4XivtpLRMCCzA2JAKWoh6EnKBAAJgGgR71zJkzbDp/j7ZCnEDoZvuL7MGQ
         /gmMOVmlSxo39pf5BTzt2RPTITWhsVN/ug2Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d9YYUjyIB4GGMnPEwa7CwHtQ1NRrD225KBJEU/zz65g=;
        b=ElL8VSpUX3kr+DUhsGQ5ZFwxLNQgHVyHnMBFCAJEK1fiKHzIxrAx1SXJ7Z4izcGBrK
         /26cAo0DDPhhgA7kmMMjqp80aFHBEdKk2KS/CVAP9kAkS1hF/IwINu6Mokc6v7aPm0W1
         a7uuyPgY9GG1SJ1eebRptmT0/Y9e9+9iEoClWxBUG47kBSpfnSDBaSiAvCgjMpYemXdT
         MAj1rqB3DjMgSKflA4dOfLCtF+8B6ulKOKhyVJf53psPwzRod3nSSZL1DyOUB73GJmF6
         4wsnTBVJ4gWFqiqotQvPXbWe0sBtkSt577hefgmqIlirijH5VJeU0z4ES90zojRWHImZ
         MGhg==
X-Gm-Message-State: AOAM532B51YPCghs3pgNeU16CJiI2xrJ5EnLJRLlVp2s5HVQc/ikO045
        45ahzSg1tldHBiyYh6+itKLUXHs+zw7qwA==
X-Google-Smtp-Source: ABdhPJxbbDdVCu94CkSvgp3Vmk8oIyl8132USut+HwzVAUtSnFlTGoUJ6fgMagD/ptC5b7qVvxj71A==
X-Received: by 2002:a5e:c81a:: with SMTP id y26mr2708436iol.67.1611628688892;
        Mon, 25 Jan 2021 18:38:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm12503110iln.65.2021.01.25.18.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:38:08 -0800 (PST)
Subject: Re: [PATCH v4 10/17] selftests/resctrl: Fix MBA/MBM results reporting
 format
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
 <20201130202010.178373-11-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <112f84b0-c7c1-7b92-75f9-d71d557ecbe2@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-11-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:20 PM, Fenghua Yu wrote:
> MBM unit test starts fill_buf (default built-in benchmark) in a new con_mon
> group (c1, m1) and records resctrl reported mbm values and iMC (Integrated
> Memory Controller) values every second. It does this for five seconds
> (randomly chosen value) in total. It then calculates average of resctrl_mbm
> values and imc_mbm values and if the difference is greater than 300 MB/sec
> (randomly chosen value), the test treats it as a failure. MBA unit test is
> similar to MBM but after every run it changes schemata.
> 
> Checking for a difference of 300 MB/sec doesn't look very meaningful when
> the mbm values are changing over a wide range. For example, below are the
> values running MBA test on SKL with different allocations
> 
> 1. With 10% as schemata both iMC and resctrl mbm_values are around 2000
>     MB/sec
> 2. With 100% as schemata both iMC and resctrl mbm_values are around 10000
>     MB/sec
> 
> A 300 MB/sec difference between resctrl_mbm and imc_mbm values is
> acceptable at 100% schemata but it isn't acceptable at 10% schemata because
> that's a huge difference.
> 
> So, fix this by checking for percentage difference instead of absolute
> difference i.e. check if the difference between resctrl_mbm value and
> imc_mbm value is within 5% (randomly chosen value) of imc_mbm value. If the
> difference is greater than 5% of imc_mbm value, treat it is a failure.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/mba_test.c | 20 +++++++++++---------
>   tools/testing/selftests/resctrl/mbm_test.c | 13 +++++++------
>   2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 6449fbd96096..b4c81d2ee53b 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -12,7 +12,7 @@
>   
>   #define RESULT_FILE_NAME	"result_mba"
>   #define NUM_OF_RUNS		5
> -#define MAX_DIFF		300
> +#define MAX_DIFF_PERCENT	5
>   #define ALLOCATION_MAX		100
>   #define ALLOCATION_MIN		10
>   #define ALLOCATION_STEP		10
> @@ -62,7 +62,8 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   	     allocation++) {
>   		unsigned long avg_bw_imc, avg_bw_resc;
>   		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> -		unsigned long avg_diff;
> +		int avg_diff_per;
> +		float avg_diff;
>   
>   		/*
>   		 * The first run is discarded due to inaccurate value from
> @@ -76,17 +77,18 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>   
>   		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>   		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
> -		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
> +		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> +		avg_diff_per = (int)(avg_diff * 100);
>   
> -		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
> -		       avg_diff > MAX_DIFF ? "not " : "",
> -		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
> -		       MAX_DIFF);
> +		printf("%sok MBA: diff within %d%% for schemata %u\n",
> +		       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "",
> +		       MAX_DIFF_PERCENT,
> +		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
>   		tests_run++;
> -		printf("# avg_diff: %lu\n", avg_diff);
> +		printf("# avg_diff_per: %d%%\n", avg_diff_per);
>   		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
>   		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
> -		if (avg_diff > MAX_DIFF)
> +		if (avg_diff_per > MAX_DIFF_PERCENT)
>   			failed = true;
>   	}
>   
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index ec6cfe01c9c2..672d3ddd6e85 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -11,7 +11,7 @@
>   #include "resctrl.h"
>   
>   #define RESULT_FILE_NAME	"result_mbm"
> -#define MAX_DIFF		300
> +#define MAX_DIFF_PERCENT	5
>   #define NUM_OF_RUNS		5
>   
>   static void
> @@ -19,8 +19,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>   {
>   	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
>   	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> -	long avg_diff = 0;
> -	int runs;
> +	int runs, avg_diff_per;
> +	float avg_diff = 0;
>   
>   	/*
>   	 * Discard the first value which is inaccurate due to monitoring setup
> @@ -33,12 +33,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>   
>   	avg_bw_imc = sum_bw_imc / 4;
>   	avg_bw_resc = sum_bw_resc / 4;
> -	avg_diff = avg_bw_resc - avg_bw_imc;
> +	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> +	avg_diff_per = (int)(avg_diff * 100);
>   
>   	printf("%sok MBM: diff within %d%%\n",
> -	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
> +	       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "", MAX_DIFF_PERCENT);
>   	tests_run++;
> -	printf("# avg_diff: %lu\n", labs(avg_diff));
> +	printf("# avg_diff_per: %d%%\n", avg_diff_per);
>   	printf("# Span (MB): %d\n", span);
>   	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
>   	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
> 

Can we move all the name changes after the real fixes?

thanks,
-- Shuah
