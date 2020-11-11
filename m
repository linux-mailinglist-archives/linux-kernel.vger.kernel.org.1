Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00912AEE99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKKKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:14:10 -0500
Received: from foss.arm.com ([217.140.110.172]:46324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbgKKKOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:14:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2586101E;
        Wed, 11 Nov 2020 02:14:08 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A12D3F6CF;
        Wed, 11 Nov 2020 02:14:06 -0800 (PST)
Subject: Re: [PATCH v8 00/22] perf arm-spe: Refactor decoding & dumping flow
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20201111071149.815-1-leo.yan@linaro.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Cc:     Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Organization: ARM Ltd.
Message-ID: <08024ef8-0407-5eeb-d6ad-86018dace8a4@arm.com>
Date:   Wed, 11 Nov 2020 10:13:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 07:11, Leo Yan wrote:

Hi Arnaldo, Ingo, Peter, (whoever feels responsible for taking this)

> This is patch set v8 for refactoring Arm SPE trace decoding and dumping.
I have reviewed every patch of this in anger, and am now fine with this
series. Given the bugs fixed, the improvements it brings in terms of
readability and maintainability, and the low risk it has on breaking
things, I would be happy to see it merged.

Thanks,
Andre.

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
> 
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

