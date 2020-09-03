Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06925C901
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgICSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 14:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgICSyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:54:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D9320722;
        Thu,  3 Sep 2020 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599159293;
        bh=KOwGs1x8wySgQDqnIRQyUhxb76FmtYMVFh0gVgyNmhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMEiC+Qyub8H7S1OM51aYO2I5bEAnEC3kSAVgWEmPJ0Ff6Tsf1OZ3chNaggpS7veF
         GQBzbkGmQr/DwY7AOYCdwijPtnmsPWz4+JMAFQIgmWF5irP0GYvBMiaa2MOFoiv83Z
         crSV7l1/h+uMMyR8iZSb10wzs6ZweP7CaCIg95Xk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FD7040D3D; Thu,  3 Sep 2020 15:54:51 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:54:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf bench: fix return value check in
 do_run_multi_threaded()
Message-ID: <20200903185451.GF3495158@kernel.org>
References: <20200902140526.26916-1-yuehaibing@huawei.com>
 <20200903185301.GE3495158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903185301.GE3495158@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 03:53:01PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 02, 2020 at 10:05:26PM +0800, YueHaibing escreveu:
> > In case of error, the function perf_session__new() returns ERR_PTR()
> > and never returns NULL. The NULL test in the return value check
> > should be replaced with IS_ERR()
> > 
> > Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks, applied, kudos for adding the Fixes: tag, appreciated!

But...
 
> > ---
> >  tools/perf/bench/synthesize.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> > index 8d624aea1c5e..e39daa609db2 100644
> > --- a/tools/perf/bench/synthesize.c
> > +++ b/tools/perf/bench/synthesize.c
> > @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
> >  	init_stats(&event_stats);
> >  	for (i = 0; i < multi_iterations; i++) {
> >  		session = perf_session__new(NULL, false, NULL);
> > -		if (!session)
> > -			return -ENOMEM;
> > +		if (IS_ERR(session)) {
> > +			return PTR_ERR(session);

This doesn't compile, so I take back that kudo ;-\

I'm fixing this by removing that needless '{'.

Please be more careful,

- Arnaldo

> >  
> >  		atomic_set(&event_count, 0);
> >  		gettimeofday(&start, NULL);
> > -- 
> > 2.17.1
> > 
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
