Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8E27AA90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgI1JUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgI1JUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:20:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F43C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=30T0FOFjfup+Xc84zz0B0IrJTJpFFLhaauTgsoWU/vg=; b=dqhF/17zLtuWgP8vfUJj6kxVDE
        DN9qfWWs6nkL0ZQvTQRstH+1mFJRiORKfJswAhkdcZ6rI0qOK1ZhonK7xqrochxUezjLb1LkNqlHd
        zpBii3DvlKZvW29KEl/t5pvHDnZp2kTohy7exbExevGh0pp3jNQmUmBptFKVg0N+aYpEOGUhLRE9o
        Eljg4T8z72WGsf4bd3wissM0KXp/s2SJWmRidUK6tMsmPwXD1H/AGc9YkPsxIDuRcqVieg5QtGsFL
        PvTnvKvg4dmttuLUjFS3ftFX0e24UXhgyEnJLYwSmSaveaRa90X+pIUkxR0wRTL603NwenIxJiUMX
        h58yyiIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMpKr-0005Bl-Mq; Mon, 28 Sep 2020 09:20:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08B6D302753;
        Mon, 28 Sep 2020 11:20:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DECDE203E73B9; Mon, 28 Sep 2020 11:20:39 +0200 (CEST)
Date:   Mon, 28 Sep 2020 11:20:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, laoar.shao@gmail.com,
        qais.yousef@arm.com, urezki@gmail.com, frederic@kernel.org
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200928092039.GB2628@hirez.programming.kicks-ass.net>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915115609.85106-5-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 07:56:09PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> Allow terminating the softirq processing loop without finishing the vectors.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/softirq.c | 113 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 91 insertions(+), 22 deletions(-)

This is still a ginormous patch for something that should be simple.

I've put my patches (and a bunch on top) in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/softirq

but got a fairly significant regression report from 0day on that, and
haven't had time/motivation to look at that.


