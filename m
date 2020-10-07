Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6016285F03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgJGMVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgJGMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:21:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15856C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7c5q/AXN3ZlW1k7u+3sa3kPQ18bX/GmWmc5N6iE5bPY=; b=lHYopw8Pm6hHGHtoOJ4r038IEc
        SG1UxulHtRT6bt9wT53npHVxMvH1CzeGLfNSnEWJbUIoFnAVY6hhGYMg8x6UnSTIynTgWep5GikUz
        djU29IJSR+w+aoOwYU/YQh0kKR0d2OwzX/CddfqiqhAQ78hZn4TCzmaM41KXKFauU50F1r16vS/re
        xXVPrEMGD1s57CxgiKhjVKPoLJ0/RDJQQ+bBp/ai98MbVmOZLqFKIg11BUqLnsgZ2QxJKy8FxMVy2
        n837WHzXDFa23IyOAf31IjtZfSupEiYz8x+OpBflz3PnBfwULKOAsueQucF13+6SJG0C1PUr7SmY2
        D7lAikqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8S2-00085S-9j; Wed, 07 Oct 2020 12:21:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D756F3019CE;
        Wed,  7 Oct 2020 14:21:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C52F229AD665D; Wed,  7 Oct 2020 14:21:44 +0200 (CEST)
Date:   Wed, 7 Oct 2020 14:21:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201007122144.GF2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007120401.11200-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> I wanted to make sure that the idea is sound for maintainers first. The
> next step would be extending the command line to support full preemption
> as well but there is much more work in that area. Frederic has promissed
> to look into that.

The sanest way there is to static_call() __preempt_schedule() I think.
Alternatively you could use alternatives but that makes the whole thing
arch specific again.
