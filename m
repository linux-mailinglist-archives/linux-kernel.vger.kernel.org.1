Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA82C1988
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKWXmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKWXmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:42:39 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10467C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:42:39 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id n137so6519136pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZhy2jw4Xu/oQFRCdpsQxYirO+rgltzt8td0oXWBLe0=;
        b=SCaa4rl/HL3o3NV8cjGoyliX+zBCBYuwSDP+DtSPoVnCtoDdon3UW0rzdpCZy0Lz9e
         D6KP3bXiTKeL4YyMDsv8MBNqW0X6Ztt9uHrlj9+M/rgUO7VyjmTKyASvqo8UY0UPt62B
         wKGH8WLXtsK2+xAlGPrBh0mb2EafxxZ6Qg8mkADG3/qBKOQOzlv7BDYr8r/9vigH/ftT
         VCqqOOIpVULJAXlfIkCnflzG9yg46tq2bgcpiDmx1IXyrOzs3c6dpiH3JjpweDTqNhWt
         iIwV+riWsdPRCIZ6Lu9p43herk85XxKn7n9LFmpOKJBpQ6Zs1Mv4isBcstiG5m4pPms3
         Gt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZhy2jw4Xu/oQFRCdpsQxYirO+rgltzt8td0oXWBLe0=;
        b=WmBiVlDOYlg/LWs5V91N8DaoWrozq4Y0rp5l1Y5jVaQ/A8dE4ywXQSlnlb++se16Wt
         KOJl27bBHnjwPPknWxHgVeUwX844yTLsCWxbnNut80b2XcBt7B/5reER2KFYTYXdGSxQ
         89bL80SDAnQPRYD91+MD4sZGQKDGRQOPj8d5VklXWmLjxGIoYX5EdxwC9ySGqXBLklam
         k3wC56iAjub+Av0kW0a6tqxw+6tTr7TFWK2+gIRStBFrF2P6IKUv3lH5xvtQbjp/g5qa
         hXt6w53g4Q356MktefPTG7XKWw7sAXggwFcX3Z4mHP1SR+JgGgn+RcpWR94+Gmz0b5NB
         du/g==
X-Gm-Message-State: AOAM530xUAkrbCgrba5n40EtS6jYFawfgvYIOZZfrir2tzsjRXduPFIm
        hZh0dZK9xh/mp+m/OhE0Gc+/5iqAkXZ7ji0H0yT35nUN5kvvVw==
X-Google-Smtp-Source: ABdhPJyx88oWq/NEtB2WjGuwddGuttVdvpDiOVh9TuP4gtPO6bGXXB5KID17YTTDWfj5t/aI59HYSJ6kF5whmm5eJxE=
X-Received: by 2002:a63:4c10:: with SMTP id z16mr1509124pga.440.1606174958408;
 Mon, 23 Nov 2020 15:42:38 -0800 (PST)
MIME-Version: 1.0
References: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
 <20201113123035.tjllvijjzd54npsf@linutronix.de> <CAAeHK+zd0ucaj8EJ8ro+0ekubrxp5GiBMaBULHJB05dDrzpQGw@mail.gmail.com>
 <20201113132818.zhtdhzg6ukv4wgxl@linutronix.de> <CAAeHK+yZEQ7r1bBWbUhdys8s1CntwpOyF+Fm+H=NiuK0g3KwYg@mail.gmail.com>
 <CANpmjNNd1-0+UX8Pkjov7Roq-c2RHcHed2znqvMVMxmoX-3LXg@mail.gmail.com>
In-Reply-To: <CANpmjNNd1-0+UX8Pkjov7Roq-c2RHcHed2znqvMVMxmoX-3LXg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 24 Nov 2020 00:42:27 +0100
Message-ID: <CAAeHK+wC4uHz0-g8jEp=Nn11De1EpDsNeOLbXxrR2hJ3-2DFkA@mail.gmail.com>
Subject: Re: [PATCH v4] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
To:     Marco Elver <elver@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 4:47 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 13 Nov 2020 at 14:42, Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Fri, Nov 13, 2020 at 2:28 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2020-11-13 13:51:19 [+0100], Andrey Konovalov wrote:
> > > > Hi Sebastian,
> > >
> > > Hi Andrey,
> > >
> > > > Replaced with what and why?
> > >
> > > Linus requested in
> > >         https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com/
> > >
> > > that drivers should not change their behaviour on context magic like
> > > in_atomic(), in_interrupt() and so on.
> > > The USB bits were posted in
> > >         https://lkml.kernel.org/r/20201019100629.419020859@linutronix.de
>
> Arguably this patch is *not* changing "driver behaviour", it's only
> changing how and when KCOV collects coverage, which is not related to
> how the driver behaves.
>
> > > and merged (which is probably the same time as this patch).
> > >
> > > I haven't look what this code should do or does but there are HCDs for
> > > which this is never true like the UHCI/OHCI controller for instance.
> >
> > We could go back to adding softirq-specific kcov callbacks. Perhaps
> > with a simpler implementation than what we had before to only cover
> > this case. Something like kcov_remote_start_usb_softirq() and
> > kcov_remote_stop_softirq() that do the softirq check internally.
>
> Is this a matter of simply banning such functions entirely without
> understanding their use? Because that sounds wrong. But if it is, we
> probably have to just add some static inline functions in
> include/linux/kcov.h that simply does the check.

Yeah, this seems like a solution that will satisfy everyone. Will mail
a new version shortly.
