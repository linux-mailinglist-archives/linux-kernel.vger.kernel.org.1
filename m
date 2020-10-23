Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8C296D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462873AbgJWLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462851AbgJWLVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:21:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C047C0613CE;
        Fri, 23 Oct 2020 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VTzREImgBpc2Ef+UDWW8JBTMD/ctCUwWEOpMdvOHXqw=; b=X43iKc+ANUZlHkD3jHcDE7LMAK
        29HfAqHQgjl0jLBRr9wIcXH9+3KsrMlz4nCy7arZRXqQq44KQKMhNDsqeMTECzj08Q+ja+bcwdNnt
        qTOl8mBnORqZIr8XockcIMM6bVYKrbSsUqLDOa+0Fh3V6HTHT48nvlrALvvbPqftX9Lmq48cIcjTQ
        IXqmCUTHgzYzJCZ/h9SlHMFjQPNPdjD1GnFB4bcdmwJa/LoIEJmF13PLbzJ/w36xcRKfEKVb3Uu3t
        qhSxBMGaQdapFp1w77gTkgDkn1nevkPy7MKyTROSbrwjCfO12K96FQ4s4NujxN4z8J+aETAwzxVUC
        V8XjpX4Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVv8U-0006MT-Km; Fri, 23 Oct 2020 11:21:30 +0000
Date:   Fri, 23 Oct 2020 12:21:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201023112130.GA23790@infradead.org>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (!IS_ENABLED(CONFIG_SMP) ||
> +	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
>  	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))

This needs a big fat comment explaining your rationale.  And probably
a separate if statement to make it obvious as well.
