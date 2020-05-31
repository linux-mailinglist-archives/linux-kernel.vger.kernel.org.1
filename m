Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFED1E977E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgEaMXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 08:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEaMXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:23:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8758206EB;
        Sun, 31 May 2020 12:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590927792;
        bh=3yMy+xck8CUmE5HBSkTT9c450oZcodhaZnaDFAcZ8EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXyrdsi3bhNL2B8H5YlXp8Py8muivG5UNfqMfZ3KdJCc/3P5rjJVlggZjVWqOi3sb
         ThmCQPE+JpHpbsizohoyCkGkvTsTw6EA+61fsmtpz522o/FnayZ87A7Rt81bD2bvA/
         aEDnTyg5cHuiVbTiiV5d36PdA8jhiJ5RpGd7v0m8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D480540AFD; Sun, 31 May 2020 09:23:10 -0300 (-03)
Date:   Sun, 31 May 2020 09:23:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v8 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200531122310.GF31795@kernel.org>
References: <20200530122442.490-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530122442.490-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 30, 2020 at 08:24:39PM +0800, Leo Yan escreveu:
> This patch set is to support synthetic events with enabling Arm SPE
> decoder.  This patch set is based Xiaojun Tan (Hisilicon) and
> James Clark (Arm)'s previous patches who have contributed much for
> the related task.

Applied, will push to tmp.perf/core, and then perf/core if all tests are
successful, Adrian, if you could provide an Acked-by: for the auxtrace
case, that would be good,

- Arnaldo
 
> This patch set has been checked with checkpatch.pl, though it leaves
> several warnings, but these warnings are deliberately kept after
> reviewing.  Some warnings ask to add maintainer (so far it's not
> necessary), and some warnings complaint for patch 02 "perf auxtrace:
> Add four itrace options" for the text format, since need to keep the
> consistency with the same code format in the source code, this is why
> this patch doesn't get rid of checkpatch warnings.
> 
> This patch set has been rebased on Perf tmp.perf/core branch with
> latest commit 9300acc6fed8 ("perf build: Add a LIBPFM4=1 build test
> entry").  The patches has been tested on Arm N1 machine (by James)
> and on Hisilicon D06 platform (by Leo).
> 
> Changes from v7:
> * Added James's tested-by tags;
> * Rebased on Perf tmp.perf/core branch.
> 
> 
> Tan Xiaojun (3):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf auxtrace: Add four itrace options
>   perf arm-spe: Support synthetic events
> 
>  tools/perf/Documentation/itrace.txt           |   6 +-
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 219 +++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  82 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |  16 +
>  tools/perf/util/arm-spe.c                     | 823 +++++++++++++++++-
>  tools/perf/util/auxtrace.c                    |  17 +
>  tools/perf/util/auxtrace.h                    |  15 +-
>  10 files changed, 1135 insertions(+), 46 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (64%)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
