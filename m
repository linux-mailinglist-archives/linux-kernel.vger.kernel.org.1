Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB52CC6AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgLBTaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:30:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:16554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgLBTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:30:11 -0500
IronPort-SDR: Uyfi/dOH0U1JHRGkMft5Ya+cBYlQkUejbFFrVHgFGJMlGvAr2QLu8ya7cDjP7uvkQvMV4Cwn+h
 8/QV+TdWyGkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="191295033"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="191295033"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:28:30 -0800
IronPort-SDR: tJqPkaYET2VK+XwPUQMAf0LvzhTpG/zn5zuMDG/l5JrlZ6Dsks/sl7KlHuqlX4123SiFvvVUCq
 3JlIblxC0LlQ==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550189635"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:28:29 -0800
Date:   Wed, 2 Dec 2020 11:28:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Message-ID: <20201202192828.GG1363814@tassilo.jf.intel.com>
References: <20201202150205.35750-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202150205.35750-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> +	next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> +
> +	if (prev_cgrp != next_cgrp)
> +		perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);

Seems to be the perf cgroup only, not all cgroups.
That's a big difference and needs to be documented properly.

Probably would make sense to have two events for both, one for 
all cgroups and one for perf only.



-Andi
