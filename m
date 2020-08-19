Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B140B249937
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHSJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 05:21:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHSJVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7302CADC1;
        Wed, 19 Aug 2020 09:21:33 +0000 (UTC)
Date:   Wed, 19 Aug 2020 11:21:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2] serial: 8250: change lock order in
 serial8250_do_startup()
Message-ID: <20200819092106.GA4353@alley>
References: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-08-17 11:26:46, Sergey Senozhatsky wrote:
> We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
> lockdep reports coming from 8250 driver; this causes a bit of trouble
> to people, so let's fix it.
> 
> The problem is reverse lock order in two different call paths:
> 
> chain #1:
> 
>  serial8250_do_startup()
>   spin_lock_irqsave(&port->lock);
>    disable_irq_nosync(port->irq);
>     raw_spin_lock_irqsave(&desc->lock)
> 
> chain #2:
> 
>   __report_bad_irq()
>    raw_spin_lock_irqsave(&desc->lock)
>     for_each_action_of_desc()
>      printk()
>       spin_lock_irqsave(&port->lock);
> 
> Fix this by changing the order of locks in serial8250_do_startup():
>  do disable_irq_nosync() first, which grabs desc->lock, and grab
>  uart->port after that, so that chain #1 and chain #2 have same lock
>  order.
> 
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch is committed in printk/linux.git, branch for-5.10.

Best Regards,
Petr
