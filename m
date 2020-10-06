Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1476B284537
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 07:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJFFKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 01:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFFKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:10:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463FC208B6;
        Tue,  6 Oct 2020 05:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601961039;
        bh=/HDOxzvcqV0a4z88WirUH3PPk/2vQQlgIigWfWOmbPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQK4yJ22SCdJmASayNfvhV/p8wS7/Yoah29/TlwwasREpeboY7bwY3/M0NoLZDD1k
         0NGRdQjlOWrCwRlBeGpHoieRpT44mveX+hflcxzUEgLwEIDxdm0m4h7Vnmz9VHUD0t
         uSFA2jOY2SoMjvwsV6ge2k9gMVVu62vTeOtjYItE=
Date:   Tue, 6 Oct 2020 07:08:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006050820.GA274215@kroah.com>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 08:35:59PM -0700, Guenter Roeck wrote:
> On 10/5/20 7:59 PM, Sergey Senozhatsky wrote:
> > Cc-ing Guenter,
> > 
> > On (20/05/22 12:00), Petr Mladek wrote:
> >> On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
> >>> If uboot passes a blank string to console_setup then it results in a trashed memory.
> >>> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
> >>> is a blank parameter being passed to console_setup from uboot.
> >>> In case it detects that the console parameter is blank then
> >>> it doesn't setup the serial device and it gracefully exits.
> >>>
> >>> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> >>> ---
> >>>  V1:
> >>>     Fixed console_loglevel to default as per the review comments
> >>>
> >>>  kernel/printk/printk.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >>> index ad4606234545..e9ad730991e0 100644
> >>> --- a/kernel/printk/printk.c
> >>> +++ b/kernel/printk/printk.c
> >>> @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
> >>>  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> >>>  	char *s, *options, *brl_options = NULL;
> >>>  	int idx;
> >>> -
> >>> +	if (str[0] == 0) {
> >>> +		return 1;
> >>> +	}
> >>>  	if (_braille_console_setup(&str, &brl_options))
> >>>  		return 1;
> >>
> >> I have fixed formatting and pushed it into printk/linux.git,
> >> branch for-5.8.
> > 
> > Petr, this patch's causing regressions for us. We use blank console= boot
> > param to bypass dts. It appears that it'd be better to revert the change.
> > 
> 
> Not just to bypass dts, it was also possible to use console= to disable consoles
> passed as config option, as well as other default console options. A quick test
> confirms that this affects all platforms/architectures, not just Chromebooks.
> Prior to this patch, it was possible to disable a default console with an
> empty "console=" parameter. This is no longer possible. This means that
> this patch results in a substantial (and, as far as I can see, completely
> undiscussed) functionality change.
> 
> I don't understand why (yet), but the patch also causes regressions with
> seemingly unrelated functionality, specifically with dm-verity on at least
> one Chromebook platform. I filed crbug.com/1135157 to track the problem,
> and reverted the patch from all our stable releases immediately after
> the last round of stable release merges.
> 
> On a side note, I don't see the problem presumably fixed with this
> patch in any of my tests.

I have no problem reverting this in the stable trees, but are you going
to hit this issue in Linus's tree in the next release?

thanks,

greg k-h
