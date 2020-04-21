Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9E1B271F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgDUNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 09:07:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:43845 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:07:07 -0400
IronPort-SDR: 2twUAlpQJI1tm0a5GnYzRziT5RSA5vxgKSaLk1TujSC0zTeI2EQ15ucPZ83/swjgGjWKYoYOwA
 QkSpukuw2ojA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 06:07:03 -0700
IronPort-SDR: zFkVyC6mhHM0WZz4UZ6Z21PYYWCWic5iCbW1pt7UsKjoBAVw7Usu3KxbuW4uCum52yPBZ4MY1e
 /3TQ405MYqrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="279631889"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2020 06:07:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQscB-002F84-V1; Tue, 21 Apr 2020 16:07:03 +0300
Date:   Tue, 21 Apr 2020 16:07:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Message-ID: <20200421130703.GL185537@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415132011.624f35f6@gandalf.local.home>
 <20200416023425.GB30641@jagdpanzerIV.localdomain>
 <c8c8f37f20625922eb114574c544ebb6332ac025.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c8f37f20625922eb114574c544ebb6332ac025.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 07:46:27PM -0700, Joe Perches wrote:
> On Thu, 2020-04-16 at 11:34 +0900, Sergey Senozhatsky wrote:
> > On (20/04/15 13:20), Steven Rostedt wrote:
> > > On Wed, 15 Apr 2020 20:00:43 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > > > We have few users of time64_t that would like to print it.
> > > > 
> > > > Andrew, since Petr can't pay attention on this perhaps it can be passed thru
> > > > your tree?
> > > > 
> > > > Sergey, Steven, what do you think?
> > > 
> > > I'm fine with these changes. Sergey, what do you think?
> > 
> > I'm not against it in general, I'm slightly concerned if "two users"
> > is enough of a justification for new vsprintf() specifier.
> 
> Me too as separate functions could be used here.

If we drop T in favour of ' ' (space) as delimiter, we will immediately get 5
or 6 users (I didn't check for new ones during last couple of years though).

-- 
With Best Regards,
Andy Shevchenko


