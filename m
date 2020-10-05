Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5088A2834C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgJELRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:17:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJELRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:17:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601896619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Na9ImoXVtQeG9O/r9eFCcjjqKb6xyBpj5IaWgFawJo=;
        b=kQR4NnPBfzUjc1yFP92NN96Xbky5GQ1P/8Zg7f5v6lIEWZ4u7pacNlAirJTftA5GNmJ0eI
        a0yvI9zFa0momTTnvxdedEb+lRtgc3PgJYFj6nk+YH5kzKMa+19/SD55VpvXofyGkAiepj
        Jzd96O/fvhutrBg2e/b3kz7ufrH8khQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D1D7AC8B;
        Mon,  5 Oct 2020 11:16:59 +0000 (UTC)
Date:   Mon, 5 Oct 2020 13:16:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
Message-ID: <20201005111658.GD3673@alley>
References: <20200926040426.11936-1-hdanton@sina.com>
 <20201001095151.5640-1-hdanton@sina.com>
 <20201002023412.2276-1-hdanton@sina.com>
 <20201004021213.14572-1-hdanton@sina.com>
 <20201005083829.GA3673@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005083829.GA3673@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-10-05 10:38:29, Petr Mladek wrote:
> On Sun 2020-10-04 10:12:13, Hillf Danton wrote:
> > On Fri, 02 Oct 2020 10:32:32 Thomas Gleixner wrote:
> > > So having a consistent behaviour accross all these facilities makes
> > > absolutely sense and I don't agree with your sentiment in the changelog
> > > at all.
> > > 
> > > Just because it does not make sense to you is not a justification for
> > > making stuff inconsistent. You still have not provided a technical
> > > reason why this change is needed.
> > 
> > Given the queue method, it is no win to modify delayed work from callback
> > in any case because "we are not adding interfaces just because we can."
> 
> What about ipmi_kthread_worker_func()? It is delayed work that
> queues itself.

The function name is actually mv88e6xxx_irq_poll() in upstream.

The wrong name came from a patch when I worked on the API and
tried to switch some kthreads to it.

Best Regards,
Petr
