Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B12ED5FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbhAGRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:47:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:53102 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGRr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:47:27 -0500
IronPort-SDR: rYwECGs3wX7dkg6Usi0/QnLZeWbeozH5uikpMeWiUGoZdj718wySGLi5Hq+ywQmOrazp8d44sa
 DgWx7VLjt1tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="164535496"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="164535496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:45:39 -0800
IronPort-SDR: ZcrPIhtEdY5p2Oa7/7GfEhGWJ2eNA+sB1RalhfQ6IWja9h5VvV91BcXFyTymJXxCSMK+YryGeR
 T1IFXZtJvJYw==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="396032066"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:45:36 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kxZMs-0050uv-6C; Thu, 07 Jan 2021 19:46:38 +0200
Date:   Thu, 7 Jan 2021 19:46:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when
 there is no console"
Message-ID: <20210107174638.GH4077@smile.fi.intel.com>
References: <20210107164400.17904-1-pmladek@suse.com>
 <20210107164400.17904-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107164400.17904-2-pmladek@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

Shouldn't it have Fixes tag along with Reported-by ones and explanation what
was the actual problem reported?

-- 
With Best Regards,
Andy Shevchenko


