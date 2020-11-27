Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48B2C6A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgK0RaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbgK0RaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:30:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9373122250;
        Fri, 27 Nov 2020 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606498223;
        bh=xmP8gcXuSDMVJyjkMa0hBLOirCsCrqhYvzLRXHrrROk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlBjocCogPiRqU8mohInEWNBA/iXGN91/8RrU457W1oP3RNRwxQnfoPJ1WxbB0bRU
         lAxxH1IFPL095drpFYJKwL/5MISvXSLt59hZ+N6BfkKVjZ6uE1G5KE01eVGksdqpwI
         qq7n9MoHExSHhDmNCneZJWoDK1LSauuJIZRrlLaQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E93E40D0D; Fri, 27 Nov 2020 14:30:21 -0300 (-03)
Date:   Fri, 27 Nov 2020 14:30:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Synthesize cgroup events only if needed
Message-ID: <20201127173021.GN70905@kernel.org>
References: <20201127054356.405481-1-namhyung@kernel.org>
 <20201127154557.GB2729821@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127154557.GB2729821@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 04:45:57PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 27, 2020 at 02:43:56PM +0900, Namhyung Kim wrote:
> > It didn't check the tool->cgroup_events bit which is set when
> > the --all-cgroups option is given.  Without it, samples will not have
> > cgroup info so no reason to synthesize.
> > 
> > We can check the PERF_RECORD_CGROUP records after running perf record
> > *WITHOUT* the --all-cgroups option:
> > 
> > Before:
> >   $ perf report -D | grep CGROUP
> >   0 0 0x8430 [0x38]: PERF_RECORD_CGROUP cgroup: 1 /
> >           CGROUP events:          1
> >           CGROUP events:          0
> >           CGROUP events:          0
> > 
> > After:
> >   $ perf report -D | grep CGROUP
> >           CGROUP events:          0
> >           CGROUP events:          0
> >           CGROUP events:          0
> > 
> > Fixes: 8fb4b67939e16 ("perf record: Add --all-cgroups option")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 8a23391558cf..d9c624377da7 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -563,6 +563,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
> >  	char cgrp_root[PATH_MAX];
> >  	size_t mount_len;  /* length of mount point in the path */
> >  
> > +	if (!tool || !tool->cgroup_events)
> > +		return 0;
> 
> can !tool actually happen here? or it's just being extra cautious
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, tested with/without --all-cgroups and applied.

- Arnaldo
