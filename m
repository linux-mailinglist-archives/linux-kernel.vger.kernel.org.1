Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB32ED753
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbhAGTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:16:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B75072343E;
        Thu,  7 Jan 2021 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610046920;
        bh=eVbf8+HJ1mj8sG5PUsuFmbQMq89wv8eiPNTQRTzGhQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=08Nytn/LI4ieeCIDrw+lZcGhcDdz7u3YZBv5pHx0ShKjFDcmENZQiFBg6xfx3p2hy
         0TVOdTb0hXWXzS3BpESvTzy6NqgTkUrMgLRiE34jGPfw5H9lXWk2z3cDJypG+yANzo
         uVYwjCZ17gsXn1dT3H2sruDGAs+gg6+hX+nIFXuQ=
Date:   Thu, 7 Jan 2021 20:16:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Message-ID: <X/deF3U+LK5YCQT3@kroah.com>
References: <20210107164400.17904-1-pmladek@suse.com>
 <20210107164400.17904-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107164400.17904-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:44:00PM +0100, Petr Mladek wrote:
> This reverts commit 757055ae8dedf5333af17b3b5b4b70ba9bc9da4e.
> 
> The commit caused that ttynull was used as the default console
> on many systems. It happened when there was no console configured
> on the command line and ttynull_init() was the first initcall
> calling register_console().
> 
> The commit fixed a historical problem that have been there for ages.
> The primary motivation was the commit 3cffa06aeef7ece30f6
> ("printk/console: Allow to disable console output by using console=""
> or console=null"). It provided a clean solution
> for a workaround that was widely used and worked only by chance.
> 
> This revert causes that the console="" or console=null command line
> options will again work only by chance. These options will cause that
> a particular console will be preferred and the default (tty) ones
> will not get enabled. There will be no console registered at
> all. As a result there won't be stdin, stdout, and stderr for
> the init process. But it worked exactly this way even before.
> 
> The proper solution has to fulfill many conditions:
> 
>   + Register ttynull only when explicitly required or as
>     the ultimate fallback.
> 
>   + ttynull must get associated with /dev/console but it must
>     not become preferred console when used as a fallback.
>     Especially, it must still be possible to replace it
>     by a better console later.
> 
> Such a change requires clean up of the register_console() code.
> Otherwise, it would be even harder to follow. Especially, the use
> of has_preferred_console and CON_CONSDEV flag is tricky. The clean
> up is risky. The ordering of consoles is not well defined. And
> any changes tend to break existing user settings.
> 
> Do the revert at the least risky solution for now.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Linus, can you take this directly, or is this going through some other
tree?

thanks,

greg k-h
