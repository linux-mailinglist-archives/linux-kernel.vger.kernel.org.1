Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539AA2EC06E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAFPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbhAFPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:33:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E1C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8GwBElr0nb2YD6QJJnL2YiCregS8nezybV0+a4eN50Y=; b=Xyf1ncHRqVeB65b3vj2KYB2J2U
        BdUEaPlbqNabg/N6nBsKDpRA/edWZMm9x/lGYnImfe0EYgWH/baM4QM0yHKy52LOfdpwTkecjiJkK
        XVnvV25yenLCDW4IHhmtIL9ayQvbn58e89XT/sATBuX/FFE1IXs0JoXQkcGE0sKhumCRC2f3QT3g2
        UfOY0DWFcIls9slhQ3/w09wc93s8BTS9KwfAJZj8DwJZK6pmiRR3YW9P+OkKzkvdeedtolUEA/SxM
        hEn37S13kAPPXAyNVfzD6/8PA5ZAJ+O5YHECWO7vy+3TUrC2qRZsU4R1l6VD4P6S1FewMYM7jtha8
        cQgbOdfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxAnp-0001Co-GU; Wed, 06 Jan 2021 15:32:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB2073010D2;
        Wed,  6 Jan 2021 16:32:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D31AB2029C723; Wed,  6 Jan 2021 16:32:47 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:32:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
Message-ID: <X/XYHxPtGFhJe+bu@hirez.programming.kicks-ass.net>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-3-vincent.guittot@linaro.org>
 <X/XSH7Qv58pSpi95@hirez.programming.kicks-ass.net>
 <CAKfTPtB+Nrk6ST9c-OacdW3zh07VC6M8GqvgNXzQ=KqucBrqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB+Nrk6ST9c-OacdW3zh07VC6M8GqvgNXzQ=KqucBrqQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:20:55PM +0100, Vincent Guittot wrote:

> This case here is :
> we have 2 tasks TA and TB on the rq.
> The waiting one TB can't migrate for a reason other than the pinned case.
> We decide to start the active migration on the running  TA task but TA
> is pinned.
> In this case we are not in the all pinned case.

But then can_migrate_task(TB) should clear ALL_PINNED, no?
