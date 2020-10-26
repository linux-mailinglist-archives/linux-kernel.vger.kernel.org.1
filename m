Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737F2990EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783721AbgJZPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:21:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:38173 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783502AbgJZPVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:21:12 -0400
IronPort-SDR: G5Gl1T2i2FoJ9PFRr0nh+afp8LvNAeTLoGqKbcdh6Ldrh7Qp4aFwzYBkDXjWAcjOXP6dYKlhwJ
 BOL58KNF87YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="168062090"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168062090"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:21:10 -0700
IronPort-SDR: hDWIcpdPFuaVCAuqhpRW5Wy/KZaCv0XZUMZI1V+Q+kjgctOcNof7v4aEXd73IYEG7bKTb8CZ4j
 F/bNgtjyHLtA==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="467958822"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:21:09 -0700
Date:   Mon, 26 Oct 2020 08:21:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC] perf evlist: Warn if event group has mixed sw/hw events
Message-ID: <20201026152108.GW466880@tassilo.jf.intel.com>
References: <20201026141937.582087-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026141937.582087-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:19:37PM +0900, Namhyung Kim wrote:
> This patch just added a warning before running it.  I'd really want to
> fix the kernel if possible but don't have a good idea.  Thoughts?

The easiest fix would be some multi threading in perf stat opening, then then
extra latencies could be mostly hidden. One thread per group would probably
be overkill, but just a few threads would lower the penalty significantly.

I think that would be better than this patch and it's likely not that much
more complicated, as this is already a lot of code.

> +{
> +	const char *known_sw_pmu[] = {
> +		"software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"

That's a non scalable approach. New pmus get added regularly. It would be better to
indicate this in a generic way from the kernel.

> +			pr_warning("WARNING: Event group has mixed hw/sw events.\n"
> +				   "This will slow down the perf_event_open syscall.\n"
> +				   "Consider putting a hw event as a leader.\n\n");

You really need to tell the user which group, otherwise it is hard to find
in a large command line.


-Andi
