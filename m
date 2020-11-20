Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78C2BABCA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgKTOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:24:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgKTOYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:24:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605882278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBNRtXPgIFrwBxBRZV+yOpZA9Rsx/wRrIx/DAGNkojI=;
        b=jKRUwi/pVrbuG0IzqKtCNs15kXkRGA3ebX5i3HZ8hH7rg45Brn1BjpgisDbA9mSHON0kWL
        MJpBS4Ghj74nrz9jSXXJU+NXJg9QJoQ13PXpn+juVJHHEzlZDqRA0xwOird+M25rDkKn5V
        DcwNIyiRWcIHd+yDI9jaem/TLNAp4zo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 732B5AE93;
        Fri, 20 Nov 2020 14:24:38 +0000 (UTC)
Date:   Fri, 20 Nov 2020 15:24:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk/console: Use ttynull when no console is
 available or wanted
Message-ID: <X7fRpVezPnh2uCVc@alley>
References: <20201111135450.11214-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-11-11 14:54:48, Petr Mladek wrote:
> This is another attempt to solve regression caused by the commit
> 48021f98130880dd74 ("printk: handle blank console arguments passed in.").
> 
> It prevented a crash caused by empty console= parameter. But it caused
> performance problems on Chromebooks because they use it to disable
> all consoles, see
> see https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain
> 
> Solve both problems by using ttynull console driver that was crated
> exactly for this purpose.
> 
> The 1st patch should prevent the crash for any invalid console name.
> 
> The 2nd patch allows to used the ttynull driver also with the widely
> used console= and console=null parameters.
> 
> Best Regards,
> Petr
> 
> Petr Mladek (2):
>   init/console: Use ttynull as a fallback when there is no console
>   printk/console: Allow to disable console output by using console="" or
>     console=null

The patchset has been committed into printk/linux.git, branch
for-5.11-null-console.

Best Regards,
Petr
