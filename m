Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD79B26E4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIQTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgIQTA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:00:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA34B21973;
        Thu, 17 Sep 2020 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369229;
        bh=3JGWNB8c2qNysyg2H63u02x8rYe2epKRl1hQ1YYXCFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qzk+eKAqIZxb9O9BkJq7d0k4YLbKsoqob6kA/9KsyhcG1yUGlZhj1gnnQTqFpoI8R
         aeNx4IMzR9URbWUo1SVWenORu1OQ9vwKbEMp0pQDoXNvDkKIZmWGXFdhwSpprF/thR
         EAW4YSDrWGrjTc2hrzhcn0l4b+WIyFuDASgh0ql8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F4226400E9; Thu, 17 Sep 2020 16:00:26 -0300 (-03)
Date:   Thu, 17 Sep 2020 16:00:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf metricgroup: Fix uncore metric expressions
Message-ID: <20200917190026.GB1426933@kernel.org>
References: <20200910180231.786751-1-irogers@google.com>
 <CAM9d7cjLpE=cKfemsuokc57-5kzezRr3YzqOKZb9Pf4r4-X8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLpE=cKfemsuokc57-5kzezRr3YzqOKZb9Pf4r4-X8+g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 11, 2020 at 12:07:35PM +0900, Namhyung Kim escreveu:
> On Fri, Sep 11, 2020 at 3:02 AM Ian Rogers <irogers@google.com> wrote:
> > v3. cleans up searching for the same event within metric_events to use a
> >     helper and avoids a redundant search. It uses a continue loop to
> >     make the search for similarly named events shorter.
> > v2. avoids iterating over the whole evlist as suggested by
> >     namhyung@kernel.org. It also fixes the metric_leader computation
> >     that was broken in the same commits.
> >
> > Erroneous duplication introduced in:
> > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> >
> > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > Reported-by: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

On my perf/urgent branch (upstream should be the same):

[acme@five perf]$ patch -p1 < /wb/1.patch
patching file tools/perf/util/metricgroup.c
Hunk #1 succeeded at 150 with fuzz 2 (offset 1 line).
Hunk #2 succeeded at 192 (offset 1 line).
Hunk #3 succeeded at 223 (offset 1 line).
Hunk #4 succeeded at 252 (offset 1 line).
Hunk #5 succeeded at 260 (offset 1 line).
[acme@five perf]$

I'm fixing it up, please check that doing this is safe on your side.

- Arnaldo
