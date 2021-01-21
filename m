Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C412E2FF556
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAUUEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbhAUUC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:02:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE5F323A54;
        Thu, 21 Jan 2021 20:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611259333;
        bh=qxeauuOKJa9gE5mephDicU6nhBk43WQQJAq4rE/RYj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fI4KOPrdaIt4BZJIXXkXCyTLiG7rHxBD1cllSHxzAUIW0XDcoSg0LAHXFGxCK74oZ
         HH1q68osjJUPl58fo1uj8ScsgShH4IHll4rs5rhZU+YoxH0wMpwirHOrASIOg9ZIjB
         bi4QyHSYhHsjpAY24U6CyM3/AyzaYoFN6nJwMeQy+K9+AtQAwcH6rttGvcalmFBfBX
         DduUDX+9MWXcqNi6bZqsWvyBFz6SQ5GPm9tmoDXBx9Q0Xzbc64XN90OhkGnqs2Q0dW
         G9oOorvJVoqv3RPHZqkuAkU5B79ua2J4GGnrPNe8v/codzbr1BwJLpnanbSVPJwE/j
         tqzxonovZKmMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCD3E40513; Thu, 21 Jan 2021 17:02:10 -0300 (-03)
Date:   Thu, 21 Jan 2021 17:02:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH] perf metricgroup: Fix for metrics containing
 duration_time
Message-ID: <20210121200210.GB356537@kernel.org>
References: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
 <20210120213535.GB1798087@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120213535.GB1798087@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 10:35:35PM +0100, Jiri Olsa escreveu:
> On Thu, Jan 21, 2021 at 12:18:38AM +0800, John Garry wrote:
> > Metrics containing duration_time cause a segfault:
> > 
> > $./perf stat -v -M L1D_Cache_Fill_BW sleep 1
> > Using CPUID GenuineIntel-6-3D-4
> > metric expr 64 * l1d.replacement / 1000000000 / duration_time for L1D_Cache_Fill_BW
> > found event duration_time
> > found event l1d.replacement
> > adding {l1d.replacement}:W,duration_time
> > l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
> > Segmentation fault
> > 
> > In commit c2337d67199a ("perf metricgroup: Fix metrics using aliases
> > covering multiple PMUs"), the logic in find_evsel_group() when iter'ing
> > events was changed to not only select events in same group, but also for
> > aliased PMUs.
> > 
> > Checking whether events were for aliased PMUs was done by comparing the
> > event PMU name. This was not safe for duration_time event, which has no
> > associated PMU (and no PMU name), so fix by checking if the event PMU name
> > is set also.
> > 
> > Fixes: c2337d67199a ("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
> > Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Tested/Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 2e60ee170abc..e6d3452031e5 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -162,6 +162,14 @@ static bool contains_event(struct evsel **metric_events, int num_events,
> >  	return false;
> >  }
> >  
> > +static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
> > +{
> > +	if (!ev1->pmu_name || !ev2->pmu_name)
> > +		return false;
> > +
> > +	return !strcmp(ev1->pmu_name, ev2->pmu_name);
> > +}
> > +
> >  /**
> >   * Find a group of events in perf_evlist that correspond to those from a parsed
> >   * metric expression. Note, as find_evsel_group is called in the same order as
> > @@ -280,8 +288,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >  			 */
> >  			if (!has_constraint &&
> >  			    ev->leader != metric_events[i]->leader &&
> > -			    !strcmp(ev->leader->pmu_name,
> > -				    metric_events[i]->leader->pmu_name))
> > +			    evsel_same_pmu(ev->leader, metric_events[i]->leader))
> >  				break;
> >  			if (!strcmp(metric_events[i]->name, ev->name)) {
> >  				set_bit(ev->idx, evlist_used);
> > -- 
> > 2.26.2
> > 
> 

-- 

- Arnaldo
