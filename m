Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049528BD2D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbgJLQDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:03:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:38593 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389555AbgJLQDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:03:43 -0400
IronPort-SDR: vGOO8P+9X++1q/O+Anx1MvGBCAqqDNtDN9Y2tvHO2lVWrCEziXgUIcLx/wyf7W4R1hrZOr2DPC
 oU4dcXNLHdpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152689843"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="152689843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:03:41 -0700
IronPort-SDR: M5j79n+CE0wd4PUjVgJxGHSdnkhN9BhNlbtFdkX7IjVPlC1RHRWg3Kcbd6wNAazbeftBLLl/mW
 XPWGaY0lljbQ==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="345899088"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:03:41 -0700
Date:   Mon, 12 Oct 2020 09:03:39 -0700
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
Subject: Re: [PATCH v1 03/15] perf data: open data directory in read access
 mode
Message-ID: <20201012160339.GB466880@tassilo.jf.intel.com>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:55:07AM +0300, Alexey Budankov wrote:
> 
> Open files located at data directory in case of read access mode.

Need some rationale. Is this a bug fix? Did the case not matter
before?

> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/data.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..6ad61ac6ba67 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>  		return -1;
>  
>  	ret = open_file(data);
> +	if (!ret && perf_data__is_dir(data)) {
> +		if (perf_data__is_read(data))
> +			ret = perf_data__open_dir(data);
> +	}
>  
>  	/* Cleanup whatever we managed to create so far. */
>  	if (ret && perf_data__is_write(data))
> -- 
> 2.24.1
> 
> 
