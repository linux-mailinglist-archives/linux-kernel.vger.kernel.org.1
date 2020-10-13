Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E628D052
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgJMOiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgJMOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:38:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2BC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:38:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a1so118833pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/zhEg0dNpXhH+pDUGJuAqxBZu+cNp3JAbQ0iH2743s=;
        b=tQKWMv0GMGQ69/NG2DriXticCxNTeqK/pUl2tLRujmpxtMkz35U1QateWHn8+8ptX8
         U9XimeECJknPPs8xDaaEEpUO/hyq0ivzblk+bSCq7zQ/LXiWt0hEv/603zXTrBACaJSu
         O2lWxusOEyxvuwHnqDVErqw7/XykmxgwAN0Nd+npLLeDuslnz/4wN5JPOJ0rv2HV1oiU
         vEIZ0F+Df44j/wJPTpJxxrKdLbGofiUG1phspFrlRDuEwhLcjoG09EoZ/IZv0n0LaTUc
         a47bYnsRuBIIGFW/BGr2Jyqp6U1+5jqyopj6hmymkk2tMN5a8tw/y2oj8qFM8kqL1cuo
         jpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/zhEg0dNpXhH+pDUGJuAqxBZu+cNp3JAbQ0iH2743s=;
        b=pZi/neCv2GRo3zT9wa8T29xP14puZ4hjfABFUdT8U+p3AvXHo0ozBHxua1ObpcjL+N
         Wds7pqhIzWq+WBbSJgH5b+aujcxn6HQB17CSsgSKFD6rrFUtMpU+agKAu3NsIwUbG044
         gJgzU6+bvfnd/wAi8RG0KXvEvoiMmwSY2tLSK+2jzQvOHAkwm2tfkCTg4YTn1biokNeK
         vKi2QTLN1MQAvkRt4mx5c/eTHobjZMGM3oW4WTwQbZ/kz7u2Y1p/L3y6iYK+FshtDqcB
         rIwBAmyCrpGMzvNv7x+uV90OHHo0euR2UTguCOri66UwUywZCAYvI9mQPBg+CJM/O//P
         Ohwg==
X-Gm-Message-State: AOAM532V5l17rHL+IP8rYT3UO/mFDYaQC7CAyp6ljtEo7d8LFv7MHQHr
        iVlIj6cfzuNNx3XGUasyELs5/Dkr6w0yBpafT0MVfQ==
X-Google-Smtp-Source: ABdhPJxQvBIwmfXGqjOkxhwNlRVLccTZxw4vK/ybW7FaIYErIJGyCaqrw3P60glbbdZ07hvQ63ceVQkiO6z3WOj2rys=
X-Received: by 2002:a17:902:b40a:b029:d4:e1c7:db59 with SMTP id
 x10-20020a170902b40ab02900d4e1c7db59mr91867plr.85.1602599892643; Tue, 13 Oct
 2020 07:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <c229372e5526b84ed0542028437111c2eb83d55f.1602522784.git.andreyknvl@google.com>
 <CACT4Y+aX-LN=tz2Xu3509K1tfrGiLWWKZQwMtRCg059whv-Gvg@mail.gmail.com>
 <CAAeHK+zur-CpmCj2bBucwVSAKkk8XBKZsQoGA8AmWraXuDctvA@mail.gmail.com> <CACT4Y+ZYUWqFemUE8_xJ-XyBrvnkmiNxokrwUNjjq3ShTLTz9Q@mail.gmail.com>
In-Reply-To: <CACT4Y+ZYUWqFemUE8_xJ-XyBrvnkmiNxokrwUNjjq3ShTLTz9Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Oct 2020 16:38:01 +0200
Message-ID: <CAAeHK+zWaurHxxo0VwvbRmOsRBDGV3wbzhEzGwTBZqO2iAZtXA@mail.gmail.com>
Subject: Re: [PATCH v4] kcov, usb: specify contexts for remote coverage sections
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Tue, Oct 13, 2020 at 4:15 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Oct 13, 2020 at 3:58 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > > Currently there's a KCOV remote coverage collection section in
> > > > __usb_hcd_giveback_urb(). Initially that section was added based on the
> > > > assumption that usb_hcd_giveback_urb() can only be called in interrupt
> > > > context as indicated by a comment before it. This is what happens when
> > > > syzkaller is fuzzing the USB stack via the dummy_hcd driver.
> > > >
> > > > As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
> > > > context, provided that the caller turned off the interrupts; USB/IP does
> > > > exactly that. This can lead to a nested KCOV remote coverage collection
> > > > sections both trying to collect coverage in task context. This isn't
> > > > supported by KCOV, and leads to a WARNING.
> > >
> > > How does this recursion happen? There is literal recursion in the task
> > > context? A function starts a remote coverage section and calls another
> > > function that also starts a remote coverage section?
> >
> > Yes, a literal recursion. Background thread for processing requests
> > for USB/IP hub (which we collect coverage from) calls
> > __usb_hcd_giveback_urb().
> >
> > Here's the stack trace:
> >
> >  kcov_remote_start_usb include/linux/kcov.h:52 [inline]
> >  __usb_hcd_giveback_urb+0x284/0x4b0 drivers/usb/core/hcd.c:1649
> >  usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1716
> >  vhci_urb_enqueue.cold+0x37f/0x4c5 drivers/usb/usbip/vhci_hcd.c:801
> >  usb_hcd_submit_urb+0x2b1/0x20d0 drivers/usb/core/hcd.c:1547
> >  usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:570
> >  usb_start_wait_urb+0x10f/0x2c0 drivers/usb/core/message.c:58
> >  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
> >  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
> >  hub_set_address drivers/usb/core/hub.c:4472 [inline]
> >  hub_port_init+0x23f6/0x2d20 drivers/usb/core/hub.c:4748
> >  hub_port_connect drivers/usb/core/hub.c:5140 [inline]
> >  hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
> >  port_event drivers/usb/core/hub.c:5494 [inline]
> >  hub_event+0x1cc9/0x38d0 drivers/usb/core/hub.c:5576
> >  process_one_work+0x7b6/0x1190 kernel/workqueue.c:2269
> >  worker_thread+0x94/0xdc0 kernel/workqueue.c:2415
> >  kthread+0x372/0x450 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> > > Or is there recursion between task context and softirq context?
> >
> > No. This kind of recursion is actually supported by kcov right now. A
> > softirq with a coverage collection section can come in the middle of a
> > coverage collection section for a task.
> >
> > > But
> > > this should not happen if softirq's disabled around
> > > usb_hcd_giveback_urb call in task context...
> >
> > [...]
> >
> > > We do want to collect coverage from usb_hcd_giveback_urb in the task
> > > context eventually, right?
> >
> > Ideally, eventually, yes.
> >
> > > Is this API supposed to be final? Or it only puts down fire re the warning?
> >
> > Only puts down the fire.
> >
> > > I don't understand how this API can be used in other contexts.
> > > Let's say there is recursion in task context and we want to collect
> > > coverage in task context (the function is only called in task
> > > context). This API won't help.
> >
> > No, it won't. Full recursion support is required for this.
> >
> > > Let's say a function is called from both task and softirq context and
> > > these can recurse (softirq arrive while in remote task section). This
> > > API won't help. It will force to choose either task or softirq, but
> > > let's say you can't make that choice because they are equally
> > > important.
> >
> > This currently works, everything that happens in a softirq gets
> > associated with softirq, everything else - with the task. This seems
> > to be the only logical approach here, it makes no sense to associate
> > what happens in a softirq with the task where the softirq happened.
> >
> > > The API helps to work around the unimplemented recursion in KCOV, but
> > > it's also specific to this particular case. It's not necessary that
> > > recursion is specific to one context only and it's not necessary that
> > > a user can choose to sacrifice one of the contexts.
> > > Also, if we support recursion in one way or another, we will never
> > > want to use this API, right?
> >
> > Correct.
>
>
> I see.
> The following is simpler option that does what this patch achieves but
> in a more direct way:
>
> // Because ...
> if (in_serving_softirq())
>     kcov_remote_start_usb((u64)urb->dev->bus->busnum);

Hmm, this actually makes a lot of sense. I wonder why I haven't
thought of that :) Will do in v4.
