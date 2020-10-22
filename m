Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1787E296040
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900427AbgJVNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508274AbgJVNpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:45:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620CE20BED;
        Thu, 22 Oct 2020 13:45:14 +0000 (UTC)
Date:   Thu, 22 Oct 2020 09:45:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
Message-ID: <20201022094512.37c9bf5d@gandalf.local.home>
In-Reply-To: <20201022114228.9098-2-pmladek@suse.com>
References: <20201022114228.9098-1-pmladek@suse.com>
        <20201022114228.9098-2-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 13:42:27 +0200
Petr Mladek <pmladek@suse.com> wrote:

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fe64a49344bf..63fb96630767 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1207,6 +1207,19 @@ void __init setup_log_buf(int early)
>  	memblock_free(__pa(new_log_buf), new_log_buf_len);
>  }
>  
> +static bool mute_console;
> +
> +static int __init mute_console_setup(char *str)
> +{
> +	mute_console = true;
> +	pr_info("All consoles muted.\n");
> +
> +	return 0;
> +}
> +
> +early_param("mute_console", mute_console_setup);
> +module_param(mute_console, bool, 0644);
> +

Why have both early_param and module_param? What's the purpose of
module_param? Usually that's there to just set a variable, without a need
for another interface. But if you have early_param() that sets
mute_console, isn't that redundant?

-- Steve
