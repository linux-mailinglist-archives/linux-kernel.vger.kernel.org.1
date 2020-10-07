Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94141285F33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgJGMat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:30:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5516C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:30:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so920802pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mN08K/+L+D/ROP0EKTl3Mj3ZVQvB9MLc7JwSscEpDvI=;
        b=T4VXKfGvs0aS6oH+0NzM9ZJ7xwk71OZdmEBV4BJL4CGVYlO+QWFrU5akKUaGgm+jRC
         KiC9zNN/wfLaVfbkz66wu4lk+xTQuLFdWR90x/gaiuc8EEpXUbInvocUL08us2fEtBR/
         X+NvKKQl9k69tleBDbEUThw8OivVMkIfJpOnQh/GFuB8e6bKa8iOC56rq6+L7/kwghCv
         StUnvoBEoj8JiFKXm12+XRt9s1fQRikz4I+OBj86i3LL6ZOLqR1F5cZEk52wwtYttHyk
         EZeN2xpLSlR3de1fP1oWQfyaMsWlo80e9EE5iCO4BWXaEE6cKAkan8BpFsUSVLiwovfX
         Zq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mN08K/+L+D/ROP0EKTl3Mj3ZVQvB9MLc7JwSscEpDvI=;
        b=s3qk1Y0VlKLF81V+Mv5G6YN/zwI1JINULRgBhsy5JRDIGfzpvC9gL80iBb3D2csyNZ
         js0ZGkqV64/ly5iRiMj0X6hxfqhqP/Sd5Oo2Y0ykMcdfju00tQXO4qTxbcZRSM0b/pqO
         HeNwCjuurRhrn7kEVbviryrM7JOvH4iEzDdQ6fYBOwkczf91z1IoIeJlFxPfkZ+rQyhu
         YaoCDodAgZIxSdCPhSzfccZ5n3D/1Huk+kN2ShJMVkR/mqPdQa6EHxK2vrGdBJQqv+s/
         0HwmlSAFCy+vQzwezNoDpSFSxjhx89BA03Ea2K+RgeUW74uhv128xS/KtfPbv0q0l5G9
         N25Q==
X-Gm-Message-State: AOAM531Rs1e14D1F5anNRqh0zZFvlGm4c4nnT2/RB8zXuMUCSG+gFABv
        tlmHprnkJd+TfCCLcLDNLSE=
X-Google-Smtp-Source: ABdhPJz7D2X5HtSUShtQcC/8RFbVZB300OrASMFtH3wLVtC4pg2x1/Cc804mUWzGubztgpEZ4DUBDA==
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id d10-20020a170902aa8ab02900d3c9dd77d1mr2844600plr.0.1602073847950;
        Wed, 07 Oct 2020 05:30:47 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i17sm2775839pfa.29.2020.10.07.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:30:46 -0700 (PDT)
Date:   Wed, 7 Oct 2020 21:30:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201007123044.GA509@jagdpanzerIV.localdomain>
References: <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007072853.GF32369@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/07 09:28), Petr Mladek wrote:
> 
> 		/*
> 		 * Dirty hack to prevent using any console with tty
> 		 * binding as a fallback and adding the empty
> 		 * name into console_cmdline array.
> 		 */
> 		preferred_console = MAX_CMDLINECONSOLES;

Let me dump my findings so far. I still don't understand what exactly
crashes the laptop (blank screen is not very helpful).

So, things start with the "preferred_console = -1". In console_setup()
we call __add_preferred_console(). Since we have no consoles, the
name matching loop is not executed, and console selection counter remains
at 0. After the loop, despite the fact that we don't have the console
(`name' is empty), we still set `preferred_console', to 0. This affects
register_console(). Since we have `preferred_console >= 0' we don't
execute the newcon->setup(), but, more importantly, we don't set the
newcon->flags |= CON_ENABLED. Now, we call try_enable_new_console():
since there are no consoles, the ->match() loop is not executed.
newcone does not have CON_ENABLED set, so try_enable_new_console()
returns -ENOENT. Both for user_specified=true and for fallback
user_specified=false cases. At this point we hit error-return path
from register_console() - we don't add newcon to the list of console
drivers. The console drivers list, thus, remains empty. So far so good.

Now. Things get strange in init/main.c

We have that kernel_init_freeable()->console_on_rootfs() control path.

console_on_rootfs() attempts to filp_open()->tty_open() /dev/console.
This ends up in printk's console_device(), which iterates the list of
console drivers and returns associated console->device back to tty. The
problem is that console drivers list is empty, so the function returns
NULL, and filp_open("/dev/console") fails. But the console_on_rootfs()
comment says that this function should never fail (!). This sort of
makes me wonder if "console=" is actually legal.

What this filp_open() failure means in particular, is that we never
create stdin/out/err fds, because we error-out and don't invoke
init_dup(file).

Things look different in older kernels. For instance, even in 5.4
the corresponding code looks as follows:

	/* Open the /dev/console on the rootfs, this should never fail */
	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
		pr_err("Warning: unable to open an initial console.\n");

	(void) ksys_dup(0);
	(void) ksys_dup(0);

Somehow, the fact that we don't init_dup(file) causes problems on my
laptop, but, at the moment, I can't tell exactly where. Perhaps more
experienced people will be like "darn, this is trivial, the problem is
here, here and there".

Hint: I can crash my laptop when I remove the "console=" boot param and
comment out init_dup(file) calls in console_on_rootfs().

I guess the problem is somewhat related to missing stdin/out/err fds.

Any ideas?

	-ss
