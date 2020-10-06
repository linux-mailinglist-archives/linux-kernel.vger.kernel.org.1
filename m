Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1087284AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJFLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601982685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wx2auHMav5YSxabwrXD0pmlNxBIh/RjNOkQG6oFpCCM=;
        b=jUGyBuhvEqiYclLtQZCtrRE3UAiGIKXRSuArVvaCiPrD9BNzVBuy280VG/AwIq8LxmYwMf
        Or5ZIRXre5BQi0wfC8rBYQ8SIRpd+uQstuSDvoFGQn517cvV/yYHRGQ3m3zJvm2dROPzHC
        h8/3/XtZWVEZtnbPTY65hgXnf67f8ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-aZQ1Y3weOjGLRnBRIGQ5VA-1; Tue, 06 Oct 2020 07:11:20 -0400
X-MC-Unique: aZQ1Y3weOjGLRnBRIGQ5VA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A659A107AD64;
        Tue,  6 Oct 2020 11:11:17 +0000 (UTC)
Received: from krava (unknown [10.40.194.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id F278E78805;
        Tue,  6 Oct 2020 11:11:14 +0000 (UTC)
Date:   Tue, 6 Oct 2020 13:11:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Message-ID: <20201006111113.GB249615@krava>
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
 <20201001230653.GM50079@tassilo.jf.intel.com>
 <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
 <CAM9d7cjM262j4ixjayz+M1BqYDuiqRmrd9ifx++XBxT830ymRQ@mail.gmail.com>
 <41a3e45d558242f79f9e10a8d9ca92f1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a3e45d558242f79f9e10a8d9ca92f1@hisilicon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 06:39:44AM +0000, Song Bao Hua (Barry Song) wrote:

SNIP

> > > Andi, thanks! Could you share the link or the commit ID? I'd like to take a
> > look at the fix.
> > > I could still reproduce this issue in the latest linus' tree and I didn't find any
> > commit
> > > related to this issue in linux-next and tip/perf/core.
> > 
> > I think Andi was referring to this discussion which is not merged yet:
> > 
> > https://lore.kernel.org/lkml/20200922031346.15051-2-liwei391@huawei.co
> > m/
> > 
> > I suggested a patch at the end.  Can you please try it?
> 
> I tried the patch you suggested.
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 2208444ecb44..cfcdbd7be066 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>          if (!evsel->own_cpus || evlist->has_user_cpus) {
>                  perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->cpus);
> +       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
> +               perf_cpu_map__put(evsel->cpus);
> +               evsel->cpus = perf_cpu_map__get(evlist->cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> 
> it did fix the crash I have seen on arm64. I'd prefer you put the below fixes tag in the commit log. 
> Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> Perf stat began to crash from v5.4 kernel, so the fix should be backported to stable trees.

awesome.. Namhyung, could you please send full patch?

thanks,
jirka

