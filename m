Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D00295F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899373AbgJVNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:10:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899366AbgJVNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:10:23 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603372220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wxl5JRMHUAvC1JrSsaAK9KYia4L4bS6egRt+uenVx6w=;
        b=olHL2WSXNT2mwLYwOdHQaGCtNRbPn2UNJtBCeQbTkqdyvSJPFSzbqcP0ED5qLDSpJCwta8
        Iq1/bMkbVxdZRkoml3gm9J2xT6gRDlNtaNHnLC3dIvAf8DVM3aFnHLU0KZooiS1pip2uOC
        XUX8MBtCxkslHPZEBZl7VI057W7Qjuvj3/l0snCJGDnBUDh/SKUJq9B2wHKNOB00CCtqbQ
        2RNLgQd4/6MorO+eOhPhSJiABESfs6lzvfyPskDnXxCLUdZatne3txGSdwi+E5fiWMRjSY
        cYOESgE2sqpIQ7xeZ1dzT6eJsRze4rJsL/4JV8djgK7mY2N/Gvy+j72U7g3hAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603372220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wxl5JRMHUAvC1JrSsaAK9KYia4L4bS6egRt+uenVx6w=;
        b=wTtx3j/gIt26X9T5X7p9xqBFXaAo8465COCbx6v30pY1ZUzB1bBlMnpJoRf2YOIYU+arrc
        d0j9dMC2j8XmYfCA==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
In-Reply-To: <20201022114228.9098-2-pmladek@suse.com>
References: <20201022114228.9098-1-pmladek@suse.com> <20201022114228.9098-2-pmladek@suse.com>
Date:   Thu, 22 Oct 2020 15:16:19 +0206
Message-ID: <87a6wez9s4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22, Petr Mladek <pmladek@suse.com> wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 02d4adbf98d2..52b9e7f5468d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2974,6 +2974,12 @@
>  			Used for mtrr cleanup. It is spare mtrr entries number.
>  			Set to 2 or more if your graphical card needs more.
>  
> +	mute_console	[KNL]
> +			Completely disable printing of kernel messages to
> +			the console. It can still be used as stdin, stdout,
> +			and stderr for the init process. Also it can be used
> +			for login.

IMHO it would make more sense for this to be a console option:

    console=ttyS0,115200,mute

Then other consoles could still exist that are not muted.

On a side note, I am considering proposing something similar for my
printk-rework efforts. Once console printers are moved to kthreads, some
users may not care about latencies and instead prefer synchronous
printing. My idea for this is to provide a "sync" option for the
console:

    console=ttyS0,115200,sync

John Ogness
