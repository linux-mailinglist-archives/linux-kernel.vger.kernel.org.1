Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFFF27FA53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgJAHdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJAHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:33:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41D4C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WQ4YJE3C8JSXp7AEvKTAJrdFclhhTJrnVqotRqAv0oM=; b=Jg1HAowrTWvfFObH3fW6z6YeHi
        tlWFuRDsNv3HrkEzMJRWPIdlx/NF1JRHQUTAb4VDC/08AuvnmPel+kyrM/FkzFimF8Dms1IrmcfS0
        ZKQN8cRbVbN73Qw6S61yZtgOdo28sVik49MIJRnjfACZn8sk+XU1kQoCJoGT5Ev/ac0q9GHmYVDnV
        kqABHJ8Dcq4QTYz31eXmhQu0LoTx4Mr1yAlbnHPfk+4jaX84ZoWg1ZvRQu782gcxhCS1OCuFqJdus
        DeafyKhCUSIOgCQyuZYXFefY7fu7wbxgqz6oOK9SyBMNTWSZkrcUTbz1v+IO3sne56kGbzVuK1fOi
        brJ+piUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNt5R-00070g-TT; Thu, 01 Oct 2020 07:33:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55B213011F0;
        Thu,  1 Oct 2020 09:33:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 343FB200F912C; Thu,  1 Oct 2020 09:33:09 +0200 (CEST)
Date:   Thu, 1 Oct 2020 09:33:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH] sched/fair: tweak pick_next_entity
Message-ID: <20201001073309.GL2628@hirez.programming.kicks-ass.net>
References: <20200930173532.1069092-1-posk@google.com>
 <CAKfTPtBbaw5Ny_qmdhwiQyErfpE+GehY3wTMUxNVtfBjnAVC5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBbaw5Ny_qmdhwiQyErfpE+GehY3wTMUxNVtfBjnAVC5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:17:43AM +0200, Vincent Guittot wrote:
> On Wed, 30 Sep 2020 at 19:35, Peter Oskolkov <posk@google.com> wrote:
> >
> > Currently, pick_next_entity(...) has the following structure
> > (simplified):
> >
> > [...]
> > if (last_buddy_ok())
> >   result = last_buddy;
> > if (next_buddy_ok())
> >   result = next_buddy;
> > [...]
> >
> > The intended behavior is to prefer next buddy over last buddy;
> > the current code somewhat obfuscates this, and also wastes
> > cycles checking the last buddy when eventually the next buddy is
> > picked up.
> >
> > So this patch refactors two 'ifs' above into
> >
> > [...]
> > if (next_buddy_ok())
> >     result = next_buddy;
> > else if (last_buddy_ok())
> >     result = last_buddy;
> > [...]
> >
> > Signed-off-by: Peter Oskolkov <posk@google.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guitttot@linaro.org>

Thanks!
