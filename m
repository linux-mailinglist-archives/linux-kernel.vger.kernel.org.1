Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30C22B92AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKSMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKSMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:38:35 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:38:35 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id g4so1301762oom.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=n2bv/cLDYS+WfqbFySGfXKEkQq1vveQfrw1XHuIr4p8=;
        b=DG2lS0KRrtmTbGaOTGL73LGIfcxvcB/qubpdw3HQcUXA08EAmRvbJ5LrPEEQWhOWNi
         Zx8na/p+GbCHEOWwcPKOXdgD5Jr3BGtQobhGnDDdWzj4I0bOqHg+N+vFKJXjqpNd4137
         N+rqyG0ZbthbJyNyW1Rab1x0ui6O0qEIop7FNZ+bRWk6ZvglCiTzhpgWR/Vp/xqPC6Lv
         s9MEb7hha0rLipwEqR0Gufdj/fwkw9h3IkMyZPzCrqLkAJPMTfenYwm4fe0Saul7TjrS
         +c/YbiYd5mBAGDWxoy8kUHoUDWGGwEZf8/BShNk/Di2cz58rwCoIWghaOx1Zw4COdV+5
         Ppkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=n2bv/cLDYS+WfqbFySGfXKEkQq1vveQfrw1XHuIr4p8=;
        b=SmbLC25AsFIAnA2Izej4q01KT/+qpDWx06t6GDPDCjUglkRMWgPkUS1iDCQ72f37Pj
         7Fut0sXrRnRJI3CGOQ2zi2epa28y2nZYuaiAVe/8M+0tJ7b0Pq6U8BsvW0+fH79Kh/rV
         nmwUBaGx4LO8TK/HV9XPdQfFOZepqPvbGFzGq1GG78HlVA++4wmknzFeB9kTTJ/5f1u2
         0n52YUinXA6Yeppmr9vxw6UNQ2TVCrXUvnLbhJud0U7qoneGUwVRsbJeRXzvNbd+xfH/
         JIFrP+6Mh4T7xvyG7YmULyvB0Zx5sUhu9cvNl7ISZNGBAvQzOyUj8CSWM5bnc5t0jeXh
         VhLA==
X-Gm-Message-State: AOAM5321YEPXnD9U+E+FwSaRYVnizqPJFBAnYTIj9sDI8F7UlQ2RShTx
        Q8LkO4qcLB+ii4KZ/0M25Q==
X-Google-Smtp-Source: ABdhPJwQ6NyAbg2GhlN6KPKdOqUneJzzoExcKVfN/jx/ZurB3E8jB62sxyTvcadsW75q7GW8YNoNKA==
X-Received: by 2002:a4a:b689:: with SMTP id v9mr10440361ooo.0.1605789514480;
        Thu, 19 Nov 2020 04:38:34 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f20sm6348550otp.70.2020.11.19.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 04:38:33 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1d26:c11b:68a6:17b3])
        by serve.minyard.net (Postfix) with ESMTPSA id 738D1180048;
        Thu, 19 Nov 2020 12:38:32 +0000 (UTC)
Date:   Thu, 19 Nov 2020 06:38:31 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: msghandler: Suppress suspicious RCU usage warning
Message-ID: <20201119123831.GH3710@minyard.net>
Reply-To: minyard@acm.org
References: <20201119070839.381-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119070839.381-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:08:39PM +0800, Qinglang Miao wrote:
> while running ipmi, ipmi_smi_watcher_register() caused
> a suspicious RCU usage warning.

Thanks.  I had looked at this and found it was ok, but I hand't spent
the time to figure out how to suppress it.  It's in my next queue.

-corey

> 
> -----
> 
> =============================
> WARNING: suspicious RCU usage
> 5.10.0-rc3+ #1 Not tainted
> -----------------------------
> drivers/char/ipmi/ipmi_msghandler.c:750 RCU-list traversed in non-reader section!!
> other info that might help us debug this:
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syz-executor.0/4254:
> stack backtrace:
> CPU: 0 PID: 4254 Comm: syz-executor.0 Not tainted 5.10.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/ 01/2014
> Call Trace:
> dump_stack+0x19d/0x200
> ipmi_smi_watcher_register+0x2d3/0x340 [ipmi_msghandler]
> acpi_ipmi_init+0xb1/0x1000 [acpi_ipmi]
> do_one_initcall+0x149/0x7e0
> do_init_module+0x1ef/0x700
> load_module+0x3467/0x4140
> __do_sys_finit_module+0x10d/0x1a0
> do_syscall_64+0x34/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x468ded
> 
> -----
> 
> It is safe because smi_watchers_mutex is locked and srcu_read_lock
> has been used, so simply pass lockdep_is_held() to the
> list_for_each_entry_rcu() to suppress this warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 8774a3b8f..c44ad1846 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -747,7 +747,8 @@ int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
>  	list_add(&watcher->link, &smi_watchers);
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
> +			lockdep_is_held(&smi_watchers_mutex)) {
>  		int intf_num = READ_ONCE(intf->intf_num);
>  
>  		if (intf_num == -1)
> -- 
> 2.23.0
> 
