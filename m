Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0C293AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbgJTMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394266AbgJTMJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:09:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229BE20770;
        Tue, 20 Oct 2020 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603195749;
        bh=bzUlpqwLpEkr2ycDDBBKsn7VBnc/jgcacxUUZtEDpAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OygGjj/s/jcVzDy29QfRDbY86pBhCGKuSwQPXf1kb1uS/B68yooaJO2zV+3yE3X0m
         JmXvEpeD98vTpgl1MXQNXG9m1H6C2NlFV2mnD2efb81OaXeqAmkc/lNI1wfDq+EKOs
         PebMOgT2I2vY2pCrBAnwVALp2MFCXonbl5pZwSzA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 158E0403C2; Tue, 20 Oct 2020 09:09:07 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:09:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] perf: Make tsc testing as a common testing case
Message-ID: <20201020120907.GD2294271@kernel.org>
References: <20201019100236.23675-1-leo.yan@linaro.org>
 <20201020061159.GB2084117@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020061159.GB2084117@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 20, 2020 at 08:11:59AM +0200, Jiri Olsa escreveu:
> On Mon, Oct 19, 2020 at 06:02:34PM +0800, Leo Yan wrote:
> > This patch set is to move tsc testing from x86 specific to common
> > testing case.  Since Arnaldo found the building failure for patch set
> > v4 [1], the first four patches have been merged but the last two patches
> > were left out; this patch set is to resend the last two patches with
> > fixed the building failure (by removing the header "arch-tests.h" from the
> > testing code).
> > 
> > These two patches have been tested on x86_64 and Arm64.  Though I don't
> > test them on archs MIPS, PowerPC, etc, I tried to search every header so
> > ensure included headers are supported for all archs.
> > 
> > These two patches have been rebased on the perf/core branch with its
> > latest commit 744aec4df2c5 ("perf c2c: Update documentation for metrics
> > reorganization").
> > 
> > Changes from v5:
> > * Found the merging confliction on latest perf/core, so rebased it.
> > 
> > [1] https://lore.kernel.org/patchwork/cover/1305382/#1505752
> > 
> > 
> > Leo Yan (2):
> >   perf tests tsc: Make tsc testing as a common testing
> >   perf tests tsc: Add checking helper is_supported()
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>



Thanks, applied.

- Arnaldo

