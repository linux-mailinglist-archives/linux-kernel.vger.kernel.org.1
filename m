Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16C0296DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463212AbgJWLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:50:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463205AbgJWLuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603453799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9AfaYkVLSY802vzN1LJgcu333YmY7HCYO1P84FAMi/c=;
        b=VhPvxGOCKGQS4yA7Fk0Kl6fSkFlLXWwjBdCv2Y1vyqBjIFLtQrXRJZueUokKs2ZZ9mkwQD
        msftKzV9SVTHY0X4ubAGAOvLyGd/s0SriHHK5gLceSyz11jm4bRZw/0O0HMqRyTuRnBOpq
        Vy3+v4ISg/urQrV6dHVSXmf8zgRqrBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A121ACBF;
        Fri, 23 Oct 2020 11:49:59 +0000 (UTC)
Date:   Fri, 23 Oct 2020 13:49:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
Message-ID: <20201023114958.GE32486@alley>
References: <20201022114228.9098-1-pmladek@suse.com>
 <20201022114228.9098-2-pmladek@suse.com>
 <87a6wez9s4.fsf@jogness.linutronix.de>
 <5a30b3e8-c2c3-ceae-517e-c93fb2c3118f@roeck-us.net>
 <877driz50k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877driz50k.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-22 16:59:15, John Ogness wrote:
> On 2020-10-22, Guenter Roeck <linux@roeck-us.net> wrote:
> > The whole point of the exercise is to disable all consoles, including
> > default ones which are not explicitly specified on the command line.
> 
> In that case I think specifying something like:
> 
>     console=null
> 
> makes that most sense. I think implementing a "null console" driver
> would be quite simple. Then there would be no need for special handling
> in the printk subsystem.

Heh, it actually already exists and has been created for exactly this
purpose, see the commit 3117ff13f104e98b05b6 ("tty: Add NULL TTY
driver").

Regarding the interface:

   + console=null or console= is OK when people do not want consoles
     at all

   + mute_console (or another extra parameter) would be needed if
     people wanted to have login console.

It is true that nobody asked for the login support. So, the null
console should be enough for now.

Best Regards,
Petr
