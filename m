Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94A72935B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405110AbgJTH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731189AbgJTH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603178826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXfk9bvQNtcUwvRwOlj5eknnkdmx+lgFsSH9b/xK0bg=;
        b=XfQiGV3spMGDOo3lYcNH5Q1E50ZMUHXmxS/HIPARBnRDOedouXh/+s0E+oegr3xwrroYry
        NmGc6m4cKHkQGtFNY9mOoWb2KMRFH8bLjDb62cI9gFu4YHZBe7ATkDuFiQcqMicgL7AL9/
        WZx6o/sDOfXTFJKZfM3DX0N7E2T0ZdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-V3yXrWZUN4GIRsEVg1KYVw-1; Tue, 20 Oct 2020 03:27:04 -0400
X-MC-Unique: V3yXrWZUN4GIRsEVg1KYVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA2E8030C4;
        Tue, 20 Oct 2020 07:27:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94FD75D9D2;
        Tue, 20 Oct 2020 07:26:58 +0000 (UTC)
Date:   Tue, 20 Oct 2020 09:26:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/8] perf c2c: Update documentation for display option
 'llc'
Message-ID: <20201020072657.GE2084117@krava>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-9-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015145041.10953-9-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 03:50:41PM +0100, Leo Yan wrote:
> Since the new display option 'llc' is introduced, this patch is to
> update the documentation to reflect it.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/Documentation/perf-c2c.txt | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index c81d72e3eecf..eadce62ecd28 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -109,7 +109,8 @@ REPORT OPTIONS
>  
>  -d::
>  --display::
> -	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
> +	Switch to HITM type (rmt, lcl) or LLC load access (llc) to display
> +	and sort on. Total HITMs as default.

ok, forget the doc update I asked in previous reply ;-)

thanks,
jirka

>  
>  --stitch-lbr::
>  	Show callgraph with stitched LBRs, which may have more complete
> @@ -174,12 +175,18 @@ For each cacheline in the 1) list we display following data:
>    Cacheline
>    - cacheline address (hex number)
>  
> -  Rmt/Lcl Hitm
> +  Rmt/Lcl Hitm (For display with HITM types)
>    - cacheline percentage of all Remote/Local HITM accesses
>  
> -  LLC Load Hitm - Total, LclHitm, RmtHitm
> +  LLC Load Hitm - Total, LclHitm, RmtHitm (For display with HITM types)
>    - count of Total/Local/Remote load HITMs
>  
> +  LLC Hit Pct (For display 'llc')
> +  - cacheline percentage of all LLC load accesses
> +
> +  LLC Hit Total (For display 'llc')
> +  - sum of all LLC load accesses
> +
>    Total records
>    - sum of all cachelines accesses
>  
> @@ -207,9 +214,12 @@ For each cacheline in the 1) list we display following data:
>  
>  For each offset in the 2) list we display following data:
>  
> -  HITM - Rmt, Lcl
> +  HITM - Rmt, Lcl (For display with HITM types)
>    - % of Remote/Local HITM accesses for given offset within cacheline
>  
> +  LLC LD - LclHit, LclHitm (For display 'llc')
> +  - % of LLC hits and LLC HITMs accesses for given offset within cacheline
> +
>    Store Refs - L1 Hit, L1 Miss
>    - % of store accesses that hit/missed L1 for given offset within cacheline
>  
> -- 
> 2.17.1
> 

