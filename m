Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D314529BAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807607AbgJ0QMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:10 -0400
Received: from casper.infradead.org ([90.155.50.34]:47024 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1806748AbgJ0QHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HA4ZHwr5t1Huss17kvkjWkUe8BF7x7y1mhBWMJ9fwWk=; b=oSa7/SiGcBhIb/pUG0Zhal2LtO
        H3knAhBbJ0uy/aKRI5bjq/YlQqpr2fNV1hRzc3Pnb4wuDyVCqq4KuAYDKbMPw9fmoqeJrqh8zV/Xg
        mtW1ya/9yI3/+fS8AAHNpa2QYZeWr5why/1VC1z35ZISToTvwLYVky4Vp1FJ/D9B7BWBWaARJIXHt
        KtQRxk6A13AWWKm3h16MGKQwzUzQohKv8ePfbKUy3HaL1uiQ0RaKIugZCPUJUTmnEPIkKHH2c2q/I
        oBvqJiQZFYYQ9J974WOQa+UW7oLDUz1q12e9n0kd5SDeNRznDw/h9EztE+lcM1rEsOxIBblTXUDkr
        y/5BcaMg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXRVe-0005NX-9w; Tue, 27 Oct 2020 16:07:42 +0000
Date:   Tue, 27 Oct 2020 16:07:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027160742.GA19073@infradead.org>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:11:02AM +0100, Sebastian Andrzej Siewior wrote:
> Right. I found this David Runge's log:

True, ->bi_end_io instances can do a lot of things as long as they
are hardirq safe.

And in the end the IPI case isn't the super fast path anyway, as it
means we don't use a queue per CPU.

Is there a way to raise a softirq and preferably place it on a given
CPU without our IPI dance?  That should be a win-win situation for
everyone.
