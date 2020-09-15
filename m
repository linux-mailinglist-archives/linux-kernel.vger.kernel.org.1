Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351CD26A50C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIOMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIOMV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26AD1B032;
        Tue, 15 Sep 2020 12:21:42 +0000 (UTC)
Date:   Tue, 15 Sep 2020 14:21:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v1] kernel.h: Move oops_in_progress to printk.h
Message-ID: <20200915122125.GG11154@alley>
References: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
 <20200914084332.GC10658@alley>
 <20200914150018.GG3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914150018.GG3956970@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-14 18:00:18, Andy Shevchenko wrote:
> On Mon, Sep 14, 2020 at 10:43:32AM +0200, Petr Mladek wrote:
> > On Fri 2020-09-11 20:02:02, Andy Shevchenko wrote:
> > > The oops_in_progress is defined in printk.c, so it's logical
> > > to move oops_in_progress to printk.h.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Yeah, it makes sense.
> > 
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > 
> > I am always a bit afraid of messing with these heavily used includes.
> > Let's see if boots complain about some build failure.
> 
> Agree.
> 
> Just to clarify: I assumed, might be wrongly, that this will go via PRINTK
> tree. If you have something else in mind, please tell, I will route it to
> the corresponding maintainer(s).

I have just pushed the patch into printk/linux.git, branch for-5.10.

I am sorry that I was not clear enough. I wanted to wait at least one
day just in case anyone (human or robot) complains.

Best Regards,
Petr
