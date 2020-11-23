Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E42C1985
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgKWXmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgKWXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:42:01 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD95C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:42:01 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so9674597plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddsFJ+jC1awuSgHzP7dGNCpw29K1ItTlp+tGgX4yqy8=;
        b=RxBpAIy2Vqdc59bVkBCgjz5eydkAmqUUZLGBOgWJ5O1xw2WzF9gU6qQgMl9Cbhg/eS
         Viw5cqcP9CdVJwXrxGAE3JI1IwkHazkkohS5ZpTt8WpgC7A6FFMephyDDe8tTvQWUl8h
         Gp1aZchWX6CfdDqftIkBQFEdLE9S5AXLGLOKsKdwtSkEVOV7wEJ11731K171iE7l+c9e
         GOdOaKScyTeMlSWLWlfz3Oam27uhH+GvNyG11I0CUbk7cKE1iNKUvVjCV15Ca9guAYhq
         zVA9oGsQdjj3CNYX7CcFL0IKgMAa5M6CgMkv7+EoI+2MNzPQD5ciUdTNSBBHNQzZA8EZ
         z0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddsFJ+jC1awuSgHzP7dGNCpw29K1ItTlp+tGgX4yqy8=;
        b=hoQIGzDB6HaX3KXfOvSYoNMjN3VwAcJ3yifrdSOud3yHryfXTD9LtbsbdRUgOQ/v+0
         zP2R+2kKmi+QvI5x6Sv6ZtSRtcrFy9us7Xw+IpnWvjU72Bu+jerqf5rIncnZ53ADWd2i
         mrihMUgep0YN3oGBwON90AIjS4rM3QsEU93/+vOIV37W6r5GyAKss4qa3WRRUAxpQVyQ
         xvWGtiiWXAkm1AqryT1OTxfIbQeuspl3BX4D4zSfEdK4MEIQ1g4liCBx91V9jlfbeqUA
         FWHZU68LmvRgv5Uy0zDxqXxR3+WgJC+bw9OvWXkf+Dy0azz5j/Y1rxNGVM3aV3IRavuK
         7F2A==
X-Gm-Message-State: AOAM533zT/mpZ43h57TyPUIpQAK6FaPylc2GmJ/oA/4ZLN05qe12TnO4
        D5aWplQp2oPBoWW2kU9ZPP2nNR0gZeP84AG4kTVdLg==
X-Google-Smtp-Source: ABdhPJzlHI/oEYOBmc2GrXSt1AUPO/4i8Dgx42F6jDr3wid1Ox40Ag7fVUufNRhAs4KT4PZgSaNOA9/Tw1fBPqCeXLE=
X-Received: by 2002:a17:902:8ec7:b029:d8:e603:304c with SMTP id
 x7-20020a1709028ec7b02900d8e603304cmr1422207plo.85.1606174920996; Mon, 23 Nov
 2020 15:42:00 -0800 (PST)
MIME-Version: 1.0
References: <e626ad10573bdc561c6f00667a31c87ee7725044.1603127827.git.andreyknvl@google.com>
 <ca9c83b0-364a-6a26-4539-e38373a455aa@linuxfoundation.org> <2ee45dd7-0735-fcbb-545c-352d9c5d8689@linuxfoundation.org>
In-Reply-To: <2ee45dd7-0735-fcbb-545c-352d9c5d8689@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 24 Nov 2020 00:41:50 +0100
Message-ID: <CAAeHK+zxNif7MgZ=HC9T8KjzzustFRkJ-aCpE_=x5ykLdKuZMg@mail.gmail.com>
Subject: Re: [PATCH v3] kcov, usbip: collect coverage from vhci_rx_loop
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 8:52 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/19/20 12:49 PM, Shuah Khan wrote:
> > On 10/19/20 11:20 AM, Andrey Konovalov wrote:
> >> From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> >>
> >> Add kcov_remote_start()/kcov_remote_stop() annotations to the
> >> vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> >> coming into USB/IP client.
> >>
> >> Since vhci_rx_loop() threads are spawned per vhci_hcd device instance,
> >> the
> >> common kcov handle is used for kcov_remote_start()/stop() annotations
> >> (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> >> can now be used to collect coverage from vhci_rx_loop() threads.
> >>
> >> Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >> ---
> >>
> >> Changes v2->v3:
> >> - Fix build without KCOV enabled.
> >>
> >> ---
> >>   drivers/usb/usbip/usbip_common.h | 4 ++++
> >>   drivers/usb/usbip/vhci_rx.c      | 7 +++++++
> >>   drivers/usb/usbip/vhci_sysfs.c   | 4 ++++
> >>   3 files changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/usb/usbip/usbip_common.h
> >> b/drivers/usb/usbip/usbip_common.h
> >> index 8be857a4fa13..0906182011d6 100644
> >> --- a/drivers/usb/usbip/usbip_common.h
> >> +++ b/drivers/usb/usbip/usbip_common.h
> >> @@ -277,6 +277,10 @@ struct usbip_device {
> >>           void (*reset)(struct usbip_device *);
> >>           void (*unusable)(struct usbip_device *);
> >>       } eh_ops;
> >> +
> >> +#ifdef CONFIG_KCOV
> >> +    u64 kcov_handle;
> >> +#endif
> >>   };
> >>   #define kthread_get_run(threadfn, data, namefmt, ...)               \
> >> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> >> index 266024cbb64f..68ec0aa64f69 100644
> >> --- a/drivers/usb/usbip/vhci_rx.c
> >> +++ b/drivers/usb/usbip/vhci_rx.c
> >> @@ -3,6 +3,7 @@
> >>    * Copyright (C) 2003-2008 Takahiro Hirofuchi
> >>    */
> >> +#include <linux/kcov.h>
> >>   #include <linux/kthread.h>
> >>   #include <linux/slab.h>
> >> @@ -261,7 +262,13 @@ int vhci_rx_loop(void *data)
> >>           if (usbip_event_happened(ud))
> >>               break;
> >> +#ifdef CONFIG_KCOV
> >> +        kcov_remote_start_common(ud->kcov_handle);
> >> +#endif
> >>           vhci_rx_pdu(ud);
> >> +#ifdef CONFIG_KCOV
> >> +        kcov_remote_stop();
> >> +#endif
> >>       }
> >
> > Let's move these into usbip_common.h as inline functions along
> > the line of
> >
> > #ifdef CONFIG_KCOV
> > usbip_kcov_remote_start_common(ud)
> > {
> >    kcov_remote_start_common(ud->kcov_handle);
> > }
> >
> > usbip_kcov_remote_stop_common(ud)
> > {
> >    kcov_remote_stop_common(ud->kcov_handle);
> > }
> > #else
> > stubs that do nothing
> > #endif

Sounds good, will mail a new version shortly. Sorry for a delay, I was
busy with other work.

> >
> >>       return 0;
> >> diff --git a/drivers/usb/usbip/vhci_sysfs.c
> >> b/drivers/usb/usbip/vhci_sysfs.c
> >> index be37aec250c2..e167b8a445ad 100644
> >> --- a/drivers/usb/usbip/vhci_sysfs.c
> >> +++ b/drivers/usb/usbip/vhci_sysfs.c
> >> @@ -4,6 +4,7 @@
> >>    * Copyright (C) 2015-2016 Nobuo Iwata
> >>    */
> >> +#include <linux/kcov.h>
> >>   #include <linux/kthread.h>
> >>   #include <linux/file.h>
> >>   #include <linux/net.h>
> >> @@ -383,6 +384,9 @@ static ssize_t attach_store(struct device *dev,
> >> struct device_attribute *attr,
> >>       vdev->ud.sockfd     = sockfd;
> >>       vdev->ud.tcp_socket = socket;
> >>       vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> >> +#ifdef CONFIG_KCOV
> >> +    vdev->ud.kcov_handle = kcov_common_handle();
> >> +#endif
> >
> >
> > Same here add a usbip_kcov_handle_init(ud)
> >
>
> btw - I am seeing bounces on handeharputlu@google.com address.

Hande is no longer at Google, so the email is no longer valid. I think
it makes sense to preserve the original email address in the patch.
