Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0752B6610
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgKQOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgKQNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:14:35 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:14:35 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j14so19337553ots.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AsagFz3qpxvVnJRhGWKP2r3LdabVn8VjcVj7U5Klrqw=;
        b=majB0eflvTZCnsjAsfnZsNXqpawuau5y4+fJhgwuuqiCP0xVrd6B1KkxkGe7ZHyYU4
         jKoyt4r1Mfvcnsx9tYLr6e6T1spacTbgHuwy/akI8xg3OtqCGqa/Nq+VCbgUFyAwSAfn
         lDgRyU8JHoYVVDEa/BB6pnwenkJaDYUyX24mO+0LnM2OVylEZDqZsc2jKejD5LF9BpcR
         mRpy8nQHrV5pOfDcnaQF7VVLFWmsISTfSpuXIdeACocGlN4BbB4zE4butjnCSA6BUWhv
         vgSrsBca/vRSe7tWnpEH8hPxhpD8yCXXvDkcCK1lLsyyaMXQedVOlfsy+htriMGMTQ8o
         SEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=AsagFz3qpxvVnJRhGWKP2r3LdabVn8VjcVj7U5Klrqw=;
        b=TgmOYf0IB2GV54onEjqER4uktYCoY9RZ/5XaZesUpIuzRCLM/BV2hB9ifKR4kxJP4E
         8jKr/CjkR1uqvtUk4U2UtKhtLmc6Aq0BnPWAhI396cEVzFfxsSSmGbjIpXZ6wolU3F5w
         18zmHZEIWY2TXAHn4w/yxiJqA+xr9SOqudnvKY4GlidIVFvBWDcg/wwPkjvl2z7XlMob
         z7d9G7UxTFuQeM31bJV7/a+v0SZwD4V+37PdiwWHbx2DENvQvi1O8T98AbfdcDDeWaz6
         bMmoZY5JP4celHne63SWeqNLmgThsR9rhqIeaboKzG+xw9PheHoZ4s8TD1AWLtujjcTC
         Nlmw==
X-Gm-Message-State: AOAM530Z6CBZ5jWMhNKP1X6TY8ZinVpmCj5sJ5ju+ZcUEzkELgJ8/4KF
        ZhWJXSRPuiZfS/MWFiF/8Q==
X-Google-Smtp-Source: ABdhPJyKZn00h7XgR3FLqYlpXYY/rrlfnfyXcZ8qxAbNzeMsbVYqgp/tRBAQSFSYYhpRd5BrCbJEzQ==
X-Received: by 2002:a9d:6351:: with SMTP id y17mr3012191otk.68.1605618874859;
        Tue, 17 Nov 2020 05:14:34 -0800 (PST)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id x18sm436917otq.6.2020.11.17.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 05:14:33 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2568:ae33:2356:c8f1])
        by serve.minyard.net (Postfix) with ESMTPSA id 8B574180048;
        Tue, 17 Nov 2020 13:14:32 +0000 (UTC)
Date:   Tue, 17 Nov 2020 07:14:31 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi/watchdog: replace atomic_add() and atomic_sub()
Message-ID: <20201117131431.GF3710@minyard.net>
Reply-To: minyard@acm.org
References: <1605511807-7135-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605511807-7135-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:30:07PM +0800, Yejune Deng wrote:
> atomic_inc() and atomic_dec() looks better

Yes, that's a little neater.  Queued for next release.

Thanks,

-corey

> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index f78156d..32c334e 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -495,7 +495,7 @@ static void panic_halt_ipmi_heartbeat(void)
>  	msg.cmd = IPMI_WDOG_RESET_TIMER;
>  	msg.data = NULL;
>  	msg.data_len = 0;
> -	atomic_add(1, &panic_done_count);
> +	atomic_inc(&panic_done_count);
>  	rv = ipmi_request_supply_msgs(watchdog_user,
>  				      (struct ipmi_addr *) &addr,
>  				      0,
> @@ -505,7 +505,7 @@ static void panic_halt_ipmi_heartbeat(void)
>  				      &panic_halt_heartbeat_recv_msg,
>  				      1);
>  	if (rv)
> -		atomic_sub(1, &panic_done_count);
> +		atomic_dec(&panic_done_count);
>  }
>  
>  static struct ipmi_smi_msg panic_halt_smi_msg = {
> @@ -529,12 +529,12 @@ static void panic_halt_ipmi_set_timeout(void)
>  	/* Wait for the messages to be free. */
>  	while (atomic_read(&panic_done_count) != 0)
>  		ipmi_poll_interface(watchdog_user);
> -	atomic_add(1, &panic_done_count);
> +	atomic_inc(&panic_done_count);
>  	rv = __ipmi_set_timeout(&panic_halt_smi_msg,
>  				&panic_halt_recv_msg,
>  				&send_heartbeat_now);
>  	if (rv) {
> -		atomic_sub(1, &panic_done_count);
> +		atomic_dec(&panic_done_count);
>  		pr_warn("Unable to extend the watchdog timeout\n");
>  	} else {
>  		if (send_heartbeat_now)
> -- 
> 1.9.1
> 
