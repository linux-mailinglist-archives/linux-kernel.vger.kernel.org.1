Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3B21BB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGJQkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJQkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:40:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519B9206A1;
        Fri, 10 Jul 2020 16:40:21 +0000 (UTC)
Date:   Fri, 10 Jul 2020 12:40:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
Message-ID: <20200710124018.34a04ca1@oasis.local.home>
In-Reply-To: <20200710094432.19655-1-pmladek@suse.com>
References: <20200710094432.19655-1-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 11:44:32 +0200
Petr Mladek <pmladek@suse.com> wrote:

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

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  S:	Maintained
>  F:	include/linux/printk.h
>  F:	kernel/printk/

