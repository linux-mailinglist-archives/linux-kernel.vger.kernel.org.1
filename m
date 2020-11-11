Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF22AF02E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKKL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgKKL6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:58:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058C3206C0;
        Wed, 11 Nov 2020 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605095934;
        bh=Hvar/KZsnF1u6eHe/6eJqSDkxTC0QNASzoL2ocZ4L7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYfn4E5KcbCXHeKtatEQFCWZCV0OqVfS8sjkCD+ZXcq93/s/GckTFm2pRNhUVq8P2
         xAvtRHdGbrDVVEspNkvsVti2n5xayGhdZkL+SkMbEzt4zDPzV1PGDR+TJx9vesbNqb
         k5tjw7d/JPZOJobym6LJUCmYE77LsKFe1wpm+HwM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3944411D1; Wed, 11 Nov 2020 08:58:51 -0300 (-03)
Date:   Wed, 11 Nov 2020 08:58:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
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
Subject: Re: [PATCH v8 00/22] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201111115851.GC355344@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <08024ef8-0407-5eeb-d6ad-86018dace8a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08024ef8-0407-5eeb-d6ad-86018dace8a4@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 10:13:52AM +0000, André Przywara escreveu:
> On 11/11/2020 07:11, Leo Yan wrote:
> 
> Hi Arnaldo, Ingo, Peter, (whoever feels responsible for taking this)
> 
> > This is patch set v8 for refactoring Arm SPE trace decoding and dumping.
> I have reviewed every patch of this in anger, and am now fine with this
> series. Given the bugs fixed, the improvements it brings in terms of
> readability and maintainability, and the low risk it has on breaking
> things, I would be happy to see it merged.

Ok, I'll have it in perf/core for v5.11, thanks!

- Arnaldo
 
> Thanks,
> Andre.
> 
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
> > 
> > Changes from v7:
> > - Changed to pass '&buf_len' for the last call arm_spe_pkt_snprintf() in
> >   the patch 07/22 (Andre).
> > 
> > Changes from v6:
> > - Removed the redundant comma from the string in the patch 21/22 "perf
> >   arm_spe: Decode memory tagging properties" (Dave);
> > - Refined the return value for arm_spe_pkt_desc(): returns 0 for
> >   success, otherwise returns non zero for failures; handle error code at
> >   the end of function arm_spe_pkt_desc(); this is accomplished in the
> >   new patch 07/22 "perf arm-spe: Consolidate arm_spe_pkt_desc()'s
> >   return value" (Dave).
> > 
> > Changes from v5:
> > - Directly bail out arm_spe_pkt_snprintf() if any error occurred
> >   (Andre).
> > 
> > Changes from v4:
> > - Implemented a cumulative error for arm_spe_pkt_snprintf() and changed
> >   to condense code for printing strings (Dave);
> > - Changed to check payload bits [55:52] for parse kernel address
> >   (Andre).
> > 
> > Changes from v3:
> > - Refined arm_spe_payload_len() and removed macro SPE_HEADER_SZ()
> >   (Andre);
> > - Refined packet header index macros (Andre);
> > - Added patch "perf arm_spe: Fixup top byte for data virtual address" to
> >   fixup the data virtual address for 64KB pages and refined comments for
> >   the fixup (Andre);
> > - Added Andre's review tag (using "b4 am" command);
> > - Changed the macros to SPE_PKT_IS_XXX() format to check operation types
> >   (Andre).
> > 
> > 
> > Andre Przywara (1):
> >   perf arm_spe: Decode memory tagging properties
> > 
> > Leo Yan (20):
> >   perf arm-spe: Include bitops.h for BIT() macro
> >   perf arm-spe: Fix a typo in comment
> >   perf arm-spe: Refactor payload size calculation
> >   perf arm-spe: Refactor arm_spe_get_events()
> >   perf arm-spe: Fix packet length handling
> >   perf arm-spe: Refactor printing string to buffer
> >   perf arm-spe: Consolidate arm_spe_pkt_desc()'s return value
> >   perf arm-spe: Refactor packet header parsing
> >   perf arm-spe: Add new function arm_spe_pkt_desc_addr()
> >   perf arm-spe: Refactor address packet handling
> >   perf arm_spe: Fixup top byte for data virtual address
> >   perf arm-spe: Refactor context packet handling
> >   perf arm-spe: Add new function arm_spe_pkt_desc_counter()
> >   perf arm-spe: Refactor counter packet handling
> >   perf arm-spe: Add new function arm_spe_pkt_desc_event()
> >   perf arm-spe: Refactor event type handling
> >   perf arm-spe: Remove size condition checking for events
> >   perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
> >   perf arm-spe: Refactor operation packet handling
> >   perf arm-spe: Add more sub classes for operation packet
> > 
> > Wei Li (1):
> >   perf arm-spe: Add support for ARMv8.3-SPE
> > 
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    |  59 +-
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 601 ++++++++++--------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 122 +++-
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  5 files changed, 479 insertions(+), 322 deletions(-)
> > 
> 

-- 

- Arnaldo
