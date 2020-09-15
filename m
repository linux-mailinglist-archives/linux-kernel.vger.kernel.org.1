Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4426A5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIONKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:10:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:56218 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgIONFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:05:37 -0400
IronPort-SDR: dZQABgKJ/C8R2YLNGSsSvYMDussJ6XIOngtrb826NEJpluDad3baWAlGw5Khym3FnIvg/pGskA
 4VDms9bUlQ+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159298833"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="159298833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:05:27 -0700
IronPort-SDR: lRC2xYXFydM/bfh6DqlgWCMi9D69VMUa+KkRyE8RLrx5pe9gaUqx9W2ZtmR6i01xftfMqs4wqB
 XNrFbbiGh89g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="335641013"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2020 06:05:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIATd-00GqF6-7Y; Tue, 15 Sep 2020 15:54:29 +0300
Date:   Tue, 15 Sep 2020 15:54:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v1] kernel.h: Move oops_in_progress to printk.h
Message-ID: <20200915125429.GV3956970@smile.fi.intel.com>
References: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
 <20200914084332.GC10658@alley>
 <20200914150018.GG3956970@smile.fi.intel.com>
 <20200915122125.GG11154@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915122125.GG11154@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:21:25PM +0200, Petr Mladek wrote:
> On Mon 2020-09-14 18:00:18, Andy Shevchenko wrote:
> > On Mon, Sep 14, 2020 at 10:43:32AM +0200, Petr Mladek wrote:
> > > On Fri 2020-09-11 20:02:02, Andy Shevchenko wrote:
> > > > The oops_in_progress is defined in printk.c, so it's logical
> > > > to move oops_in_progress to printk.h.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Yeah, it makes sense.
> > > 
> > > Acked-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > I am always a bit afraid of messing with these heavily used includes.
> > > Let's see if boots complain about some build failure.
> > 
> > Agree.
> > 
> > Just to clarify: I assumed, might be wrongly, that this will go via PRINTK
> > tree. If you have something else in mind, please tell, I will route it to
> > the corresponding maintainer(s).
> 
> I have just pushed the patch into printk/linux.git, branch for-5.10.
> 
> I am sorry that I was not clear enough. I wanted to wait at least one
> day just in case anyone (human or robot) complains.

Thank you, Petr, for clarification and applying it!

-- 
With Best Regards,
Andy Shevchenko


