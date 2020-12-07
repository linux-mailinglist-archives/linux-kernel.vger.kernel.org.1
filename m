Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02B2D16D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLGQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLGQwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:52:34 -0500
Date:   Mon, 7 Dec 2020 13:52:02 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607359913;
        bh=//0K9RBmvFiwzCncH8BL+Ewt2josOBCPAEbsulY5Jek=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePUllLk5sPJs1AlGFP12HIFMARptegb0c1zihV0R4CEWjTVZxQwaIaOlb5jkeM6Ur
         THXsP0WTM3xw5BFi/EN2La6nvJzT27zWWKSU91fUdAq8MvgSwfKIpB7hTHjsHr7OdZ
         H2QkqPsZ6IOY7GY3BegsH6obrBRgP2cMxZOlvNkOPZbInc+UJXs/IGJ+Cblej9tCvJ
         KQM1DPxCNTmeVhpN+WHkYklhbFmT4W4wtwpc/1Lh5Z+9B/cKfBVv6q3Sm4pOyhfoW6
         D5eMWPXrH9oRsES+Da32qEfUoFw9sgMS43VTRxXL31XEMOkGzFsN72DA7xIHy3y2mx
         KLCy2wKWy5Ewg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 01/12] tools headers UAPI: Update tools's copy of
 linux/perf_event.h
Message-ID: <20201207165202.GA129853@kernel.org>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-2-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 30, 2020 at 09:27:52AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> To get the changes in:
> 
>    commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
>    commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
> 
> This silences this perf tools build warning:

Thanks, this is in tip/perf/core, so I'm applying it to my perf/core
branch.

- Arnaldo
 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
> differs from latest version at 'include/uapi/linux/perf_event.h'
>   diff -u tools/include/uapi/linux/perf_event.h
> include/uapi/linux/perf_event.h
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/include/uapi/linux/perf_event.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index b95d3c485d27..b15e3447cd9f 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -143,8 +143,10 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>  	PERF_SAMPLE_AUX				= 1U << 20,
>  	PERF_SAMPLE_CGROUP			= 1U << 21,
> +	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
> +	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
>  
> -	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -896,6 +898,8 @@ enum perf_event_type {
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>  	 *	{ u64			size;
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> +	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
> +	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> -- 
> 2.17.1
> 

-- 

- Arnaldo
