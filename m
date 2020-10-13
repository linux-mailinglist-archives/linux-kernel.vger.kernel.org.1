Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456CA28CFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgJMOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbgJMOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:15:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEEC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:15:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so27723qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDYyefM2Pzv2rMnzoJ3sgAdHit1ls0lrIdpXC5uoCyY=;
        b=oRufayoFefL6yVwqcjc/StTCckYjROD6rXt0IMjDlM8WP+v0+Pyg4IH8wP5QXWC7xE
         VHczL/S727NCOnUm0rQ6NzGcQJFRf4qrlo6o8tNmLcEUlKmg6jhtejwKGTwCqZWmlYdQ
         u8c6A0D1DHq2KlQUan6qesc8xDsiIv2AJqT2baLrs8cb071V/CBslZIT6GkZriLW8lSZ
         rCxJo+jc4LFx8GNl11cBjwT4+7DsyGey4oyUTMwwR+iwpdVcOOijti315/f0GZQOzXEe
         bjTw7zRPcPPM2OAXuurIs/0WzWMvQF4IZtWz+Xtm2q3N27NScPxzWpQkxafeA1uJyR9P
         ffjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDYyefM2Pzv2rMnzoJ3sgAdHit1ls0lrIdpXC5uoCyY=;
        b=e1QwiqH5+Y9HXG08SoZ+ZgIASE3eR5urZPLNAUdYZIpKLtTzhg34lkRYaxrkvErEZX
         MAzcoMjL/k21Nre9hINpf5GS/Cp88XO9VFFB6alkPoKVraBanzCzGknVetEcmRdNE8WW
         W6XS7T+ESmZCjw512r//B1DKw8BwDUeY4SISxQ/TleuP3FW2iFwZQag1PWdbTXXNZdrb
         yvq31/CBmKihMNAMQ2i/cMZti4S8DbfkNdouXFkxpByRXZucYALorMOuJzlNp/05zBVz
         Ma4bBk5vMu1fSWNsxpK9qK4V754hy2iUbdk3h8ZXwdDbFqBvb71s4XYAvZ805dXgT4rq
         Cuaw==
X-Gm-Message-State: AOAM532ye5p3/UgYc0FvVkefnHW2xMYFCUpd3LNJRuvBL3hdx9/azKo9
        m6Ab2GmbMYNuitqYaJguWWFDzOWoyrerDdhFwvUml3rOpepDxg==
X-Google-Smtp-Source: ABdhPJw71XsxJMOvkFMg8IysNNbT7GkDOa/n1PdYW1g0j2e2nSjqdGQZViBTdST1wPGNiMEdFBB2pqTsgEVRSTcm6YY=
X-Received: by 2002:ac8:7773:: with SMTP id h19mr14805793qtu.337.1602598528295;
 Tue, 13 Oct 2020 07:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <c229372e5526b84ed0542028437111c2eb83d55f.1602522784.git.andreyknvl@google.com>
 <CACT4Y+aX-LN=tz2Xu3509K1tfrGiLWWKZQwMtRCg059whv-Gvg@mail.gmail.com> <CAAeHK+zur-CpmCj2bBucwVSAKkk8XBKZsQoGA8AmWraXuDctvA@mail.gmail.com>
In-Reply-To: <CAAeHK+zur-CpmCj2bBucwVSAKkk8XBKZsQoGA8AmWraXuDctvA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Oct 2020 16:15:16 +0200
Message-ID: <CACT4Y+ZYUWqFemUE8_xJ-XyBrvnkmiNxokrwUNjjq3ShTLTz9Q@mail.gmail.com>
Subject: Re: [PATCH v4] kcov, usb: specify contexts for remote coverage sections
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 3:58 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > Currently there's a KCOV remote coverage collection section in
> > > __usb_hcd_giveback_urb(). Initially that section was added based on the
> > > assumption that usb_hcd_giveback_urb() can only be called in interrupt
> > > context as indicated by a comment before it. This is what happens when
> > > syzkaller is fuzzing the USB stack via the dummy_hcd driver.
> > >
> > > As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
> > > context, provided that the caller turned off the interrupts; USB/IP does
> > > exactly that. This can lead to a nested KCOV remote coverage collection
> > > sections both trying to collect coverage in task context. This isn't
> > > supported by KCOV, and leads to a WARNING.
> >
> > How does this recursion happen? There is literal recursion in the task
> > context? A function starts a remote coverage section and calls another
> > function that also starts a remote coverage section?
>
> Yes, a literal recursion. Background thread for processing requests
> for USB/IP hub (which we collect coverage from) calls
> __usb_hcd_giveback_urb().
>
> Here's the stack trace:
>
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
>
> > Or is there recursion between task context and softirq context?
>
> No. This kind of recursion is actually supported by kcov right now. A
> softirq with a coverage collection section can come in the middle of a
> coverage collection section for a task.
>
> > But
> > this should not happen if softirq's disabled around
> > usb_hcd_giveback_urb call in task context...
>
> [...]
>
> > We do want to collect coverage from usb_hcd_giveback_urb in the task
> > context eventually, right?
>
> Ideally, eventually, yes.
>
> > Is this API supposed to be final? Or it only puts down fire re the warning?
>
> Only puts down the fire.
>
> > I don't understand how this API can be used in other contexts.
> > Let's say there is recursion in task context and we want to collect
> > coverage in task context (the function is only called in task
> > context). This API won't help.
>
> No, it won't. Full recursion support is required for this.
>
> > Let's say a function is called from both task and softirq context and
> > these can recurse (softirq arrive while in remote task section). This
> > API won't help. It will force to choose either task or softirq, but
> > let's say you can't make that choice because they are equally
> > important.
>
> This currently works, everything that happens in a softirq gets
> associated with softirq, everything else - with the task. This seems
> to be the only logical approach here, it makes no sense to associate
> what happens in a softirq with the task where the softirq happened.
>
> > The API helps to work around the unimplemented recursion in KCOV, but
> > it's also specific to this particular case. It's not necessary that
> > recursion is specific to one context only and it's not necessary that
> > a user can choose to sacrifice one of the contexts.
> > Also, if we support recursion in one way or another, we will never
> > want to use this API, right?
>
> Correct.


I see.
The following is simpler option that does what this patch achieves but
in a more direct way:

// Because ...
if (in_serving_softirq())
    kcov_remote_start_usb((u64)urb->dev->bus->busnum);
