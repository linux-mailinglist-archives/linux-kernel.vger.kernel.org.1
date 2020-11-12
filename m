Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76032AFCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgKLBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKLARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:17:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:17:11 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f38so2642195pgm.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64Ko4Uh2MgBriFYyivKMWhMNceryN3D5u9ODreNzjGk=;
        b=smp9Ay7pG8XxMZ7JT55xPcY3A/F0cvt0czHtFytIG/d05bckUGx5ezAJkNJBlbA6Nx
         XAxGSQY2lNHdRpk/pkD6nO2piIZxaUQ+MYWSn2mS5IgxdsSY3zLSTqWrCCx9LuOpGDFa
         pJUtr87dD1I3G1/h1nTKyvpbwSrBWCAhJNjGuh9jrJxfDIy4ZyRhhWw8M5ehh0xPbOVp
         4kn6KPg7yDfpKvNA54eZfQuVFpLx4bXGIJW6i3Wianb1nFxsC1pEH7f5j4QoKK94pWOG
         D88DK4d8jpNXo8MSL8Srbmi6rCjQfRrqEWNzjsvjoWs4wnxkeXsWYaGA2l4pn57BzZbL
         jVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64Ko4Uh2MgBriFYyivKMWhMNceryN3D5u9ODreNzjGk=;
        b=FYBF9BHa9LBnFtkVVfb7HtWNeK93XH47gdefdzpwR1CKIlOQzjDbxhTyTxJOiw4QWC
         RHh44EwD3LPXj1Q7ylZsNHz7x9buSvA5qjc/rdBMXINreci9uXejmeI4Xj+BL9skJ4hH
         f1V4a1HUKDJawCm3sufJY/j4E28XRxMoAssAHhQ9K19gpxQGeJU/wRmOoFfx8afIclBM
         VM/qAYUMjhPhkZ7bM8iQdzeIjgNXCjyeefdC3PEUK1OHRO3O+dqKhm2qu83xvVJkdtOe
         HN93lfTZLBD8h4R1ciaovj7E+BO+cftT/1KgHjqlaFbpY4RkCCjneJPDXduHpHW3XHIV
         cjXw==
X-Gm-Message-State: AOAM533SyhNQYdm6v8o6NoNZBmugXTwf6esGvifl9Gs6PpOiHrXVP6QQ
        Y3WxCefqNStt5Au1zrB+nig=
X-Google-Smtp-Source: ABdhPJzFd0QzA+CH2EjzP/ZzkbapKdBnvCgzddcQ1E2noqsPT1KJYMSj5l+xAT3AdenJeikYTa9l7A==
X-Received: by 2002:a05:6a00:91:b029:18c:abea:233e with SMTP id c17-20020a056a000091b029018cabea233emr1937097pfj.36.1605140230822;
        Wed, 11 Nov 2020 16:17:10 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id v12sm3515097pgr.4.2020.11.11.16.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:17:09 -0800 (PST)
Date:   Thu, 12 Nov 2020 09:17:07 +0900
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
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <X6x/AxD1qanC6evJ@jagdpanzerIV.localdomain>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/11 14:54), Petr Mladek wrote:
[..]
> diff --git a/init/main.c b/init/main.c
> index 130376ec10ba..24413c055a85 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
>  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
>  
>  	if (IS_ERR(file)) {
> -		pr_err("Warning: unable to open an initial console.\n");
> -		return;
> +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> +		register_ttynull_console();
> +

A nit, this probably can be done in console_device() function.

For several reasons:

- we will get covered all the future cases when something other than
  console_on_rootfs() will filp_open("/dev/console")

- filp_open() failure does not necessarily mean that we have console=
  and hence must register null-tty driver

- this will keep low level printk/tty details within the printk

Something like this?

---
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 08c50d8ba110..202fa87eb991 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2633,6 +2633,12 @@ struct tty_driver *console_device(int *index)
 	struct tty_driver *driver = NULL;
 
 	console_lock();
+	if (unlikely(!console_drivers)) {
+		console_unlock();
+		register_ttynull_console();
+		console_lock();
+	}
+
 	for_each_console(c) {
 		if (!c->device)
 			continue;
