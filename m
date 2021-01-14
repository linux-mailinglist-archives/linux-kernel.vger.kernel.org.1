Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407C2F5B64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhANHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:36:08 -0500
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:38630 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbhANHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:36:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7B054182CED34;
        Thu, 14 Jan 2021 07:35:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:4321:5007:6737:7652:10004:10400:11026:11232:11473:11658:11914:12048:12296:12297:12679:12740:12760:12895:13069:13138:13231:13311:13357:13439:14659:14721:21080:21627:21796:21990:30029:30036:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: son03_2f0babc27524
X-Filterd-Recvd-Size: 2241
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Jan 2021 07:35:24 +0000 (UTC)
Message-ID: <07e9ed776de833ab89fafdb76164e038e47f6d7c.camel@perches.com>
Subject: Re: [PATCH v3 3/5] perf c2c: Refactor display filter
From:   Joe Perches <joe@perches.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 23:35:23 -0800
In-Reply-To: <20210114033939.164538-4-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
         <20210114033939.164538-4-leo.yan@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 11:39 +0800, Leo Yan wrote:
> When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
> macro FILTER_HITM is to filter out the cache line entries if its
> overhead is less than 1%.
> 
> This patch introduces static function filter_display() to replace macro;
> and refines its parameter with more flexbile way, rather than passing
> field name, it changes to pass the cache line's statistic value and the
> sum value.
[]
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
[]
> +static u8 filter_display(u32 val, u32 sum)
> +{
> +	double ld_dist;
> +
> +	if (sum) {
> +		ld_dist = ((double)(val) / (sum));
> +		if (ld_dist < DISPLAY_LINE_LIMIT)
> +			return HIST_FILTER__C2C;
> +	} else {
> +		return HIST_FILTER__C2C;
> +	}
> +
> +	return 0;
> +}

style:

It's generally better to test and return early and unindent the remainder.
Also, parentheses aren't necessary around now not-macro args.

{
	if (sum == 0 || ((double)val / sum) < DISPLAY_LINE_LIMIT)
		return HIST_FILTER__C2C;

	return 0;
}


