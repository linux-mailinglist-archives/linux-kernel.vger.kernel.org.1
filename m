Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EB20A02A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405209AbgFYNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:41:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:55780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404923AbgFYNla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:41:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 949F1AEF7;
        Thu, 25 Jun 2020 13:41:28 +0000 (UTC)
Date:   Thu, 25 Jun 2020 15:41:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200625134127.GH6156@alley>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
> Some of the console providers treat error code, returned by ->setup() hook,
> differently. Here is the unification of the behaviour.
> 
> The drivers checked by one of the below criteria:
> 1/ the driver has explicit struct console .setup assignment
> 2/ the driver has assigned callback to the setup member
> 
> All such drivers were read in order to see if there is any problematic return
> codes, and fixed accordingly which is this series in the result.
> 
> Andy Shevchenko (6):
>   mips: Return proper error code from console ->setup() hook
>   serial: sunsab: Return proper error code from console ->setup() hook
>   serial: sunzilog: Return proper error code from console ->setup() hook
>   tty: hvc: Return proper error code from console ->setup() hook
>   console: Propagate error code from console ->setup()
>   console: Fix trivia typo 'change' -> 'chance'

The entire patchset has been pushed into printk/linux.git,
branch for-5.9-console-return-codes.

I have done "s/pure/poorly/" to fix the typo in commit messages
reported by Jiri Slaby.

Best Regards,
Petr
