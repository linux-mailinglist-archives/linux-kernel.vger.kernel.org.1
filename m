Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34E329070B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408746AbgJPOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408737AbgJPOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:18:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CCC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:18:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n9so1533421pgf.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NhDInpW1iBikeTa4E3fQ1xw/szHYX7nD+T6Eo5XuV8=;
        b=qetqLy2ITeJhMctzuRBOHZPup1bhJ4dpeQxx5CjJQ33nbh/txTQarwnaKmhXNX6dwN
         RkjjZwmcqgxYz/AaglPMeKEpUKS/t9R5vt0T2Dv8DNiJL8yDlywYE5+Cbglqvcn0Op2U
         Lyb8iKfVgZHU4QB82hg8Icy+brJZwQLiJ6UeVKibTDbBRYJ/JQ+StmPFsrLxfB8fzYcn
         /gUeZCF4mfDyS+aD7peTERuePcPaIfssbbnPa8IwIp/Ln/Gf9YkHZcwbjN3f5MpdA0fP
         TOH3K8eO70oDqcVbs6cPkDhGTXxSMSL/7NTcEl97AHDkCv/Cai2GHWz6a+AtIDrPz9wX
         dg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NhDInpW1iBikeTa4E3fQ1xw/szHYX7nD+T6Eo5XuV8=;
        b=TeWKHF+TNlUbOTD3UInkm8kzCF9oEPMWRRaYeeZj9OC/1VdoVraNMNf+Yo1Jil33/B
         NPJ568hYc6Dt+YtEDdNK7X7XQeteDXUsQCST2sFgpeM9K28wdd7LYFmmb2lMQkJMvMuN
         feJ9Y015PKQBIGqMwdu3HBFteJ5XpIhFL26b2n/Lm7ujWo9bgx/MFptyStolL9j+6Y7h
         snX9xWpDagZDarecVpWSSYKtqfVY33D8vrPp0HqA4Mm8ZEUmjCoJNLvEOkI5XiKp6GkX
         6w9Q4AT+AJt7uTyqk5suOeQVkR2UWRlZfsf3D8vzWdj26h758ATz3koFhQMDhxqVcwsB
         Fcmw==
X-Gm-Message-State: AOAM5330VFUsNgKCBG8AaE486XfkTuakBF3q2mZ7t/SoIJsB/60Ofm1Y
        RqzqWhzL+g7BIU9hnDygAwKgxSOQhGATwOBu/HNxbA==
X-Google-Smtp-Source: ABdhPJwDzYxUiG1nfH61t2+7V8ocz2R2c5m9j6wPWeA63DersAnWdOBpBhERgsjRfGKoF3ioVTT8q8XsuTBLPgTwgyY=
X-Received: by 2002:a63:5d07:: with SMTP id r7mr3363475pgb.440.1602857905600;
 Fri, 16 Oct 2020 07:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <c07a2deae7a75e394de272c1a33cfcc1f667af92.1602522185.git.andreyknvl@google.com>
 <dddca63c-088c-d87c-370f-e8f02d1b0d04@linuxfoundation.org>
In-Reply-To: <dddca63c-088c-d87c-370f-e8f02d1b0d04@linuxfoundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 16:18:14 +0200
Message-ID: <CAAeHK+zdH0WqihL-394p88VM8tkMztdagR=_KuOSwteEdLsFgg@mail.gmail.com>
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

Hi Shuah,

We could have this field always defined, which allows us to not check
CONFIG_KCOV in the places where it's used (this is what we do for
vhost; the kcov functions will be optimized away). Or we could keep
the ifdef CONFIG_KCOV check here, and then add the same checks to
other places.

What would be your preference here?

Thanks!
