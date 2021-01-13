Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA72F4579
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAMHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbhAMHpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:45:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FCF123333;
        Wed, 13 Jan 2021 07:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610523892;
        bh=eRUXu8yAOS3wyz6COdj6X5ania/Z1vd80fo4W3PoN9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0PcAgHKWXcQj3UwGmv/EeIfOAhFP1x3PEuiylN++NfA5jS+GAxcfIKv6EgQdkJVL
         hABJMYUVOrVtEGNUrLcJvpZugqcaXzJDe8dybnh+LVIJUnQCp6eBzGe7ocWm6A1PTz
         rldnz1vYNJRzJAUMP+B/+AWdd9MAvc2mHE9T1/qs=
Date:   Wed, 13 Jan 2021 08:44:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Zabrocki <pi3@pi3.com.pl>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] module: invoke kobject uevent before sending LIVE
 notification
Message-ID: <X/6k73cc9ft8be5o@kroah.com>
References: <20210110175401.GB32505@pi3.com.pl>
 <20210111142048.GA27038@linux-8ccs>
 <20210112001559.GA20073@pi3.com.pl>
 <20210112104654.GA26122@linux-8ccs>
 <20210113003310.GA3040@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113003310.GA3040@pi3.com.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:33:10AM +0100, Adam Zabrocki wrote:
> The recent change "module: delay kobject uevent until after module init
> call", while helping avoid a race between udev/systemd and the module
> loader, made it unnecessarily more difficult to monitor kernel module
> integrity by out-of-tree projects such as Linux Kernel Runtime Guard.

We don't support out-of-tree kernel code, sorry.

> Specifically, that change delayed the kobject uevent unnecessarily too far,
> to until after sending a MODULE_STATE_LIVE notification.  As the uevent
> modifies internal state of the KOBJ itself, this violated the assumption
> (non-guaranteed yet handy while we can maintain it) that the KOBJ remains
> consistent and can be integrity-checked as soon as the module is LIVE.
> 
> To make all of these projects happy at once, move the kobject KOBJ_ADD
> uevent to just before sending the MODULE_STATE_LIVE notification.
> 
> Fixes: 38dc717e9715 ("module: delay kobject uevent until after module init call")
> Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
> ---
>  kernel/module.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 4bf30e4b3eaa..7d56b1b07237 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3681,14 +3681,14 @@ static noinline int do_init_module(struct module *mod)
>                 dump_stack();
>         }
> 
> +       /* Delay uevent until module has finished its init routine */
> +       kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
> +
>         /* Now it's a first class citizen! */
>         mod->state = MODULE_STATE_LIVE;
>         blocking_notifier_call_chain(&module_notify_list,
>                                      MODULE_STATE_LIVE, mod);
> 
> -       /* Delay uevent until module has finished its init routine */
> -       kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
> -

No, the code is correct as-is, userspace should be told _after_ the
kernel itself has handled all of the needed housekeeping of the module
being added.

so consider this:

Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
