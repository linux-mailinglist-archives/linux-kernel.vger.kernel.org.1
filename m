Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312122C5B15
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbgKZRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391741AbgKZRvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:51:40 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B9420665;
        Thu, 26 Nov 2020 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606413099;
        bh=gZ9qg9LQpXvKPlB4tlTS2cx56/Nkhs90eRgyWc22/R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHtHqSlA2oXWFzgw8iu3A3pmabY12hk5Xj6fcY11uqNOHIyTWE3oX84a4p11zOmfW
         R3tXZ5nzYgRvteguGf0fFKKFaxzuiox5kX5MQJct5raKY9LAekR+OZoN/L1Zv/h8Ud
         3G8us4/3Jiaqc/jXauqueygqcx+OODSqApAM7PUY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72B2B40E29; Thu, 26 Nov 2020 14:51:37 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:51:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 20/25] perf tools: Add is_perf_data function
Message-ID: <20201126175137.GE70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-21-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-21-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:21PM +0100, Jiri Olsa escreveu:
> Adding is_perf_data function that returns true if
> the given path is perf data file. It will be used
> in following patches.

Thanks, applied.

- Arnaldo

 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c | 19 +++++++++++++++++++
>  tools/perf/util/data.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 05bbcb663c41..f29af4fc3d09 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -492,3 +492,22 @@ char *perf_data__kallsyms_name(struct perf_data *data)
>  
>  	return kallsyms_name;
>  }
> +
> +bool is_perf_data(const char *path)
> +{
> +	bool ret = false;
> +	FILE *file;
> +	u64 magic;
> +
> +	file = fopen(path, "r");
> +	if (!file)
> +		return false;
> +
> +	if (fread(&magic, 1, 8, file) < 8)
> +		goto out;
> +
> +	ret = is_perf_magic(magic);
> +out:
> +	fclose(file);
> +	return ret;
> +}
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index c563fcbb0288..62a3e66fbee8 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -98,4 +98,5 @@ int perf_data__update_dir(struct perf_data *data);
>  unsigned long perf_data__size(struct perf_data *data);
>  int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
>  char *perf_data__kallsyms_name(struct perf_data *data);
> +bool is_perf_data(const char *path);
>  #endif /* __PERF_DATA_H */
> -- 
> 2.26.2
> 

-- 

- Arnaldo
