Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9C26FC48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIRMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgIRMNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600431223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/aXhqWiIrrJX5NNhaAEYok++HqGAIDlzevY0FDzWn0=;
        b=YQ6X4KEbT5IFK6oEPNIcqG9nYm38yc4TyGjl+D1SfHpZ1VCmLeAyOVEhqC2vanA9hk8IBY
        Umgkdrh7T9+nrSgUF8ll6AiN7lpLO//3A+VRxBSPnyQItZhg0kmoeZ+OzS2cnnb5N0pnY+
        6lJhEcZZHxV4SUipyItL/YPl/+MH6ZY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AEF5AC2F;
        Fri, 18 Sep 2020 12:14:17 +0000 (UTC)
Date:   Fri, 18 Sep 2020 14:13:42 +0200
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
Message-ID: <20200918121342.GD14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
 <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-18 08:16:37, Rasmus Villemoes wrote:
> On 17/09/2020 15.16, John Ogness wrote:
> 
> >  	if (dev->class)
> >  		subsys = dev->class->name;
> >  	else if (dev->bus)
> >  		subsys = dev->bus->name;
> >  	else
> > -		return 0;
> > +		return;
> >  
> > -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
> > -	if (pos >= hdrlen)
> > -		goto overflow;
> > +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
> 
> It's unlikely that subsys would contain a %, but this will be yet
> another place to spend brain cycles ignoring if doing static analysis.
> So can we not do this. Either of strXcpy() for X=s,l will do the same
> thing, and likely faster.

Good point! Better be on the safe size in a generic printk() API.

Well, I am afraid that this would be only small drop in a huge lake.
class->name and bus->name seems to be passed to %s in so many
*print*() calls all over the kernel code.

IMHO, this is not the right place to prevent the problem. Dangerous
names must be prevented when a new bus, class, device is added.

Best Rergards,
Petr
