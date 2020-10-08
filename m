Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B016286E51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgJHFwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:52:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 22:52:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so3054585pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/Fx3EEpUtmYqkplb0FjHD2BN92xz6YGIh9sDxudzG4=;
        b=ert8QG3WHzyEJRVoDJ13JIxUe6SUIxcWXwWco2NxjcJnlTHQw4yImu35L2NXlQgNRN
         l2T8rha0O5NwhpNz8ixcnOi+WLJdq/mek79m5VGWo0t4JbXifm1nnBdeB1YjL5FxGPh8
         wJD2fMi7qx5nMIuxIpc1ANnWh5bkYOHrr00cAZgYdDDesTnh1VruLVZu1TiJh2888OiZ
         DM6M4qAjU8M3gI2bXyGGYV11JVsQoeLNx1EwcmNWao7N9zdqNejHLcYnoIfqmyUtdX0h
         BMjG7VacZf+3Y7Y9AqyZ0EUcewijpHy7mW9jlYrD2KeaNyUcqrgEck/XxScQZ8IotJ95
         Rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/Fx3EEpUtmYqkplb0FjHD2BN92xz6YGIh9sDxudzG4=;
        b=arRSJjfh0f3KGKUldmkuKmIx8xEgcMIsPR7eu1KTfC3BllWaXnayYZcCEFGAH6F/hO
         XwVtqjzmQBf3P5czT08vyc8FBxE3Wyhw8l/Xyvz2J86ARMTTU2GhaR5zMGiDbOetO+a2
         A3+gBEIRk7Yw/vn3wxIWdCVipfa++mwGBZql44fgT8inMyJvKoBgAQVvwYypSVyiJX51
         OACb1cX3koPw7Mk7pgrzbVaqSTJhSotNrG2PjpsAwrqyJpNIdzvpwFuBFvb2hHRiqhDG
         z+VgRkE9h5e7JFzN97wTfpEc6g6xxKt1vqnerkPNMY1BUPB5cLkueEAqdbWO2Jxpqa/b
         /XnQ==
X-Gm-Message-State: AOAM532p5rA1jOISuL5+HMYhh/dR4eXXeAR1Fkx6zw1IXCp8sEpIQcHn
        djrYtm3bjhHa+3f9fo99FTw=
X-Google-Smtp-Source: ABdhPJwwDqTok5Z4b554bKXi1m18ENR317iYc7cBlpHbJJ5neQjQLXmgcGJ7Uq1mSsuiNujvMdXRVw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr5943863pgt.250.1602136361633;
        Wed, 07 Oct 2020 22:52:41 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i24sm5271453pfd.15.2020.10.07.22.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 22:52:40 -0700 (PDT)
Date:   Thu, 8 Oct 2020 14:52:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>
Cc:     Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008055238.GA554@jagdpanzerIV.localdomain>
References: <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
 <20201007162942.GA440@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007162942.GA440@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/08 01:29), Sergey Senozhatsky wrote:
> On (20/10/07 08:57), Guenter Roeck wrote:
> > On 10/7/20 5:30 AM, Sergey Senozhatsky wrote:
> 
> [..]
> 
> > I can see to options: Link /dev/console to /dev/null if there is no console,
> > or do something like
> > 
> > 	if (IS_ERR(file)) {
> >                 pr_warn("Warning: unable to open an initial console.\n");
> >                 file = filp_open("/dev/null", O_RDWR, 0);
> > 		if (IS_ERR(file))
> >                 	return;
> >         }
> 
> As far as I can tell, /dev/null does not exist yet on this stage
> (at least not in my system). But generally the idea looks interesting.

Hmm. How about this. console= is undocumented and unspecified - it
may work sometimes or it may kill the system (and theoretically even
corrupt some files, depending on what fd 1 and fd 2 point to). So
maybe we can document console= and handle it in printk, rather than
somewhere deep in init/main.c

IOW add one more flag (yeah, I know) and set it when console_setup()
sees console= boot param. The idea is allow console registration,
but all consoles should be disabled (cleared CON_ENABLED bit). This
would be easier to document, at least.

Schematically:

---
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 929e86a01148..b71ff9d87693 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -281,6 +281,7 @@ static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
 static bool has_preferred_console;
+static bool mute_consoles = false;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2141,6 +2142,9 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	struct console_cmdline *c;
 	int i;
 
+	if (mute_consoles)
+		return;
+
 	/*
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
@@ -2189,6 +2193,11 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
+	if (str[0] == 0) {
+		mute_consoles = true;
+		return 0;
+	}
+
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
@@ -2630,6 +2639,9 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	if (mute_consoles)
+		return;
+
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
@@ -2811,6 +2823,9 @@ void register_console(struct console *newcon)
 		console_drivers->next = newcon;
 	}
 
+	if (mute_consoles)
+		newcon->flags &= ~CON_ENABLED;
+
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
