Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A693A28E1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgJNODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbgJNODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602684214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzi3uHEke45p4GzjIigCF2kVHokNJeipSLBKiTDbzzg=;
        b=ZJvnICN2RziOBunFlVwQBxp1EEAy1AHHpRxHKCyME3dB3PZsWYCXHW/maZMpn/vKBn5Fkg
        o6smg88DqcU3sC0Vh2zXuAB76q4FDLpB6eDGSYlj9iSOIH7JBZhQGuLdwtRo+lcbHzCqZ3
        GRtnrK5MdLOpufXius06p0lKy4HJ310=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-A0_j0y88NAuoL3jQez2nzA-1; Wed, 14 Oct 2020 10:03:32 -0400
X-MC-Unique: A0_j0y88NAuoL3jQez2nzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C932186DD21;
        Wed, 14 Oct 2020 14:03:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F8275D9DD;
        Wed, 14 Oct 2020 14:03:27 +0000 (UTC)
Date:   Wed, 14 Oct 2020 16:03:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] perf c2c: Refine the organization of metrics
Message-ID: <20201014140326.GB1395746@krava>
References: <20201014050921.5591-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 06:09:13AM +0100, Leo Yan wrote:
> This patch set is to refine metrics output organization.
> 
> If we reivew the current memory metrics in Perf c2c tool, it doesn't
> orgnize the metrics with directive approach; thus user needs to take
> time to dig into every statistics item.  On the other hand, if use the
> "summary and breakdown" approach, the output result will be easier for
> reviewing by users, e.g. the output result can firstly give out the
> summary values, and then the later items will breakdown into more
> detailed statistics.
> 
> For this reason, this patch is to reorgnize the metrics and it only
> changes for the "Shared Data Cache Line Table": it firstly displays the
> summary values for total records, total loads, total stores; then it
> breaks these summary values into small values, with the order from the
> most near memory node ("CPU Load Hit") to more far nodes
> ("LLC Load Hit", "RMT Load Hit", "Load Dram").
> 
>   "LLC Load Hit" = "LclHit" + "LclHitm"
> 
>   "RMT Load Hit" = "RmtHit" + "RmtHitm" \
>                                          ->  LLC Load Miss
>   "Load Dram"    = "Lcl" + "Rmt"        /
> 
> Another main reason for this patch set is wanting to extend "perf c2c"
> to support Arm SPE memory event, but Arm SPE doesn't contain 'HTIM' tag
> in its default trace data, for this case if want to analyze cache false
> sharing issue, we need to rely on LLC metrics + multi-threading info.
> So this patch set can be friendly to show LLC related metrics in the
> "Shared Data Cache Line Table"; for sorting cache lines with LLC metrics
> which will be sent out with another separate patch set.
> 
> Before:
> 
> =================================================
>            Shared Data Cache Line Table          
> =================================================
> #
> #        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----  ---- Store Reference ----  --- Load Dram ----      LLC    Total  ----- Core Load Hit -----  -- LLC Load Hit --
> # Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss    Loads       FB       L1       L2       Llc       Rmt
> # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  .......  ........  ........
> #
>       0      0x55acdcc92100     0    8197    40716   52.18%     3170     3170        0    24466    24437       29         0         0        0    16250     3349     5909        0      3822         0
>       1      0x55acdcc920c0     0       1     4621   31.01%     1884     1884        0        0        0        0         0         0        0     4621      739        0        0      1998         0
>       2      0x55acdcc92080     0       1     4475   16.69%     1014     1014        0        0        0        0         0         0        0     4475     2405        0        0      1056         0
> 
> 
> After:
> 
> =================================================
>            Shared Data Cache Line Table          
> =================================================
> #
> #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
> # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
> # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
> #
>       0      0x55acdcc92100     0    8197   52.18%     3170     3170        0    40716    16250    24466    24437       29     3349     5909        0      3822     3170         0        0         0         0
>       1      0x55acdcc920c0     0       1   31.01%     1884     1884        0     4621     4621        0        0        0      739        0        0      1998     1884         0        0         0         0
>       2      0x55acdcc92080     0       1   16.69%     1014     1014        0     4475     4475        0        0        0     2405        0        0      1056     1014         0        0         0         0

I haven't used the tool for some time, so it's fine with me,
but there might be some people already used to see certain
columns in place and I don't want to make them angry unless
there's really good reason for that ;-)

Joe, could you please check on these changes?

thanks,
jirka

> 
> 
> Leo Yan (8):
>   perf c2c: Display the total numbers continuously
>   perf c2c: Display "Total Stores" as a standalone metrics
>   perf c2c: Organize metrics based on memory hierarchy
>   perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
>   perf c2c: Use more explicit headers for HITM
>   perf c2c: Change header for LLC local hit
>   perf c2c: Correct LLC load hit metrics
>   perf c2c: Add metrics "RMT Load Hit"
> 
>  tools/perf/builtin-c2c.c | 83 +++++++++-------------------------------
>  1 file changed, 18 insertions(+), 65 deletions(-)
> 
> -- 
> 2.17.1
> 

