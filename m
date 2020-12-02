Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB772CC9CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgLBWoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:44:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:16721 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgLBWoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:44:21 -0500
IronPort-SDR: 3zZN1DhlkFqYM+LpeCy/znaoqVCRM/9YTKv5II4J2Y7+LznZLZkCAUoXXH7bJSDrnVHDxzs9u1
 fNqzgAjvsoyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173196293"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="173196293"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 14:42:41 -0800
IronPort-SDR: X4V5BzLtOSZ7Bcgs0+Yro3VupStgDab0e/L1UZZATXUGJqPNxD9YGocZa3wYZ7yS9VvwXPAroI
 98OGbqWgjskA==
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="481731189"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 14:42:40 -0800
Date:   Wed, 2 Dec 2020 14:42:39 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Message-ID: <20201202224239.GJ1363814@tassilo.jf.intel.com>
References: <20201202150205.35750-1-namhyung@kernel.org>
 <20201202192828.GG1363814@tassilo.jf.intel.com>
 <CABPqkBR5nCfn756Wb8xQEb9Xse+UQPAbGy969cP4sxO78-Nq4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBR5nCfn756Wb8xQEb9Xse+UQPAbGy969cP4sxO78-Nq4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:47:25AM -0800, Stephane Eranian wrote:
> On Wed, Dec 2, 2020 at 11:28 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > +     prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > > +     next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > > +
> > > +     if (prev_cgrp != next_cgrp)
> > > +             perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> >
> > Seems to be the perf cgroup only, not all cgroups.
> > That's a big difference and needs to be documented properly.
> >
> We care about the all-cgroup case.

Then it's not correct I think. You need a different hook point.

-Andi
