Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46F2CB520
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgLBGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:38:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:42060 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387462AbgLBGix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:38:53 -0500
IronPort-SDR: qfPlIivmZ9R0/MiD3AMCBSg7SNhh5lZr5h5LcBFD9eViy/AhAPjhDRgnsgnCt+1audN/y0v6fZ
 cKfsTg59tC+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169459558"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="169459558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:37:00 -0800
IronPort-SDR: nhjfwl1wyrL9S96FyxTBjmLY2G1FXKobY8fNTUjclrSGlo7OUwSoPEOljhB2np9rjA0soeqm8k
 8qCLpF4zA6lA==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="549914773"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:37:00 -0800
Date:   Tue, 1 Dec 2020 22:36:57 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v4 5/5] perf metric: Don't compute unused events.
Message-ID: <20201202063657.GC1363814@tassilo.jf.intel.com>
References: <20201202062646.3780002-1-irogers@google.com>
 <20201202062646.3780002-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202062646.3780002-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +| expr '-' expr
> +{
> +	if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
> +		assert($1.ids == NULL);
> +		assert($3.ids == NULL);
> +		$$.val = $1.val - $3.val;
> +		$$.ids = NULL;
> +	} else {
> +		/* LHS and/or RHS need computing from event IDs so union. */
> +		$$ = union_expr($1, $3);
> +	}

Can't this be all in a macro? It's still a lot of duplication.

I'm still not a fan, but I think with a macro it wouldn't be too bad.


-Andi
