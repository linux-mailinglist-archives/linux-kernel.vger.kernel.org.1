Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498412EF6C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbhAHRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:47478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAHRp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610127912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gy94qC4XCy03Semo26HM+yaE2VFSVwCyprGmcwkRvVI=;
        b=SPX3VXdgQ5pSeM9Dz6Ec/vHWeJjC3dP4d0sVp8nu0MJm+2as3EwPdUev55dvdtfpEBQquP
        HbearfZGYHeraCtHzqAjnbFypmEHLCIFrKJqPnjRwuUd+i6NfyE2WYf1oqFDNw5CWUfipq
        fs7R+iICh2OP3oV7YRAKUTfb8HfxUSA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73105AD1E;
        Fri,  8 Jan 2021 17:45:12 +0000 (UTC)
Date:   Fri, 8 Jan 2021 18:45:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Message-ID: <X/iaJw1JKRRGcoX9@alley>
References: <20210107164400.17904-1-pmladek@suse.com>
 <20210107164400.17904-2-pmladek@suse.com>
 <X/deF3U+LK5YCQT3@kroah.com>
 <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSz8tS=QqvnMDk4qHe5t5FS-Nk-SQMPAHJo5SJYp_t6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-07 11:38:36, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 11:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Linus, can you take this directly, or is this going through some other
> > tree?
> 
> I was _assuming_ that I'd get it through the normal printk pull
> request, it doesn't seem to be that timing-critical.
> 
> But if there is nothing else pending, I can certainly take it directly
> as that patch too.

This is the only printk-related fix at the moment.

I have just pushed v2 (updated commit message, tags) into
printk/linux.git for linux-next. It is the patch sent as
https://lore.kernel.org/lkml/20210108114847.23469-1-pmladek@suse.com/

Feel free to push v2 directly. Or I will create pull request the
following week after it spends few days in linux-next.

Best Regards,
Petr
