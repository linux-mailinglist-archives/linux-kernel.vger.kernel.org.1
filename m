Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C62849B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJFJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:52:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJFJw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:52:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601977948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulSDWXMr10E+uJPSQdJ8cKG+Cd7wmtT+2X/m5iX0aAU=;
        b=ikiY38WS/RPv+s96r6L/3Tsq8KSOAEGIOtfbM6PSVu7LNRaEOEM1bV46q8GR24gURXKaVd
        smhZ6NQOZycL8zEEWFiCy7AZaSHaoUr3ZLHL1Go0y1CI8yxBMBHt1X1nqGnSbtSN2LHh5y
        13F4ppPol58ohTd+N167oy+89m77SuE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D803FB204;
        Tue,  6 Oct 2020 09:52:27 +0000 (UTC)
Date:   Tue, 6 Oct 2020 11:52:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006095226.GB32369@alley>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-10-05 20:35:59, Guenter Roeck wrote:
> On 10/5/20 7:59 PM, Sergey Senozhatsky wrote:
> > On (20/05/22 12:00), Petr Mladek wrote:
> >> On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
> >>> If uboot passes a blank string to console_setup then it results in a trashed memory.
> >>> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
> >>> is a blank parameter being passed to console_setup from uboot.
> >>> In case it detects that the console parameter is blank then
> >>> it doesn't setup the serial device and it gracefully exits.
> >>>
> > Petr, this patch's causing regressions for us. We use blank console= boot
> > param to bypass dts. It appears that it'd be better to revert the change.
> > 
> Not just to bypass dts, it was also possible to use console= to disable consoles
> passed as config option, as well as other default console options. A quick test
> confirms that this affects all platforms/architectures, not just Chromebooks.
> Prior to this patch, it was possible to disable a default console with an
> empty "console=" parameter. This is no longer possible. This means that
> this patch results in a substantial (and, as far as I can see, completely
> undiscussed) functionality change.

Where is this behavior documented, please?

I do not see it anywhere (documentation, git log, google) and it is far from
obvious from the code. It seems that any random string would do the
same job, e.g. console=none.

Of course, we need to restore the original behavior when it breaks
existing systems. But I want to be sure that there is no better
solution.

And it makes perfect sense to disable all consoles or drop all defined
by dts. But I would prefer to make it more obvious way, for
example by parameters like:

   + console=none
   + no-console
   + no-dtd-console
   + no-default-console


JFYI, the console= parameter handling is a real historical mess. We are
always surprised what undefined behavior people depend on. For
example, see:

  + commit 33225d7b0ac9903c5701b ("printk: Correctly set CON_CONSDEV
    even when preferred console was not registered")

  + commit e369d8227fd211be3624 ("printk: Fix preferred console
    selection with multiple matches")

> I don't understand why (yet), but the patch also causes regressions with
> seemingly unrelated functionality, specifically with dm-verity on at least
> one Chromebook platform. I filed crbug.com/1135157 to track the problem,
> and reverted the patch from all our stable releases immediately after
> the last round of stable release merges.
> 
> On a side note, I don't see the problem presumably fixed with this
> patch in any of my tests.

Console drivers might provide a custom match() callback to handle
various aliases. I guess that some driver wrongly matches the empty
string stored in the array of preferred consoles.

There are likely other ways to fix the original problem.

Best Regards,
Petr
