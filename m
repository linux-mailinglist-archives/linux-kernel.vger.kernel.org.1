Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8781B2F1AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbhAKQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbhAKQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:23:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F44C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:22:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t30so415448wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gwQH6dtzsCy0fjQ/z11MBCBLa3D12iPspZ6VAfJeoA=;
        b=uYcqJwcLzshcKsQam0fUoCPbBq99OHpRgeQ7eC9tN7owwXHrcUuq9QCgxefFgn+TGO
         Xl9l73pSVU+uIw0tKDTaqCc8Uo+FnNwbw3etnCmT+DtC+s1bDFA3bWU7/VSByuUR2LVe
         5oGyTvaFSMcljxhWQGKxXxZjk1jOyQGeTlaj/8hFIEn4wtu/j6HO8x/z86ZKEdgJsCtj
         NYHyxO8TN/I0RWGiL0a3VIfwsCLU5KJ2QIwuPeqd4AQiaT4KUSJdXY8A2CKPKsfANRxe
         9FAoSsFtJvhiy2T7kV2z5LDpESQlJ6dH3PPVnr2nJEhfPh2XNR+CqYwIMwgZFrlmOsXw
         j8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gwQH6dtzsCy0fjQ/z11MBCBLa3D12iPspZ6VAfJeoA=;
        b=Bf0uLjGE68BJlmGLwAgybiK9ryR+9gGx3xlQ0lYqS8RcDTPyVvoQEdXQODvljlF+7h
         AQWp4wivU2wnjMh2aI6d2sXt0NDZXS0j1cS5J84Rty/tgn3X95eQbTG811qm9ozzmmlq
         JQ/NJZKTWKHkcHnFuxzyxm4JpSccndL14/86T68VAvOixsm9u5iliut3DmbkDCa564R9
         bLjn0lDyLvVvaJ4KdAaU7/vMeYbkrgwCalKlthEIjs29+8ain+9E2uO2IT3fbWR8STk3
         7j13fgRoXaK+0HVPONFaRtWsnhbIJHtdO+T0vcMpyFpwz2eyZ6Yi8r5ZRL+zBmrY2lvQ
         48ig==
X-Gm-Message-State: AOAM531RvmgXiGQ0m0/+wg8pQn0xkYSBUtM+29bhFKDuWmmWUJp2xRC8
        DQVKEytsTKh/yX9XJQnbuVEc3HC8jxsh0Wgc/NPWaw==
X-Google-Smtp-Source: ABdhPJxlSpdfwpazOxBawRiWOItqIjORYiPJRS5XT4CBdZIHGGqMAjuI3c2hwCPmiIV+OyuSU7t1WnZa05fL/Jsm13M=
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr16661832wra.275.1610382170314;
 Mon, 11 Jan 2021 08:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20210109074435.626855-1-leo.yan@linaro.org> <20210109074435.626855-2-leo.yan@linaro.org>
In-Reply-To: <20210109074435.626855-2-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 11 Jan 2021 16:22:39 +0000
Message-ID: <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sat, 9 Jan 2021 at 07:44, Leo Yan <leo.yan@linaro.org> wrote:
>
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
>  PMU_FORMAT_ATTR(cycacc,                "config:" __stringify(ETM_OPT_CYCACC));
>  PMU_FORMAT_ATTR(contextid,     "config:" __stringify(ETM_OPT_CTXTID));
> +PMU_FORMAT_ATTR(contextid_in_vmid,     "config:" __stringify(ETM_OPT_CTXTID_IN_VMID));
>  PMU_FORMAT_ATTR(timestamp,     "config:" __stringify(ETM_OPT_TS));
>  PMU_FORMAT_ATTR(retstack,      "config:" __stringify(ETM_OPT_RETSTK));
>  /* Sink ID - same for all ETMs */
>  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
>
> +static ssize_t format_attr_pid_show(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *page)
> +{
> +       int pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID_IN_VMID : ETM_OPT_CTXTID;
> +
> +       return sprintf(page, "config:%d\n", pid_fmt);
> +}
> +
> +struct device_attribute format_attr_pid = __ATTR(pid, 0444, format_attr_pid_show, NULL);
> +
>  static struct attribute *etm_config_formats_attr[] = {
>         &format_attr_cycacc.attr,
>         &format_attr_contextid.attr,
> +       &format_attr_contextid_in_vmid.attr,
> +       &format_attr_pid.attr,
>         &format_attr_timestamp.attr,
>         &format_attr_retstack.attr,
>         &format_attr_sinkid.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff17cf6..8b7c7a8b2874 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -477,6 +477,15 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
>                 /* bit[6], Context ID tracing bit */
>                 config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
>
> +       /* Do not enable VMID tracing if we are not running in EL2 */
> +       if (attr->config & BIT(ETM_OPT_CTXTID_IN_VMID)) {
> +               if (!is_kernel_in_hyp_mode()) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +               config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
> +       }
> +
>         /* return stack - enable if selected and supported */
>         if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>                 /* bit[12], Return stack enable bit */
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index b0e35eec6499..927c6285ce5d 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -11,16 +11,19 @@
>  #define CORESIGHT_ETM_PMU_SEED  0x10
>
>  /* ETMv3.5/PTM's ETMCR config bit */
> -#define ETM_OPT_CYCACC  12
> -#define ETM_OPT_CTXTID 14
> -#define ETM_OPT_TS      28
> -#define ETM_OPT_RETSTK 29
> +#define ETM_OPT_CYCACC         12
> +#define ETM_OPT_CTXTID         14
> +#define ETM_OPT_CTXTID_IN_VMID 15

Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
with the ETM3.5 options?

Regards

Mike

> +#define ETM_OPT_TS             28
> +#define ETM_OPT_RETSTK         29
>
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>  #define ETM4_CFG_BIT_CYCACC    4
>  #define ETM4_CFG_BIT_CTXTID    6
> +#define ETM4_CFG_BIT_VMID      7
>  #define ETM4_CFG_BIT_TS                11
>  #define ETM4_CFG_BIT_RETSTK    12
> +#define ETM4_CFG_BIT_VMID_OPT  15
>
>  static inline int coresight_get_trace_id(int cpu)
>  {
> --
> 2.25.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
