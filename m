Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867EA2F88B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbhAOWpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhAOWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:44:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF1C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c79so6418645pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e81ibpl8m3OeV5P+npAe8fsvBPFGkb8COxfkkXMCuyw=;
        b=mHkfD/BfGifDNCYMMghuTWXVcN4Dgt/wtkTIDegfLOMf9hf7zC5k5/IpX71RYfdliG
         aLvSeAX8EgzE6OHk3w6i9rP3RL36cWz2AmvBxWqKBbOYaW6tXo6p3ETXNQyPhdwvxbPe
         zNMJu5xl1yLaFaY6LHKs5iyd5Ft4qSgUeKmrWKAcC6kgk3D8RXAE8D4p3IutvdKENmC6
         gewnPqyoG4pLTdAU9reerNLOKR7Jt9TobrJoiqjzCpfDsdqHtMTR/zuQm5rcofJbOu9g
         B4s0+fDXhTZC+gOy5uKTOIpTF1DXRjAqLlqxnd3xbQ42ee78/s05+cthLoUHR2UZC1po
         W6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e81ibpl8m3OeV5P+npAe8fsvBPFGkb8COxfkkXMCuyw=;
        b=M2Y2J5BUyDRXz74x4q+ct1WfZNE1s2fXS80BgDzUiwG8o1kL20iJaTQkoODByXVLkH
         2++a1ZZc5aH1Zv8uNIT03q1Ha4IRyEiwdW/j4EcXvcUjR19U6EOs9eAGCSm+9cOT/FbP
         EGycLuibxsLOGZ5vkYE4MHdfNWl9d60VB16WlbtIZZEOnMxt+u/rzvyEXf5CQ6U/UhAx
         Xh2oX6RdOff988QYSPdXNOJc1UVYFksayvKdwYxJtYk1Ca8ozb0AQTi1FipPs0ictB0U
         HxiAdUrgKweeQkDqoXD7zk7JpXVXtSS1v5LCTlbx5Oz/ja1EBx78hQ0OjzhBKmxMxMrG
         V5gw==
X-Gm-Message-State: AOAM530KfrRRkmrVS5oMtdfgS96fN7wNUrDsej6CB05+iBKA6BEX201g
        +Ejn1tbCsfDYyOKCuRlTVEumXA==
X-Google-Smtp-Source: ABdhPJzBgJUvyT9JP0751yR7tznQFt+eD+LP9SKU7un72IXbtUX9XPUI55Tp/pQCSAwzZMB/yfWImQ==
X-Received: by 2002:aa7:8712:0:b029:1a7:fe2e:1023 with SMTP id b18-20020aa787120000b02901a7fe2e1023mr14857576pfo.49.1610750659089;
        Fri, 15 Jan 2021 14:44:19 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a22sm9182764pfa.215.2021.01.15.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:44:16 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v1 2/7] perf cs_etm: Use pid tracing explicitly instead
 of contextid
Message-ID: <20210115224416.GB375055@xps15>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109074435.626855-3-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 03:44:30PM +0800, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> If the kernel is running at EL2, the pid of the task is exposed
> via VMID instead of the CONTEXTID. Add support for this in the
> perf tool.
> 
> By default the perf tool requests contextid and timestamp for
> task bound events. Instead of hard coding contextid, switch
> to "pid" config exposed by the kernel. While at it, define new
> independent macros (rather than using the "config" bits) for
> requesting the "pid" and "timestamp" for cs_etm_set_option(),
> since the PID config is now dynamic depending on the kernel
> exception level.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h | 11 +++--
>  tools/perf/arch/arm/util/cs-etm.c   | 68 ++++++++++++++++++++++-------
>  2 files changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index b0e35eec6499..927c6285ce5d 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -11,16 +11,19 @@
>  #define CORESIGHT_ETM_PMU_SEED  0x10
>  
>  /* ETMv3.5/PTM's ETMCR config bit */
> -#define ETM_OPT_CYCACC  12
> -#define ETM_OPT_CTXTID	14
> -#define ETM_OPT_TS      28
> -#define ETM_OPT_RETSTK	29
> +#define ETM_OPT_CYCACC		12
> +#define ETM_OPT_CTXTID		14
> +#define ETM_OPT_CTXTID_IN_VMID	15
> +#define ETM_OPT_TS		28
> +#define ETM_OPT_RETSTK		29
>  
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>  #define ETM4_CFG_BIT_CYCACC	4
>  #define ETM4_CFG_BIT_CTXTID	6
> +#define ETM4_CFG_BIT_VMID	7
>  #define ETM4_CFG_BIT_TS		11
>  #define ETM4_CFG_BIT_RETSTK	12
> +#define ETM4_CFG_BIT_VMID_OPT	15

Wasn't this done in the previous patch?

>  
>  static inline int coresight_get_trace_id(int cpu)
>  {
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index cad7bf783413..fad7b6e13ccc 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -59,14 +59,15 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
>  
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>  
> -static int cs_etm_set_context_id(struct auxtrace_record *itr,
> -				 struct evsel *evsel, int cpu)
> +static int cs_etm_set_pid(struct auxtrace_record *itr,
> +			  struct evsel *evsel, int cpu)
>  {
>  	struct cs_etm_recording *ptr;
>  	struct perf_pmu *cs_etm_pmu;
>  	char path[PATH_MAX];
>  	int err = -EINVAL;
>  	u32 val;
> +	u64 pid_fmt;
>  
>  	ptr = container_of(itr, struct cs_etm_recording, itr);
>  	cs_etm_pmu = ptr->cs_etm_pmu;
> @@ -86,21 +87,50 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  		goto out;
>  	}
>  
> +	pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");

If we go with my suggestion from patch 1 this would become "contextid".

I think what follows below is all good.

>  	/*
> -	 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
> -	 * is supported:
> -	 *  0b00000 Context ID tracing is not supported.
> -	 *  0b00100 Maximum of 32-bit Context ID size.
> -	 *  All other values are reserved.
> +	 * If the kernel doesn't support the "pid" format (older kernel),
> +	 * fall back to using the CTXTID.
>  	 */
> -	val = BMVAL(val, 5, 9);
> -	if (!val || val != 0x4) {
> +	if (!pid_fmt)
> +		pid_fmt = 1ULL << ETM_OPT_CTXTID;
> +
> +	switch (pid_fmt) {
> +	case (1ULL << ETM_OPT_CTXTID):
> +		/*
> +		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
> +		 * tracing is supported:
> +		 *  0b00000 Context ID tracing is not supported.
> +		 *  0b00100 Maximum of 32-bit Context ID size.
> +		 *  All other values are reserved.
> +		 */
> +		val = BMVAL(val, 5, 9);
> +		if (!val || val != 0x4) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +	case (1ULL << ETM_OPT_CTXTID_IN_VMID):
> +		/*
> +		 * TRCIDR2.VMIDOPT[30:29] != 0 and
> +		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
> +		 * We can't support CONTEXTIDR in VMID if the size of the
> +		 * virtual context id is < 32bit.
> +		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
> +		 */
> +		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +	default:
>  		err = -EINVAL;
>  		goto out;
>  	}
>  
> +
>  	/* All good, let the kernel know */
> -	evsel->core.attr.config |= (1 << ETM_OPT_CTXTID);
> +	evsel->core.attr.config |= pid_fmt;
>  	err = 0;
>  
>  out:
> @@ -156,6 +186,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
>  	return err;
>  }
>  
> +#define ETM_SET_OPT_PID		(1 << 0)
> +#define ETM_SET_OPT_TS		(1 << 1)
> +#define ETM_SET_OPT_MASK	(ETM_SET_OPT_PID | ETM_SET_OPT_TS)
> +

I don't think we need this as part of the current patchset.  Back in the days I
thought it would be a good idea to use the ETMv3.5/PTM configuration bits but in
hindsight it wasn't.  That's what happens when your crystal ball isn't working.

That being said we can start treating the perf_event_attr::config bits
arbitrarily.  Someone pointed out that it might get confusing but I don't think
it is anything that can't be overcomed with good in-line documentation.   

>  static int cs_etm_set_option(struct auxtrace_record *itr,
>  			     struct evsel *evsel, u32 option)
>  {
> @@ -169,17 +203,17 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
>  		    !cpu_map__has(online_cpus, i))
>  			continue;
>  
> -		if (option & ETM_OPT_CTXTID) {
> -			err = cs_etm_set_context_id(itr, evsel, i);
> +		if (option & ETM_SET_OPT_PID) {
> +			err = cs_etm_set_pid(itr, evsel, i);
>  			if (err)
>  				goto out;
>  		}
> -		if (option & ETM_OPT_TS) {
> +		if (option & ETM_SET_OPT_TS) {
>  			err = cs_etm_set_timestamp(itr, evsel, i);
>  			if (err)
>  				goto out;
>  		}
> -		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
> +		if (option & ~(ETM_SET_OPT_MASK))
>  			/* Nothing else is currently supported */
>  			goto out;
>  	}
> @@ -406,7 +440,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  		evsel__set_sample_bit(cs_etm_evsel, CPU);
>  
>  		err = cs_etm_set_option(itr, cs_etm_evsel,
> -					ETM_OPT_CTXTID | ETM_OPT_TS);
> +					ETM_SET_OPT_PID | ETM_SET_OPT_TS);
>  		if (err)
>  			goto out;
>  	}
> @@ -485,7 +519,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>  		config |= BIT(ETM4_CFG_BIT_TS);
>  	if (config_opts & BIT(ETM_OPT_RETSTK))
>  		config |= BIT(ETM4_CFG_BIT_RETSTK);
> -
> +	if (config_opts & BIT(ETM_OPT_CTXTID_IN_VMID))
> +		config |= BIT(ETM4_CFG_BIT_VMID) |
> +			  BIT(ETM4_CFG_BIT_VMID_OPT);
>  	return config;
>  }
>  
> -- 
> 2.25.1
> 
