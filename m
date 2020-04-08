Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0911A25EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgDHPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729682AbgDHPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586360847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAEJnsFvJ/UE0FB3O27yABAEEtvPXM+Fg0YVQjfo/a4=;
        b=SO0UzvBPB3brW+NKADWrvbBix+Dl8ZGoVw3WqvT2Y0ezg0kcukRYW8YiZM6wtfqkKVllkK
        Kx6LYA6Ye5BFiv2yJVeuYT++Rbard2oJL69TDNpWGeJ38mSCW+7ZWHNxBBur+cqx51FxwR
        Nex0VDT/iFibLxkPYl/7WrpxVIapTjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-brNGuT3YMYqs6Ze3U7W-EQ-1; Wed, 08 Apr 2020 11:47:25 -0400
X-MC-Unique: brNGuT3YMYqs6Ze3U7W-EQ-1
Received: by mail-wr1-f71.google.com with SMTP id x9so2523717wrq.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gAEJnsFvJ/UE0FB3O27yABAEEtvPXM+Fg0YVQjfo/a4=;
        b=GbgKD/TlLU6qEUtidtOuCRwqoDdajG0G5ujxP9QYQGFleKfS4C2EpGw/l/gfNwqLzD
         Q95YhmG+MYSqSt2o9NirTyHq5X385f5yVtBysDo8q08CfTpV32RWnxX03hBniH1HVAek
         ReH/5djpWXWSwgSXKnAIsP3C/3F3irXZoZVYqT+jsxfYVlo5xZAUQi1JUpyL7mzL/Bg1
         Wxx6pdrcHqDxvUz+jap0mbVHusRoYYbAYreqVFLkn3SvLkaFiEQ1KaLuAnaVEa+sAbMN
         pmhp0R/QFUA0yTvB9Om8THQtNZSxemsD97fkB2wLznIukSzQk1hCKw3uD63cao03rM3/
         bLfA==
X-Gm-Message-State: AGi0PuYufI+/iq7qtkz6H97+gXnJK2XoJhXYHngfsqKrvB9FSgey07vr
        P0iIGJF4I+F+KssqrFafYFdSUAvLfVcN6wp2UvhXpAHI+6i2KfMhFaCz794jKOH278HLzO0Pqnl
        0BEzrcKSdBjalgsF9iQ+XCfpk
X-Received: by 2002:a1c:9652:: with SMTP id y79mr5236093wmd.89.1586360840768;
        Wed, 08 Apr 2020 08:47:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIaJalJox0wC1qgjSXqmHy0drYO5xeMGjHVXA0P2g5EJhvdpeQG2ZSxTcASdJhmstQtru9VQ==
X-Received: by 2002:a1c:9652:: with SMTP id y79mr5236080wmd.89.1586360840526;
        Wed, 08 Apr 2020 08:47:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c190sm7520877wme.4.2020.04.08.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:47:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
In-Reply-To: <1586296907-53744-1-git-send-email-decui@microsoft.com>
References: <1586296907-53744-1-git-send-email-decui@microsoft.com>
Date:   Wed, 08 Apr 2020 17:47:18 +0200
Message-ID: <877dyq2d4p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> Before the hibernation patchset (e.g. f53335e3289f), a Linux VM on Hyper-V
> can run "echo freeze > /sys/power/state" (or "systemctl suspend")
> to freeze the system. The user can press the keyboard or move the mouse
> to wake up the VM. Note: the two aforementioned commands are equivalent
> here, because Hyper-V doesn't support the guest ACPI S3 state.
>
> With the hibernation patchset, a Linux VM on Hyper-V can hibernate to disk
> and resume back; however, the 'freeze' operation is broken for Hyper-V
> Generation-2 VM (which doesn't have a legacy keyboard/mouse): when the
> vmbus devices are suspended, the VM can not receive any interrupt from
> the synthetic keyboard/mouse devices, so there is no way to wake up the
> VM. This is not an issue for Generaton-1 VM, because it looks the legacy
> keyboard/mouse devices can still be used to wake up the VM in my test.
>
> IMO 'freeze' in a Linux VM on Hyper-V is not really useful in practice,
> so let's disallow the operation for both Gen-1 and Gen-2 VMs, even if
> it's not an issue for Gen-1 VMs.

Suspend-to-idle may not be very useful indeed, however, it worked before
and I think we can just fix it. In particular, why do we need to do
anything when we are not hibernating? 

>
> Fixes: f53335e3289f ("Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 029378c..82a4327 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -28,6 +28,7 @@
>  #include <linux/notifier.h>
>  #include <linux/ptrace.h>
>  #include <linux/screen_info.h>
> +#include <linux/suspend.h>
>  #include <linux/kdebug.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
> @@ -2357,6 +2358,23 @@ static void hv_synic_resume(void)
>  	.resume = hv_synic_resume,
>  };
>  
> +/*
> + * Note: "freeze/suspend" here means "systemctl suspend".
> + * "systemctl hibernate" is still supported.

Let's not use systemd terminology in kernel, let's use the ones from
admin-guide/pm/sleep-states.rst (Suspend-to-Idle/Standby/Suspend-to-RAM/
Hibernation).

> + */
> +static int hv_pm_notify(struct notifier_block *nb,
> +			unsigned long val, void *ign)
> +{
> +	if (val == PM_SUSPEND_PREPARE) {
> +		pr_info("freeze/suspend is not supported\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block hv_pm_nb;
> +
>  static int __init hv_acpi_init(void)
>  {
>  	int ret, t;
> @@ -2389,6 +2407,8 @@ static int __init hv_acpi_init(void)
>  	hv_setup_crash_handler(hv_crash_handler);
>  
>  	register_syscore_ops(&hv_synic_syscore_ops);
> +	hv_pm_nb.notifier_call = hv_pm_notify;
> +	register_pm_notifier(&hv_pm_nb);
>  
>  	return 0;
>  
> @@ -2402,6 +2422,7 @@ static void __exit vmbus_exit(void)
>  {
>  	int cpu;
>  
> +	unregister_pm_notifier(&hv_pm_nb);
>  	unregister_syscore_ops(&hv_synic_syscore_ops);
>  
>  	hv_remove_kexec_handler();

-- 
Vitaly

