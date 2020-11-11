Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08BD2AF7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKKSIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKKSIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:08:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD64D206FB;
        Wed, 11 Nov 2020 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605118121;
        bh=CAj5BtBzNYKOt2TTvtYuecOJKOMH0cp76evLYDno5TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQ0oaqxqrD5eNgShVtXwIf3S02IQxitv/ruvs1gX+uG2b8Qrl5qrHdmYZz4caiiCk
         3EKoffprkd7J1Ys7OYUKSTqXd6Iv5qqvSELKw1mt36ClIxxaB5BwXhwsZItSw8Zmfh
         YvOuPyFLWYr4jnSh+stdbRgTh7me+owYwSBpYKlo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0C1E411D1; Wed, 11 Nov 2020 15:08:38 -0300 (-03)
Date:   Wed, 11 Nov 2020 15:08:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Andre Przywara <Andre.Przywara@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201111180838.GF380127@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org>
 <20201111175827.GR6882@arm.com>
 <20201111180127.GD380127@kernel.org>
 <20201111180248.GE380127@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111180248.GE380127@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 03:02:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > I'll keep the series up to that point and will run my build tests, then
> > push it publicly to acme/perf/core and you can go from there, ok?

> > I've changed the BIT() to BIT_ULL() as Andre suggested and I'm testing
> > it again.
 
> To make it clear, this is what I have locally:
 
> 0a04244cabc5560c (HEAD -> perf/core) perf arm-spe: Fix packet length handling
> b65577baf4829092 perf arm-spe: Refactor arm_spe_get_events()
> b2ded2e2e2764e50 perf arm-spe: Refactor payload size calculation
> 903b659436b70692 perf arm-spe: Fix a typo in comment
> c185f1cde46653cd perf arm-spe: Include bitops.h for BIT() macro
> 40714c58630aaaf1 perf mem: Support ARM SPE events
> c825f7885178f994 perf c2c: Support AUX trace
> 13e5df1e3f1ba1a9 perf mem: Support AUX trace
> 014a771c7867fda5 perf auxtrace: Add itrace option '-M' for memory events
> 436cce00710a3f23 perf mem: Only initialize memory event for recording
> 8b8173b45a7a9709 perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
> 4ba2452cd88f39da perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
> eaf6aaeec5fa301c perf mem: Introduce weak function perf_mem_events__ptr()
> f9f16dfbe76e63ba perf mem: Search event name with more flexible path
> 644bf4b0f7acde64 (tag: perf-tools-tests-v5.11-2020-11-04, acme/perf/core) perf jevents: Add test for arch std events

So with the above it works with at least these:

[perfbuilder@five ~]$ dm android-ndk:r15c-arm ubuntu:18.04-x-arm
   1    22.37 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   2    28.52 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
[perfbuilder@five ~]$

previously it was failing in all 32-bit build test containers:

[perfbuilder@five linux-perf-tools-build]$ grep FAIL dm.log/summary 
 android-ndk:r12b-arm: FAIL
 android-ndk:r15c-arm: FAIL
 fedora:24-x-ARC-uClibc: FAIL
 fedora:30-x-ARC-uClibc: FAIL
 ubuntu:16.04-x-arm: FAIL
 ubuntu:16.04-x-powerpc: FAIL
 ubuntu:18.04-x-arm: FAIL
 ubuntu:18.04-x-m68k: FAIL
 ubuntu:18.04-x-powerpc: FAIL
 ubuntu:18.04-x-sh4: FAIL
 ubuntu:19.10-x-hppa: FAIL
[perfbuilder@five linux-perf-tools-build]$

I'll redo the full set of tests and push perf/core publicly.

- Arnaldo
