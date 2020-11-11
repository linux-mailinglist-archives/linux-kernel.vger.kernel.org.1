Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544822AF7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKKSCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKKSCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:02:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26954206B6;
        Wed, 11 Nov 2020 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605117770;
        bh=c6+pW3lw+shG0mbohxs3JzOIRUMxGkhGMDw53k5Zi58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSHahqpDqc2+mMs7hvXeTkPg8ndmvVZJHEdDq0fkvTlTbNkHQwPp/LElIAG86ERkL
         nKOlPA4Wl3iJe1vgsUK1O5w9lzLKxU0+QWBzuvMEW8G8OztqlpktfO8WofoX7Wq40J
         uGxQLvrDkGpOpcVV0U2nTyBnhYfkGA8mOa4d8mc4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 210B2411D1; Wed, 11 Nov 2020 15:02:48 -0300 (-03)
Date:   Wed, 11 Nov 2020 15:02:48 -0300
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
Message-ID: <20201111180248.GE380127@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org>
 <20201111175827.GR6882@arm.com>
 <20201111180127.GD380127@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111180127.GD380127@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 03:01:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 11, 2020 at 05:58:27PM +0000, Dave Martin escreveu:
> > 
> > On Wed, Nov 11, 2020 at 05:39:22PM +0000, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Nov 11, 2020 at 03:45:23PM +0000, Andr� Przywara escreveu:
> > > > On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> > > > > Isn't this 'ret +=' ? Otherwise if any of these arm_spe_pkt_snprintf()
> > > > > calls are made the previous 'ret' value is simply discarded. Can you
> > > > > clarify this?
> 
> > > > ret is the same as err. If err is negative (from previous calls), we
> > > > return that straight away, so it does nothing but propagating the error.
> 
> > > Usually the return of a snprintf is used to account for buffer space, ok
> > > I'll have to read it, which I shouldn't as snprintf has a well defined
> > > meaning...
> 
> > > Ok, now that I look at it, I realize it is not a snprintf() routine, but
> > > something with different semantics, that will look at a pointer to an
> > > integer and then do nothing if it comes with some error, etc, confusing
> > > :-/
> 
> > Would you be happier if the function were renamed?
> 
> > Originally we were aiming for snprintf() semantics, but this still
> > spawns a lot of boilerplate code and encourages mistakes in the local
> > caller here -- hence the current sticky error approach.
> 
> > So maybe the name should now be less "snprintf"-like.
> 
> Please, its important to stick to semantics for such well known type of
> routines, helps reviewing, etc.
> 
> I'll keep the series up to that point and will run my build tests, then
> push it publicly to acme/perf/core and you can go from there, ok?
> 
> I've changed the BIT() to BIT_ULL() as Andre suggested and I'm testing
> it again.

To make it clear, this is what I have locally:

0a04244cabc5560c (HEAD -> perf/core) perf arm-spe: Fix packet length handling
b65577baf4829092 perf arm-spe: Refactor arm_spe_get_events()
b2ded2e2e2764e50 perf arm-spe: Refactor payload size calculation
903b659436b70692 perf arm-spe: Fix a typo in comment
c185f1cde46653cd perf arm-spe: Include bitops.h for BIT() macro
40714c58630aaaf1 perf mem: Support ARM SPE events
c825f7885178f994 perf c2c: Support AUX trace
13e5df1e3f1ba1a9 perf mem: Support AUX trace
014a771c7867fda5 perf auxtrace: Add itrace option '-M' for memory events
436cce00710a3f23 perf mem: Only initialize memory event for recording
8b8173b45a7a9709 perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
4ba2452cd88f39da perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
eaf6aaeec5fa301c perf mem: Introduce weak function perf_mem_events__ptr()
f9f16dfbe76e63ba perf mem: Search event name with more flexible path
644bf4b0f7acde64 (tag: perf-tools-tests-v5.11-2020-11-04, acme/perf/core) perf jevents: Add test for arch std events

The perf-tools-tests-v5.11-2020-11-04, is in git.kernel.org, as it was
tested, etc, test results are in that signed tag, as usual for some
months.

- Arnaldo
