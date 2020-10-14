Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89F828E688
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgJNSi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730119AbgJNSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602700704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDBsW7KYfWx9uryvjHydSKzIvDYC9SOehlV+TonjhrY=;
        b=T6QEL6247dkzakQR2ckLv8FYxVi55Aa73ricFU+ixrc+hLCB1j7bw2BqhMslRuUpQI+oh7
        7VUeUU1yu8ZAJk1crB+bwdSdN9g9t6lsUmArtv9fefwsKhJi5I0NRoT7aZWYgiGqu/gFq6
        DHd1YieTbLrsuGGqQVOvldiDx0E7EII=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-EuHBfzdyN8aEykj_VlyvZA-1; Wed, 14 Oct 2020 14:38:23 -0400
X-MC-Unique: EuHBfzdyN8aEykj_VlyvZA-1
Received: by mail-io1-f70.google.com with SMTP id i1so287036iog.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDBsW7KYfWx9uryvjHydSKzIvDYC9SOehlV+TonjhrY=;
        b=nvC5el5aSK3S8ZpUyZhuS0A2RX1/744F2BRuGlqvKq5vCJVYNMyByF1fSre9ERfvGG
         OyXP1Nrq9NizcNVJfpx44RRmj6xZD1JNnhssbMu5IY9m0bg8r3/il6rHGphKTA1MLSNZ
         RBUTpLaVrxF37VkKxVyV0PvnCILv42J8bH1db2DG3TxLRhCuI8pAHWoHmkmStos6KR8C
         VjxSrjAKgBeVITWpRp7906SYOMUpETnPhx3skjikg306Ygw4SuJhQNzZmgjEJ6KhTWgo
         QKIqbReLnbWNqbKXBJFfDo9jR0xTN24VsAGg/FkLbSYunFbW9AnPvlm9JJAtwM8gLtkw
         U5AA==
X-Gm-Message-State: AOAM532qIBScPNUSZ6TJYWLYhx5hwSLFBxEeef6gyZ+GDrfyYnPqsdxC
        RheT/Wk6BeIBOpDjVO0A67t2rXA1rl6t/uWXMNySr4p6b+ZmU9hO8UAQbaihS8uf3/qWUZ0v9Xu
        nLuP9Nfiww5y7i+M9XjHY7eIP
X-Received: by 2002:a6b:c94f:: with SMTP id z76mr585924iof.88.1602700701942;
        Wed, 14 Oct 2020 11:38:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcMmzD8oiXe3zzuQixP0UGeIEyei9EmrSX7C8xHPwz4v+9KHNKuC+DTVYsSRRjBi140CsupA==
X-Received: by 2002:a6b:c94f:: with SMTP id z76mr585904iof.88.1602700701675;
        Wed, 14 Oct 2020 11:38:21 -0700 (PDT)
Received: from localhost.localdomain (pool-71-174-203-64.bstnma.fios.verizon.net. [71.174.203.64])
        by smtp.gmail.com with ESMTPSA id d21sm315020ioi.39.2020.10.14.11.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:38:21 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] perf c2c: Refine the organization of metrics
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
References: <20201014050921.5591-1-leo.yan@linaro.org>
From:   Joe Mario <jmario@redhat.com>
Message-ID: <79f2db37-a03f-c01f-0b3b-4e2d3ed429f4@redhat.com>
Date:   Wed, 14 Oct 2020 14:38:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014050921.5591-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/20 1:09 AM, Leo Yan wrote:
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
> <SNIP>
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

Hi Leo:
I ran your patches through some perf c2c tests and it all looks good.  
I agree the new format of the "Shared Data Cache Line Table" makes more sense now.  And it still holds together nicely when sorted on local HitMs (-d lcl).

Thank you for doing this.
Joe

Tested-by: Joe Mario <jmario@redhat.com>

