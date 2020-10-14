Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297C628E3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJNPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJNPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:54:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69858C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:54:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so50026pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjTu1+t0tUfToQ8JcebZ+ZLiOhu8sxp8i2tJ0e1HE8I=;
        b=Ypo21mzRT76jgF/cryVhF6C/IijAKxuRRfG4WepUFjk2CFg++BHRNGkcdpcchfvCQS
         qTaJ34n9Z7oowskW0mZtwPH/CarAZIpdLmZW+QS7LlZikEAMxRoxbecLNjCs1sUnFbVH
         kBoMn3ciOnP1gSv5imf1WStGu3EwZMTHVcMSmlrvaXXpTiAUouzIQ4yIe2581Z/GG4sP
         77pBF1o5wDFXeaCTCtJag05fFn3ySOhOHUkYwpEq7IMfKppphbJLNIp7/v/7F9D9CQMO
         XDC7xzCtFF42n8s6T2j8ALJScHhz6tIWa9j9N/XoradLg70DLIzeqUGVRdmGOtOkXgwi
         PF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjTu1+t0tUfToQ8JcebZ+ZLiOhu8sxp8i2tJ0e1HE8I=;
        b=UMYO7Zq8ZwEkODkBZMZobUhJQdyNOQtMth5sgx5i7iwmp0VzSxqLwgwKFZyRmOy/Xu
         BDJ2f2U2/8/+TFboBHUiXzCiWdIg8DAxS7oDi26NCPluVXLCk29rok3VoeqZtH2htdzU
         gQ9JQZZHA+tlq9V7SHrxpwlJPZYOUYlwjKJA4veUuI6CBRasDdfUazZ2ykyWJuUbmRwI
         BJA+nyMIv5EoZL60gBWG9nZAJ0QPoNnMMMUqgpyS5rYPvw4qT2AUC7sP65u2wXfY5sKk
         mdP5btQygDQX34aggDwH9/kzq1RfXjz5Ind+5yLh0gJF0J+7OhfhZ8eiz7kXIkfGrYWL
         D74g==
X-Gm-Message-State: AOAM533yw6PjqoihgqrPgwof+SmNbxFQpg/Jk+HSurQ7uc2fwqcbEU0w
        4YjUEMaI2b7hx07Y0XY0bQCXBjpJwzPVyBZq7UajCw==
X-Google-Smtp-Source: ABdhPJxVoLBb8z7rqGnl0lHmLq7iGqzFZ/x3NKSgwuAHHyuILJrDnsnnBLxTRwrU6pzHMiNNgE+Fmue/sMY2m/TcuY0=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr91170pjb.166.1602690852727;
 Wed, 14 Oct 2020 08:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <c07a2deae7a75e394de272c1a33cfcc1f667af92.1602522185.git.andreyknvl@google.com>
 <dddca63c-088c-d87c-370f-e8f02d1b0d04@linuxfoundation.org>
In-Reply-To: <dddca63c-088c-d87c-370f-e8f02d1b0d04@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Oct 2020 17:54:01 +0200
Message-ID: <CAAeHK+zbq9K8mPusnzxxwBVi50Rb-WJfdmNVZmckLNJndmquXA@mail.gmail.com>
Subject: Re: [PATCH v2] kcov, usbip: collect coverage from vhci_rx_loop
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 7:28 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/12/20 11:10 AM, Andrey Konovalov wrote:
> > From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> >
> > Add kcov_remote_start()/kcov_remote_stop() annotations to the
> > vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> > coming into USB/IP client.
> >
> > Since vhci_rx_loop() threads are spawned per vhci_hcd device instance, the
> > common kcov handle is used for kcov_remote_start()/stop() annotations
> > (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> > can now be used to collect coverage from vhci_rx_loop() threads.
> >
> > Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> > ---
> >
> > Changes v1->v2:
> > - Fix spacing issues.
> > - Add ifdef CONFIG_KCOV around kcov_handle in usbip_device struct.
> >
>
> Does this compile without CONFIG_KCOV?
>
> > ---
> >   drivers/usb/usbip/usbip_common.h |  4 ++++
> >   drivers/usb/usbip/vhci_rx.c      |  3 +++
> >   drivers/usb/usbip/vhci_sysfs.c   | 12 +++++++-----
> >   3 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> > index 8be857a4fa13..0906182011d6 100644
> > --- a/drivers/usb/usbip/usbip_common.h
> > +++ b/drivers/usb/usbip/usbip_common.h
> > @@ -277,6 +277,10 @@ struct usbip_device {
> >               void (*reset)(struct usbip_device *);
> >               void (*unusable)(struct usbip_device *);
> >       } eh_ops;
> > +
> > +#ifdef CONFIG_KCOV
> > +     u64 kcov_handle;
> > +#endif
> >   };
> >
> >   #define kthread_get_run(threadfn, data, namefmt, ...)                          \
> > diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> > index 266024cbb64f..473f14587bd5 100644
> > --- a/drivers/usb/usbip/vhci_rx.c
> > +++ b/drivers/usb/usbip/vhci_rx.c
> > @@ -3,6 +3,7 @@
> >    * Copyright (C) 2003-2008 Takahiro Hirofuchi
> >    */
> >
> > +#include <linux/kcov.h>
> >   #include <linux/kthread.h>
> >   #include <linux/slab.h>
> >
> > @@ -261,7 +262,9 @@ int vhci_rx_loop(void *data)
> >               if (usbip_event_happened(ud))
> >                       break;
> >
> > +             kcov_remote_start_common(ud->kcov_handle);
>
> You are referencing kcov_handle defined in CONFIG_KCOV scope
> here. Does this compile for you without CONFIG_KCOV?
>
> >               vhci_rx_pdu(ud);
> > +             kcov_remote_stop();
> >       }
> >
> >       return 0;
> > diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> > index be37aec250c2..966f1f5cafb1 100644
> > --- a/drivers/usb/usbip/vhci_sysfs.c
> > +++ b/drivers/usb/usbip/vhci_sysfs.c
> > @@ -4,6 +4,7 @@
> >    * Copyright (C) 2015-2016 Nobuo Iwata
> >    */
> >
> > +#include <linux/kcov.h>
> >   #include <linux/kthread.h>
> >   #include <linux/file.h>
> >   #include <linux/net.h>
> > @@ -378,11 +379,12 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
> >       dev_info(dev, "devid(%u) speed(%u) speed_str(%s)\n",
> >                devid, speed, usb_speed_string(speed));
> >
> > -     vdev->devid         = devid;
> > -     vdev->speed         = speed;
> > -     vdev->ud.sockfd     = sockfd;
> > -     vdev->ud.tcp_socket = socket;
> > -     vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> > +     vdev->devid          = devid;
> > +     vdev->speed          = speed;
> > +     vdev->ud.sockfd      = sockfd;
> > +     vdev->ud.tcp_socket  = socket;
> > +     vdev->ud.status      = VDEV_ST_NOTASSIGNED;
> > +     vdev->ud.kcov_handle = kcov_common_handle();
>
> Don't change spacing for other variables. Add just the new
> code. Don't you need CONFIG_KCOV around this new code?

Yeah, this breaks without CONFIG_KCOV, my bad.

I'll fix everything and submit v3.

Thank you!
