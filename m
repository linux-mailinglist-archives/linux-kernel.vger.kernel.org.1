Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A341C2AF5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKKQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKKQKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:10:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858E0206A1;
        Wed, 11 Nov 2020 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605111054;
        bh=B8emSrl5cDEqUKAszZCD2s041YBsX8RrpoCViT/4R0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KSzrLC19c+McysSPs1fu5TTNA+rf9kFWLw4PPbrMr1/Q+2988f+ygQ3IJs8HyHqL
         YfF/AyQ0v+dFRdEAEJFyZwdyD4MDxd2N3O9R70MkJJmtK3yTEPUSDiRMznXHjjOYCf
         ScMBh6i3ywCBdD4XVoRrDrsIlWBt1XM6IEYYgEvQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42466411D1; Wed, 11 Nov 2020 13:10:51 -0300 (-03)
Date:   Wed, 11 Nov 2020 13:10:51 -0300
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
Message-ID: <20201111161051.GH355344@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 03:11:27PM +0800, Leo Yan escreveu:
> This is patch set v8 for refactoring Arm SPE trace decoding and dumping.
> 
> This version addresses Andre's comment to pass parameter '&buf_len' at
> the last call arm_spe_pkt_snprintf() in the function arm_spe_pkt_desc().
> 
> This patch set is cleanly applied on the top of perf/core branch
> with commit 644bf4b0f7ac ("perf jevents: Add test for arch std events").
> 
> I retested this patch set on Hisilicon D06 platform with commands
> "perf report -D" and "perf script", compared the decoding results
> between with this patch set and without this patch set, "diff" tool
> shows the result as expected.

With the patches I applied I'm getting:

util/arm-spe-decoder/arm-spe-pkt-decoder.c: In function 'arm_spe_pkt_desc':
util/arm-spe-decoder/arm-spe-pkt-decoder.c:410:3: error: left shift count >= width of type [-Werror]
   case 1: ns = !!(packet->payload & NS_FLAG);
   ^
util/arm-spe-decoder/arm-spe-pkt-decoder.c:411:4: error: left shift count >= width of type [-Werror]
    el = (packet->payload & EL_FLAG) >> 61;
    ^
util/arm-spe-decoder/arm-spe-pkt-decoder.c:411:4: error: left shift count >= width of type [-Werror]
util/arm-spe-decoder/arm-spe-pkt-decoder.c:416:3: error: left shift count >= width of type [-Werror]
   case 3: ns = !!(packet->payload & NS_FLAG);
   ^
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
 

On:

  16    11.70 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17    11.32 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)

That were building ok before, builds still under way, perhaps its just
on these old systems...

- Arnaldo
 
> Changes from v7:
> - Changed to pass '&buf_len' for the last call arm_spe_pkt_snprintf() in
>   the patch 07/22 (Andre).
> 
> Changes from v6:
> - Removed the redundant comma from the string in the patch 21/22 "perf
>   arm_spe: Decode memory tagging properties" (Dave);
> - Refined the return value for arm_spe_pkt_desc(): returns 0 for
>   success, otherwise returns non zero for failures; handle error code at
>   the end of function arm_spe_pkt_desc(); this is accomplished in the
>   new patch 07/22 "perf arm-spe: Consolidate arm_spe_pkt_desc()'s
>   return value" (Dave).
> 
> Changes from v5:
> - Directly bail out arm_spe_pkt_snprintf() if any error occurred
>   (Andre).
> 
> Changes from v4:
> - Implemented a cumulative error for arm_spe_pkt_snprintf() and changed
>   to condense code for printing strings (Dave);
> - Changed to check payload bits [55:52] for parse kernel address
>   (Andre).
> 
> Changes from v3:
> - Refined arm_spe_payload_len() and removed macro SPE_HEADER_SZ()
>   (Andre);
> - Refined packet header index macros (Andre);
> - Added patch "perf arm_spe: Fixup top byte for data virtual address" to
>   fixup the data virtual address for 64KB pages and refined comments for
>   the fixup (Andre);
> - Added Andre's review tag (using "b4 am" command);
> - Changed the macros to SPE_PKT_IS_XXX() format to check operation types
>   (Andre).
> 
> 
> Andre Przywara (1):
>   perf arm_spe: Decode memory tagging properties
> 
> Leo Yan (20):
>   perf arm-spe: Include bitops.h for BIT() macro
>   perf arm-spe: Fix a typo in comment
>   perf arm-spe: Refactor payload size calculation
>   perf arm-spe: Refactor arm_spe_get_events()
>   perf arm-spe: Fix packet length handling
>   perf arm-spe: Refactor printing string to buffer
>   perf arm-spe: Consolidate arm_spe_pkt_desc()'s return value
>   perf arm-spe: Refactor packet header parsing
>   perf arm-spe: Add new function arm_spe_pkt_desc_addr()
>   perf arm-spe: Refactor address packet handling
>   perf arm_spe: Fixup top byte for data virtual address
>   perf arm-spe: Refactor context packet handling
>   perf arm-spe: Add new function arm_spe_pkt_desc_counter()
>   perf arm-spe: Refactor counter packet handling
>   perf arm-spe: Add new function arm_spe_pkt_desc_event()
>   perf arm-spe: Refactor event type handling
>   perf arm-spe: Remove size condition checking for events
>   perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
>   perf arm-spe: Refactor operation packet handling
>   perf arm-spe: Add more sub classes for operation packet
> 
> Wei Li (1):
>   perf arm-spe: Add support for ARMv8.3-SPE
> 
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  59 +-
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 601 ++++++++++--------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
>  tools/perf/util/arm-spe.c                     |   2 +-
>  5 files changed, 479 insertions(+), 322 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
