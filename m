Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04926FFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIROYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:24:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIROYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:24:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600439091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhTTG3AAgrCpwmciInJaUJL+OcbiXHiDYJ/Fm1dkKoI=;
        b=DvWFXDWLV4VPEdcu0TOFnLUeO8eYuWPT7mjavXlRAQhJFko7NnR0XfEzT3rXnAkrXZP3P9
        ErFOJ75tFuOD0S27Aft4wKW885ROW8po1xK4h0sJN/Swnu0U88CcW0Q5llpc6MFEApXwWa
        uoJ1Qi8bVnUdsoTjA01KLjd94JL2z7Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 945F1AB91;
        Fri, 18 Sep 2020 14:25:25 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:24:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to
 dev_printk_info
Message-ID: <20200918142450.GE14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
 <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
 <20200918121342.GD14605@alley>
 <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-18 14:32:41, Rasmus Villemoes wrote:
> On 18/09/2020 14.13, Petr Mladek wrote:
> > On Fri 2020-09-18 08:16:37, Rasmus Villemoes wrote:
> >> On 17/09/2020 15.16, John Ogness wrote:
> >>
> >>>  	if (dev->class)
> >>>  		subsys = dev->class->name;
> >>>  	else if (dev->bus)
> >>>  		subsys = dev->bus->name;
> >>>  	else
> >>> -		return 0;
> >>> +		return;
> >>>  
> >>> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
> >>> -	if (pos >= hdrlen)
> >>> -		goto overflow;
> >>> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
> >>
> >> It's unlikely that subsys would contain a %, but this will be yet
> >> another place to spend brain cycles ignoring if doing static analysis.
> >> So can we not do this. Either of strXcpy() for X=s,l will do the same
> >> thing, and likely faster.
> > 
> > Good point! Better be on the safe size in a generic printk() API.
> > 
> > Well, I am afraid that this would be only small drop in a huge lake.
> > class->name and bus->name seems to be passed to %s in so many
> > *print*() calls all over the kernel code.
> 
> So what? printf("%s", some_string_that_might_contain_percent_chars) is
> not a problem.

Grr, shame on me. I have completely messed this. The combination of
Friday afternoon and noisy kids did not help me much to get it right.

> printf(some_string_that_might_contain_percent_chars) is.

I fully agree that passing unknown string as "fmt" is dangerous and
must be used carefully. It is not needed here.

> And yes, one could do
> 
>   snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), "%s", subsys);
>
> but one might as well avoid the snprintf overhead and use one of the
> strX functions that have the exact same semantics (copy as much as
> there's room for, ensure nul-termination).

Yes, we should use either snprinf() with %s or strXcpy().

Best Regards,
Petr
