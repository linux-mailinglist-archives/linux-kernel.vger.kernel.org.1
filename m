Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFB303AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbhAZKq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbhAZCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:09:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC28C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:08:58 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p72so30704368iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+FJZjz2nAWnPHRvoM0ksPEa7Bc9QRmXTCW24EpzGFj4=;
        b=RMImFjtIjvPyCeF8Ijm14l5AiHfxXrRiwuaF9DQVGADdoIWdFZ54tcPGGs97AO7WgE
         SvVHKFmcU2NmZe4Z4+RKTjsjz5cLnrGFt5ziQ80XenQguiA2vIbDNkzUrW+8xPqqJlgy
         7PtZFbyZqFdMQdJany2yQq2LGl8OLXfIQRoAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FJZjz2nAWnPHRvoM0ksPEa7Bc9QRmXTCW24EpzGFj4=;
        b=pf26a1lUL9QxRyvh4/hHSyiZy9gzVQ3pMfLqHsC/SR2IGHnyNKQwSIm/rbK8BFPZ72
         d8qMWHRAq6p7cYFLUkwlFJzf5dnVfVEXu2ykJKEoDc65PFNvuq8XEetquAFnlAFJWHzF
         +d1tTRgKEfwin0P/uF1LjEQdtTewxk6viBbR2Laq99pj5KoimuDMqFenTLosFamr14K3
         P5uF9Zi4Oy4ZtAiJjMWUHDtx0CayYGuw0E32HnejN2GY0QUAyTqmQpV+W2fCkusB0MNO
         ge3CnJ2bwoIams9aMRPlULpt1BLOkH3V6siVNL6Ri1Us9j8jAroBCl1ZI+6Hjm4BG4dy
         UrTQ==
X-Gm-Message-State: AOAM532bLTqzBzuS4G44kWFCbfKYZoiu3XIY7wR5vSXLHVNKuRDOTgjI
        mrO2WxCut32vBvM6xP78wuRC+yowcY6rXw==
X-Google-Smtp-Source: ABdhPJywyWCslOVyQuo5J4HUVG4Heah+VXqu3t3CLyvNXWxKyXxEKpaNlfUnoRR8BInZH4hQVjshWQ==
X-Received: by 2002:a05:6602:2c49:: with SMTP id x9mr2614209iov.173.1611626937383;
        Mon, 25 Jan 2021 18:08:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v7sm12616032iln.79.2021.01.25.18.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:08:56 -0800 (PST)
Subject: Re: [PATCH v4 02/17] selftests/resctrl: Clean up resctrl features
 check
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
 <20201130202010.178373-3-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8dcb048f-ed24-f75d-2782-13eacb64c807@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-3-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> Checking resctrl features call strcmp() to compare feature strings
> (e.g. "mba", "cat" etc). The checkings are error prone and don't have
> good coding style. Define the constant strings in macros and call
> strncmp() to solve the potential issues.
> 
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/cache.c       |  8 +++---
>   tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>   tools/testing/selftests/resctrl/cqm_test.c    |  2 +-
>   tools/testing/selftests/resctrl/fill_buf.c    |  4 +--
>   tools/testing/selftests/resctrl/mba_test.c    |  2 +-
>   tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
>   tools/testing/selftests/resctrl/resctrl.h     | 25 +++++++++++++++++++
>   .../testing/selftests/resctrl/resctrl_tests.c | 12 ++++-----
>   tools/testing/selftests/resctrl/resctrl_val.c | 19 ++++++--------
>   tools/testing/selftests/resctrl/resctrlfs.c   | 14 +++++------
>   10 files changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 38dbf4962e33..248bf000c978 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -182,7 +182,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>   	/*
>   	 * Measure cache miss from perf.
>   	 */
> -	if (!strcmp(param->resctrl_val, "cat")) {
> +	if (is_cat(param->resctrl_val)) {

Is there reason to add this function for one line of code?
Same comment for all these is_* routines in this patch.

>   		ret = get_llc_perf(&llc_perf_miss);
>   		if (ret < 0)
>   			return ret;
> @@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>   	/*
>   	 * Measure llc occupancy from resctrl.
>   	 */
> -	if (!strcmp(param->resctrl_val, "cqm")) {
> +	if (is_cqm(param->resctrl_val)) {
>   		ret = get_llc_occu_resctrl(&llc_occu_resc);
>   		if (ret < 0)
>   			return ret;
> @@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param)
>   	if (ret)
>   		return ret;
>   
> -	if ((strcmp(resctrl_val, "cat") == 0)) {
> +	if (is_cat(resctrl_val)) {
>   		ret = initialize_llc_perf();
>   		if (ret)
>   			return ret;
> @@ -242,7 +242,7 @@ int cat_val(struct resctrl_val_param *param)
>   
>   	/* Test runs until the callback setup() tells the test to stop. */
>   	while (1) {
> -		if (strcmp(resctrl_val, "cat") == 0) {
> +		if (is_cat(resctrl_val)) {
>   			ret = param->setup(1, param);
>   			if (ret) {
>   				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 7f723bd8f328..6d9a41f3939a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -160,7 +160,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>   		return -1;
>   
>   	struct resctrl_val_param param = {
> -		.resctrl_val	= "cat",
> +		.resctrl_val	= CAT_STR,
>   		.cpu_no		= cpu_no,
>   		.mum_resctrlfs	= 0,
>   		.setup		= cat_setup,
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
> index b6af940ccfc2..6635b24a74cc 100644
> --- a/tools/testing/selftests/resctrl/cqm_test.c
> +++ b/tools/testing/selftests/resctrl/cqm_test.c
> @@ -142,7 +142,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>   	}
>   
>   	struct resctrl_val_param param = {
> -		.resctrl_val	= "cqm",
> +		.resctrl_val	= CQM_STR,
>   		.ctrlgrp	= "c1",
>   		.mongrp		= "m1",
>   		.cpu_no		= cpu_no,
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 79c611c99a3d..bece8bb4b575 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
>   
>   	while (1) {
>   		ret = fill_one_span_read(start_ptr, end_ptr);
> -		if (!strcmp(resctrl_val, "cat"))
> +		if (is_cat(resctrl_val))
>   			break;
>   	}
>   
> @@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
>   {
>   	while (1) {
>   		fill_one_span_write(start_ptr, end_ptr);
> -		if (!strcmp(resctrl_val, "cat"))
> +		if (is_cat(resctrl_val))
>   			break;
>   	}
>   
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7bf8eaa6204b..6449fbd96096 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -141,7 +141,7 @@ void mba_test_cleanup(void)
>   int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
>   {
>   	struct resctrl_val_param param = {
> -		.resctrl_val	= "mba",
> +		.resctrl_val	= MBA_STR,
>   		.ctrlgrp	= "c1",
>   		.mongrp		= "m1",
>   		.cpu_no		= cpu_no,
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 4700f7453f81..ec6cfe01c9c2 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -114,7 +114,7 @@ void mbm_test_cleanup(void)
>   int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
>   {
>   	struct resctrl_val_param param = {
> -		.resctrl_val	= "mbm",
> +		.resctrl_val	= MBM_STR,
>   		.ctrlgrp	= "c1",
>   		.mongrp		= "m1",
>   		.span		= span,
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 12b77182cb44..bfbc16b39a9e 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -62,6 +62,31 @@ struct resctrl_val_param {
>   	int		(*setup)(int num, ...);
>   };
>   
> +#define MBM_STR			"mbm"
> +#define MBA_STR			"mba"
> +#define CQM_STR			"cqm"
> +#define CAT_STR			"cat"
> +

This is fine.

> +static inline bool is_mbm(const char *str)
> +{
> +	return !strncmp(str, MBM_STR, 3);

Why not use sizeof(MBM_STR) instead of hardcoding?
Same comment on all the other such usahes below.

> +}
> +
There is no need to add an entire routine for this.

> +static inline bool is_mba(const char *str)
> +{
> +	return !strncmp(str, MBA_STR, 3);
> +}
> +

There is no need to add an entire routine for this.

> +static inline bool is_cqm(const char *str)
> +{
> +	return !strncmp(str, CQM_STR, 3);
> +}
> +

There is no need to add an entire routine for this.

> +static inline bool is_cat(const char *str)
> +{
> +	return !strncmp(str, CAT_STR, 3);
> +}
> +

There is no need to add an entire routine for this.

>   extern pid_t bm_pid, ppid;
>   extern int tests_run;
>   
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 425cc85ac883..f425eaf8c331 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -85,13 +85,13 @@ int main(int argc, char **argv)
>   			cqm_test = false;
>   			cat_test = false;
>   			while (token) {
> -				if (!strcmp(token, "mbm")) {
> +				if (is_mbm(token)) {
>   					mbm_test = true;
> -				} else if (!strcmp(token, "mba")) {
> +				} else if (is_mba(token)) {
>   					mba_test = true;
> -				} else if (!strcmp(token, "cqm")) {
> +				} else if (is_cqm(token)) {
>   					cqm_test = true;
> -				} else if (!strcmp(token, "cat")) {
> +				} else if (is_cat(token)) {
>   					cat_test = true;
>   				} else {
>   					printf("invalid argument\n");
> @@ -161,7 +161,7 @@ int main(int argc, char **argv)
>   	if (!is_amd && mbm_test) {
>   		printf("# Starting MBM BW change ...\n");
>   		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", "mba");
> +			sprintf(benchmark_cmd[5], "%s", MBA_STR);
>   		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
>   		printf("%sok MBM: bw change\n", res ? "not " : "");
>   		mbm_test_cleanup();
> @@ -181,7 +181,7 @@ int main(int argc, char **argv)
>   	if (cqm_test) {
>   		printf("# Starting CQM test ...\n");
>   		if (!has_ben)
> -			sprintf(benchmark_cmd[5], "%s", "cqm");
> +			sprintf(benchmark_cmd[5], "%s", CQM_STR);
>   		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
>   		printf("%sok CQM: test\n", res ? "not " : "");
>   		cqm_test_cleanup();
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 520fea3606d1..f55e04a30a77 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -397,10 +397,10 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
>   		return;
>   	}
>   
> -	if (strcmp(resctrl_val, "mbm") == 0)
> +	if (is_mbm(resctrl_val))
>   		set_mbm_path(ctrlgrp, mongrp, resource_id);
>   
> -	if ((strcmp(resctrl_val, "mba") == 0)) {
> +	if (is_mba(resctrl_val)) {
>   		if (ctrlgrp)
>   			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
>   				RESCTRL_PATH, ctrlgrp, resource_id);
> @@ -524,7 +524,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>   		return;
>   	}
>   
> -	if (strcmp(resctrl_val, "cqm") == 0)
> +	if (is_cqm(resctrl_val))
>   		set_cqm_path(ctrlgrp, mongrp, resource_id);
>   }
>   
> @@ -579,8 +579,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   	if (strcmp(param->filename, "") == 0)
>   		sprintf(param->filename, "stdio");
>   
> -	if ((strcmp(resctrl_val, "mba")) == 0 ||
> -	    (strcmp(resctrl_val, "mbm")) == 0) {
> +	if (is_mba(resctrl_val) || is_mbm(resctrl_val)) {
>   		ret = validate_bw_report_request(param->bw_report);
>   		if (ret)
>   			return ret;
> @@ -674,15 +673,14 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   	if (ret)
>   		goto out;
>   
> -	if ((strcmp(resctrl_val, "mbm") == 0) ||
> -	    (strcmp(resctrl_val, "mba") == 0)) {
> +	if (is_mbm(resctrl_val) || is_mba(resctrl_val)) {
>   		ret = initialize_mem_bw_imc();
>   		if (ret)
>   			goto out;
>   
>   		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>   					  param->cpu_no, resctrl_val);
> -	} else if (strcmp(resctrl_val, "cqm") == 0)
> +	} else if (is_cqm(resctrl_val))
>   		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
>   					    param->cpu_no, resctrl_val);
>   
> @@ -710,8 +708,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   
>   	/* Test runs until the callback setup() tells the test to stop. */
>   	while (1) {
> -		if ((strcmp(resctrl_val, "mbm") == 0) ||
> -		    (strcmp(resctrl_val, "mba") == 0)) {
> +		if (is_mbm(resctrl_val) || is_mba(resctrl_val)) {
>   			ret = param->setup(1, param);
>   			if (ret) {
>   				ret = 0;
> @@ -721,7 +718,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>   			ret = measure_vals(param, &bw_resc_start);
>   			if (ret)
>   				break;
> -		} else if (strcmp(resctrl_val, "cqm") == 0) {
> +		} else if (is_cqm(resctrl_val)) {
>   			ret = param->setup(1, param);
>   			if (ret) {
>   				ret = 0;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 2a16100c9c3f..dc4f1286aefa 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>   		operation = atoi(benchmark_cmd[4]);
>   		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
>   
> -		if (strcmp(resctrl_val, "cqm") != 0)
> +		if (!is_cqm(resctrl_val))
>   			buffer_span = span * MB;
>   		else
>   			buffer_span = span;
> @@ -459,8 +459,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   		goto out;
>   
>   	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
> -	if ((strcmp(resctrl_val, "cqm") == 0) ||
> -	    (strcmp(resctrl_val, "mbm") == 0)) {
> +	if (is_cqm(resctrl_val) || is_mbm(resctrl_val)) {
>   		if (strlen(mongrp)) {
>   			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
>   			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
> @@ -505,9 +504,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>   	int resource_id, ret = 0;
>   	FILE *fp;
>   
> -	if ((strcmp(resctrl_val, "mba") != 0) &&
> -	    (strcmp(resctrl_val, "cat") != 0) &&
> -	    (strcmp(resctrl_val, "cqm") != 0))
> +	if (!is_mba(resctrl_val) && !is_cat(resctrl_val) &&
> +	    !is_cqm(resctrl_val))
>   		return -ENOENT;
>   
>   	if (!schemata) {
> @@ -528,9 +526,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>   	else
>   		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
>   
> -	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
> +	if (is_cat(resctrl_val) || is_cqm(resctrl_val))
>   		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> -	if (strcmp(resctrl_val, "mba") == 0)
> +	if (is_mba(resctrl_val))
>   		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
>   
>   	fp = fopen(controlgroup, "w");
> 

thanks,
-- Shuah
