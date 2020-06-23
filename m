Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4021A205147
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgFWLu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgFWLuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:50:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8372EAFB1;
        Tue, 23 Jun 2020 11:50:52 +0000 (UTC)
Date:   Tue, 23 Jun 2020 13:50:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: remove unnecessary ioc nested locking
Message-ID: <20200623115052.comb37q22kjgzyen@beryllium.lan>
References: <20200619151718.22338-1-john.ogness@linutronix.de>
 <20200619151718.22338-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619151718.22338-2-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:23:17PM +0206, John Ogness wrote:
> The legacy CFQ IO scheduler could call put_io_context() in its exit_icq()
> elevator callback. This led to a lockdep warning, which was fixed in
> commit d8c66c5d5924 ("block: fix lockdep warning on io_context release
> put_io_context()") by using a nested subclass for the ioc spinlock.
> However, with commit f382fb0bcef4 ("block: remove legacy IO schedulers")
> the CFQ IO scheduler no longer exists.
> 
> The BFQ IO scheduler also implements the exit_icq() elevator callback but
> does not call put_io_context().
> 
> The nested subclass for the ioc spinlock is no longer needed. Since it
> existed as an exception and no longer applies, remove the nested subclass
> usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

As far I can tell, looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
