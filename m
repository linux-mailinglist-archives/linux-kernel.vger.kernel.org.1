Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000781DE3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEVKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 06:00:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgEVKAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:00:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33477AC49;
        Fri, 22 May 2020 10:00:50 +0000 (UTC)
Date:   Fri, 22 May 2020 12:00:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200522100046.GH3464@linux-b0ei>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522065306.83-1-shreyas.joshi@biamp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
> If uboot passes a blank string to console_setup then it results in a trashed memory.
> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
> is a blank parameter being passed to console_setup from uboot.
> In case it detects that the console parameter is blank then
> it doesn't setup the serial device and it gracefully exits.
> 
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
>  V1:
>     Fixed console_loglevel to default as per the review comments
> 
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
> +		return 1;
> +	}
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;

I have fixed formatting and pushed it into printk/linux.git,
branch for-5.8.

Best Regards,
Petr
