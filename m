Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691D6268EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgINPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:04:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:62881 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgINPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:00:32 -0400
IronPort-SDR: GGtOX74ZFIw6HtNgKTFZaF4BouXsgPv/GEV9u9jcnwtAjyXcaJ25uUELSBAH0NlsDGQZNGTlHn
 ap/ogBwUg9hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146828485"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="146828485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 08:00:22 -0700
IronPort-SDR: 5I/1XS9lPuEwhiKJ3KYJGPb4gAH5iq/inrLAxT5zfmbB9kBLlKxWOxwKaKmIADMlD4l1YfJfoV
 kr44ii1Z0P/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335308800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 08:00:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kHpxq-00Gcov-0u; Mon, 14 Sep 2020 18:00:18 +0300
Date:   Mon, 14 Sep 2020 18:00:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v1] kernel.h: Move oops_in_progress to printk.h
Message-ID: <20200914150018.GG3956970@smile.fi.intel.com>
References: <20200911170202.8565-1-andriy.shevchenko@linux.intel.com>
 <20200914084332.GC10658@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914084332.GC10658@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:43:32AM +0200, Petr Mladek wrote:
> On Fri 2020-09-11 20:02:02, Andy Shevchenko wrote:
> > The oops_in_progress is defined in printk.c, so it's logical
> > to move oops_in_progress to printk.h.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Yeah, it makes sense.
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> I am always a bit afraid of messing with these heavily used includes.
> Let's see if boots complain about some build failure.

Agree.

Just to clarify: I assumed, might be wrongly, that this will go via PRINTK
tree. If you have something else in mind, please tell, I will route it to
the corresponding maintainer(s).

-- 
With Best Regards,
Andy Shevchenko


