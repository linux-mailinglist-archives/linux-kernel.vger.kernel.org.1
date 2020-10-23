Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48B2967F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373822AbgJWAdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373815AbgJWAdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:33:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F35C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:33:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 19so2079196pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+lVaUm+mt4Dn/C7y5wypETHPv79D4JhdQvf1YdjtjU8=;
        b=Zr8Ndps1DsC07jJMnlWyIUaWvFklugkZsrtLlyOZcSmF3VUL4oRwSp4byq58mCBxoY
         ZEbPD4omh+EoeCZmZupePY2YeQifILcUuixnIDhx/+a/xnpaLGzRWo47cit2sEQwoeqd
         UXET4xSEgZ0xtsnfngKaT0E2L9QMqJa81HZNjOzDpzGrDCYjlhF73f1PEeS7E1HG3y0i
         LUuT2ZsgllNQVRPDvbdEM+FTMC5wr6ndETjCUMY+tj9c9gkS8JD/viC1DOQ7WwXT7YCQ
         eLtfDmDsricrGn4PnK2JDg5Ma1jEBFOT6nWXtATmtJ0ig8oLh9Poqdt4Z/wWxOCzKPdu
         ya1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lVaUm+mt4Dn/C7y5wypETHPv79D4JhdQvf1YdjtjU8=;
        b=M054scb0GdwVsf9yqIl2e9F5X51yLknQdhgLpTI3H9UC0cQ4rlc75fZGrgZwJNswYo
         Alw7cGiwT0ifDGlgCXUWjIPJ3/7g2ClPqAeR+7AoFFs9YzwF89UVTkWHynXq0c7rpScY
         GNzdTwMX/luajT6p3+taipTk80Agwlbs/H3Rp53wxOoLn89hNBLrwWMig9i5sBs29QvQ
         PrGhnTp9+vzsZVreXM+Vkxkh0QJUyLGrZ+QdCc3JYBfcY0LbBKiE0TMF5pQc8vcAJhVR
         lasuHj54tzL48KpxnzdSgSTEokzM85in1Kf1MR1fKgb2btYCd0FdR2mR0nPZE9Fpbp6n
         WZqw==
X-Gm-Message-State: AOAM533tfU0h2XVSQrRPQp/sy8BJX7mG2NaMjCv9jDfUThkuTCx3rk/D
        lshRUdC86TH9rE6BnYEnwccGKsgAWVI44g==
X-Google-Smtp-Source: ABdhPJw+fJuvzHTQcwTOUfRv2QuPQYhzMVm7Oct098aAz7wmJX5m/wPTlIKk8FZGWfhHv7Dd1F8H8Q==
X-Received: by 2002:a63:134d:: with SMTP id 13mr4401196pgt.370.1603413217446;
        Thu, 22 Oct 2020 17:33:37 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e186sm3533671pfh.60.2020.10.22.17.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 17:33:36 -0700 (PDT)
Date:   Fri, 23 Oct 2020 09:33:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
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
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
Message-ID: <20201023003334.GA588@jagdpanzerIV.localdomain>
References: <20201022114228.9098-1-pmladek@suse.com>
 <20201022114228.9098-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022114228.9098-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/22 13:42), Petr Mladek wrote:
> +static bool mute_console;
> +
> +static int __init mute_console_setup(char *str)
> +{
> +	mute_console = true;
> +	pr_info("All consoles muted.\n");
> +
> +	return 0;
> +}

First of all, thanks a lot for picking this up and for the patch set!

I've several thoughts and comments below.

>  static bool suppress_message_printing(int level)
>  {
> -	return (level >= console_loglevel && !ignore_loglevel);
> +	if (unlikely(mute_console))
> +		return true;
> +
> +	if (unlikely(ignore_loglevel))
> +		return false;
> +
> +	return (level >= console_loglevel);
>  }

This is one way of doing it. Another one is to clear CON_ENABLED bit
from all consoles (upon registration), one upside of this is that we
will signal user-space that consoles are disabled/muted (by removing
the E flag from /proc/consoles).

But, if I'm mistaken, but this mutes only printk side, consoles still
have uart running:
	printf -> tty -> uart -> serial_driver_IRQ() -> TX
	seriaal_driver_IRQ() -> RX -> uart -> tty

so user space, in theory, still can push messages to slow consoles,
AFAIU.

Thinking more about it. We are still relying on the fact that there is
anything registered as console driver, which is not necessarily the case,
we can have NULL console drivers list. So how about having a dummy struct
console in printk, with NOP read/write and NOP tty_driver and NOP
tty_operations. So that when init calls filp_open("/dev/console") and
we can't give tty anything but NULL, we'd just give tty back the dummy
NOP device.

	-ss
