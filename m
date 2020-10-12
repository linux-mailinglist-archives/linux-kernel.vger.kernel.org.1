Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F155228BD36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbgJLQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:05:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:43344 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389068AbgJLQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:05:48 -0400
IronPort-SDR: pu92tcXtoLhnuiZHZ7ACXjLmRjlGx4CIfdBJZAZFPxvM8Gxc28tN5tsxajTSDlWqrLKIklC0DY
 jT3bzXfbbkCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="227407050"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="227407050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:05:27 -0700
IronPort-SDR: afRT3RG8XvgpDVZf3D1Kh1esm2dLeoI1T6USxXzv79Ware+HVwdjOsYCNotKW5Yqq18oaK7uw3
 XRLUAYBD+rWA==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="520735622"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:05:24 -0700
Date:   Mon, 12 Oct 2020 09:05:23 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/15] perf session: introduce decompressor into trace
 reader object
Message-ID: <20201012160523.GC466880@tassilo.jf.intel.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <a7fa42f9-a3a9-0ee0-4933-fe5d1d60176f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fa42f9-a3a9-0ee0-4933-fe5d1d60176f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:57:00AM +0300, Alexey Budankov wrote:
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index abdb8518a81f..4fc9ccdf7970 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -42,6 +42,7 @@ struct reader {
>  	u64		 data_size;
>  	u64		 data_offset;
>  	reader_cb_t	 process;
> +	struct zstd_data zstd_data;

Just to make sure, there is a suitable definition of zstd_data in case
the Zstd library not available?

-Andi

