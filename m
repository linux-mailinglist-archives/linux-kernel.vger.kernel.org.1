Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4992873F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgJHMUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJHMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:20:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B9C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 05:20:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so3848290pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i113na5WZQwVLGUym6+dZhvqLmyupFHhMJH579nd8mo=;
        b=S0H1H9iDbJ2q36sWSl1CSICTXdhdPJuQrcVbJlUHTdPBdYn7ia+rIqZoiNVRq+vZkT
         RYThFs8qtPnMqA5ek5/MIcmpoxY1NtaiAiFDqpo4PKE9aUbJiuRidpkr4tnJhJzK3Jz8
         Pa5zd7yAY1GHEnsVb0FLrbpoyr53W74uTK02E0DzJ5Ntf9249NW/8UwJ+m7Ei0c0Ftcc
         zQ6LNpLSCD56fmXtix7IwpJBX3XPWus1YmRgPmuv+KzLdrSeNshIWvS0SlmuS2HobLKr
         dVSiKCaQnlfIW4MoT6tfrAdxA9e1ERplw6iXK8aRyKTuKB7U06+8hip7BGxyPl3M4BV1
         BOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i113na5WZQwVLGUym6+dZhvqLmyupFHhMJH579nd8mo=;
        b=HejH5584rReEmv5oirSQOqTj6KkO18Izx0sF41KXt2e0YQMfbaR67QBKnbmdUtxIdM
         xubwDZ2y4f/7+8FRegcCoaT6j1aFArxxwb9+pwXw9A4XVeoY0CZ5ljg/DMIm/FXGJ10U
         tDh41rrXCjqiXz1G1gj4nRXe4BcAFovGHWS7617O9v0M7ZWRdQDHJO/eSkCVQZhuYU+x
         SJHaJ3U6wGjpGuQH2KD5nj6+967PVbNqhngPzklTdzkmIkjblujsfGf5SCUCcKToKiz9
         TSPRJI4xAX57hOISCJLysk1lrRYZbsD8wHmRD/2D6JDb8QQvRKh3kH/0ZeWTr0QlD+nx
         DrVg==
X-Gm-Message-State: AOAM531B/dWiSdS7aXzVh/LlYnihEcHwJljhHY8qw1PJC7vaLxAn9azA
        QZQgepp7kElkF5V/rxAbbEg=
X-Google-Smtp-Source: ABdhPJwGaCAxtlGSLZRqjYdmCSdxO2/+akfrj/mU8BkOwFoIrKWBFWz2i51FYsg5NZrgtN6zTc8b0A==
X-Received: by 2002:a62:6042:0:b029:155:7e44:ed3d with SMTP id u63-20020a6260420000b02901557e44ed3dmr96751pfb.73.1602159645561;
        Thu, 08 Oct 2020 05:20:45 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m11sm6768775pfk.57.2020.10.08.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 05:20:44 -0700 (PDT)
Date:   Thu, 8 Oct 2020 21:20:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008122042.GB127397@jagdpanzerIV.localdomain>
References: <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <20201008085008.GA16837@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008085008.GA16837@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/08 10:50), Petr Mladek wrote:
> On Wed 2020-10-07 21:30:44, Sergey Senozhatsky wrote:
> > On (20/10/07 09:28), Petr Mladek wrote:
> > > 
> > > 		/*
> > > 		 * Dirty hack to prevent using any console with tty
> > > 		 * binding as a fallback and adding the empty
> > > 		 * name into console_cmdline array.
> > > 		 */
> > > 		preferred_console = MAX_CMDLINECONSOLES;
> > 
> > Let me dump my findings so far. I still don't understand what exactly
> > crashes the laptop (blank screen is not very helpful).
> > 
> > So, things start with the "preferred_console = -1". In console_setup()
> > we call __add_preferred_console(). Since we have no consoles, the
> > name matching loop is not executed, and console selection counter remains
> > at 0. After the loop, despite the fact that we don't have the console
> > (`name' is empty), we still set `preferred_console', to 0.
> 
> Heh, we actually add the console.

To the console drovers list? I don't think so. At least on my laptop
what I have is as follows:

	/* See if this console matches one we selected on the command line */
	err = try_enable_new_console(newcon, true);

	/* If not, try to match against the platform default(s) */
	if (err == -ENOENT)
		err = try_enable_new_console(newcon, false);

	/* printk() messages are not printed to the Braille console. */
	if (err || newcon->flags & CON_BRL)
		return;

We hit this error return. Because both try_enable_new_console() return
-ENOENT. So this is never executed

	...
	console_lock();
	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
		newcon->next = console_drivers;
		console_drivers = newcon;
		if (newcon->next)
			newcon->next->flags &= ~CON_CONSDEV;
		/* Ensure this flag is always set for the head of the list */
		newcon->flags |= CON_CONSDEV;
	} else {
		newcon->next = console_drivers->next;
		console_drivers->next = newcon;
	}
	...

The console driver list is 0x00.

> I wonder if you see the problem solved by the commit 2d3145f8d2809592ef8
> ("early init: fix error handling when opening /dev/console").

/dev/console does exist. What does not exist is console driver, because
console drivers list is NULL. So the failure here is not filp_open()
per se, but tty_lookup_driver()->console_device(), which returns NULL.
As far as I'm concerned.

> I am also curious about the commit 74f1a299107b9e1a56 "Revert "fs:
> remove ksys_dup()"". I wonder why it was safe to call ksys_dup(0);
> even though the previous ksys_open() failed.

I'm quite sure ksys_dup(0) fails, in fact. I guess the issue here boils
down to user-space that does modprobe/fsck/mount and what kind of things
it attempts to do with standard file descriptors 0/1/2.

> PS: I am quite busy with something else this week.

Sure, no prob. Thanks.

	-ss
