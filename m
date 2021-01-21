Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F82FE7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbhAUKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:43:10 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:35106 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbhAUKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:42 -0500
Received: by mail-oo1-f44.google.com with SMTP id r199so379369oor.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhQpKRDpo0JI72DdeBtwsWbmJasuwFpOTIJINqmlpF8=;
        b=NDA8Re0y1oqgD23VV1MJDQXiEmS3+whqIQgzolRoFAcH1BGLVkTosfPmXPtcviT0r3
         xR2eS1q/l0QemgrnBBGZtuTb5AwN2c9Uto0hWsRjpnsj9RKQeTpYBEbgFI5gmVLq1e0Z
         TDgpQH4hBOjeBgT1JajA2FB4genSDpom66S8NbWvppgoo+OAZjDkrRVlx+DfpBnFIsM0
         gEnWai2pgGlJa90hJVDClkWfKIXGC3Mggt0rJ3PjYlRY4f9s2KEGEcZNoeqFkq/h9Guu
         aEnx3WwYdhaI3kToMuUvr6KG9orEL19UBxi0Q4+bdx1+KJpc3CUAZLoLYv3G1nv8ik46
         u7/A==
X-Gm-Message-State: AOAM531BQptOae/S49fvGNbc26fUd9WYP6D8NTXrJnGxP7tk5g3W5GFA
        3HLKwofe+Rw+2i8hEPoy7rVdaFENNm9Myw9BHYs=
X-Google-Smtp-Source: ABdhPJzH8ZSUuvgmLnSesQV/UZCGpMoty6dPxl8WK7wQWO9loeqPddMICI6wD4wphJ6hf0ik51Xgra0LDFXJUJ2f3I0=
X-Received: by 2002:a4a:96b3:: with SMTP id s48mr7413231ooi.11.1611225480043;
 Thu, 21 Jan 2021 02:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-6-saravanak@google.com>
 <20210121082248.883253-1-saravanak@google.com> <CAGETcx9+JbVAX4uXGn5hYSd-1VK8oZeLxhGAKZksyR31xpeQhg@mail.gmail.com>
In-Reply-To: <CAGETcx9+JbVAX4uXGn5hYSd-1VK8oZeLxhGAKZksyR31xpeQhg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jan 2021 11:37:49 +0100
Message-ID: <CAMuHMdVs6UM-jvQh8kgp9x9n_rBt36ToOik44oVwKD_kkqkCVg@mail.gmail.com>
Subject: Re: [TEST PATCH v1] driver: core: Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Thu, Jan 21, 2021 at 9:28 AM Saravana Kannan <saravanak@google.com> wrote:
> On Thu, Jan 21, 2021 at 12:22 AM Saravana Kannan <saravanak@google.com> wrote:
> > This patch is for test purposes only and pretty experimental. Code might
> > not be optimized, clean, formatted properly, etc.
> >
> > Please review it only for functional bugs like locking bugs, wrong
> > logic, etc.
> >
> > It's basically trying to figure out which devices will never probe and
> > ignore them. Might not always work.
> >
> > Marek, Geert, Marc,
> >
> > Can you please try this patch INSTEAD of the other workarounds we found?

Thanks for your patch!

> Oh and can you please also try with the CONFIG_MODULES enabled vs
> disabled? Or have it disabled but fix the patch so the condition
> always evaluates to true.

With CONFIG_MODULES=y, it fails in the same way as before (no "Deleting
{fwnode,dev} link" messages seen), with a new lockdep warning:

+======================================================
+WARNING: possible circular locking dependency detected
+5.11.0-rc2-salvator-x-00009-gdf1dd3208a90 #941 Not tainted
+------------------------------------------------------
+swapper/0/1 is trying to acquire lock:
+ffffffc0110da488 (fwnode_link_lock){+.+.}-{4:4}, at: fw_devlink_unblock_probe+0
x50/0x158
+
+but task is already holding lock:
+ffffffc0110da988 (deferred_probe_mutex){+.+.}-{4:4}, at: deferred_probe_initcal
l+0xe4/0x12c
+
+which lock already depends on the new lock.
+
+
+the existing dependency chain (in reverse order) is:
+
+-> #2 (deferred_probe_mutex){+.+.}-{4:4}:
+       lock_acquire+0x344/0x390
+       __mutex_lock+0xc0/0x37c
+       mutex_lock_nested+0x34/0x48
+       driver_deferred_probe_add+0x2c/0x88
+       device_links_driver_bound+0x11c/0x1ac
+       driver_bound+0x64/0xac
+       really_probe+0x304/0x338
+       driver_probe_device+0x98/0xa8
+       device_driver_attach+0x40/0x68
+       __driver_attach+0xa8/0xac
+       bus_for_each_dev+0x6c/0xb8
+       driver_attach+0x20/0x28
+       bus_add_driver+0x16c/0x1b0
+       driver_register+0xac/0xe4
+       __platform_driver_probe+0x88/0xe0
+       cpg_mssr_init+0x20/0x28
+       do_one_initcall+0xf0/0x280
+       kernel_init_freeable+0x1e0/0x1e4
+       kernel_init+0x10/0x108
+       ret_from_fork+0x10/0x18
+
+-> #1 (device_links_lock){+.+.}-{4:4}:
+       lock_acquire+0x344/0x390
+       __mutex_lock+0xc0/0x37c
+       mutex_lock_nested+0x34/0x48
+       device_links_write_lock+0x18/0x20
+       device_link_add+0xfc/0x3e4
+       fw_devlink_create_devlink+0x40/0xec
+       device_add+0x640/0x6ac
+       of_device_add+0x38/0x40
+       of_platform_device_create_pdata+0xb0/0xcc
+       of_platform_bus_create+0x2b8/0x364
+       of_platform_bus_create+0x300/0x364
+       of_platform_populate+0x7c/0xd8
+       of_platform_default_populate+0x20/0x28
+       of_platform_default_populate_init+0x80/0xb8
+       do_one_initcall+0xf0/0x280
+       kernel_init_freeable+0x1e0/0x1e4
+       kernel_init+0x10/0x108
+       ret_from_fork+0x10/0x18
+
+-> #0 (fwnode_link_lock){+.+.}-{4:4}:
+       check_noncircular+0x74/0xa4
+       __lock_acquire+0xdd0/0x10a8
+       lock_acquire+0x344/0x390
+       __mutex_lock+0xc0/0x37c
+       mutex_lock_nested+0x34/0x48
+       fw_devlink_unblock_probe+0x50/0x158
+       deferred_probe_initcall+0x11c/0x12c
+       do_one_initcall+0xf0/0x280
+       kernel_init_freeable+0x1e0/0x1e4
+       kernel_init+0x10/0x108
+       ret_from_fork+0x10/0x18
+
+other info that might help us debug this:
+
+Chain exists of:
+  fwnode_link_lock --> device_links_lock --> deferred_probe_mutex
+
+ Possible unsafe locking scenario:
+
+       CPU0                    CPU1
+       ----                    ----
+  lock(deferred_probe_mutex);
+                               lock(device_links_lock);
+                               lock(deferred_probe_mutex);
+  lock(fwnode_link_lock);
+
+ *** DEADLOCK ***
+
+1 lock held by swapper/0/1:
+ #0: ffffffc0110da988 (deferred_probe_mutex){+.+.}-{4:4}, at:
deferred_probe_initcall+0xe4/0x12c
+
+stack backtrace:
+CPU: 2 PID: 1 Comm: swapper/0 Not tainted
5.11.0-rc2-salvator-x-00009-gdf1dd3208a90 #941
+Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
+Call trace:
+ dump_backtrace+0x0/0x188
+ show_stack+0x14/0x28
+ dump_stack+0xf0/0x140
+ print_circular_bug.isra.0+0x1b0/0x1e8
+ check_noncircular+0x74/0xa4
+ __lock_acquire+0xdd0/0x10a8
+ lock_acquire+0x344/0x390
+ __mutex_lock+0xc0/0x37c
+ mutex_lock_nested+0x34/0x48
+ fw_devlink_unblock_probe+0x50/0x158
+ deferred_probe_initcall+0x11c/0x12c
+ do_one_initcall+0xf0/0x280
+ kernel_init_freeable+0x1e0/0x1e4
+ kernel_init+0x10/0x108
+ ret_from_fork+0x10/0x18

With CONFIG_MODULES disabled, it deletes one link, and hangs:

+platform e61c0000.interrupt-controller: Deleting dev link to
e6180000.system-controller
+INFO: task swapper/0:1 blocked for more than 120 seconds.
+      Not tainted 5.11.0-rc2-salvator-x-00009-gdf1dd3208a90-dirty #944
+"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
+task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x00000008
+Call trace:
+ __switch_to+0xa8/0x10c
+ __schedule+0x54c/0x728
+ schedule+0x7c/0xc0
+ schedule_preempt_disabled+0x10/0x1c
+ __mutex_lock+0x1e8/0x37c
+ mutex_lock_nested+0x34/0x48
+ driver_deferred_probe_del+0x28/0x8c
+ device_del+0x198/0x30c
+ device_unregister+0x14/0x28
+ __device_link_del+0x4c/0x5c
+ device_link_drop_managed+0x44/0x50
+ fw_devlink_unblock_probe+0x1e8/0x230
+ deferred_probe_initcall+0x11c/0x12c
+ do_one_initcall+0xf0/0x240
+ kernel_init_freeable+0x1e0/0x1e4
+ kernel_init+0x10/0x108
+ ret_from_fork+0x10/0x18
+INFO: lockdep is turned off.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
