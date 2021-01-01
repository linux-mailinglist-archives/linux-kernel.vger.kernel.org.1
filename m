Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D952E8339
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 07:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAAGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 01:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbhAAGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 01:12:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB70C061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 22:11:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w6so12168109pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 22:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmAkaRO9ofNP/6j9RK7haiAvDC6oSSf/13JUxt6XUpg=;
        b=BTMVd0Mnqvbh3hjtXYbPj9j74wDyKIql+z3uzxuM5xuQAVoMXSKz68StDG467zM5gL
         lvwlI4fOHLz+mv5b0ErbqlGWWyl8tWGzA1SnsxWFG6wP5czUXTou6TvowB3iiVZaAI3O
         4DO8B5/oFa0HQtN0FO5vm7EwCV4tJ+AtMKDtemFQSkuBTnewTscBD3e5Kqg8SzTWBRg5
         3ZlRywm8P+aB1GKNr+2JTuPkLg32hC6MrCcHWrS6v8LcY+KZUsjAEqSDyJrb7nC0LVkl
         IC9r1Mmu6lndRqyWw5fVdwdKhNyaE80WfXdW2LS+EgXDP0zkW7NiksFm3EZuKHEx74Y1
         pIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmAkaRO9ofNP/6j9RK7haiAvDC6oSSf/13JUxt6XUpg=;
        b=qWBWvPd156LcGlOHsBt7v2aJka1x3PzM9Za7JQCNcF60KVJ3G1ukGBtT3nH4XcUNUF
         1hXtPFTOdmlocAz39TZOvWdSh+L5ZoLQv+T3SLDdU8rQGgdBsXVRjsJuzVUXWRYZZW0J
         obNdXd4SQWukJDFzp6sOYT6CQsIysLNJKSWX9/sthk9NPBRnmmQAf5oHGstHmMeYVULE
         x9IAL0dPDm9CObydFZk7t+LmSxwtisqOrb6WTcOpHbPmLu6XMVeiHSScnubphxTekLR2
         Bnycwp80aFvM088VNnaf7h7PduQRq+d5CuEnDRvRxW493TOkNRY7tpL1Ff9T9e/GXXGF
         OYVw==
X-Gm-Message-State: AOAM533RdufeG0u6Px0WAshXciyC3xMvQhn15r+crFoPZkmloJNz9ELv
        sqpldeQy7bIFH5Ygcip1Cl8UdWNf0Aw=
X-Google-Smtp-Source: ABdhPJxbMw7KU34kDW7dVD8O1dieGLyXAkOPQWp/DIIgRLUyPE3kpanqpWup+pFrWXqVdhspKQsgMA==
X-Received: by 2002:a63:c444:: with SMTP id m4mr58675255pgg.420.1609481499888;
        Thu, 31 Dec 2020 22:11:39 -0800 (PST)
Received: from localhost (g39.222-224-245.ppp.wakwak.ne.jp. [222.224.245.39])
        by smtp.gmail.com with ESMTPSA id h10sm43515056pfn.213.2020.12.31.22.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 22:11:39 -0800 (PST)
Date:   Fri, 1 Jan 2021 15:11:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: restart: Call common handlers before hanging
Message-ID: <20210101061135.GA3106870@lianli.shorne-pla.net>
References: <20201227091446.118437-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227091446.118437-1-joel@jms.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 07:44:46PM +1030, Joel Stanley wrote:
> Currently openrisc will print a message and then hang in an infinite
> loop when rebooting.
> 
> This patch adopts some code from ARM, which calls the common restart
> infrastructure and hangs after a small delay if the restart infra
> doesn't do anything.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Geert has a patch[1] for the litex soc code that adds a restart hander.
> Openrisc doesn't hit that code path, this patch fixes that.
> 
> [1] https://github.com/geertu/linux/commit/7d09dc0797a8208a11eb7c0c2156c1a4c120180f
> 
>  arch/openrisc/kernel/process.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index 3c98728cce24..181448f74316 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -34,6 +34,7 @@
>  #include <linux/init_task.h>
>  #include <linux/mqueue.h>
>  #include <linux/fs.h>
> +#include <linux/reboot.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/io.h>
> @@ -49,10 +50,16 @@
>   */
>  struct thread_info *current_thread_info_set[NR_CPUS] = { &init_thread_info, };
>  
> -void machine_restart(void)
> +void machine_restart(char *cmd)
>  {
> -	printk(KERN_INFO "*** MACHINE RESTART ***\n");
> -	__asm__("l.nop 1");
Just a note, this nop with argument 1, is used by the simulators to shutdown.  I
am happy to get rid of this though.  The simulator should be simulating how real
hardware is shut down not doing these tricks.

> +	do_kernel_restart(cmd);
As you mentioned this depends on Geert's patch.  Does he plan to submit it soon?

Geert is CCed.

> +
> +	/* Give a grace period for failure to restart of 1s */
> +	mdelay(1000);
> +
> +	/* Whoops - the platform was unable to reboot. Tell the user! */
> +	pr_emerg("Reboot failed -- System halted\n");
> +	while (1);
>  }
>  
>  /*
> -- 
> 2.29.2

I am queing this for 5.11 anyway is it hurt's nothing without Geert's patch.

-Stafford

