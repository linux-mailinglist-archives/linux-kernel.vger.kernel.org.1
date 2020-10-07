Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3875D285987
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgJGH24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:28:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbgJGH24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:28:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602055734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tgNdkoIql/aHv1CAWmmBdC3fKzgtAi5ow9FlHidozE=;
        b=J42+yA/N6vGRJDjEcBLH4SvL0rlLOpWDStub0hxTsiSEAadDsKH8Dorlop6iV0c9zLs1g5
        zLox6oHb9JUzx8G2g5rE4aJuvY7bPWjSLncUnqRkAHWpPStIOAt9XNfrPLObWweozcUq0D
        LUHA6whsmLm18sb+LsL58+dG1aRyr5Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61472AC2F;
        Wed,  7 Oct 2020 07:28:54 +0000 (UTC)
Date:   Wed, 7 Oct 2020 09:28:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201007072853.GF32369@alley>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006171504.GA64770@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-10-07 02:15:04, Sergey Senozhatsky wrote:
> On (20/10/06 18:35), Petr Mladek wrote:
> > > > Whatever is decided, I'd like to have it made official and documented to
> > > > avoid a similar problem in the future.
> > 
> > Sigh, it is even bigger mess than I expected. There is a magic
> > variable "console_set_on_cmdline". It used, for example, in
> > of_console_check() to prevent using the default console from dts.
> 
> I wonder if we can do something like:
> 
> ---
> @@ -2200,6 +2200,9 @@ static int __init console_setup(char *str)
>         char *s, *options, *brl_options = NULL;
>         int idx;
>  
>         if (str[0] == 0) {
> +		console_set_on_cmdline = 1;

Unfortunately, this is not enough. We will also need to prevent
enabling the fallback console when has_preferred_console is not set.
The following might work:

		/*
		 * Dirty hack to prevent using any console with tty
		 * binding as a fallback and adding the empty
		 * name into console_cmdline array.
		 */
		preferred_console = MAX_CMDLINECONSOLES;

>                 return 1;
>  	}

It might be the minimal change that would fix the regression and keep
the original fix. But it would make the code even more hairy.

It might be acceptable as a hotfix. But we really should somehow clean
up the code and try to make the behavior more consistent.

Best Regards,
Petr
