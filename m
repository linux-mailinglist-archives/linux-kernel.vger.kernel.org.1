Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B364326A4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIOMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgIOMFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:05:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4C521D24;
        Tue, 15 Sep 2020 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600171033;
        bh=wwhNf1Y+epm74o19Sux2rj32x/cvkYKvJy+IfcYOex4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtzWylKyDiFa2E3s9nahtghGP1MthownpZcuwjI7pA6JG1x5QpNrDjrqJ3lmi0Wy+
         wy+PbTP5DtG0z9khmBrz12rq57LQH6m0HmhtAor38ZY4sKfiP3b7Ime6cIZdQdEqyt
         spkpzV4ZWzhKO/lIJchfTGNOEe52MKLCBBTUzvcA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8DD0740D3D; Tue, 15 Sep 2020 08:57:11 -0300 (-03)
Date:   Tue, 15 Sep 2020 08:57:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 10/11] perf test: Free aliases for PMU event map aliases
 test
Message-ID: <20200915115711.GB720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-11-namhyung@kernel.org>
 <d1704e16-0561-8bd7-02bb-dbef0233e395@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1704e16-0561-8bd7-02bb-dbef0233e395@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 08:37:15AM +0100, John Garry escreveu:
> On 15/09/2020 04:18, Namhyung Kim wrote:
> > The aliases were never released causing the following leaks:
> > 
> >    Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
> >      #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
> >      #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
> >      #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
> >      #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
> >      #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
> >      #5 0x56332c76a09b in run_test tests/builtin-test.c:410
> >      #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
> >      #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
> >      #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
> >      #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
> >      #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
> >      #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
> >      #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
> >      #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Just a minor comment below, either way:
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied to perf/urgent.

- Arnaldo
 
> Thanks
> 
> > Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   tools/perf/tests/pmu-events.c | 5 +++++
> >   tools/perf/util/pmu.c         | 2 +-
> >   tools/perf/util/pmu.h         | 1 +
> >   3 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> > index eb19f9a0bc15..d3517a74d95e 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
> >   	int res = 0;
> >   	bool use_uncore_table;
> >   	struct pmu_events_map *map = __test_pmu_get_events_map();
> > +	struct perf_pmu_alias *a, *tmp;
> >   	if (!map)
> >   		return -1;
> > @@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
> >   			  pmu_name, alias->name);
> >   	}
> > +	list_for_each_entry_safe(a, tmp, &aliases, list) {
> > +		list_del(&a->list);
> > +		perf_pmu_free_alias(a);
> > +	}
> 
> You could also consider putting this in a helper in pmu.c
> 
> >   	free(pmu);
> >   	return res;
> >   }
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index f1688e1f6ed7..555cb3524c25 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -274,7 +274,7 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
> >   }
> >   /* Delete an alias entry. */
> > -static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> > +void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> >   {
> >   	zfree(&newalias->name);
> >   	zfree(&newalias->desc);
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 44ccbdbb1c37..b63c4c5e335e 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -113,6 +113,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
> >   struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
> >   bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
> > +void perf_pmu_free_alias(struct perf_pmu_alias *alias);
> >   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
> > 
> 

-- 

- Arnaldo
