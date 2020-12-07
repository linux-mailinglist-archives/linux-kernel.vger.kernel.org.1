Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC02D1129
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLGM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:56:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A82C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YSUGplj7HrXl3d4m+FRlG+q1bwrz6RtuXMVuVA83zX0=; b=sJTwpfjFu/XeZCXuuKMRvg6WKa
        vOZcrdYm/QO59AkATkF12knuCPWcpX8e0NVmO7wvofmFywTSEyfDfp/BR9CtveMEAseHAegvQeOuk
        Zm2D72ng64AhHfdj2YYLrKAll5yfby/1sNbblgKQMsBh/HKGAxQkvBiDroVd5HRAqCo4QCpNdtZCo
        GJud4mNNOyHvOt0PUaBv6VSY8OnonwjsBj+VzQGAHxOYVzuWwu2xshFh4UY+kKjCBfC7e0O2Rmxb/
        p0Ewfvb1rgFPSngfA+KtQFDDO/twB88H7KTvawenP6m2nPwGe1iyGzA0AAUO6WIgPAWrHgQIDKVtJ
        C3WZbZtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmG3i-0004pU-Gv; Mon, 07 Dec 2020 12:56:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D852D301478;
        Mon,  7 Dec 2020 13:56:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2ED7200AAFCA; Mon,  7 Dec 2020 13:56:05 +0100 (CET)
Date:   Mon, 7 Dec 2020 13:56:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201207125605.GN3040@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <875z5eof8g.fsf@jogness.linutronix.de>
 <20201207093419.GH3040@hirez.programming.kicks-ass.net>
 <87mtyq9blw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtyq9blw.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:09:39AM +0106, John Ogness wrote:
> That will not work. We are talking about a situation where the writer is
> preempted. So seq will never equal seq_copy in that situation. I expect
> that the seqcount_latch is necessary.

Interrupted rather, I would think, specifically NMIs? Then yes, latch
should work. Gets you either the old or new, but never something in
between.
