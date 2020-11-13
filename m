Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E212F2B20BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKMQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKMQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:46:09 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF1C0613D1;
        Fri, 13 Nov 2020 08:46:09 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id l36so9490182ota.4;
        Fri, 13 Nov 2020 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7zjvxB8IPM5Mhr2gw8hZWusdq8Z7SVhEwNnCSZ2W0A=;
        b=gYDpFI0IJFPeUKrMjgO+G5qRDjpWh3koaJ9fER24+4aboghe/I+yzNfbSd5G8+Vt5E
         ppvi5Q773XiFNeBdZ27zrfu6xbB+PnyV3mr1feJGkfpSxzbN1agJfDSfxiimyWonf3KL
         LgZl3ZiojfgtlGL4FwUbs6Pk2TyoqGkPtTjE1hC1ao5F+8/zF0EY2MBht3OTRo6ZH0c8
         s5/YguZ6349pQV2/Lhp26e2nc6ZHE0KjFatzKERbnsPXpFkRkmxztpxvCBfyGp7mpmRs
         nQl9VSCQafmODOczX0lkwJO0+DWaQ07uXCxVBIF+St8kkfP3dDRwphDnhBEQiiLzDTNE
         GbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7zjvxB8IPM5Mhr2gw8hZWusdq8Z7SVhEwNnCSZ2W0A=;
        b=qvJ+6ZeGD4tE65oOp+fSW9Oi4yXZxCQQ1/8qCkMXAiyRXtp9mEMjqDhFKdt2rwSP9l
         4WcJd6SN3cKV2ie17cQEi/8qyQykcc7kTgyGa3EfDIozhc8GY+XAaQryD5rnjQKxbF30
         bMpULqX7e590ywfR5p1okcZeQLP2EDeg+hPBF1qkQMcXGLpq2x+VgEMpTP9GuHjMp+Ks
         XQSl61q+b1i3OBhBEusmqHxnDeKYNwg0V6XygOHaP/G8wRotfOL7EagbP6TUDCGqt/3W
         wpn4wZMuX/bTUoyrAzaW2f0TShrxsB3mWXMYoU5LBXBDKTbwNAQLZejN7tbnQ2x7TaSd
         VtEw==
X-Gm-Message-State: AOAM531qtN0JiyzppgEU9jsUIdNJ0pgMPlnJOT+du3AiZ6TUZy+R/FDD
        RAOYEDqdGQrqb2OV5ZefgT2G4HaydY8MsKrRMuU=
X-Google-Smtp-Source: ABdhPJwSYa7zc8BKwHO408gv+VEOzNUP0dG9UPHF3tEBu7A+/LLBxuzIp0SWJji6Bnhi8BKG4R/AxmVIY1OrRQpL1bc=
X-Received: by 2002:a9d:6207:: with SMTP id g7mr2276252otj.22.1605285964008;
 Fri, 13 Nov 2020 08:46:04 -0800 (PST)
MIME-Version: 1.0
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com> <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com> <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu> <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
 <20201113163449.GB322940@rowland.harvard.edu>
In-Reply-To: <20201113163449.GB322940@rowland.harvard.edu>
From:   John Boero <boeroboy@gmail.com>
Date:   Fri, 13 Nov 2020 16:45:52 +0000
Message-ID: <CAO5W59iqXGeAQTP7hzzRmbqwZUcK=vwuJ7pFzzNzZ9o11_k2tw@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I wanted to include a pastebin or link but was trying to follow maillist
guidelines and not include links or exceed wrap guidelines.  Full contents:
https://paste.centos.org/view/3746bc40

Yes I understand the return dodges the config dereference.

Original line usb.c:281 is the original error:

280| for (i = 0; i < config->desc.bNumInterfaces; i++)
281|  if (config->interface[i]->altsetting[0]
282|    .desc.bInterfaceNumber == ifnum)
283|  return config->interface[i];

Thanks
John

On Fri, Nov 13, 2020 at 4:34 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Nov 13, 2020 at 01:18:05PM +0000, John Boero wrote:
> > Thanks for the tips.
> >
> > I've spent some more time on this this morning.
> > It looks like it's not the dev after all.
>
> What isn't the dev?
>
> > Every interface in the dev is set NULL after init.
>
> I can't tell what this means.  Please be more explicit.
>
> > Just like in the original Ubuntu bug 1827452 filed by someone else
> > the device seems to disconnect itself after uvcvideo initialization.
> > Then there is a 5 second pause before usb_ifnum_to_if tries
> > to iterate through its 8 interfaces - all of which are null.
> > It looks like uvc properly locks the dev, so maybe this could
> > be caused by any device being unplugged after init?
>
> More likely there is a bug in the uvcvideo driver.
>
> > The WARNING handle preserves USB function though,
> > and subsequent lsusb behaves fine:
>
> No, the WARN only writes a message to the system log.  The "return"
> statement is what prevented the system from crashing.
>
> > $ lsusb | fold -w 80
> > Bus 002 Device 002: ID 8087:8002 Intel Corp. 8 channel internal hub
> > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 001 Device 002: ID 8087:800a Intel Corp. Hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 004 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
> > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 003 Device 005: ID 1ea7:0064 SHARKOON Technologies GmbH 2.4GHz Wireless rech
> > argeable vertical mouse [More&Better]
> > Bus 003 Device 004: ID 145f:025c Trust Trust USB Microphone
> > Bus 003 Device 002: ID 1050:0407 Yubico.com Yubikey 4/5 OTP+U2F+CCID
> > Bus 003 Device 009: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
> > Bus 003 Device 008: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
> > Bus 003 Device 006: ID 062a:4101 MosArt Semiconductor Corp. Wireless Keyboard/Mo
> > use
> > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
> > 8x (0-7) occurences of the following WARNING:
> >
> > [ 140.678756] usb 3-4: USB disconnect, device number 3
> > [ 145.995855] ------------[ cut here ]------------
> > [ 145.995863] dev interface is NULL in usb_ifnum_to_if
> > [ 145.995907] WARNING: CPU: 31 PID: 5617 at drivers/usb/core/usb.c:289
> > usb_ifnum_to_if+0x58/0x80
>
> You removed the most important part of the log message!  What appears
> below this point?
>
> In fact, you should just post the entire log (or put it on a server
> somewhere and post a URL).
>
> Alan Stern
