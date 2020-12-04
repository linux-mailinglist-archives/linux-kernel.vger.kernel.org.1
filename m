Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F582CF362
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgLDRwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgLDRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:52:47 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C4C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:52:01 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id i18so6638503ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UAVaDXI+I5u9V+JJpY6eb9l7dnPddi/+P+0R/fGgMY=;
        b=AjlKtvRF/fi9F8lPROkXKg51IjrxmrrtIDYi5sz1HKdVda2FMTzJCtoidPFpsLedvF
         togG9/KWphvdHTDOGeIlz1Mx/vJGAxIMxBYRbs+xMZUl0vNscohNS6Smpy6YBV2JJmW6
         eS1H66CEcz07rLjMmevcT0oN+JVCmOdsgyWeSKXJaQwy/rcTKn+ELv8LmofPqSbt7wdu
         2sJ1zpBA6MsuOEKBZDoU+YFUos6p4Et0XrSg9r/GqGE4JKei4NtQP0CiJ3DvUdjdMsDK
         0u8Hwkho8bFJVZHqeqghFZv6x60COdfFVYG7TIlNFO5+fQr4if81wHxlKP7655rP3CGO
         K60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UAVaDXI+I5u9V+JJpY6eb9l7dnPddi/+P+0R/fGgMY=;
        b=SBSxednIyiZJn3zJa0i1OZaIrgtW4u+RVN9tfihaQZdyQMy6efaVOKdin1KwKtOLk1
         CZlg65BETI0m8zmqVrsTYfTBLjlTnL8fenDJeGL9MHRpmFSw2dcD3fNbAKZuYPIvu+vB
         AWnZieFDBJvI0jdi7rFkVNo/IR1Ge7mrhNW01hABaZ8YoJhtUwYTrduksd8l4gBSiXpi
         YEDUIGPPQjQPzHmGvnSExsOcvtnRXxCDi1ZgZvZ0PPnxnfW/kkEI+LfbvKfQPSv1ydHG
         zjIkMuKdc9tCokL4efSRybVvE4EIftHA9PrL6zYxDFyUt5loC7VB29qOlkjpCWBFTy5B
         WomQ==
X-Gm-Message-State: AOAM5321P06e8izALxKz5yob3Roq1OLPZpBC2X3NQefchpMKSX5hnwDZ
        oL7tuV3pQjnIzenZfG0OEGn2Ksr/+tc9a/ysRNk33A==
X-Google-Smtp-Source: ABdhPJyI3pTXHexcHgBPq8OSBX6ioRMzSNf+GCrlVplPEh/3zrvNYahNpsh1ZldQNo3MU+KoMgSUBVxGggJrmOmyB1s=
X-Received: by 2002:a5e:db4b:: with SMTP id r11mr7636498iop.148.1607104320277;
 Fri, 04 Dec 2020 09:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20201120214245.172963-1-mathieu.poirier@linaro.org>
 <20201123160610.GA19108@ubuntu> <20201202110555.GA65230@ubuntu>
 <20201202203954.GC1282360@xps15> <20201203204218.GA13001@ubuntu>
In-Reply-To: <20201203204218.GA13001@ubuntu>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 4 Dec 2020 10:51:49 -0700
Message-ID: <CANLsYkzDiWtyNvYm8a_MBgz=cryb2mNNUwVA9=K2yrO3XTa-xA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] rpmsg: Make RPMSG name service modular
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am adding Vincent Whitchurch and the virtualization mailing list...

On Thu, 3 Dec 2020 at 13:42, Guennadi Liakhovetski
<guennadi.liakhovetski@linux.intel.com> wrote:
>
> (adding vhost maintainers and the author of [1])
>
> Hi,
>
> I'm working on an Audio DSP virtualisation solution [2] and the next
> step in its upstreaming should be an RPMsg vhost implementation, based
> on [3], which contains a simple addition to the current library-style
> vhost API. Later in [1] a different approach has been presented,
> converting the vhost framework to a proper bus-type and device driver.
> Therefore my questions:
>
> 1. if the latter approach is prefered, should we expect follow up
> versions of [1] and their upstreaming?
> 2. judging by the size and complexity of [1] would it maybe be
> preferable to first extract a minimum patch set just to add vhost
> rpmsg? Looking at the patch set it should be doable and not too
> difficult? Kishon, would it be something you could submit?

To me that is the best approach.  It might be best for you to do the
work and credit Kishon where needed.

> 3. or would it be preferable to keep vhost in its present form, use
> [3] for rpmsg support and re-implement [1] based on a different
> vhost / vringh approach?
>
> Thanks
> Guennadi
>
> [1] https://www.spinics.net/lists/kvm/msg219632.html
> [2] https://mailman.alsa-project.org/pipermail/sound-open-firmware/2020-April/003766.html
> [3] https://www.spinics.net/lists/linux-virtualization/msg43359.html
>
> On Wed, Dec 02, 2020 at 01:39:54PM -0700, Mathieu Poirier wrote:
> > Good day,
> >
> > On Wed, Dec 02, 2020 at 12:05:55PM +0100, Guennadi Liakhovetski wrote:
> > > Hi Mathieu,
> > >
> > > I'd like to resume reviewing and begin upstreaming of the next steps of
> > > my Audio DSP Virtualisation work, based on this your patch set. How
> >
> > I'm all for it too.
> >
> > > confident are we that it's going to be upstreamed in its present form?
> > > What's the plan to push it to "next?"
> > >
> >
> > I thought we were pretty unanimous that something like what Kishon did was the
> > way to go.
> >
> > > Thanks
> > > Guennadi
> > >
> > > On Mon, Nov 23, 2020 at 05:06:10PM +0100, Guennadi Liakhovetski wrote:
> > > > Hi Mathieu,
> > > >
> > > > Thanks for bringing all the stuff together and for polishing it!
> > > >
> > > > For the entire series:
> > > >
> > > > Tested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > >
> > > > Thanks
> > > > Guennadi
> > > >
> > > > On Fri, Nov 20, 2020 at 02:42:37PM -0700, Mathieu Poirier wrote:
> > > > > This revision addresses comments received from the previous revision,
> > > > > i.e V6.  Please see details below.
> > > > >
> > > > > It starts by making the RPMSG protocol transport agnostic by
> > > > > moving the headers it uses to generic types and using those in the
> > > > > current implementation.  From there it re-uses the work that Arnaud
> > > > > published[1] to make the name service modular.
> > > > >
> > > > > Tested on stm32mp157 with the RPMSG client sample application.  Applies
> > > > > cleanly on rpmsg-next.
> > > > >
> > > > > Thanks,
> > > > > Mathieu
> > > > >
> > > > > [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335
> > > > >
> > > > > -------
> > > > > New for V7:
> > > > > - Fixed error path in rpmsg_probe() as reported by Guennadi
> > > > >
> > > > > Arnaud Pouliquen (4):
> > > > >   rpmsg: virtio: Rename rpmsg_create_channel
> > > > >   rpmsg: core: Add channel creation internal API
> > > > >   rpmsg: virtio: Add rpmsg channel device ops
> > > > >   rpmsg: Turn name service into a stand alone driver
> > > > >
> > > > > Mathieu Poirier (4):
> > > > >   rpmsg: Introduce __rpmsg{16|32|64} types
> > > > >   rpmsg: virtio: Move from virtio to rpmsg byte conversion
> > > > >   rpmsg: Move structure rpmsg_ns_msg to header file
> > > > >   rpmsg: Make rpmsg_{register|unregister}_device() public
> > > > >
> > > > >  drivers/rpmsg/Kconfig            |   9 ++
> > > > >  drivers/rpmsg/Makefile           |   1 +
> > > > >  drivers/rpmsg/rpmsg_core.c       |  44 ++++++++
> > > > >  drivers/rpmsg/rpmsg_internal.h   |  14 ++-
> > > > >  drivers/rpmsg/rpmsg_ns.c         | 126 +++++++++++++++++++++
> > > > >  drivers/rpmsg/virtio_rpmsg_bus.c | 186 +++++++++++--------------------
> > > > >  include/linux/rpmsg.h            |  63 ++++++++++-
> > > > >  include/linux/rpmsg/byteorder.h  |  67 +++++++++++
> > > > >  include/linux/rpmsg/ns.h         |  45 ++++++++
> > > > >  include/uapi/linux/rpmsg_types.h |  11 ++
> > > > >  10 files changed, 439 insertions(+), 127 deletions(-)
> > > > >  create mode 100644 drivers/rpmsg/rpmsg_ns.c
> > > > >  create mode 100644 include/linux/rpmsg/byteorder.h
> > > > >  create mode 100644 include/linux/rpmsg/ns.h
> > > > >  create mode 100644 include/uapi/linux/rpmsg_types.h
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
