Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBC25DFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIDQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIDQWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:22:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97912067C;
        Fri,  4 Sep 2020 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599236531;
        bh=aT2FJHW1WlNv25o153zFstwJjPQmAqnZElzR5tHePyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euspleWFeid+yEEBVznB9qMfOXeiAXiRvZgG1K83RI+zpcWZEAdFDLaUI7jQ9lj7i
         YTzePv2YfCbisYJZSULETQfBojrb5Ey9v2nOdWaPYzJN3yIoPgEcuMbLVKJffJ+Xed
         FfhNU6eJytU6xIbD5Sv0ZQqoLjdg1OhFdwarJqpY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E35D040D3D; Fri,  4 Sep 2020 13:22:08 -0300 (-03)
Date:   Fri, 4 Sep 2020 13:22:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf bench: fix return value check in
 do_run_multi_threaded()
Message-ID: <20200904162208.GS3495158@kernel.org>
References: <20200902140526.26916-1-yuehaibing@huawei.com>
 <20200903185301.GE3495158@kernel.org>
 <20200903185451.GF3495158@kernel.org>
 <20200903185549.GG3495158@kernel.org>
 <6815e565-c3a2-c7a2-f164-8d3c56f9c516@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6815e565-c3a2-c7a2-f164-8d3c56f9c516@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 04, 2020 at 09:25:02PM +0800, Yuehaibing escreveu:
> On 2020/9/4 2:55, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 03, 2020 at 03:54:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>> Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
> >>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

> >>> Thanks, applied, kudos for adding the Fixes: tag, appreciated!

> >> But...
 
> OOps, sorry for this, I'll pay attention next time.

Thanks!

- Arnaldo
 
> >>>> +++ b/tools/perf/bench/synthesize.c
> >>>> @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
> >>>>  	init_stats(&event_stats);
> >>>>  	for (i = 0; i < multi_iterations; i++) {
> >>>>  		session = perf_session__new(NULL, false, NULL);
> >>>> -		if (!session)
> >>>> -			return -ENOMEM;
> >>>> +		if (IS_ERR(session)) {
> >>>> +			return PTR_ERR(session);

> >> This doesn't compile, so I take back that kudo ;-\

> >> I'm fixing this by removing that needless '{'.
