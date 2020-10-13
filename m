Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35328D0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgJMOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgJMOxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:53:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087AE2489C;
        Tue, 13 Oct 2020 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602600814;
        bh=deMf+UyiVh07dVCA51wXAWNWae5FM0SoGd9A67zB4ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rXg93Wr67Lyf+KSoJQWVW8rz4UfIQsKlyhKRLvsTxqOIBtTqug6vCaPlxuccIQAK
         fiyYAybDxhgBdpqJdKPSZ0qC/RhM85f5v8sM1T1r7Qm1Q9wywJSkRTQcMnAbpoRl6i
         nATMoQtLX616HUMIxTCduUz1uWBsJ5fytQ3blztM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19F074047F; Tue, 13 Oct 2020 11:53:32 -0300 (-03)
Date:   Tue, 13 Oct 2020 11:53:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v2 00/14] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201013145332.GG1063281@kernel.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 29, 2020 at 02:39:03PM +0100, Leo Yan escreveu:
> The prominent issue for the SPE trace decoding and dumping is the packet
> header and payload values are hard coded with numbers and it's not
> readable and difficult to maintain; and has other minor issues, e.g. the
> packet length (header + payload) calculation is not correct for some
> packet types, and the dumping flow misses to support specific sub
> classes for operation packet, etc.
> 
> So this patch set is to refactor the Arm SPE decoding SPE with:
> - Patches 01, 02 are minor cleans up;
> - Patches 03, 04 are used to fix and polish the packet and payload
>   length calculation;
> - Patch 05 is to add a helper to wrap up printing strings, this can
>   avoid bunch of duplicate code lines;
> - Patches 06 ~ 12 are used to refactor decoding for different types
>   packet one by one (address packet, context packet, counter packet,
>   event packet, operation packet);
> - Patch 13 is coming from Andre to dump memory tagging;
> - Patch 14 is coming from Wei Li to add decoding for ARMv8.3
>   extension, in this version it has been improved to use defined
>   macros, also is improved for failure handling and commit log.
> 
> This patch set is cleanly applied on the top of perf/core branch
> with commit a55b7bb1c146 ("perf test: Fix msan uninitialized use."),
> and the patches have been verified on Hisilicon D06 platform and I
> manually inspected the dumping result.
> 
> Changes from v1:
> - Heavily rewrote the patch 05 for refactoring printing strings; this
>   is fundamental change, so adjusted the sequence for patches and moved
>   the printing string patch ahead from patch 10 (v1) to patch 05;
> - Changed to use GENMASK_ULL() for bits mask;
> - Added Andre's patch 13 for dumping memory tagging;
> - Refined patch 12 for adding sub classes for Operation packet, merged
>   some commit log from Andre's patch, which allows commit log and code
>   to be more clear; Added "Co-developed-by: Andre Przywara" tag to
>   reflect this.

Ok, so I'll wait for v3, as Leo indicated he'll respin.

Thanks,

- Arnaldo
 
> 
> Andre Przywara (1):
>   perf arm_spe: Decode memory tagging properties
> 
> Leo Yan (12):
>   perf arm-spe: Include bitops.h for BIT() macro
>   perf arm-spe: Fix a typo in comment
>   perf arm-spe: Refactor payload length calculation
>   perf arm-spe: Fix packet length handling
>   perf arm-spe: Refactor printing string to buffer
>   perf arm-spe: Refactor packet header parsing
>   perf arm-spe: Refactor address packet handling
>   perf arm-spe: Refactor context packet handling
>   perf arm-spe: Refactor counter packet handling
>   perf arm-spe: Refactor event type handling
>   perf arm-spe: Refactor operation packet handling
>   perf arm-spe: Add more sub classes for operation packet
> 
> Wei Li (1):
>   perf arm-spe: Add support for ARMv8.3-SPE
> 
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  54 +-
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 567 +++++++++++-------
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 124 +++-
>  4 files changed, 478 insertions(+), 284 deletions(-)
> 
> -- 
> 2.20.1
> 

-- 

- Arnaldo
