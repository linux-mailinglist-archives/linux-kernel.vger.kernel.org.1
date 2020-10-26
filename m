Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61E299169
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784404AbgJZPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:49:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:34210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773092AbgJZPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:49:15 -0400
IronPort-SDR: Qx6XNKoNK4y9Gcprj6v/AEH2VaFZQGBRZoOkOnWz4m9cgfjyM7imqfK6+s82wqXytg64kPpfKz
 pYmbuy9KjyLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168041448"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168041448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:49:11 -0700
IronPort-SDR: L8CHJOf2wvavRphnAa7lRq33t4OuN8POPsrsN04+1wsbgVoo/uMvtCu3d61iojK6cLpyXh36vx
 28L2YFSY/uRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="467967505"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2020 08:49:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [RFC] perf evlist: Warn if event group has mixed sw/hw events
In-Reply-To: <20201026152108.GW466880@tassilo.jf.intel.com>
References: <20201026141937.582087-1-namhyung@kernel.org> <20201026152108.GW466880@tassilo.jf.intel.com>
Date:   Mon, 26 Oct 2020 17:49:07 +0200
Message-ID: <87y2jtq970.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

> On Mon, Oct 26, 2020 at 11:19:37PM +0900, Namhyung Kim wrote:
>> This patch just added a warning before running it.  I'd really want to
>> fix the kernel if possible but don't have a good idea.  Thoughts?
>
> The easiest fix would be some multi threading in perf stat opening, then then
> extra latencies could be mostly hidden. One thread per group would probably
> be overkill, but just a few threads would lower the penalty significantly.
>
> I think that would be better than this patch and it's likely not that much
> more complicated, as this is already a lot of code.
>
>> +{
>> +	const char *known_sw_pmu[] = {
>> +		"software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"
>
> That's a non scalable approach. New pmus get added regularly. It would be better to
> indicate this in a generic way from the kernel.

That, and also, intel_pt is a software PMU and a few of its features
depend on intel_pt/.../ being a group leader.

Regards,
--
Alex
