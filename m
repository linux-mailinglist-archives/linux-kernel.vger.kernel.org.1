Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D9295D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897379AbgJVLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:38:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897372AbgJVLiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:38:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603366686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pV9zZjS0Im2RddjJnNHoMXX7Dj5mJr2Ovyhf1Xa2aOY=;
        b=d9CzVFfdqEEYZML/AX+ye/WomeqdjGoplxko7pSp3OADCEnlV5Tfwkt+iZARLrPY5mmKsi
        uL0LokZt41s8yaevhd1oSjYqpjwC3sDN8R+sgH8CAceSiCs3I2vgrTMks9K+zuh5vCti7p
        0IJqDIr3JXb+bf2k6IQph+QTtBOPe6A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60A7CABBE;
        Thu, 22 Oct 2020 11:38:06 +0000 (UTC)
Date:   Thu, 22 Oct 2020 13:38:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201022113805.GA32486@alley>
References: <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
 <20201007162942.GA440@jagdpanzerIV.localdomain>
 <20201008055238.GA554@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008055238.GA554@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-08 14:52:38, Sergey Senozhatsky wrote:
> On (20/10/08 01:29), Sergey Senozhatsky wrote:
> > On (20/10/07 08:57), Guenter Roeck wrote:
> > > On 10/7/20 5:30 AM, Sergey Senozhatsky wrote:
> > 
> > [..]
> > 
> > > I can see to options: Link /dev/console to /dev/null if there is no console,
> > > or do something like
> > > 
> > > 	if (IS_ERR(file)) {
> > >                 pr_warn("Warning: unable to open an initial console.\n");
> > >                 file = filp_open("/dev/null", O_RDWR, 0);
> > > 		if (IS_ERR(file))
> > >                 	return;
> > >         }
> > 
> > As far as I can tell, /dev/null does not exist yet on this stage
> > (at least not in my system). But generally the idea looks interesting.
> 
> Hmm. How about this. console= is undocumented and unspecified - it
> may work sometimes or it may kill the system (and theoretically even
> corrupt some files, depending on what fd 1 and fd 2 point to). So
> maybe we can document console= and handle it in printk, rather than
> somewhere deep in init/main.c

I have dig more into it. If I get it correctly, /dev/console is really
used as stdin, stdout, and stderr for the init process. It has been
like this from the very beginning.

In theory, it might be possible to fallback into /dev/null. But it
would not solve the problem when anyone tries to use /dev/console
later.

IMHO, creating /dev/console really _should not_ fail. It means
that we should register some console.


> IOW add one more flag (yeah, I know) and set it when console_setup()
> sees console= boot param. The idea is allow console registration,
> but all consoles should be disabled (cleared CON_ENABLED bit). This
> would be easier to document, at least.

It seems that introducing a new option/flag is the best solution
after all. All other flags are manipulated on different situations
and it would not be easy to define a sane behavior.

I like the proposed "mute_consoles". Well, I have it associated rather
with CONSOLE_LOGLEVEL_SILENT than with disabled console.

I have played with it and am going to send two patches as RFC.

Best Regards,
Petr
