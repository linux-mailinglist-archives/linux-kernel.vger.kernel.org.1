Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D82D4722
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgLIQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLIQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:50:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72DC0613CF;
        Wed,  9 Dec 2020 08:49:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b26so1387375pfi.3;
        Wed, 09 Dec 2020 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70H7VzBCULzlKUies7Ypgvo9YkJeiVpUhwkoyXoRk7k=;
        b=UompSTh2w9L9hx2Ixn7rVp79dW4+VHAm+2Ug2TJq3b5yPLu2oSb48nOH+C5786oYP9
         nI0YlQmRNj9RL/GPi/sVK93g6/yzxl1kefP91H1XBDoqzrOshFtEdl4r846ykzBj0Z6k
         3tx9Vtge+bWIfIfv5EsMVTN+1Kd3/Yu9nCapApZmPrThscFOZqXj8b6w19c24Fjz5QmL
         /gkdjaYRo2AsArFRs7Wl8FeZfs5O2Hsy4JFUax8q5+zaXSI0+iHIac6cQIsutP/fh5fv
         aEk0wsKYa1fVbpPcHjIS5EpSSz4cTgMrcqqlw/VenZpArfc9rRCkKBehnlpM18+n06OB
         Fg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70H7VzBCULzlKUies7Ypgvo9YkJeiVpUhwkoyXoRk7k=;
        b=HdKTb9huGbc3PzGqByeTUu9rwbu7EHuEBXDA4vEmR4mvP6h8UKkUHSgUpLlDopfiqc
         e0ZlKXaTKC+2JuPnjEaY6q0sTBk/evRfdKAX6N0cPmgqO6OY5jWxVNL+5exWpuMxc6bn
         u+y21pwpJllsibUI2sIIFiUQtQ7i0ZAtfcALvxffw1ZwcBfPWPetQB7kmOMZjF/IdoS1
         S6IqCoOnaus2L/DEng0qaDEhuHmQDvkMP+CBxs5N2kOl1wg21X7t/93grkOgaqLEcNjC
         mnOxLTa11mqjl6rk0Zy4P+DCUtZJqWIrp3D62w47eeGTD4NMnlxzGNFOeqyZUDZRZOux
         JSUA==
X-Gm-Message-State: AOAM533vAcNFvcNF/v4iD/yMpHUxpwYD6qJoh9/Wj2PJ8/5jvFyCfEbZ
        3FxwKlil/qCpDlJPUuugO0vpUsvekJtSV1AcfAI=
X-Google-Smtp-Source: ABdhPJxZ4i60Eh06WECErzobTcjqtBhfb06dwhcJTeY6tiiNBTw/hFEO+hD1YZOoqAO09U51GQtV1KGgWnHepb8dVAE=
X-Received: by 2002:a62:d003:0:b029:19d:cf06:f8c2 with SMTP id
 p3-20020a62d0030000b029019dcf06f8c2mr3064301pfg.48.1607532576820; Wed, 09 Dec
 2020 08:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com> <20201207160152.GB351233@robh.at.kernel.org>
 <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
 <CABb+yY1Qm4G5rHmRbt8Pyno8h4X6EqesLv1=ybup0fHJ+rnPww@mail.gmail.com> <20201209001247.GA6438@linux.intel.com>
In-Reply-To: <20201209001247.GA6438@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 9 Dec 2020 10:49:26 -0600
Message-ID: <CABb+yY2B=pmfqxq=OcDPDJ3g-aw1SV+F7PSX0ARjgEmK61wxvg@mail.gmail.com>
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
To:     mgross@linux.intel.com
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
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

On Tue, Dec 8, 2020 at 6:12 PM mark gross <mgross@linux.intel.com> wrote:
>
> On Mon, Dec 07, 2020 at 02:31:37PM -0600, Jassi Brar wrote:
> > On Mon, Dec 7, 2020 at 12:43 PM Daniele Alessandrelli
> > <daniele.alessandrelli@linux.intel.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks for the feedback.
> > >
> > > On Mon, 2020-12-07 at 10:01 -0600, Rob Herring wrote:
> > > > On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > >
> > > > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > > > enables communication between the Computing Sub-System (CSS) and the
> > > > > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > > > > Bay.
> > > > >
> > >
> > > [cut]
> > >
> > > > > +
> > > > > +description:
> > > > > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > > > > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > > > > +  Keem Bay.
> > > >
> > > > Sounds like a mailbox.
> > >
> > > We did consider using the mailbox framework, but eventually decided
> > > against it; mainly because of the following two reasons:
> > >
> > > 1. The channel concept in the Mailbox framework is different than the
> > >    channel concept in Keem Bay IPC:
> > >
> > >    a. My understanding is that Mailbox channels are meant to be SW
> > >       representation of physical HW channels, while in Keem Bay IPC
> > >       channels are software abstractions to achieve communication
> > >       multiplexing over a single HW link
> > >
> > In mailbox api, that would be a physical channel shared between various clients.
> >
> > >    b. Additionally, Keem Bay IPC has two different classes of channels
> > >       (high-speed channels and general-purpose channels) that need to
> > >       access the same HW link with different priorities.
> > >
> > If the priorities are hard (programmed into some register), you could
> > do that via dt during channel population.
> > If they are soft, that would be handled in the shared channel implementation.
> >
> > > 2. The blocking / non-blocking TX behavior of mailbox channels is
> > >    defined at channel creation time (by the tx_block value of the
> > >    mailbox client passed to mbox_request_channel();
> > >
> > No, that is checked at mbox_send_message()
> >
> > > my understanding
> > >    is that the tx_block value cannot be modified after the channel is
> > >    created),
> > >
> > Again no. If you don't queue more than one message at any time you can
> > change it between transfers. To be safe you can always change it
> > between channel release - request calls.
> >
> > >  while in Keem Bay IPC the same channel can be used for
> > >    both blocking and non-blocking TX (behavior is controlled by the
> > >    timeout argument passed to keembay_ipc_send()).
> > >
> > > Having said that, I guess that it could be possible to create a Mailbox
> > > driver implementing the core communication mechanism used by the Keem
> > > Bay IPC and then build our API around it (basically having two
> > > drivers). But I'm not sure that would make the code simpler or easier
> > > to maintain. Any thoughts on this?
> > >
> > I think so. Most of KeemBay specific behaviour would be implemented in
> > the shared channel above the mailbox api.
>
> Quick question.  By "I think so"
>
From what I have read, it seems it should be doable as a mailbox.

> do you mean that you feel the keem bay IPC
> code will be simpler and easier to maintain if we make yet another driver at the
> Keem Bay IPC driver sits on top off?  Or, the current implementation would be
> simpler if we rework the implementation to use the mailbox api?
>
Most of the queue management code would be taken over my mailbox api.
And you'll have
separated out the pure controller driver from protocol assumptions.
So there shouldn't be extra code... just this code reorganised and some reduced.

cheers!
