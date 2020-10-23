Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC337296C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461677AbgJWJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:46:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461670AbgJWJqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603446374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTM/+P4KRWrBjgo7uNy72xB7J3AIXl7gcRb4zVxC7og=;
        b=j/V5xQTUvBfmvAZAgahqEJecnxGoI7WUntBbUzIioH2u+E3cuQqd4E8i0ExLIVb+ipMasA
        UQRu+1l1DITKij0vK506075LDp4L1e0oHJuLDYwH8R0bazLOX/UVK+Ulv7VuSaCidP+4Z2
        sVqnyQCwTmRpVdfDMnQklUY++GmBTFk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D304AFF2;
        Fri, 23 Oct 2020 09:46:14 +0000 (UTC)
Date:   Fri, 23 Oct 2020 11:46:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
Message-ID: <20201023094613.GD32486@alley>
References: <20201022114228.9098-1-pmladek@suse.com>
 <20201022114228.9098-2-pmladek@suse.com>
 <20201022094512.37c9bf5d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022094512.37c9bf5d@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-22 09:45:12, Steven Rostedt wrote:
> On Thu, 22 Oct 2020 13:42:27 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index fe64a49344bf..63fb96630767 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1207,6 +1207,19 @@ void __init setup_log_buf(int early)
> >  	memblock_free(__pa(new_log_buf), new_log_buf_len);
> >  }
> >  
> > +static bool mute_console;
> > +
> > +static int __init mute_console_setup(char *str)
> > +{
> > +	mute_console = true;
> > +	pr_info("All consoles muted.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("mute_console", mute_console_setup);
> > +module_param(mute_console, bool, 0644);
> > +
> 
> Why have both early_param and module_param? What's the purpose of
> module_param? Usually that's there to just set a variable, without a need
> for another interface. But if you have early_param() that sets
> mute_console, isn't that redundant?

I was surprised as well. But both seem to be needed:

   + early_param allows to enable it on the command line.
     Note that module_param would need to be set via
     printk.mute_console

   + module_param() allows to modify the state at runtime

IMHO, both should be possible. It is supposed to be used similar
way like ignore_loglevel.

Best Regards,
Petr
