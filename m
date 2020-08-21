Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223824D11D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHUJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 05:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHUJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:05:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4472120720;
        Fri, 21 Aug 2020 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598000735;
        bh=fxpxtYGX1gssjbmWIGMT6Jb9xqglQcp9k3a1C7EoRgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUz6eLTbqcZV4oug1pReTKbuT5em4Bq+zFA8Hj89wTSQaY244GcokImEY+F7dZxRf
         +ayNNyDIIYwA6FG5k9y+TV4nSZ+8IFzatMoMAd7+JXKrSGIDU4n6u/uqMNodi+4N+d
         ZrTCjdqRvSTvclvL/UGjnS87G7674+0V1IdGwCoc=
Date:   Fri, 21 Aug 2020 10:05:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, john.garry@huawei.com, leo.yan@linaro.org,
        jolsa@redhat.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add entries for CoreSight and Arm SPE
Message-ID: <20200821090531.GC20255@willie-the-truck>
References: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820175510.3935932-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:55:10AM -0600, Mathieu Poirier wrote:
> Add entries for perf tools elements related to the support of Arm CoreSight
> and Arm SPE.  Also lump in Arm and Arm64 architecture files to provide
> coverage.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> V2:
> - Completed fileset for SPE.
> - Added Arm and Arm64 architecture files.
> 
>  MAINTAINERS | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..e76f7bb014ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13569,12 +13569,18 @@ F:	kernel/events/*
>  F:	tools/lib/perf/
>  F:	tools/perf/
>  
> -PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> +PERFORMANCE EVENTS SUBSYSTEM ARM64

I'd probably prefer to go with TOOLING instead of SUBSYSTEM, since the
kernel parts are covered by the "ARM PMU PROFILING AND DEBUGGING" entry.

>  R:	John Garry <john.garry@huawei.com>
>  R:	Will Deacon <will@kernel.org>
> +R:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +R:	Leo Yan <leo.yan@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
> +F:	tools/build/feature/test-libopencsd.c
> +F:	tools/perf/arch/arm*/
>  F:	tools/perf/pmu-events/arch/arm64/
> +F:	tools/perf/util/arm-spe*
> +F:	tools/perf/util/cs-etm*

Either way,

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
