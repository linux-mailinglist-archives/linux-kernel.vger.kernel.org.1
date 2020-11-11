Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A52AFC38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgKLBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgKKWxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:53:46 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605BC061A04
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:52:51 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id d9so4113235oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BapSN4ceDUrkxFtWDRvBzpzHF+VZMJmzpSyozC9g/IE=;
        b=lLyO9063mwSyhWlWsqfRIchca1uOre5v2arKKZlfkYpbgR2IwwlB0wH5yedgYLstOc
         Q577UAHOg9/x6bNErowMTrJE+4o0XxVmdcysTQLmVB7iiwCjSbL896y53Dh/N9D0rDNS
         NYSOfRjXWzSfiXloxlaXrsbSOZMN5Im/e+A+JGm2jQQfWwitSYR4LXWj8Mqh7/v36aQC
         w7BKAavu3xUgA2k9wE+dRowtHZ9pqowZFU0NdfKrcKkzfcpdNdpLPqcwtq99WuR8kHwl
         AVK4QDbVMCTuAnZIPXba396oz5ZGbfYISq5E7l0dBVSHWbK7kwr49+17bI0+G/NW+phX
         8sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BapSN4ceDUrkxFtWDRvBzpzHF+VZMJmzpSyozC9g/IE=;
        b=EONS1Lb3QUmAuCUO7p5wpr+G8FuT/B2a5P3o4ajF1afLpglxujwF8KHd5g353qMElR
         qQ8C+REVAD5BKP1MiwIhpwJq+hCrGzWh/PhXuYqF1G4ZY4/G0zwdwZoEzujvCs+GPQWI
         2wuQJVbEU+bdXC5/gYJTUKB1O1mQRYdzKTTIZCrM37RcQp48UwFgOglu4DrhJswiwCrb
         qequBcFXsn3Bpc5aZsP9oYUaqmVvtvYFPv20VvIaRjbyCzwL9aHsgwEw6ceyEFFadyPI
         8LMWzGhmphZdsY/4jCPcSGcb5xCF9S0ERcYbXESIRSaEfEmah2mxCna3OgWoK4n+Uplt
         oVBQ==
X-Gm-Message-State: AOAM530XfHyjBJRrfTv+18Ilbc2cUOo/a93foyg6tjDg94pGsXkiTL5U
        m/CJnrHjmemuNh44fMebgmY=
X-Google-Smtp-Source: ABdhPJx1qEUEG7Gv8hXKAVOL5Tfjwg6jkM6c4m6srC/kb+LiBt6cGJFFLGG9Di3IptTcBnmL48RzLg==
X-Received: by 2002:aca:4797:: with SMTP id u145mr2563154oia.0.1605135170481;
        Wed, 11 Nov 2020 14:52:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm805880oth.73.2020.11.11.14.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 14:52:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Nov 2020 14:52:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk/console: Allow to disable console output by
 using console="" or console=null
Message-ID: <20201111225248.GB211321@roeck-us.net>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-3-pmladek@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:54:50PM +0100, Petr Mladek wrote:
> The commit 48021f98130880dd74 ("printk: handle blank console arguments
> passed in.") prevented crash caused by empty console= parameter value.
> 
> Unfortunately, this value is widely used on Chromebooks to disable
> the console output. The above commit caused performance regression
> because the messages were pushed on slow console even though nobody
> was watching it.
> 
> Use ttynull driver explicitly for console="" and console=null
> parameters. It has been created for exactly this purpose.
> 
> It causes that preferred_console is set. As a result, ttySX and ttyX
> are not used as a fallback. And only ttynull console gets registered by
> default.
> 
> It still allows to register other consoles either by additional console=
> parameters or SPCR. It prevents regression because it worked this way even
> before. Also it is a sane semantic. Preventing output on all consoles
> should be done another way, for example, by introducing mute_console
> parameter.
> 
> Link: https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/printk/printk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fe64a49344bf..ac440b879a2c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2189,8 +2189,15 @@ static int __init console_setup(char *str)
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
>  
> -	if (str[0] == 0)
> +	/*
> +	 * console="" or console=null have been suggested as a way to
> +	 * disable console output. Use ttynull that has been created
> +	 * for exacly this purpose.
> +	 */
> +	if (str[0] == 0 || strcmp(str, "null") == 0) {
> +		__add_preferred_console("ttynull", 0, NULL, NULL, true);
>  		return 1;
> +	}
>  
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;
> -- 
> 2.26.2
> 
