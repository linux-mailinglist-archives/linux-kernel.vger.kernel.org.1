Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057528B504
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgJLMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgJLMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:52:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50727C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:52:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so14175687pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipcIccSaehWRY8KFTu0E4RX30NBtF9Iei0Qm//1giqU=;
        b=vDmn/7Sox6P2fsbvwBYtK3OIQm6frCDfK+NSfp+MWaNoEgAtO9OtRnCMzRgCodb9J+
         f05LMh5zkDIZDdcf3k9UKZ2WSAJDbkSqns6f5KRDk2ajKEtdvXHVmIvVguLro00+VdVC
         Cm3abEcZErgIwXroZQUSpltfGvWD8+8AkcS12d93tTsy615SnA8R0btDLyVHy31STuIO
         cDX5Z2LBkQ6OPRMQN4YuSMvykCIeEDQcOy0deYu3RGBOfJpTg9sMDWH1ReEX684Rr3LI
         SJzsy9iSkbSjVugDsOXmw+JNzLgUM+w5BPn7R3bLKie+PMbBwXWeacPP0nwRpCdc1joe
         KQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipcIccSaehWRY8KFTu0E4RX30NBtF9Iei0Qm//1giqU=;
        b=RTcyxdfhHhZB/ndPAdiYtLRNjJVuUoXKMN56TgTxhO7FfjVQyT3r/oztZ3l+DiyXYW
         az6GboE1TEs3gstk9d9IB5mdV4MmFmKNkayyaHVrHVcIKh2XoXlceVWFrMG801brWjXV
         QWgZ/zYvLZnN+P0KviKXexQy47qTmZqW6c610RMijRlQxjxRTdWXsEUn0rMDPS6uTVBL
         fG5S3AJ2j658MiDHZh9EU6pCo1YAAEBh2/lI3kX5AYrNp9u0TlkLpaWGSSL7y8KmCBO1
         +ovgAMhMYeukpjRZZXA+9axqWJ4KSktU1HC4Omgbay3oBHrq4E0Ycr7pL7jh7OxcRJSS
         XqMQ==
X-Gm-Message-State: AOAM5330/khZ79c7fwbRFNU40x3bm43NSZf0F1Tfix3mHhzF9C7028Jp
        +q0+cdurRCD7KfgtIfUB2BDOOzGAjiBoQ2yvfS1DdA==
X-Google-Smtp-Source: ABdhPJxlshYioCMTyfDuNgCaIHvRc9rwT6fnHXX2uNOsXi4q+WcC9764HESYH/R1WG1xuE19lwP7z+hBF+xWhaf8e6g=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr19285084pjb.166.1602507168618;
 Mon, 12 Oct 2020 05:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <dfb5eee2b1bdff14508100ee7c427596de384cd3.1602237653.git.handeharputlu@google.com>
 <20201010065527.GA130900@kroah.com>
In-Reply-To: <20201010065527.GA130900@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Oct 2020 14:52:37 +0200
Message-ID: <CAAeHK+zQzyjN6c8swzzmtA726hP1Or6s=Cw-tB1y3N3zKJCqqA@mail.gmail.com>
Subject: Re: [PATCH] usbip, kcov: collect coverage from usbip client
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NazimeHandeHarputluogluhandeharput@gmail.com,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 8:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 09, 2020 at 03:22:55PM +0000, NazimeHandeHarputluogluhandeharput@gmail.com wrote:
> > From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> >
> > Add kcov_remote_start()/kcov_remote_stop() annotations to the
> > vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> > in USB/IP client.
> >
> > Since vhci_rx_loop() threads are spawned per usbip device instance, the
> > common kcov handle is used for kcov_remote_start()/stop() annotations
> > (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> > can now be used to collect coverage from vhci_rx_loop() threads.
> >
> > Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> > ---
> >  drivers/usb/usbip/usbip_common.h | 2 ++
> >  drivers/usb/usbip/vhci_rx.c      | 6 ++++--
> >  drivers/usb/usbip/vhci_sysfs.c   | 2 ++
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> > index 8be857a4fa13..cbbf2aa8ac73 100644
> > --- a/drivers/usb/usbip/usbip_common.h
> > +++ b/drivers/usb/usbip/usbip_common.h
> > @@ -277,6 +277,8 @@ struct usbip_device {
> >               void (*reset)(struct usbip_device *);
> >               void (*unusable)(struct usbip_device *);
> >       } eh_ops;
> > +
> > +        u64 kcov_handle;
> >  };
> >
> >  #define kthread_get_run(threadfn, data, namefmt, ...)                           \
> > diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> > index 266024cbb64f..b2eb3e8c04b9 100644
> > --- a/drivers/usb/usbip/vhci_rx.c
> > +++ b/drivers/usb/usbip/vhci_rx.c
> > @@ -260,8 +260,10 @@ int vhci_rx_loop(void *data)
> >       while (!kthread_should_stop()) {
> >               if (usbip_event_happened(ud))
> >                       break;
> > -
> > -             vhci_rx_pdu(ud);
> > +
> > +                kcov_remote_start_common(ud->kcov_handle);
> > +                vhci_rx_pdu(ud);
> > +                kcov_remote_stop();
> >       }
> >
> >       return 0;
> > diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> > index be37aec250c2..4dfe3809ebbb 100644
> > --- a/drivers/usb/usbip/vhci_sysfs.c
> > +++ b/drivers/usb/usbip/vhci_sysfs.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/net.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > +#include <linux/kcov.h>
> >
> >  /* Hardening for Spectre-v1 */
> >  #include <linux/nospec.h>
> > @@ -383,6 +384,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
> >       vdev->ud.sockfd     = sockfd;
> >       vdev->ud.tcp_socket = socket;
> >       vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> > +        vdev->ud.kcov_handle = kcov_common_handle();
> >
> >       spin_unlock(&vdev->ud.lock);
> >       spin_unlock_irqrestore(&vhci->lock, flags);
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
>
> Please run checkpatch.pl on your patches before sending them out, so you
> don't get grumpy maintainers telling you to run checkpatch.pl on your
> patch...

Hi Greg,

Sorry, I'll fix it up and send v2.

Thanks!
