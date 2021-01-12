Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0252F28DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbhALHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388500AbhALHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:23:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:23:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id my11so424294pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WmlY6cB1KziWR4qZ1ENND6Ny3UeS1N+iTUZ1zXSZW5g=;
        b=bIyPU7ixJOkuVRan0CZeEbbek0ZZ22v8ccu2WZCuSxlDkn6wqgXZ+LXbYH7wtNpzWf
         k31NmGUPRicjifDZVg+8jveHZq5YGKConluAG0tuhOAkU/KuhOh4Tc5Y4LKSAUmv4Y4+
         TQju0b+TyjTxc3YsK2tDtGWdUtKHWYgTiAkKJot6sWz8ANcu2yOxh5PAIoSc/Ne+gURi
         UuUDOjoIxFC4fVUqKNbF2V/YGMNWRUCbPshK1nUnxJcNI2NVYp6jbfE1FmbJpK9fL/Rm
         JzieM76v0G+5OSgOTzl89DWGrU/nFUwuyBasWcS2FwvY5rU6EJO4kFnz55q6aomTKWH0
         uTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmlY6cB1KziWR4qZ1ENND6Ny3UeS1N+iTUZ1zXSZW5g=;
        b=mPsGTj+6TDs7WKaA+qQjwR1N7MRsskl/MhkTzb5FawQFBxEN12VwQE9yEFFy4CqH7+
         WUveyGDHOjPnR1PiMcp7G6Vh/RQ0b5VLLjRU85vh4u2+TlzJLjSUYlIKdQ6B17720SnK
         TPK3cIDvfrPvgBaDGHOnEfspx9BE1Y+UQGgw9WLCkbnK9z1dqOgSctgW/ixshD5YSBx1
         r4zQVCNsXa0Kv0pYtbqk6aYFzI9ql1g4Q7ZPHGjv+x+T96tAm3Q1BOqU9DxuPdg+AZd6
         z/a+5KZJ6dtxhG4DhiPdQz3q7c+ARuhvgCX6lVzfHD2ZHWgHvebt0o5bBBFAJIHVKa8h
         xoXw==
X-Gm-Message-State: AOAM5303CtQXRBUIXUtdygca9ZAIqbyeB3erbF+oqlXiqOmbzcG9OX59
        8HPrDyxZjI5BMthG+IlHySxBUw==
X-Google-Smtp-Source: ABdhPJwNnuAwInB8+SbAtG3x0KGldKuAwjsHAf8rAYwQyZm5xpl89DE+HU6zzOy6wiKQoto9RDML/A==
X-Received: by 2002:a17:90b:3596:: with SMTP id mm22mr3112906pjb.235.1610436185536;
        Mon, 11 Jan 2021 23:23:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id mv17sm1420438pjb.17.2021.01.11.23.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 23:23:04 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:22:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
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
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
Message-ID: <20210112072257.GA18965@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-2-leo.yan@linaro.org>
 <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> On Sat, 9 Jan 2021 at 07:44, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
> > So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
> > Thus we should trace the VMID with VMIDOPT set to trace
> > CONTEXTIDR_EL2 instead of CONTEXTIDR_EL1. Given that we have an existing
> > config option "contextid" and this will be useful for tracing
> > virtual machines (when we get to support virtualization). So instead,
> > this patch adds a new option, contextid_in_vmid as a separate config.
> > Thus on an EL2 kernel, we will have two options available for
> > the perf tool. However, to make it easier for the user to
> > do pid tracing, we add a new format which will default to
> > "contextid" (on EL1 kernel) or "contextid_in_vmid" (on EL2
> > kernel). So that the user doesn't have to bother which EL the
> > kernel is running.
> >
> >  i.e, perf record -e cs_etm/pid/u --
> >
> > will always do the "pid" tracing, independent of the kernel EL.
> >
> > Also, the perf tool will be updated to automatically select
> > "pid" config instead of the "contextid" for system wide/CPU wide
> > mode.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Al Grant <al.grant@arm.com>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm-perf.c   | 14 ++++++++++++++
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c |  9 +++++++++
> >  include/linux/coresight-pmu.h                      | 11 +++++++----
> >  3 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index bdc34ca449f7..f763def145e4 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -30,14 +30,28 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> >  /* ETMv3.5/PTM's ETMCR is 'config' */
> >  PMU_FORMAT_ATTR(cycacc,                "config:" __stringify(ETM_OPT_CYCACC));
> >  PMU_FORMAT_ATTR(contextid,     "config:" __stringify(ETM_OPT_CTXTID));
> > +PMU_FORMAT_ATTR(contextid_in_vmid,     "config:" __stringify(ETM_OPT_CTXTID_IN_VMID));
> >  PMU_FORMAT_ATTR(timestamp,     "config:" __stringify(ETM_OPT_TS));
> >  PMU_FORMAT_ATTR(retstack,      "config:" __stringify(ETM_OPT_RETSTK));
> >  /* Sink ID - same for all ETMs */
> >  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
> >
> > +static ssize_t format_attr_pid_show(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   char *page)
> > +{
> > +       int pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID_IN_VMID : ETM_OPT_CTXTID;
> > +
> > +       return sprintf(page, "config:%d\n", pid_fmt);
> > +}
> > +
> > +struct device_attribute format_attr_pid = __ATTR(pid, 0444, format_attr_pid_show, NULL);
> > +
> >  static struct attribute *etm_config_formats_attr[] = {
> >         &format_attr_cycacc.attr,
> >         &format_attr_contextid.attr,
> > +       &format_attr_contextid_in_vmid.attr,
> > +       &format_attr_pid.attr,
> >         &format_attr_timestamp.attr,
> >         &format_attr_retstack.attr,
> >         &format_attr_sinkid.attr,
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index b20b6ff17cf6..8b7c7a8b2874 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -477,6 +477,15 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
> >                 /* bit[6], Context ID tracing bit */
> >                 config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
> >
> > +       /* Do not enable VMID tracing if we are not running in EL2 */
> > +       if (attr->config & BIT(ETM_OPT_CTXTID_IN_VMID)) {
> > +               if (!is_kernel_in_hyp_mode()) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> > +               config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
> > +       }
> > +
> >         /* return stack - enable if selected and supported */
> >         if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> >                 /* bit[12], Return stack enable bit */
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index b0e35eec6499..927c6285ce5d 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -11,16 +11,19 @@
> >  #define CORESIGHT_ETM_PMU_SEED  0x10
> >
> >  /* ETMv3.5/PTM's ETMCR config bit */
> > -#define ETM_OPT_CYCACC  12
> > -#define ETM_OPT_CTXTID 14
> > -#define ETM_OPT_TS      28
> > -#define ETM_OPT_RETSTK 29
> > +#define ETM_OPT_CYCACC         12
> > +#define ETM_OPT_CTXTID         14
> > +#define ETM_OPT_CTXTID_IN_VMID 15
> 
> Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
> may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
> with the ETM3.5 options?

Will fix it.  Thanks for pointing out.

> Regards
> 
> Mike
> 
> > +#define ETM_OPT_TS             28
> > +#define ETM_OPT_RETSTK         29
> >
> >  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> >  #define ETM4_CFG_BIT_CYCACC    4
> >  #define ETM4_CFG_BIT_CTXTID    6
> > +#define ETM4_CFG_BIT_VMID      7
> >  #define ETM4_CFG_BIT_TS                11
> >  #define ETM4_CFG_BIT_RETSTK    12
> > +#define ETM4_CFG_BIT_VMID_OPT  15
> >
> >  static inline int coresight_get_trace_id(int cpu)
> >  {
> > --
> > 2.25.1
> >
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
