Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324F52F2A76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405650AbhALI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbhALI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:59:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9550C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:58:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so1036533pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BffoWkdajidn6mUZtfPUrCN8QNfUBikkzP+rt9hLCqQ=;
        b=Lj2Taz3w0I4tL70yscixADOB70IZyBveEKsSFXVGhNPLcrUEcl8eXffpp48Mq4IfXG
         2W1guTJczu81hSbtXSU8ZucWF5wKDc1h63YEIc6h0Za1J6AOfCGVkCMahpT+Awu8SgpI
         qxhCfelccdYmsEJG7dBCNlr8+stvk7Na/am5AiU/cGOjUcAMUR+Fse702hOzWvcpkJQT
         tQKeuKHnosIY04skDZJ7Be+osUF47V0W+He3UTJndOZAsuxCziaBXiFUx0tr8UWs/0ch
         bEdiVjCFmIaUXaODo2KifBdX6wxkGpbq8JR/6U7tAjXsBFLdmsqrwSYCFZuNc3WS0xzp
         Pcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BffoWkdajidn6mUZtfPUrCN8QNfUBikkzP+rt9hLCqQ=;
        b=BSfoLxYJhchRwncjMzJstHO9H8BZPLhODRpHXlpOVmapE3xaaTu02P3tmdSlfWSEOg
         gzDfqMw5nnhk99ChoJzM/M3bUxnx0iUVpCO/6NCLWeRR3x0pW0W7UqOJAGp2bzDQ9hhY
         5wwoRCnMNs2xMfVfEPcDpMq5wDJlx4q5OlqKn1j2cwqdfCYL2AUUZOEBh28u+7RUYqfU
         8lyl4zt32v+zzuk9nMQaK2jin/52hEuT82zEBACzUUZQ+nqMcYo8LaS+oISZjx3OZ4QM
         7aySmsbVoF7umDxTulFnFP+nc4ntWX8tXqyS/9OiFKcdZP3M68c5xNLM67TjzgTGyRbb
         lJNw==
X-Gm-Message-State: AOAM530jpdlXPEU2Sv/7RFeaUCZnDse5nlSzqVMIMaPIhoq6XHUZpvik
        T6dWO9agw7iCB0bLi2nCFDK76g==
X-Google-Smtp-Source: ABdhPJx+5Y6TruDKBvo7P98iPsMFNkjQBUIUGc/yn/TCf4ZvyWf+Hu0y46hVvRbuupDFS2oyqSk6SA==
X-Received: by 2002:a17:90a:bb83:: with SMTP id v3mr3536246pjr.28.1610441912386;
        Tue, 12 Jan 2021 00:58:32 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id v10sm2228716pjr.47.2021.01.12.00.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:58:31 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:58:26 +0800
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
Message-ID: <20210112085826.GC18965@leoy-ThinkPad-X240s>
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

Hi Mike,

On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:

[...]

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

I looked into this suggestion but found it's complex than I assumed.
This config bits are not only used for ETMv3.x / PTM, it's also used
as an configuration interface between user space in Perf and kernel
drivers.

For example, in the userspace, perf tool sets bit ETM_OPT_TS to enable
timestamp [1], this is same for ETMv3 and ETMv4.  In the kernel side,
the configuration is directly used ETMv3 (in coresight-etm3x-core.c),
but the configuration bits are converted for ETMv4 in the function
etm4_parse_event_config() [2].

So this is a historical issue, at the early period ETMv3 and ETMv4 can
be compatible with each other for configurations, but after evoluation,
some configs only belong to ETMv4 and cannot be applied on ETMv3
anymore, but we still use ETMv3.5 config bits as the interface between
kernel and userspace.

I'd like suggest we use a saperate patch set to refactor the
configuration bits, e.g. define the arbitrary configuration bits as
interface between user space and kernel, these bits are neutral for any
ETM version, in the kernel ETM drivers need to convert to its own
configuration formats.  For this patch, I want to keep current
change as it is, is this okay for you?

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm/util/cs-etm.c?h=v5.11-rc3#n152
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwtracing/coresight/coresight-etm4x-core.c?h=v5.11-rc3#n422
