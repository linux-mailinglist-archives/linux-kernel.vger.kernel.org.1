Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC42D1A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgLGUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:32:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2058C061794;
        Mon,  7 Dec 2020 12:31:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p4so5433480pfg.0;
        Mon, 07 Dec 2020 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHTBeyJXjU66O9BxCGUEf5eFmr0sgja/xlc/Cb4+iy8=;
        b=tacYSP7BVuuSfX80iPkfDyg4hs61ja+/uzt1ddXpR00npfn+83F9JQY8TzVYoLr51T
         wXmo9/XBbAaeSoKVjRi2ArbkF8q0Y9bU+lpfQjg2xY4j1I8ep5F8RfNVvEzomWzx5p/1
         PAZfbYuH9Y3CLqFLQcLJilZm6173h18/GZV4jepPMdwbzgsAJc5mnH18bwllxVzoijai
         6r0QL5rZJJZ3rhVFl0XANIF0uhtfo+fhCRJBCX9FPyNEDuWcPuDSrCjYx0JPAzO2WqxP
         wECxDb1WJxwgIwkloJ47KGmbCNLjffx0nm6qbblW7L00LmPvlJf0pTD0RRJNb8HExZ/0
         B5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHTBeyJXjU66O9BxCGUEf5eFmr0sgja/xlc/Cb4+iy8=;
        b=XqNLJ/RTyw29BhShaDniS8HgOj8ce03BRmSeoKzxf2h1fVZ9fblqfPzEQPcJe6yWMt
         Jk4QFLY45BTxYegpp4SBe17Hm9kjG3LaRwstUJYmTB5ETzWbyBWl4ZRtk9dRSLeuhFwR
         HovGXKkAYZacCOw/9sXOf42Pb70YALqnlxj5J5Kyzf5qEnw6M6NmzN/78yShBySKMYM5
         OG5Ls1RHM+I4eEJOMUBovyLbVwAjJLzDWd29uHWEQhbZgzr0nVMY21qArk/r7lIIl6eH
         barv7NrsM2kzNntOUd7TlMMdZ/8npIpOQed+qO6JOiCkb2AV9MkXjz4PnVjMz9w+XWjU
         omDA==
X-Gm-Message-State: AOAM533Gvl+df1mj+hLUFM3+JOY06eP4c1MncNvTc4+zV0oh3oLMmPbK
        tykXBf12YXQEjYdtrjWGkkSSXAmyiTLoiBTqgdM=
X-Google-Smtp-Source: ABdhPJwLxmI3TVd7HIanQLDPx2X9O3XmK51OmJIZ0N4KJ4x3WSz1f4ojz8VWULiuiT2mJJHKkWGtoSRHwAUinaa7pt8=
X-Received: by 2002:a17:90a:a090:: with SMTP id r16mr521302pjp.179.1607373108365;
 Mon, 07 Dec 2020 12:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com> <20201207160152.GB351233@robh.at.kernel.org>
 <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
In-Reply-To: <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 7 Dec 2020 14:31:37 -0600
Message-ID: <CABb+yY1Qm4G5rHmRbt8Pyno8h4X6EqesLv1=ybup0fHJ+rnPww@mail.gmail.com>
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, mgross@linux.intel.com,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        markgross@kernel.org, "arnd@arndb.de" <arnd@arndb.de>, bp@suse.de,
        damien.lemoal@wdc.com, Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 12:43 PM Daniele Alessandrelli
<daniele.alessandrelli@linux.intel.com> wrote:
>
> Hi Rob,
>
> Thanks for the feedback.
>
> On Mon, 2020-12-07 at 10:01 -0600, Rob Herring wrote:
> > On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > >
> > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > enables communication between the Computing Sub-System (CSS) and the
> > > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > > Bay.
> > >
>
> [cut]
>
> > > +
> > > +description:
> > > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > > +  Keem Bay.
> >
> > Sounds like a mailbox.
>
> We did consider using the mailbox framework, but eventually decided
> against it; mainly because of the following two reasons:
>
> 1. The channel concept in the Mailbox framework is different than the
>    channel concept in Keem Bay IPC:
>
>    a. My understanding is that Mailbox channels are meant to be SW
>       representation of physical HW channels, while in Keem Bay IPC
>       channels are software abstractions to achieve communication
>       multiplexing over a single HW link
>
In mailbox api, that would be a physical channel shared between various clients.

>    b. Additionally, Keem Bay IPC has two different classes of channels
>       (high-speed channels and general-purpose channels) that need to
>       access the same HW link with different priorities.
>
If the priorities are hard (programmed into some register), you could
do that via dt during channel population.
If they are soft, that would be handled in the shared channel implementation.

> 2. The blocking / non-blocking TX behavior of mailbox channels is
>    defined at channel creation time (by the tx_block value of the
>    mailbox client passed to mbox_request_channel();
>
No, that is checked at mbox_send_message()

> my understanding
>    is that the tx_block value cannot be modified after the channel is
>    created),
>
Again no. If you don't queue more than one message at any time you can
change it between transfers. To be safe you can always change it
between channel release - request calls.

>  while in Keem Bay IPC the same channel can be used for
>    both blocking and non-blocking TX (behavior is controlled by the
>    timeout argument passed to keembay_ipc_send()).
>
> Having said that, I guess that it could be possible to create a Mailbox
> driver implementing the core communication mechanism used by the Keem
> Bay IPC and then build our API around it (basically having two
> drivers). But I'm not sure that would make the code simpler or easier
> to maintain. Any thoughts on this?
>
I think so. Most of KeemBay specific behaviour would be implemented in
the shared channel above the mailbox api.

cheers!
