Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C567200585
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgFSJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 05:41:49 -0400
Received: from elvis.franken.de ([193.175.24.41]:37444 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgFSJlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:41:49 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jmDWr-0006aC-00; Fri, 19 Jun 2020 11:41:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2709FC06DA; Fri, 19 Jun 2020 10:37:43 +0200 (CEST)
Date:   Fri, 19 Jun 2020 10:37:43 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/6] mips: Return proper error code from console
 ->setup() hook
Message-ID: <20200619083743.GA6894@alpha.franken.de>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200618164751.56828-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618164751.56828-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:47:46PM +0300, Andy Shevchenko wrote:
> For unifying console ->setup() handling, which is pure documented,
> return error code, rather than non-zero arbitrary number.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/fw/arc/arc_con.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
