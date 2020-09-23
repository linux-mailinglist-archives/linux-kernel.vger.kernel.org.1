Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B819275C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIWP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgIWP4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:56:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F8220897;
        Wed, 23 Sep 2020 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600876560;
        bh=TONkJrEYmGeD4XnSKtouJ/OUcUqfNtDYgo77uxd3D+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0jt69UGRtcUeuLK1RsQcMysyw7we52JjiQ11HmgonCnu7NlrZ8yt/5I/VE28+kUz
         nJPWQyJOwYdB8J9T0Z90EzK45p2tnpXlloNWJU50wZEfbzNh/l62uHEe3M2SSnfN0E
         a1hQc5saA2Y0MQCZWY3qj4080HfjnnDbMlUG2Odo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCD82400E9; Wed, 23 Sep 2020 12:55:57 -0300 (-03)
Date:   Wed, 23 Sep 2020 12:55:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Message-ID: <20200923155557.GD2517482@kernel.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
 <20200922120732.GB15124@leoy-ThinkPad-X240s>
 <20200922164906.GA2248446@kernel.org>
 <20200923152753.GC2517482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152753.GC2517482@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 23, 2020 at 12:27:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 22, 2020 at 01:49:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Sep 22, 2020 at 08:07:32PM +0800, Leo Yan escreveu:
> > > Hi Arnaldo,
> > > 
> > > On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> > > > This patch set is to refactor TSC implementation and move TSC code from
> > > > x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> > > > alse move the TSC testing from x86 folder to tests so can work as a
> > > > common testing.
> > > > 
> > > > So far, for x86 it needs to support cap_user_time_zero and for Arm64
> > > > it needs to support cap_user_time_short.  For architecture specific
> > > > code, every arch only needs to implement its own rdtsc() to read out
> > > > timer's counter.
> > > > 
> > > > This patch set has been rebased on the perf/core branch with latest
> > > > commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> > > > metric events") and tested on Arm64 DB410c.
> > > 
> > > Could you pick up this patch set?  Thanks!
> > 
> > Yeah, I picked it up now, its a pity nobody provided Acks :-\
> > 
> > Or have a missed them somehow?
> 
> Also:

So, this is the first:

commit 0ab58c405dd7c143a1482cb9414eb0eb9b31d42a (HEAD)
Author: Leo Yan <leo.yan@linaro.org>
Date:   Mon Sep 14 19:53:10 2020 +0800

    perf tests tsc: Make tsc testing as a common testing

I'll remove it and the ones after that, so the main feature is kept.

I'll retest, and then push to perf/core you can then continue from
there.

Thanks,

- Arnaldo
