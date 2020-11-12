Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06332AFF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKLFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgKLBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:46:26 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1719C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:45:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so3023431pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQhUQl5SKV0omnprfPWc5RGNu6gDlIOdHOTSpdoTP04=;
        b=Tdb4UZpbGfvRJjebuFXiO/6BMdhzJfVunPRmsZ670eeHqce5TISfTRxDDvIoE0zT+R
         r0TlPQU2ZoLltpxscmIni/gkJupd810wxmz+SPIRg7WuSw1n7eM7iE3pO26Qy35hiWtL
         MX/edmWzb1ZDUKD9pOEDSklGXnptDHZObeGLo7z+sTgv7CnEIcpOsAslsm5JWglaqr3S
         KzwTajEjlWbe5K0S8OOsXFHt+V0mZZBDElH9t8dAro0loM6yhx5XpnPQSfFwCSCzLUlE
         GBOAxMVgxA0+h0jfvcHvg3zj/7vmyhcfyBlOW6iPlcObtIzPfWUAvfmOPRgTj8fZ4d6n
         8RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQhUQl5SKV0omnprfPWc5RGNu6gDlIOdHOTSpdoTP04=;
        b=VNrbOzd6p6BFMdIqq12Y05Eujnj/v+yixmWEEyIbovlsloTOHJhOEwcfMB9/mHLyiU
         3GWgauotZYLPRQ7d0Gw2aBxHQe/H+RWpHpKMnfxtvLwgoUJHX6rbxfwNqw+WG5hi24RU
         iHUkTper1iTDQAGHA09cy2oM2DJc0B4nDAZnGm8jt/FsmhmxNTF0Xj5aftOov8IMbXjk
         nQcSAbNFTn5uI7fb96PrvLL2NnjxGxESXjKA4F31+wEo+vVtiqadt7Eos3oDC8biipzb
         kRdBPmiGVBFHHx1DTnKIioJEndPTff+2z/iljFHvVLrLROPvQjcO1WF6vta82a/WSXrZ
         WZnw==
X-Gm-Message-State: AOAM5339U+EU5dkqbLBHK/9JhS8h8TMPbzNIkSm/4s264J6a98KP9j2u
        YQ3FyvXyNmSRpVdh87iQDRU=
X-Google-Smtp-Source: ABdhPJxZS3ynKu7b1eRQreoqdrprQgZPjcdAEZEcXY2x9KhgTr5VyNONTqCP1wB1aN2IrYfc46gmYg==
X-Received: by 2002:a17:90a:8086:: with SMTP id c6mr6660314pjn.147.1605145551251;
        Wed, 11 Nov 2020 17:45:51 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a10sm3776091pjq.17.2020.11.11.17.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:45:49 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:45:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <X6yTyvIfRUH7TOOx@jagdpanzerIV.localdomain>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <X6x/AxD1qanC6evJ@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6x/AxD1qanC6evJ@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/12 09:17), Sergey Senozhatsky wrote:
> On (20/11/11 14:54), Petr Mladek wrote:
> [..]
> > diff --git a/init/main.c b/init/main.c
> > index 130376ec10ba..24413c055a85 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
> >  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
> >  
> >  	if (IS_ERR(file)) {
> > -		pr_err("Warning: unable to open an initial console.\n");
> > -		return;
> > +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> > +		register_ttynull_console();
> > +
> 
> A nit, this probably can be done in console_device() function.
> 
> For several reasons:
> 
> - we will get covered all the future cases when something other than
>   console_on_rootfs() will filp_open("/dev/console")

And the existing ones (including user-space). For instance,
kernel/bpf/preload/iterators/iterators.c probably fails (?)
on systems with console=

	debug_fd = open("/dev/console", O_WRONLY | O_NOCTTY | O_CLOEXEC);
	if (debug_fd < 0)
		return 1;

	-ss
