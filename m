Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B77302D60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbhAYVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732499AbhAYVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:11:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D54221E5;
        Mon, 25 Jan 2021 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611609041;
        bh=Or1lBWhIl6RhblDUyDn8EaqaFsiiaspRZSUVLOdK22s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FC9OPJ6fbDxo9sIAGIaqpRzEYEiQYDJWCp094vh/XwDlKFTOKHWwgyOQRALzzdv6l
         x1ey31edZgpKfRHXMm4wtr2xc0Aig2eATuOC1q26p9lc8sMtxn1b3W14thnXl7c+yo
         JEyZl6a6+G2pZ2zp0aHXMXi9Oz+NiMJxPvw/enaLKL8vjJgGMt1A3uJfxBufMc8Xh4
         vfDB0uNWgh+Qjqw9pw0Veg8MGu8x+HUVQoTgIFx4xZJVLeVTudYpF2bAV9q+yK4Naw
         S7sLx7Qo+6QNkV474fc6gnc2ItjY0Jm0JmiDXqyMpL9J7fkBW4w2FtcTucbf86yIbK
         YB8ERf9LAC3tA==
Received: by mail-ot1-f52.google.com with SMTP id h14so14189628otr.4;
        Mon, 25 Jan 2021 13:10:41 -0800 (PST)
X-Gm-Message-State: AOAM5324XcoLQyFPxoAL94FdnQo94c2suoK9K1Qp8erG9jLayKyKAyJC
        jXVfMdBPkrPKh3giWh5Cel5/aUf1ljuJbk8Jo58=
X-Google-Smtp-Source: ABdhPJx85RBJtKdPvFQbtXYq4Zitdz57yxwULz+I5SV5UoWY2Mu7mKXU8P0C+eO/zadx+uWCAlDypuzteW/fMha1lJc=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr1753457otq.305.1611609040975;
 Mon, 25 Jan 2021 13:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20210125113248.2268952-1-arnd@kernel.org> <20210125162230.GA145777@rowland.harvard.edu>
In-Reply-To: <20210125162230.GA145777@rowland.harvard.edu>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Jan 2021 22:10:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3YkgW2fk9=YDgcVXgA6WHR9WfRdEPOyMeA1sc_Ck7AOw@mail.gmail.com>
Message-ID: <CAK8P3a3YkgW2fk9=YDgcVXgA6WHR9WfRdEPOyMeA1sc_Ck7AOw@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci-tegra: fix Kconfig depencies
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Jan 25, 2021 at 12:32:30PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Selecting the chipidea driver from the old Kconfig symbol
> > can lead to a missing dependency:
>
> Arnd:
>
> I found this whole patch a little confusing.  For example, in the
> sentence above, what does "the old Kconfig symbol" refer to?
>
> Comparing the various Kconfig files, I see what the problem is.  The
> commit which this one fixes made CONFIG_EHCI_TEGRA select
> CONFIG_USB_CHIPIDEA, but it didn't make EHCI_TEGRA depend on the things
> that USB_CHIPIDEA depends on.  Can you please state this more explicitly
> in the patch description?

Sure, I'll resend in a bit.

> > WARNING: unmet direct dependencies detected for USB_CHIPIDEA
> >   Depends on [m]: USB_SUPPORT [=y] && (USB_EHCI_HCD [=y] && USB_GADGET [=m] || USB_EHCI_HCD [=y] && !USB_GADGET [=m] || !USB_EHCI_HCD [=y] && USB_GADGET [=m]) && HAS_DMA [=y]
> >   Selected by [y]:
> >   - USB_EHCI_TEGRA [=y] && USB_SUPPORT [=y] && USB [=y] && USB_EHCI_HCD [=y] && ARCH_TEGRA [=y]
> > aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_handle_vbus_change':
> > otg.c:(.text+0x3c8): undefined reference to `usb_gadget_vbus_connect'
> > aarch64-linux-ld: otg.c:(.text+0x42c): undefined reference to `usb_gadget_vbus_disconnect'
> > aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_otg_work':
> > otg.c:(.text+0x5d4): undefined reference to `usb_gadget_vbus_disconnect'
> > ...
> >
> > Duplicate the dependency to ensure that this driver can
> > only be a loadable module if one of its dependencies is.
> >
> > Fixes: c3590c7656fb ("usb: host: ehci-tegra: Remove the driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/usb/host/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 160e5d3927e2..66b01b619ecd 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -269,6 +269,7 @@ config USB_EHCI_HCD_AT91
> >  config USB_EHCI_TEGRA
> >       tristate "NVIDIA Tegra HCD support"
> >       depends on ARCH_TEGRA
> > +     depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
> >       select USB_CHIPIDEA
> >       select USB_CHIPIDEA_HOST
> >       select USB_CHIPIDEA_TEGRA
>
> Isn't there at least one other missing dependency?  This entry selects
> USB_CHIPIDEA_TEGRA, which depends on OF.  So shouldn't this entry also
> depend on OF?  Or does the Kconfig system detect that for us?

Yes, there is a hard dependency on ARCH_TEGRA, which implies OF.

> Also, while I'm no expert on the Kconfig language, it seems that the new
> "depends" line could be a lot easier to understand if it was refactored
> with some comments added.  Yes, I realize you just copied the existing
> dependency from the USB_CHIPIDEA entry -- that one could stand to be
> cleaned up as well.
>
> For instance, how about putting the HAS_DMA part into a separate line,
> since it's unrelated to the other stuff?

Actually it's probably best to just drop the HAS_DMA here, as it is also
implied by ARCH_TEGRA.

>  And the rest looks like it
> could be changed to:
>
>         depends on USB_EHCI_HCD || USB_GADGET
>
> although that probably isn't quite valid.  Still, can't it be changed to
> something simpler than
>
>         (USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) ||
>                         (!USB_EHCI_HCD && USB_GADGET)

The problem is that if either USB_EHCI_HCD or USB_GADGET are loadable
modules, then USB_CHIPIDEA must not be built-in, but if one of the two is
disabled, we must still have a dependency on the other. I guess it could be
rewritten into

      depends on USB_EHCI_HCD || USB_GADGET  # needs at least one of the two
      depends on m ||  USB_EHCI_HCD!=m # must be =m if USB_EHCI_HCD=m
      depends on m ||  USB_GADGET!=m # must be =m if USB_GADGET=m

I see that USB_EHCI_TEGRA already depends on USB_EHCI_HCD,
so I think this collapses into a much simpler

      depends on USB_GADGET || USB_GADGET=n # for USB_CHIPIDEA

         Arnd
