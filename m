Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91CE29BBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900511AbgJ0Qab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:30:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40517 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1802642AbgJ0Pul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:50:41 -0400
Received: by mail-ej1-f66.google.com with SMTP id z5so2921094ejw.7;
        Tue, 27 Oct 2020 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ww5iLQa/mGBZU0sMrvS6TjHJKlRbYLQ7XqqTm3MMRyE=;
        b=pUud0R1PlZyQXPkSomQMn4iz0zfuYbvpwN0AKsZgwKQpjq/FV5r4HSChUb9Jm8kfBY
         aPbBEdKKUZdYjyswi0Bhle5Gz49m/vlxIy2va8tihvk5vAC2AWNL5y3zF/4zOnzYXVug
         jWqJj7b6cDPKbIXenE9Lw4B9ZQTkk9JIoRfYd80AhOlS4zd0VOZo3tZpjiwkPUJdybjG
         ike7zXrq4hYy2ggZpTjJRhyI7dmYTjs56yYQp6ll63WpsdTtm6qpmaUz/wBr4a5GUXgB
         WXEf+XA/fiM44OaZN6Z+vLgOodQwQGU/0NRC7Kdh7i/F0w9ffEVV89BMSkfoo7J5KxKC
         M42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ww5iLQa/mGBZU0sMrvS6TjHJKlRbYLQ7XqqTm3MMRyE=;
        b=eqOW4h1bXGabtYRzgzgC+ko6T1pNn/cvYkyVSOxXMO3FHATQ+ZUcQDHzlh9DTITgEm
         EtFvboJEm53klqVhEc9jHA3itaABuMMXD/3HZHyIPdX/+5Y/Cz8ENw9K+pD6TVO0ziiZ
         XrBGskm+eLpSiXAtV0DyDVVGPgvyyH7VAtt6E9tvToMjsxLez+vYoDz0hcoCkTVn3er9
         6Yb0oVEp31rrnkzkmaavEaaRnIWVCp2/PIfvWkk/mL4+0Z711jnr0vQYKNgsmxAC2V8Z
         ElRWsdvSVdAQqG4EF8k0sUSpuBPraMi43/j+59fz+xQ8F7eO8EHFQQtJqfTQIItnUc4B
         e2Nw==
X-Gm-Message-State: AOAM533MZOSQ3U/zJYVC+aARW06UM2FL2a+/27HVxbqfAgk4SYwWN6/Z
        ceiDefQ6a4B+l8wjuAd+4kL+mhqaXLiT9Kcsc7s=
X-Google-Smtp-Source: ABdhPJxQECACtAZ35jGnuxQ+PXO/sPM1oIQDNPl0ojXgq7kFkef6b7HxQ5EobTaHjkzw6AAmkSGN2Y68u6+Ij4oWcQg=
X-Received: by 2002:a17:906:1e45:: with SMTP id i5mr2931345ejj.203.1603813837551;
 Tue, 27 Oct 2020 08:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamthOsn9JfL1K-sGUmTUJ-1GV6eCnn3baLNnG_MnUk12ow@mail.gmail.com>
In-Reply-To: <CAEAjamthOsn9JfL1K-sGUmTUJ-1GV6eCnn3baLNnG_MnUk12ow@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 27 Oct 2020 11:50:25 -0400
Message-ID: <CAEAjams+ztDnt80M37ivQtGSUS1y6_zs-o0BoLDrTfBGAt+8ow@mail.gmail.com>
Subject: Re: memory leak in u_audio_start_playback
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 3:32 PM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
> of syzkaller).
>
> An instance of struct usb_request allocated in f_audio_set_alt() leaked.
>
> ==================================================================
> BUG: memory leak
> unreferenced object 0xffff888053df0e00 (size 128):
>   comm "softirq", pid 0, jiffies 4294940573 (age 17.540s)
>   hex dump (first 32 bytes):
>     00 0e df 53 80 88 ff ff 00 0e df 53 80 88 ff ff  ...S.......S....
>     00 82 df 53 80 88 ff ff c0 00 00 00 00 00 00 00  ...S............
>   backtrace:
>     [<000000000694647e>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<000000000694647e>] slab_post_alloc_hook mm/slab.h:588 [inline]
>     [<000000000694647e>] slab_alloc_node mm/slub.c:2824 [inline]
>     [<000000000694647e>] slab_alloc mm/slub.c:2832 [inline]
>     [<000000000694647e>] kmem_cache_alloc_trace+0x15c/0x310 mm/slub.c:2849
>     [<00000000d7d91433>] kmalloc include/linux/slab.h:555 [inline]
>     [<00000000d7d91433>] kzalloc include/linux/slab.h:669 [inline]
>     [<00000000d7d91433>] dummy_alloc_request+0x83/0x120 drivers/usb/gadget/udc/dummy_hcd.c:663
>     [<000000006e043557>] usb_ep_alloc_request+0x23/0x170 drivers/usb/gadget/udc/core.c:178
>     [<00000000fb13871b>] u_audio_start_playback+0x224/0x3c0 drivers/usb/gadget/function/u_audio.c:449
>     [<0000000017cb1f54>] f_audio_set_alt+0x8e/0x170 drivers/usb/gadget/function/f_uac1.c:463
>     [<0000000063ba610c>] composite_setup+0x62e/0x2690 drivers/usb/gadget/composite.c:1793
>     [<00000000e86333ed>] configfs_composite_setup+0xa5/0xd0 drivers/usb/gadget/configfs.c:1457
>     [<00000000f9a524ea>] dummy_timer+0x5a7/0x1460 drivers/usb/gadget/udc/dummy_hcd.c:1899
>     [<00000000182f2904>] call_timer_fn+0xdd/0x3a0 kernel/time/timer.c:1416
>     [<000000000d926b91>] expire_timers kernel/time/timer.c:1461 [inline]
>     [<000000000d926b91>] __run_timers kernel/time/timer.c:1792 [inline]
>     [<000000000d926b91>] run_timer_softirq+0x286/0x670 kernel/time/timer.c:1805
>     [<000000008902fa26>] __do_softirq+0xfa/0x684 kernel/softirq.c:292
>     [<000000003597f960>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
>     [<000000005c5a9a83>] __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
>     [<000000005c5a9a83>] run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
>     [<000000005c5a9a83>] do_softirq_own_stack+0x8b/0xb0 arch/x86/kernel/irq_64.c:77
>     [<00000000590d59e5>] invoke_softirq kernel/softirq.c:387 [inline]
>     [<00000000590d59e5>] __irq_exit_rcu kernel/softirq.c:417 [inline]
>     [<00000000590d59e5>] irq_exit_rcu+0xb5/0xf0 kernel/softirq.c:429
>     [<00000000689d4053>] sysvec_apic_timer_interrupt+0x83/0xf0 arch/x86/kernel/apic/apic.c:1091
>     [<00000000f2e90960>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
> ==================================================================
>
> Regards,
> Kyungtae Kim
