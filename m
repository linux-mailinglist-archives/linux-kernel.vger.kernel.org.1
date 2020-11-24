Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC72C1C35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKXDqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgKXDqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:46:11 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B3A2085B;
        Tue, 24 Nov 2020 03:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606189571;
        bh=yuqRzy1VmelFImNgWCLaiwsWkHqzEvPvSQTi27MsTiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qv46hzPAcal0e7zPAjzGH4dOxtGJiLOlyXIJJGosS1LhVAJSRE0CEkVIDZoaABOMV
         j8DEgavWkYG6DOYZHZr0WtQSHrZ/qGIrWiA32+LawOfZfQdFqGmEzf+shKB0mgRq0Z
         qev6kzG4/cnUnGREXNHU1viuD27VDmk9ONliCye8=
Date:   Mon, 23 Nov 2020 19:46:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] ide/Falcon: Remove in_interrupt() usage.
Message-Id: <20201123194610.df0431a228d5f6fe2d1e7719@linux-foundation.org>
In-Reply-To: <20201121124424.oyr74bwxvwmvxln2@linutronix.de>
References: <20201120092421.1023428-1-bigeasy@linutronix.de>
        <20201120092421.1023428-2-bigeasy@linutronix.de>
        <20201120143535.fa533caeb5486f8c3abd605a@linux-foundation.org>
        <20201121124424.oyr74bwxvwmvxln2@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 13:44:24 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-11-20 14:35:35 [-0800], Andrew Morton wrote:
> > On Fri, 20 Nov 2020 10:24:20 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > falconide_get_lock() is called by ide_lock_host() and its caller
> > > (ide_issue_rq()) has already a might_sleep() check.
> > > 
> > > stdma_lock() has wait_event() which also has a might_sleep() check.
> > > 
> > > Remove the in_interrupt() check.
> > > 
> > > ...
> > >
> > > --- a/drivers/ide/falconide.c
> > > +++ b/drivers/ide/falconide.c
> > > @@ -51,8 +51,6 @@ static void falconide_release_lock(void)
> > >  static void falconide_get_lock(irq_handler_t handler, void *data)
> > >  {
> > >  	if (falconide_intr_lock == 0) {
> > > -		if (in_interrupt() > 0)
> > > -			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
> > >  		stdma_lock(handler, data);
> > >  		falconide_intr_lock = 1;
> > >  	}
> > 
> > The current mainline falconide_get_lock() is very different:
> 
> I have this patch on-top of next-20201120 so it should apply. You
> realize that the above hunk is against falconide_get_lock() while
> the below is falconide_release_lock().
> If there is something wrong with the patch (or its commit message) I'm
> sorry but I don't understand your signal :)
> 

oops, sorry, the MIME-encoded email messed me up, then I went and
confused myself.  Got it now, thanks ;)

