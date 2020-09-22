Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA74E274D23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIVXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:13:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35967 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:13:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so17241597otw.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGTx/Fj2zjNke6CRvCD9QIl8uae51LrS8iKAvA6PRAw=;
        b=DjrXCvQCehA1tMyNTo4eutnjicWIl8n7tQ1S4eZuP6O94XRFOShgMuPwO/7vRm9X7I
         qd1xYpGmBbzSeOu75FmB3K2mwGdd4elnxv5ARWYMul5YnsgkmJVgyzEfubDWdWypUb+X
         wvqu6dRLgLMXmWhWChUhzvv2kn8ZlVx5bP93tsy+5Y+4nrvbtxA5j4qkQOGCWmPXNdZ6
         zLsaI23bq4GaF3lIKMsLqtZ5uxVjnUtTPryeFuZXtR2h+jFDub9wGmzcE6FsPU9lF0vd
         eDfSKcdJesW4Y9f3qcI4Z1UCYeeVHTyt8f36qAUlYXxYBM48az58kjPYaFG/XVN02/cg
         JlYA==
X-Gm-Message-State: AOAM533qVoa7aAeZavAVYnUaYByHQHyRJ20Ktfxg2h+t8jWDlZAbDg4l
        qGjIw58RNMk+r/dAhIaxGYAa7OjcOE5JAQ==
X-Google-Smtp-Source: ABdhPJyDr/1F8jIQZfRcrqueIdwrGAExrftOA6h9E7ybdpa2G7NLQ6PY1LyviyuzgvHR5omxvLNTtA==
X-Received: by 2002:a05:6830:101:: with SMTP id i1mr4473157otp.300.1600816396176;
        Tue, 22 Sep 2020 16:13:16 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id l79sm7998263oih.41.2020.09.22.16.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 16:13:15 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id c13so22921785oiy.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:13:14 -0700 (PDT)
X-Received: by 2002:a05:6808:2d7:: with SMTP id a23mr3898652oid.51.1600816394656;
 Tue, 22 Sep 2020 16:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
 <4e008f0a-69da-d5c2-4dfc-ef8695e17f47@arm.com> <AM6PR04MB5413903EAAEDB2EED2E254C6F1210@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <caf01871-1c3d-bdf8-867d-daf7138966a8@arm.com>
In-Reply-To: <caf01871-1c3d-bdf8-867d-daf7138966a8@arm.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 22 Sep 2020 18:13:02 -0500
X-Gmail-Original-Message-ID: <CADRPPNQAqoFTMRBnq6WZ+jqO8LG4n5fPFxEEh4hF4h=k_D+cLQ@mail.gmail.com>
Message-ID: <CADRPPNQAqoFTMRBnq6WZ+jqO8LG4n5fPFxEEh4hF4h=k_D+cLQ@mail.gmail.com>
Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        tanveer <tanveer.alam@puresoftware.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:12 AM Ard Biesheuvel <ard.biesheuvel@arm.com> wrote:
>
> On 9/16/20 3:32 AM, Ran Wang wrote:
> > Hi Ard,
> >
> > On Tuesday, September 15, 2020 7:10 PM, Ard Biesheuvel wrote:
> >> Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
> >>
> >> On 9/15/20 1:06 PM, kuldip dwivedi wrote:
> >>> Add ACPI support in fsl RCPM driver. This is required to support ACPI
> >>> S3 state. S3 is the ACPI sleep state that is known as "sleep" or
> >>> "suspend to RAM".
> >>> It essentially turns off most power of the system but keeps memory
> >>> powered.
> >>>
> >>> Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
> >>> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> >>
> >> Why does the OS need to program this device? Can't this be done by
> >> firmware?
> >
> > This device is use to tell HW which IP (such as USB, SDHC, SATA, etc) should not be
> > clock gated during system enter low power state (to allow that IP work as a
> > wakeup source). And user does this configuration in device tree.
>
> The point of ACPI is *not* to describe a DT topology using a table
> format that is not suited for it. The point of ACPI is to describe a
> machine that is more abstracted from the hardware than is typically
> possible with DT, where the abstractions are implemented by AML code
> that is provided by the firmware, but executed in the context of the OS.
>
> So the idea is *not* finding the shortest possible path to get your
> existing DT driver code running on a system that boots via ACPI.
> Instead, you should carefully think about the abstract ACPI machine that
> you will expose to the OS, and hide everything else in firmware.
>
> In this particular case, it seems like your USB, SDHC and SATA device
> objects may need power state dependent AML methods that program this
> block directly.

The platform PM driver was created to support PM on systems without a
runtime PM firmware.   Even with PSCI firmware on later systems, there
is no standard interface to communicate the wakeup source information
directly from peripheral drivers to the PSCI firmware.  So we still
need this platform power management driver in kernel to deal with this
setup for non-ACPI scenarios.  From the code re-use perspective, I
think it is probably better to keep this generic implementation in
kernel instead of moving it to ACPI byte-code for each platform.

>
>
>
> > So implement
> > this RCPM driver to do it in kernel rather than firmware.
> >
> > Regards,
> > Ran
> >
> >>> ---
> >>>
> >>> Notes:
> >>>       1. Add ACPI match table
> >>>       2. NXP team members are added for confirming HID changes
> >>>       3. There is only one node in ACPI so no need to check for
> >>>          current device explicitly
> >>>       4. These changes are tested on LX2160A and LS1046A platforms
> >>>
> >>>    drivers/soc/fsl/rcpm.c | 22 +++++++++++++++++++---
> >>>    1 file changed, 19 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c index
> >>> a093dbe6d2cb..e75a436fb159 100644
> >>> --- a/drivers/soc/fsl/rcpm.c
> >>> +++ b/drivers/soc/fsl/rcpm.c
> >>> @@ -2,10 +2,12 @@
> >>>    //
> >>>    // rcpm.c - Freescale QorIQ RCPM driver
> >>>    //
> >>> -// Copyright 2019 NXP
> >>> +// Copyright 2019-2020 NXP
> >>> +// Copyright 2020 Puresoftware Ltd.
> >>>    //
> >>>    // Author: Ran Wang <ran.wang_1@nxp.com>
> >>>
> >>> +#include <linux/acpi.h>
> >>>    #include <linux/init.h>
> >>>    #include <linux/module.h>
> >>>    #include <linux/platform_device.h>
> >>> @@ -57,8 +59,13 @@ static int rcpm_pm_prepare(struct device *dev)
> >>>                             rcpm->wakeup_cells + 1);
> >>>
> >>>             /*  Wakeup source should refer to current rcpm device */
> >>> -           if (ret || (np->phandle != value[0]))
> >>> -                   continue;
> >>> +           if (is_acpi_node(dev->fwnode)) {
> >>> +                   if (ret)
> >>> +                           continue;
> >>> +           } else {
> >>> +                   if (ret || (np->phandle != value[0]))
> >>> +                           continue;
> >>> +           }
> >>>
> >>>             /* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
> >>>              * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
> >>> @@ -139,10 +146,19 @@ static const struct of_device_id rcpm_of_match[]
> >> = {
> >>>    };
> >>>    MODULE_DEVICE_TABLE(of, rcpm_of_match);
> >>>
> >>> +#ifdef CONFIG_ACPI
> >>> +static const struct acpi_device_id rcpm_acpi_match[] = {
> >>> +   { "NXP0015", },
> >>> +   { }
> >>> +};
> >>> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_match); #endif
> >>> +
> >>>    static struct platform_driver rcpm_driver = {
> >>>     .driver = {
> >>>             .name = "rcpm",
> >>>             .of_match_table = rcpm_of_match,
> >>> +           .acpi_match_table = ACPI_PTR(rcpm_acpi_match),
> >>>             .pm     = &rcpm_pm_ops,
> >>>     },
> >>>     .probe = rcpm_probe,
> >>>
> >
>
