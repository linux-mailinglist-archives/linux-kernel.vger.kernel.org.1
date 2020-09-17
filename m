Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEED26E66A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIQUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgIQUNY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:13:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDB620707;
        Thu, 17 Sep 2020 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600373603;
        bh=LczrSXxlFYhGfjKrHuXBmBI+IgnC0RtjmefhpAc1rls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOQA/5XFH0gD6CCOKU5SHStrKyleXz08tLpPB4TlJxDT0R5mv+zYsxbRzFO4qJlEN
         cbs4vheSyS1PoXIPTk0ADmZXPYK3IxNyCEPOeAHtATyEAKzy4Id81lHQD2RkfQoahT
         FrmiRnKnpwukN46U/gyLAI5BjS+vY1uk+3EukO30=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9F20400E9; Thu, 17 Sep 2020 17:13:20 -0300 (-03)
Date:   Thu, 17 Sep 2020 17:13:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/7] perf: Stream comparison
Message-ID: <20200917201320.GB1431236@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200917130556.GA2511679@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917130556.GA2511679@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 17, 2020 at 03:05:56PM +0200, Jiri Olsa escreveu:
> On Fri, Sep 11, 2020 at 04:03:46PM +0800, Jin Yao wrote:
> 
> SNIP
> 
> >                       main div.c:40
> >                       main div.c:40
> >                       main div.c:39
> > 
> > [ Hot streams in new perf data only ]
> > 
> > hot chain 1:
> >                                                      cycles: 4, hits: 4.54%
> >                                                  --------------------------
> >                                                               main div.c:42
> >                                                       compute_flag div.c:28
> > 
> > hot chain 2:
> >                                                      cycles: 5, hits: 3.51%
> >                                                  --------------------------
> >                                                               main div.c:39
> >                                                               main div.c:44
> >                                                               main div.c:42
> >                                                       compute_flag div.c:28
> > 
> >  v6:
> >  ---
> >  Rebase to perf/core
> 
> it looks good to me
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Jin,

	I'm sorry I only got to look at this now, there are some issues,
I'll try to point them out patch by patch,

Thanks,

- Arnaldo
