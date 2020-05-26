Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB281D5483
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgEOPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 11:24:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgEOPYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:24:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D132AB91;
        Fri, 15 May 2020 15:24:22 +0000 (UTC)
Date:   Fri, 15 May 2020 17:24:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200515152418.GH7340@linux-b0ei>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309052915.858-1-shreyas.joshi@biamp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-03-09 15:29:15, Shreyas Joshi wrote:
> If uboot passes a blank string to console_setup then it results in a trashed memory.
> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
> is a blank parameter being passed to console_setup from uboot.
> In case it detects that the console parameter is blank then
> it doesn't setup the serial device and it gracefully exits.
> 
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
>  kernel/printk/printk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ad4606234545..e9ad730991e0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
>  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
> -
> +	if (str[0] == 0) {
> +		console_loglevel = 0;

What is the reason to set console_loglevel here, please?

> +		return 1;
> +	}

Anyway, for example, earlycon parameter is allowed to be used with
empty string when the console parameters can be set via ACPI SPCR,
see param_setup_earlycon(). Therefore I am afraid that every setup()
function has to handle this on its own and this patch makes sense.

Best Regards,
Petr
