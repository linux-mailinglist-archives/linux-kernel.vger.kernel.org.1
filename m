Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76682FAECA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbhASCdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbhASCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:32:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:32:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so9669586plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SuMQrIH62Xu4SD6Twlivr0r+jwy5BFaCnuj4YIYtSxY=;
        b=n7EKsI6Xh0Z1t0TesLJwoXA92pfl/yKKVfi+x2L3uIU7bLAm71pfHb9nGd7L865PIO
         vIGlWjoLMXOnhAyY/aRVj0bNoZTygd3pYqO/kOlb+wiRGeyHOnsjDOYyvofS4VXYkcgL
         OgXOV24X5VcJYCFtVsOnF39jugJ/UCX32vSLSrHVAgkePk0SVOb3QyFTqdBDTrIWRJow
         ZG8eXVOM2yTTh6eEZXV/xwfJ4Jx/oJfCjIdCXEtqtT74gixIReIO3tGFZ7oeblDRNrG1
         FOYemz/vfLAjSjgZTzuFH5lcNbZlUBHUE/US5K+H/ITdhZGxvoIihYovCc6RF0un98A7
         badw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuMQrIH62Xu4SD6Twlivr0r+jwy5BFaCnuj4YIYtSxY=;
        b=R7NY3MUfQN/icBpPsWBumaUOn06mwHovqIeL/JOitm1kkkf9p7kylYS6aNvT05pPSJ
         oWK7dR7x8A9ooJxXt3yLtIIUW9MnZ87vpQmPGcVLUFHwucoVl5VLA6xvJGG5/morxkiW
         LwG7DuhGb0HNsuj+xH0RMTqZQN+1fh8uD8ruoPHDcty8Easg4ia0G4TpSBRtgTo/1V4E
         Gt8q5Qwds4iIT/S6rgia44UlXcU5h1VRxE5nBNltBXAzVlPnJnbBbt2K8r2nLQgXOVxC
         Fsvg6NlvY1UU1JGMN0NpfI0VdL5hYzElgJSXxAUKRcO48IDVzPrQ9aHXstjuNlwGPm2u
         g9Pw==
X-Gm-Message-State: AOAM532UkwaogsCOypKxpmQ5jjYaJ9c4j+KwFAGEHZm65y6F0uKMB+Vf
        1xsDXift+xm7laPjOV0u68+jng==
X-Google-Smtp-Source: ABdhPJwRbPzmJTXErPTmUDjCOjOwHC1A58EszURj027d3d25v9kr+MKuv4ynvAtX/hFTHTG6SMa52w==
X-Received: by 2002:a17:90a:183:: with SMTP id 3mr2538810pjc.99.1611023534028;
        Mon, 18 Jan 2021 18:32:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id n7sm17474988pfn.141.2021.01.18.18.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 18:32:13 -0800 (PST)
Date:   Tue, 19 Jan 2021 10:32:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20210119023207.GA6483@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-3-leo.yan@linaro.org>
 <20210115224416.GB375055@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115224416.GB375055@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Jan 15, 2021 at 03:44:16PM -0700, Mathieu Poirier wrote:
> On Sat, Jan 09, 2021 at 03:44:30PM +0800, Leo Yan wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > If the kernel is running at EL2, the pid of the task is exposed
> > via VMID instead of the CONTEXTID. Add support for this in the
> > perf tool.
> > 
> > By default the perf tool requests contextid and timestamp for
> > task bound events. Instead of hard coding contextid, switch
> > to "pid" config exposed by the kernel. While at it, define new
> > independent macros (rather than using the "config" bits) for
> > requesting the "pid" and "timestamp" for cs_etm_set_option(),
> > since the PID config is now dynamic depending on the kernel
> > exception level.
> > 
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Al Grant <al.grant@arm.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/include/linux/coresight-pmu.h | 11 +++--
> >  tools/perf/arch/arm/util/cs-etm.c   | 68 ++++++++++++++++++++++-------
> >  2 files changed, 59 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> > index b0e35eec6499..927c6285ce5d 100644
> > --- a/tools/include/linux/coresight-pmu.h
> > +++ b/tools/include/linux/coresight-pmu.h
> > @@ -11,16 +11,19 @@
> >  #define CORESIGHT_ETM_PMU_SEED  0x10
> >  
> >  /* ETMv3.5/PTM's ETMCR config bit */
> > -#define ETM_OPT_CYCACC  12
> > -#define ETM_OPT_CTXTID	14
> > -#define ETM_OPT_TS      28
> > -#define ETM_OPT_RETSTK	29
> > +#define ETM_OPT_CYCACC		12
> > +#define ETM_OPT_CTXTID		14
> > +#define ETM_OPT_CTXTID_IN_VMID	15
> > +#define ETM_OPT_TS		28
> > +#define ETM_OPT_RETSTK		29
> >  
> >  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> >  #define ETM4_CFG_BIT_CYCACC	4
> >  #define ETM4_CFG_BIT_CTXTID	6
> > +#define ETM4_CFG_BIT_VMID	7
> >  #define ETM4_CFG_BIT_TS		11
> >  #define ETM4_CFG_BIT_RETSTK	12
> > +#define ETM4_CFG_BIT_VMID_OPT	15
> 
> Wasn't this done in the previous patch?

In the previous patch, these bits are defined in the kernel's header
include/linux/coresight-pmu.h; at here it defines the same bits in
tool's header.

To be honest, I struggled to understand your suggestions, finally I
think it's feasbile and we can simplify the implementation.  I will
try to refine the patch series for the review.

Appreciate for good suggestions!

Leo
