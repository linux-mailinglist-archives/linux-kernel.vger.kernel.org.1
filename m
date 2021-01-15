Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE612F8879
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAOWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbhAOWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:31:32 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE983C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:30:46 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n25so6937275pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPAgssYkyEXWMUN/H2MRBKMOOslP0x6cgfhRjcdxQzA=;
        b=K0IkGfWd8XNG6xovNoEmYmr4cqc/7M4dmNkwP6cC18o+adimK9YFdCElmxenKYrm2E
         AZf9dvKWNEDQEAqW2dvvX0FVVUcSj5kUZe8zKZKU+EX1+9XDkTUcp2UQbiloOgPbMVbV
         Lh9eIwN2VRJgZBLxaHGUG8sku0XPC5GhcbrVqBiJD3a9Zy5qT400TA4FnSqWG/lx16zU
         yDjMM3qfKck2nILkZXJh/rKvWGqv9YW1sPF6tukk6owU1cgH87GIEdCO9eetyx38w0Pz
         hVtieP1KR/oS1JigZompiQOPpEnzClKcl1b4wnelqpBuUfqN8ufkn/RrqExuYE+ZGQi5
         8L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPAgssYkyEXWMUN/H2MRBKMOOslP0x6cgfhRjcdxQzA=;
        b=N6kyoqGjx/EnndGMY7cpm6NBAtnZlM1nmonmNZWmVmN2qbDlpZKYNeofuoE8TjF4Kw
         vl4+UB43CwJtuRKsRmPp2yHtT64v+OEiNyojVsGW8K+vDUXGkgJ9nqgKAlplsjf4+U6e
         fJGAlklUmI27c7TAhghL5PEjrlRez7kGRZKgs3kQU5RUpnTGZUXYh0EMpDZ4m5NNZBdE
         pKqp1FGDsRhocFPJ6XtgGeHX4LFWvNf7/1zK4cumet1qctPzjPYqJB8XnqWa2Q6bOx+A
         ENQUSFVfv1WR/eln9FF2J1kSzOap3oh+VbBoygjIETxYbaD5eFcocmROLS/zIWk02X7j
         xzvQ==
X-Gm-Message-State: AOAM533iH1KLP3c9GaE2gmqgeB8QHmIuuAL4XbzbY0YHpdusZwqrR7NF
        iqmLZg20+Y3kLqeQU0+WgIpDQg==
X-Google-Smtp-Source: ABdhPJzhFyFiqZkU5qWWM+YNEndertm+e9NVC4t2YiJd8eXO8zVH2lLc2FOKm/tMtR7ZYvfZWJvqCQ==
X-Received: by 2002:a63:e24f:: with SMTP id y15mr14578288pgj.366.1610749846220;
        Fri, 15 Jan 2021 14:30:46 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y21sm9984418pfr.90.2021.01.15.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:30:45 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:30:43 -0700
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
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
Message-ID: <20210115223043.GA375055@xps15>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109074435.626855-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

On Sat, Jan 09, 2021 at 03:44:29PM +0800, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
> So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
> Thus we should trace the VMID with VMIDOPT set to trace
> CONTEXTIDR_EL2 instead of CONTEXTIDR_EL1. Given that we have an existing
> config option "contextid" and this will be useful for tracing
> virtual machines (when we get to support virtualization). So instead,
> this patch adds a new option, contextid_in_vmid as a separate config.
> Thus on an EL2 kernel, we will have two options available for
> the perf tool. However, to make it easier for the user to
> do pid tracing, we add a new format which will default to
> "contextid" (on EL1 kernel) or "contextid_in_vmid" (on EL2
> kernel). So that the user doesn't have to bother which EL the
> kernel is running.
> 
>  i.e, perf record -e cs_etm/pid/u --
> 
> will always do the "pid" tracing, independent of the kernel EL.
> 
> Also, the perf tool will be updated to automatically select
> "pid" config instead of the "contextid" for system wide/CPU wide
> mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c   | 14 ++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c |  9 +++++++++
>  include/linux/coresight-pmu.h                      | 11 +++++++----
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index bdc34ca449f7..f763def145e4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -30,14 +30,28 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>  /* ETMv3.5/PTM's ETMCR is 'config' */
>  PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>  PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
> +PMU_FORMAT_ATTR(contextid_in_vmid,	"config:" __stringify(ETM_OPT_CTXTID_IN_VMID));

I am not convinced adding this new contextid_in_vmid is the best way forward.

>  PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>  PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
>  /* Sink ID - same for all ETMs */
>  PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>  
> +static ssize_t format_attr_pid_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *page)
> +{
> +	int pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID_IN_VMID : ETM_OPT_CTXTID;
> +
> +	return sprintf(page, "config:%d\n", pid_fmt);
> +}
> +
> +struct device_attribute format_attr_pid = __ATTR(pid, 0444, format_attr_pid_show, NULL);

The same applies here.  PMU format bits are options the PMU supports rather than
a representation of the hardware, making bit numbering arbitrary.  A such we
don't explicitly need a contextid_in_vmid option.  Making the current contextid
variable, the same it was done for 'pid', should be sufficient.  Based on the
value carried by contexid, i.e 14 or 15, the perf tools will know where to get
the contextID.

With regards to backward functionality, user who hard code 'config' on the perf
command line won't get the results they want when the kernel is at EL2 anyway.

The kernel, with function is_kernel_in_hyp_mode(), is not an issue. 

> +
>  static struct attribute *etm_config_formats_attr[] = {
>  	&format_attr_cycacc.attr,
>  	&format_attr_contextid.attr,
> +	&format_attr_contextid_in_vmid.attr,
> +	&format_attr_pid.attr,
>  	&format_attr_timestamp.attr,
>  	&format_attr_retstack.attr,
>  	&format_attr_sinkid.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff17cf6..8b7c7a8b2874 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -477,6 +477,15 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
>  		/* bit[6], Context ID tracing bit */
>  		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
>  
> +	/* Do not enable VMID tracing if we are not running in EL2 */
> +	if (attr->config & BIT(ETM_OPT_CTXTID_IN_VMID)) {
> +		if (!is_kernel_in_hyp_mode()) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
> +	}
> +
>  	/* return stack - enable if selected and supported */
>  	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>  		/* bit[12], Return stack enable bit */
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index b0e35eec6499..927c6285ce5d 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
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
>  
>  static inline int coresight_get_trace_id(int cpu)
>  {
> -- 
> 2.25.1
> 
