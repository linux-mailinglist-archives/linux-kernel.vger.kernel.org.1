Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F752A272D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgKBJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKBJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:38:59 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 01:38:59 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id o129so10622515pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QI/242QkjHiSRR2izSoqyexzCJoKkCdez+fwBBWlNlI=;
        b=NftayeQfmuCMrGAkgckhYPXyxiKWOd18y+dEMZLpHHIXLXnI7al5oFnSZiznQzqyjg
         CDzfkpNL8cTxvk+vUHpF/CD/Nk7ZH7lBm79YHQnkBXSIT2KyHRts9tu4giUKkGWWVgDQ
         T0ELpuRgAulgKahm7Ir4yD54MexXKbr1P1HbOObV+BNvphjguidtIKXAmP2jvaJEKXsU
         7194fZ689f8ucGXaXmliKZgZ85Uu/A5moozq82Gj++Pg6OwXwZjzir4NPEDO4pl/YgWs
         rewZPutxvp5sFYHB4vikYdM3lnAI6xM5s05+yOctvCVVbXtbWH9cMCZQQVmiD5tyKKqw
         mxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QI/242QkjHiSRR2izSoqyexzCJoKkCdez+fwBBWlNlI=;
        b=FGhXXBHkjLZBJIs0VGzuiEoyeopP+p0OCMkFdEDxpAlDXlN0fwoH1cY4U19FvX50nE
         dEVM3NNTPNCpS2ymyatDu5DTvxcADDjHdu3YQ1TgwFgJznWtsyduUQwx/biPVLlCGDO9
         b1A8wcRUK0BJa/PpEHqTQQhaBC61DhtxQEtZVKkF05TEVmA+m7XUPtIrWT8IWxg4IsUS
         49QYPEXg15W8dOVF+Pv8LjJSxZVFVh9xTPmQqn15fGtw2QfN5MTpfStYoX7NiAu9n4Oc
         5f88aFL15X8z6ixtQhrguAOp4BGMewU9faYu8WFe9Yj0khjpeCKttG3FpSojZTtysTGr
         0Y9g==
X-Gm-Message-State: AOAM532AvGlPmxbO1Fmd2sYypePSYetTUQlXbz7qwsyrGNlPpYVi4ivZ
        csYhP7CkDfibv7MTU5YXqWGp6A==
X-Google-Smtp-Source: ABdhPJwQvwK0ALKKA4WFTAabimtVr+1lvf4rZTcmx/mjfIdXXWulKu+ziOZp0uCM/I5y3eQ/RkRC0g==
X-Received: by 2002:a63:5821:: with SMTP id m33mr12410307pgb.16.1604309938595;
        Mon, 02 Nov 2020 01:38:58 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id s9sm13347680pfh.67.2020.11.02.01.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 01:38:57 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:38:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/9] perf mem: Support new memory event
 PERF_MEM_EVENTS__LOAD_STORE
Message-ID: <20201102093848.GA6633@leoy-ThinkPad-X240s>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-4-leo.yan@linaro.org>
 <20201031202307.GB3380099@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031202307.GB3380099@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:23:07PM +0100, Jiri Olsa wrote:
> On Wed, Oct 28, 2020 at 02:38:07PM +0800, Leo Yan wrote:
> 
> SNIP
> 
> >  		struct stat st;
> >  
> > +		/*
> > +		 * If the event entry isn't valid, skip initialization
> > +		 * and "e->supported" will keep false.
> > +		 */
> > +		if (!e->tag)
> > +			continue;
> > +
> >  		scnprintf(path, PATH_MAX, "%s/devices/%s",
> >  			  mnt, e->sysfs_name);
> >  
> > @@ -123,7 +134,7 @@ void perf_mem_events__list(void)
> >  		struct perf_mem_event *e = perf_mem_events__ptr(j);
> >  
> >  		fprintf(stderr, "%-13s%-*s%s\n",
> > -			e->tag,
> > +			e->tag ? e->tag : "",
> 
> nit, could be:          e->tag ?: "",

Will do.

Thanks,
Leo

> >  			verbose > 0 ? 25 : 0,
> >  			verbose > 0 ? perf_mem_events__name(j) : "",
> >  			e->supported ? ": available" : "");
> > diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> > index 726a9c8103e4..5ef178278909 100644
> > --- a/tools/perf/util/mem-events.h
> > +++ b/tools/perf/util/mem-events.h
> > @@ -28,6 +28,7 @@ struct mem_info {
> >  enum {
> >  	PERF_MEM_EVENTS__LOAD,
> >  	PERF_MEM_EVENTS__STORE,
> > +	PERF_MEM_EVENTS__LOAD_STORE,
> >  	PERF_MEM_EVENTS__MAX,
> >  };
> >  
> > -- 
> > 2.17.1
> > 
> 
