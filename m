Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F542F1561
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbhAKNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbhAKNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:12:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B41C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:12:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id be12so9498657plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vxLxmNp00/ADs1BfRL7o4NMbtUvoFLTlYBIY2H+Ps4=;
        b=zKB1IKhP7jxgQzFwIq4aDk8gaG/nxwrlnS4JSbAlUGvU6IezYhc7Suz4fS3aklhmoF
         rhdN0vSLwQjB8DFbMAzZz3Ilt9wVw7FpvDdicjrNp148Nr26YeTAg2OiFqlKjyB8rVcY
         bjccuChI3cxJf62jFBbtfy6uhIGkPajHXo8kmuLXe+FcHUTtQ6pqzFfQsNp/AUv9neIO
         LEqvLumJ475zC/iQiXTBtqQy+svxsewEkLIbsI2PReWOfxF/Xsi/8KpIQ8i1g71moUjB
         rOend+njerAn9v3fHa3fajiN21Yl6DGqbhwxGZEGWmz9TP+Hu+r1KwcmkHUncCDQtGeJ
         CPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vxLxmNp00/ADs1BfRL7o4NMbtUvoFLTlYBIY2H+Ps4=;
        b=POd5wZhyzT++hR1udmhAYcOm124Vkk2IG7ZLbBjge/YA09t/nPRBBRuadOjqHXrz6e
         js8QJz7xosVEs2hXtvIgnARk+tQfEZ6sQcGOyE9C51HJ9kwinQtn4vJJtExs8xa74YEn
         5W+V0haidhCkNpEWhpPEKjDLb6Hr4g6Pr5Ags5XlN3P/761wty8I3GGGpiQGysJhH6OC
         RGzuYiMiOdsnibq1KqE19TSH0Md7QeSDiWJOcfcr0TRqkDhcpLpF1dY5IrXM53icfAar
         0sNd/29jbscXhIQjli1sYTKDoO6zXkzgPMlxRB8NwBA6widNkv96xPtT9JG08k1Kt8O8
         K+IQ==
X-Gm-Message-State: AOAM533bH1QklIXTH5G5XGctYf8jPm32nbT26CNFPluDeea/ietKfMf1
        KEpJn7YiwnKjf7Ch8Kb3G+RU8g==
X-Google-Smtp-Source: ABdhPJzTYTldT9Zoofpj4KAlRo4sADwH6EDwRRQZu1318y0tBL6omOHEY+QqkArlA0iDE3jytgSsIQ==
X-Received: by 2002:a17:90b:1901:: with SMTP id mp1mr18201678pjb.233.1610370731452;
        Mon, 11 Jan 2021 05:12:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id b129sm20124237pgc.52.2021.01.11.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:12:10 -0800 (PST)
Date:   Mon, 11 Jan 2021 21:12:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/7] perf cs-etm: Add PID format into metadata
Message-ID: <20210111131205.GB222747@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-5-leo.yan@linaro.org>
 <c9aa6c3b-9df5-31c7-9a57-3180d260c660@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9aa6c3b-9df5-31c7-9a57-3180d260c660@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:45:12AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo,
> 
> On 1/9/21 7:44 AM, Leo Yan wrote:
> > It's possible for CoreSight to trace PID in either CONTEXTIDR_EL1 or
> > CONTEXTIDR_EL2, the PID format info is used to distinguish the PID
> > is traced in which register.
> > 
> > This patch saves PID format into the metadata when record.
> 
> The patch looks good to me. One minor suggestion below
> 
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   tools/perf/arch/arm/util/cs-etm.c | 21 +++++++++++++++++++++
> >   tools/perf/util/cs-etm.c          |  2 ++
> >   tools/perf/util/cs-etm.h          |  2 ++
> >   3 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index fad7b6e13ccc..ee78df3b1b07 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -613,6 +613,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >   	struct cs_etm_recording *ptr =
> >   			container_of(itr, struct cs_etm_recording, itr);
> >   	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> > +	u64 pid_fmt;
> >   	/* first see what kind of tracer this cpu is affined to */
> >   	if (cs_etm_is_etmv4(itr, cpu)) {
> > @@ -641,6 +642,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >   				      metadata_etmv4_ro
> >   				      [CS_ETMV4_TRCAUTHSTATUS]);
> > +		/*
> > +		 * The PID format will be used when decode the trace data;
> > +		 * based on it the decoder will make decision for setting
> > +		 * sample's PID as context_id or VMID.
> > +		 */
> > +		pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
> > +		if (!pid_fmt)
> > +			pid_fmt = 1ULL << ETM_OPT_CTXTID;
> > +		info->priv[*offset + CS_ETMV4_PID_FMT] = pid_fmt;
> > +
> 
> Given we do this same step twice here in this function and also in patch 2.
> I am wondering if this could be made into a small helper function ?
> 
> static u64 cs_etm_pmu_format_pid(cs_etm_pm)
> {
> 	pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
> 	/*
> 	 * An older kernel doesn't expose this, so fall back to using
> 	 * CTXTID.
> 	 */
> 	if (!pid_fmt)
> 		pid_fmt = 1ULL << ETM_OPT_CTXTID;
> 	return pid_fmt;
> }

Agreed; will follow up this suggestion.

Thanks,
Leo
