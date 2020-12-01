Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583532CA0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgLALD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgLALDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:03:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R7lTicv2X0dQEiz5cgZYJHulalzBL3nNEkOe9sOfN8U=; b=TyNJoR+bUpbzExNeyK5XVj93s5
        jERnsJPobqpdDOBZ53O3rKEpGm8EjqPpKipKMdFgaKBQAjEoaQkBBO76fPM+x6uyZPpQ2//hRBk2G
        LVUkC+1LbEb66x1VkAYXgA7ECAfbWuIF8mmZmSWJy1IzC5Pf/xq3kip6PfCRaFKLyYgaBWfRivG5w
        Of59+GL7zkTwwVpjBwdx+Jhi7wR07rsy+m6AdQSYUZjb1vY/BIiTRfaql7ZYkPCPJy0OnlxwILpVc
        ULSfpPfaMv+ZPEbPJU2tS2EKBSe2j3oblCmJpwIOzzkAKtfJnQN8Hk8DGDwQ0UFZK0CW52DRf7bdC
        Q9edWA8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk3Qz-0007Fe-6D; Tue, 01 Dec 2020 11:03:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63B173059DD;
        Tue,  1 Dec 2020 12:03:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E7502BE3BFEB; Tue,  1 Dec 2020 12:03:00 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:03:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Clear SMT siblings after determining the
 core is not idle
Message-ID: <20201201110300.GR3040@hirez.programming.kicks-ass.net>
References: <20201130144020.GS3371@techsingularity.net>
 <CAKfTPtBcZnxR073=eRsWNAGOnA8K4emL0BYEUzbkzZx6qJWmSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBcZnxR073=eRsWNAGOnA8K4emL0BYEUzbkzZx6qJWmSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:47:01PM +0100, Vincent Guittot wrote:
> On Mon, 30 Nov 2020 at 15:40, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > The clearing of SMT siblings from the SIS mask before checking for an idle
> > core is a small but unnecessary cost. Defer the clearing of the siblings
> > until the scan moves to the next potential target. The cost of this was
> > not measured as it is borderline noise but it should be self-evident.
> 
> Good point
> 
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
