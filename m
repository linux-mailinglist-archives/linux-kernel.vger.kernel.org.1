Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3B2A1BAF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgKACQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKACQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 22:16:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950EC0617A6;
        Sat, 31 Oct 2020 19:16:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a15so1813088edy.1;
        Sat, 31 Oct 2020 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5GlokU/RaLruL90MyQZH/UsYWUrL5JiW+aKThn1fQ8=;
        b=MLU7dUxnuLBwk7NxdWqpieXI49+FFHNuKCsz6QLOOzTb5NTvGvY/RNaMtvkraXiDsG
         81BxyfFHpolZ3SsF1/1S3D3l/99Th1YndGdKe7CaWBTLEVIehiQ8tr+Gh+5hNWC7tMl2
         kpD7Y81nUQMo46l/Zj9N6DXrdBennIDHNuik4D1Rp95vAZYDS9JIr8bTQvBRO0/m/pzg
         cdFIgq0v4cdnkg8AN4MlD+kLwHENUpnEzGDrxw/3kCjo6EgpUwrr9rYzDoyAqiorYg+m
         ZMy5yOiHnY4xUt+yP//VfCUsiJanhDxZtjLfpYJwfinBgMeu7v55fznaxmiClghnYmB6
         Y5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5GlokU/RaLruL90MyQZH/UsYWUrL5JiW+aKThn1fQ8=;
        b=tI4g0Pw6ti9hvNJFOj2RaUIiEIN3PHGs8UK/xWju6ZhSPtdHRZsB9nSqdqhQaax5e8
         ptgMZg00wjnmOXzkMCgFvJsF7m2xiHaW11wWtuafFiXXOExlKr1Z8uKGBpJSDQf1q+2k
         7i7GZhuftvqXlkRmp9qcGyAQeLxEIIMOE4q1pbY+RfSnvbyULT1M/1MTvYTZOOErORs3
         kiWiwObz2X4I7C4v1M/WsJGCLqDtbid2X72wX6HovCv/B1mgjIUJi05WIq+lrpqQQ5Cv
         iM+qlaRDu1e+hRkfwtvSrX7dTNNoKWrrsL7szNFVns44P/Awx/w+qk2kHy6zh8CtMn3f
         blWg==
X-Gm-Message-State: AOAM532YYYGoRfYFyw4N4U4EDNAWpukPOg88evoBQBWoFbv/1EnLs48C
        Zk4PQO/3VzLrQSlS3f/XAiCu0Rcnr/XytrWMiZb7JDqj
X-Google-Smtp-Source: ABdhPJz+e6X5ryRXxhwLlUqxgYFmgIkm5pnhl0EMO7IZstoINyiem7MeXyzfMfuql564Fy84Cmy6vG3O3D2L4eq5SDU=
X-Received: by 2002:a50:8426:: with SMTP id 35mr10144024edp.156.1604196976347;
 Sat, 31 Oct 2020 19:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamvSRv3m1XZjS7pe2HptX20w7otn6hNU4YFvt7XF4WPPng@mail.gmail.com>
In-Reply-To: <CAEAjamvSRv3m1XZjS7pe2HptX20w7otn6hNU4YFvt7XF4WPPng@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sat, 31 Oct 2020 22:16:05 -0400
Message-ID: <CAEAjamuZLCHS4geFiA5j7aUrw5p0bpefLQHZeYq6CA_LwqM7Bg@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: hidg: fix use-after-free in f_hidg
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 4:13 PM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> FuzzUSB (a variant of syzkaller) found the bug
> when accessing a freed instance of struct f_hidg.
>
> Reference: https://www.spinics.net/lists/linux-usb/msg195103.html
>
> The fix uses reference count to ensure the right access to instance of f_hidg.
>
>
> BUG: KASAN: use-after-free in f_hidg_poll+0x190/0x1e0 drivers/usb/gadget/function/f_hid.c:424
> Read of size 1 at addr ffff8880579260e8 by task syz-executor.5/2849
>
> CPU: 3 PID: 2849 Comm: syz-executor.5 Not tainted 5.6.11 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xce/0x128 lib/dump_stack.c:118
>  print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
>  __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:641
>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
>  f_hidg_poll+0x190/0x1e0 drivers/usb/gadget/function/f_hid.c:424
>  vfs_poll include/linux/poll.h:90 [inline]
>  do_pollfd fs/select.c:859 [inline]
>  do_poll fs/select.c:907 [inline]
>  do_sys_poll+0x548/0xe20 fs/select.c:1001
>  __do_sys_poll fs/select.c:1059 [inline]
>  __se_sys_poll fs/select.c:1047 [inline]
>  __x64_sys_poll+0x171/0x420 fs/select.c:1047
>  do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4531a9
> Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f07bfcd1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
> RAX: ffffffffffffffda RBX: 000000000073bfa8 RCX: 00000000004531a9
> RDX: 0000000000000080 RSI: 0000000000000001 RDI: 0000000020001980
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bd290
> R13: 00000000004d2c28 R14: 00007f07bfcd26d4 R15: 00000000ffffffff
>
> Allocated by task 2418:
>  save_stack+0x21/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:515
>  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
>  kmem_cache_alloc_trace+0xfa/0x2d0 mm/slub.c:2813
>  kzalloc include/linux/slab.h:555 [inline]
>  hidg_alloc+0x56/0x5e0 drivers/usb/gadget/function/f_hid.c:1091
>  usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
>  config_usb_cfg_link+0x1ed/0x3e0 drivers/usb/gadget/configfs.c:444
>  configfs_symlink+0x527/0x11d0 fs/configfs/symlink.c:202
>  vfs_symlink+0x33d/0x5b0 fs/namei.c:4201
>  do_symlinkat+0x11b/0x1d0 fs/namei.c:4228
>  __do_sys_symlinkat fs/namei.c:4242 [inline]
>  __se_sys_symlinkat fs/namei.c:4239 [inline]
>  __x64_sys_symlinkat+0x73/0xb0 fs/namei.c:4239
>  do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 2868:
>  save_stack+0x21/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:337 [inline]
>  __kasan_slab_free+0x135/0x190 mm/kasan/common.c:476
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
>  slab_free_hook mm/slub.c:1444 [inline]
>  slab_free_freelist_hook mm/slub.c:1477 [inline]
>  slab_free mm/slub.c:3034 [inline]
>  kfree+0xf7/0x410 mm/slub.c:3995
>  hidg_free+0x7f/0x110 drivers/usb/gadget/function/f_hid.c:1069
>  usb_put_function+0x38/0x50 drivers/usb/gadget/functions.c:87
>  config_usb_cfg_unlink+0x2db/0x3b0 drivers/usb/gadget/configfs.c:485
>  configfs_unlink+0x3b9/0x7f0 fs/configfs/symlink.c:250
>  vfs_unlink+0x287/0x570 fs/namei.c:4073
>  do_unlinkat+0x4f9/0x620 fs/namei.c:4137
>  __do_sys_unlink fs/namei.c:4184 [inline]
>  __se_sys_unlink fs/namei.c:4182 [inline]
>  __x64_sys_unlink+0x42/0x50 fs/namei.c:4182
>  do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>
> Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
> Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>
>
> ---
>  drivers/usb/gadget/function/f_hid.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 1125f4715830..e900b51c075a 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/sched.h>
>  #include <linux/usb/g_hid.h>
> +#include <linux/kref.h>
>
>  #include "u_f.h"
>  #include "u_hid.h"
> @@ -44,6 +45,7 @@ struct f_hidg {
>         unsigned short                  report_desc_length;
>         char                            *report_desc;
>         unsigned short                  report_length;
> +       struct kref             kref;
>
>         /* recv report */
>         struct list_head                completed_out_req;
> @@ -427,9 +429,21 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
>  #undef WRITE_COND
>  #undef READ_COND
>
> +static void f_hidg_free(struct kref *kref)
> +{
> +       struct f_hidg *hidg = container_of(kref, struct f_hidg, kref);
> +
> +       kfree(hidg);
> +}
> +
>  static int f_hidg_release(struct inode *inode, struct file *fd)
>  {
> +       struct f_hidg   *hidg  = fd->private_data;
> +
>         fd->private_data = NULL;
> +
> +       kref_put(&hidg->kref, f_hidg_free);
> +
>         return 0;
>  }
>
> @@ -440,6 +454,8 @@ static int f_hidg_open(struct inode *inode, struct file *fd)
>
>         fd->private_data = hidg;
>
> +       kref_get(&hidg->kref);
> +
>         return 0;
>  }
>
> @@ -1060,7 +1076,9 @@ static void hidg_free(struct usb_function *f)
>         hidg = func_to_hidg(f);
>         opts = container_of(f->fi, struct f_hid_opts, func_inst);
>         kfree(hidg->report_desc);
> -       kfree(hidg);
> +
> +       kref_put(&hidg->kref, f_hidg_free);
> +
>         mutex_lock(&opts->lock);
>         --opts->refcnt;
>         mutex_unlock(&opts->lock);
> @@ -1089,6 +1107,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>         opts = container_of(fi, struct f_hid_opts, func_inst);
>
>         mutex_lock(&opts->lock);
> +       kref_init(&hidg->kref);
>         ++opts->refcnt;
>
>         hidg->minor = opts->minor;
> --
> 2.17.1
>
