Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7761726C55D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIPQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbgIPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0EA22286;
        Wed, 16 Sep 2020 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264145;
        bh=ZNsiXz5lzWzK3By2SyYSlMrJeexW935A7TY2zdOFehE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQj4pVixVaeTuA2JPaThKigclArbCgEtK8czCUxe8apSgoaxS0Q4N1gTDuYY6iCiR
         pOAc8xxJzbeABGPVcBPo68juqqSuY6rQyKm2jboxBWgtye/IsTfu9pDDgjYTxIBkyQ
         OMOK91Lo8PxFVG9UHmgxGrc3WwGJddRhGSYnCnqg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB40C400E9; Wed, 16 Sep 2020 10:49:02 -0300 (-03)
Date:   Wed, 16 Sep 2020 10:49:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] perf metric: Remove duplicate include
Message-ID: <20200916134902.GN720847@kernel.org>
References: <20200915081541.41004-1-yuehaibing@huawei.com>
 <CAM9d7cjzPHR4wB3KA_3MfyhwH+PAwF5ucjwWe=xeSL7SHPch+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjzPHR4wB3KA_3MfyhwH+PAwF5ucjwWe=xeSL7SHPch+A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 11:51:22PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Sep 15, 2020 at 5:16 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > Remove duplicate header which is included twice.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
 
> Thanks
> Namhyung
> 
> 
> > ---
> >  tools/perf/tests/parse-metric.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 23db8acc492d..b344decfb91b 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -11,8 +11,6 @@
> >  #include "debug.h"
> >  #include "expr.h"
> >  #include "stat.h"
> > -#include <perf/cpumap.h>
> > -#include <perf/evlist.h>
> >
> >  static struct pmu_event pme_test[] = {
> >  {
> > --
> > 2.17.1
> >
> >

-- 

- Arnaldo
