Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E024021E9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNHXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:23:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgGNHXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:23:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD016B875;
        Tue, 14 Jul 2020 07:23:41 +0000 (UTC)
Date:   Tue, 14 Jul 2020 09:23:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
Message-ID: <20200714072337.GE20226@alley>
References: <20200710094432.19655-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094432.19655-1-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mea culpa, I forgot to add John into CC.

John, if you agree with being spammed by printk patches,
please ack this one ;-)

Best Regards,
Petr

On Fri 2020-07-10 11:44:32, Petr Mladek wrote:
> John Ogness has started major rework of the printk code. Add him
> as reviewer so that he is aware of all other coming changes and
> could influence their integration.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d4aa7f942de..8e82d9db2a21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13770,6 +13770,7 @@ PRINTK
>  M:	Petr Mladek <pmladek@suse.com>
>  M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
> +R:	John Ogness <john.ogness@linutronix.de>
>  S:	Maintained
>  F:	include/linux/printk.h
>  F:	kernel/printk/
> -- 
> 2.26.2
