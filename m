Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FFF28545F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJFWQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:16:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B508C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 15:16:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so167853pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZnPth6VE++hvzuNUfaHWicTx8/+4Slf0WDCf2FuLRc=;
        b=gR0n4ubdEdVO4WV/3XKYG27xL6p/ZtBAtqQAC6whuiZuOGYMz8bF2TMNtLr6vHpV4y
         gsyzCKJLQtShQeLL8Vog5N7deC3xuhZEj5J3Xr1QZBD08/iQw/Bw3T51udXUsZDiI8sw
         IMCty4759uTuXOkZBjsY2fG79kWo0H4MPq4805DG7Y9SX/V4KxX93Q//dDew0ea2ui6Z
         nU7G8tohGaBwspFk8x60m4MbKXY2CVfdMoeH83tRgl17e5180Yphnu2jEv+FIvMdw6n8
         M6WlNqyCE4P9eOhYVH5R4BT4f+VuCEi+uYeR0p2GlP84gEq92JApbyC84lTSKWVcQLtS
         UAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZnPth6VE++hvzuNUfaHWicTx8/+4Slf0WDCf2FuLRc=;
        b=A8tnHSyOJvGVE1flnwmJl3pkOZI/+TbJnctucXngxKkOAa+ZuL0//f92r7jCdhfFLg
         obwsb5lfmp3GChmxXEP/Dcbs6YoNKh+hp/XyGKf/xk6RpbR+sa/xIiDntSFhRldemPSA
         kw7KWJSX/UWwKQYj9SZzxpnhUuP1G4ISiGHPAfxYkUA2W7Ew6mzPele9A8VWR7efNBEq
         ew1WUxfveS1kIWUs5Keyjt31VWLzQoGez1gXV6IuHs6uQnqS8yYx8uiF45SxagAADFzV
         qTtG/AhlYWDGuU9+uVhCE8LxrkmZB3Gt/9GzeVv010Q1xnrRgQGzFOVGEDrbWXDSdjV2
         C3gA==
X-Gm-Message-State: AOAM532EVz9+GHksthBQEXeSAM0XZZTjPTptlXpaGMkIwzja6pvC10jG
        LHV/M6YblUVrbJwk2UMqaTtepK5VRCI1mtS4eyLjAw==
X-Google-Smtp-Source: ABdhPJwdJy8g0LlZPYfzlhUdhMsLIvpCBugytTpZRvhK5IM+CWH8zBNe2LajgIJWefDQEB8lwpe1l93L94uXeaZXuGc=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr119379pfi.55.1602022588112; Tue, 06 Oct
 2020 15:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201006215147.35146-1-skhan@linuxfoundation.org>
In-Reply-To: <20201006215147.35146-1-skhan@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Oct 2020 00:16:16 +0200
Message-ID: <CAAeHK+yve84dKiNbwwTDJHMcCECM8N3GodoL5UeBPPL6REVg8Q@mail.gmail.com>
Subject: Re: [PATCH] usbip: vhci_hcd: fix calling usb_hcd_giveback_urb() with
 irqs enabled
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 11:51 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Fix the following warning from kcov regarding usb_hcd_giveback_urb()
> call being made without disabling interrupts.

Hi Shuah,

This won't fix the kcov warning, as it still requires its own fix,
which I'll send separately. But this will fix the improper usage of
usb_hcd_giveback_urb() in USB/IP.

Thank you for working on this!

>
> usb_hcd_giveback_urb() is called from vhci's urb_enqueue, when it
> determines it doesn't need to xmit the urb and can give it back.
> This path runs in task context.
>
> Disable irqs around usb_hcd_giveback_urb() call.
>
> WARNING: CPU: 2 PID: 57 at kernel/kcov.c:834
> kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.9.0-rc7+ #45
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x14b/0x19d lib/dump_stack.c:118
>  panic+0x319/0x765 kernel/panic.c:231
>  __warn.cold+0x2f/0x2f kernel/panic.c:600
>  report_bug+0x273/0x300 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
> Code: 84 26 03 00 00 fa 66 0f 1f 44 00 00 65 8b 05 50 13 93 7e a9 00
> 01 ff 00 41 8b 94 24 50 0a 00 00 75 1a 81 e2 ff ff ff bf 74 12 <0f> 0b
> 48 83 3d 17 c4 26 08 00 0f 85 62 01 00 00 0f 0b 65 8b 05 20
> RSP: 0018:ffffc9000030f600 EFLAGS: 00010002
> RAX: 0000000080000000 RBX: 0100000000000003 RCX: ffffc90014cd1000
> RDX: 0000000000000002 RSI: ffffffff85199fcc RDI: 0100000000000003
> RBP: 0000000000000282 R08: ffff88806d594640 R09: fffff52000061eca
> R10: 0000000000000003 R11: fffff52000061ec9 R12: ffff88806d594640
> R13: 0000000000000000 R14: 0100000000000003 R15: 0000000000000000
>  kcov_remote_start_usb include/linux/kcov.h:52 [inline]
>  __usb_hcd_giveback_urb+0x284/0x4b0 drivers/usb/core/hcd.c:1649
>  usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1716
>  vhci_urb_enqueue.cold+0x37f/0x4c5 drivers/usb/usbip/vhci_hcd.c:801
>  usb_hcd_submit_urb+0x2b1/0x20d0 drivers/usb/core/hcd.c:1547
>  usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:570
>  usb_start_wait_urb+0x10f/0x2c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  hub_set_address drivers/usb/core/hub.c:4472 [inline]
>  hub_port_init+0x23f6/0x2d20 drivers/usb/core/hub.c:4748
>  hub_port_connect drivers/usb/core/hub.c:5140 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
>  port_event drivers/usb/core/hub.c:5494 [inline]
>  hub_event+0x1cc9/0x38d0 drivers/usb/core/hub.c:5576
>  process_one_work+0x7b6/0x1190 kernel/workqueue.c:2269
>  worker_thread+0x94/0xdc0 kernel/workqueue.c:2415
>  kthread+0x372/0x450 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..
>
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 1b598db5d8b9..66cde5e5f796 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -797,8 +797,14 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>         usb_hcd_unlink_urb_from_ep(hcd, urb);
>  no_need_unlink:
>         spin_unlock_irqrestore(&vhci->lock, flags);
> -       if (!ret)
> +       if (!ret) {
> +               /* usb_hcd_giveback_urb() should be called with
> +                * irqs disabled
> +                */
> +               local_irq_disable();
>                 usb_hcd_giveback_urb(hcd, urb, urb->status);
> +               local_irq_enable();
> +       }
>         return ret;
>  }
>
> --
> 2.25.1
>
