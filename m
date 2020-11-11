Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31352AF5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKKQPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgKKQPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:15:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4EF20756;
        Wed, 11 Nov 2020 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605111337;
        bh=Cc3XydRNQ/rJhLlFtO+1Ab5/V57B3mncWgHChCGggD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcbwJ3D+ajgN+JZXObYOE19B+m3OGxQK1lqLOAUo5m71I1ZhLzCjQDVi3sA/Nfnij
         yqLQVVyPvK/FV9ZL38YvNbhzHVBhgoci0d7MRJLNptNTADNQdQ6EWSeD6NndTJW33v
         jP36J5wCvnsqbt1S3C7oKn4Vd8zry5Jm0X9aZUNE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6268C411D1; Wed, 11 Nov 2020 13:15:35 -0300 (-03)
Date:   Wed, 11 Nov 2020 13:15:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/22] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201111161535.GI355344@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111161051.GH355344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111161051.GH355344@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 01:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 11, 2020 at 03:11:27PM +0800, Leo Yan escreveu:
> > This is patch set v8 for refactoring Arm SPE trace decoding and dumping.
> > 
> > This version addresses Andre's comment to pass parameter '&buf_len' at
> > the last call arm_spe_pkt_snprintf() in the function arm_spe_pkt_desc().
> > 
> > This patch set is cleanly applied on the top of perf/core branch
> > with commit 644bf4b0f7ac ("perf jevents: Add test for arch std events").
> > 
> > I retested this patch set on Hisilicon D06 platform with commands
> > "perf report -D" and "perf script", compared the decoding results
> > between with this patch set and without this patch set, "diff" tool
> > shows the result as expected.
> 
> With the patches I applied I'm getting:
> 
> util/arm-spe-decoder/arm-spe-pkt-decoder.c: In function 'arm_spe_pkt_desc':
> util/arm-spe-decoder/arm-spe-pkt-decoder.c:410:3: error: left shift count >= width of type [-Werror]
>    case 1: ns = !!(packet->payload & NS_FLAG);
>    ^
> util/arm-spe-decoder/arm-spe-pkt-decoder.c:411:4: error: left shift count >= width of type [-Werror]
>     el = (packet->payload & EL_FLAG) >> 61;
>     ^
> util/arm-spe-decoder/arm-spe-pkt-decoder.c:411:4: error: left shift count >= width of type [-Werror]
> util/arm-spe-decoder/arm-spe-pkt-decoder.c:416:3: error: left shift count >= width of type [-Werror]
>    case 3: ns = !!(packet->payload & NS_FLAG);
>    ^
>   CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
>  
> 
> On:
> 
>   16    11.70 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   17    11.32 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
> 
> That were building ok before, builds still under way, perhaps its just
> on these old systems...

[acme@five perf]$ git bisect good
cc6fa07fb1458cca3741919774eb050976471000 is the first bad commit
commit cc6fa07fb1458cca3741919774eb050976471000
Author: Leo Yan <leo.yan@linaro.org>
Date:   Wed Nov 11 15:11:28 2020 +0800

    perf arm-spe: Include bitops.h for BIT() macro

    Include header linux/bitops.h, directly use its BIT() macro and remove
    the self defined macros.

    Signed-off-by: Leo Yan <leo.yan@linaro.org>
    Reviewed-by: Andre Przywara <andre.przywara@arm.com>
    Link: https://lore.kernel.org/r/20201111071149.815-2-leo.yan@linaro.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 5 +----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)
[acme@five perf]$
