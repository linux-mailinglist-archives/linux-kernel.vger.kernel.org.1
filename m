Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31E269EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIOGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgIOGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:52:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:52:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n13so1879859edo.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=WDvIeCQ5RNLVydHGn5T1WfslUcwOnqNb4dwmVb3HxMU=;
        b=zmuyaBNIhrB7oi9l06e0aMru/WX/PioNxQagCyIKdrkNm8wmGZdUjP409SYG+l44Qq
         tThAcADZ5COCZShsVpgEx2nHsLXbmexny4YCsUSYt6G1SpgjWrJKQ/OHHRXpvA2FenBb
         KllvVG+5Y41pONP+0Ykh65TaTyFdtsSkvuegXVKS1gyq23Tz8e8ndlABxVJdhRSahsty
         KlvQKI7MosiH4nAEGWl/CJpFAhDCItQeP5Meq2fn470R1Jc1HJgHQ6Sg2gvDaj6FBkqz
         FLBdCvTU2jPkPQwHC8bNO3KVKzgO2AKr4/A5WhKY5BaKKZuWVd55cGq4UMW/tXVVf6b4
         icPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=WDvIeCQ5RNLVydHGn5T1WfslUcwOnqNb4dwmVb3HxMU=;
        b=fwfDe6jACbgYOjkbQDCeVYKWzaLPwlLGfMDo4U5Nw/lotFnzkGrfOmfC2dQ+dPVPwb
         GePdwOk8GV3LkukjE6Bd5hHwvClabQB7g4ii4zx2IkSvTiZUCKNt/pddCKNJ/xoLRDFc
         UKA4smm7E//xFOnuPSgkBmyRjqNJMllhJZtk5pcm9CNxJ1kiaUjq1qPXXszkwxnoipjm
         +9viM9XvS4OdHkxErsCnV9yOoRkovs68JHJj5AGknSFOgo/vtVoTJruYlnfvvZVfdsm6
         0VDxPCV++4JMbpM7H2QorN3hEUXqzXdJNUIQ74X3WbVlViwDrjhOplrJ7MkNTCkCxu0p
         rG6g==
X-Gm-Message-State: AOAM532GhhlmvoF20OkFaKoRq+lbTTzuyIgMnnqQtrflyms6EmS7ZmA4
        XNvtTqlKimXdqcFpJsUEdF5XuspNdXTsoYuqip7Y7Q==
X-Google-Smtp-Source: ABdhPJyCxLAW+oKOPWHupiAXoLutdXJP8omET0+rAMsydsmRiqgllVTcfQMxKIM34kf/l0J8IV0ZSw1X9sOH9npj2VA=
X-Received: by 2002:a05:6402:b72:: with SMTP id cb18mr20308016edb.299.1600152737411;
 Mon, 14 Sep 2020 23:52:17 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <HE1PR04MB31962FC006C6EB964AC2DAE895240@HE1PR04MB3196.eurprd04.prod.outlook.com>
 <20200911123428.GF4895@sirena.org.uk> <HE1PR04MB31961146633F7FE9EFE441A795240@HE1PR04MB3196.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB31961146633F7FE9EFE441A795240@HE1PR04MB3196.eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK/xI2P7uxCBV5mjF/xjkF3M143zQKAOUTHAVgUksMCVmnJ7KdlWOrw
Date:   Tue, 15 Sep 2020 12:22:17 +0530
Message-ID: <6b704e53b0f31a2a74b35e477a330aac@mail.gmail.com>
Subject: RE: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ashish Kumar <ashish.kumar@nxp.com>
> Sent: Friday, September 11, 2020 7:03 PM
> To: Mark Brown <broonie@kernel.org>
> Cc: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>; Ard Biesheuvel <Ard.Biesheuvel@arm.com>; Samer
El-
> Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>; Paul Yang
> <Paul.Yang@arm.com>
> Subject: RE: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
>
> Hi Mark,
>
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Friday, September 11, 2020 6:04 PM
> > To: Ashish Kumar <ashish.kumar@nxp.com>
> > Cc: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>; Yogesh Gaur
> > <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> > <arokia.samy@nxp.com>; Ard Biesheuvel <Ard.Biesheuvel@arm.com>; Samer
> > El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>; Paul Yang
> > <Paul.Yang@arm.com>
> > Subject: Re: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
> >
> > On Fri, Sep 11, 2020 at 12:28:47PM +0000, Ashish Kumar wrote:
> > > > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> >
> > > Please capture version change summary.
> > >
> > > Regards
> > > Ashish
> >
> > It's there:
> It did not mentioned about removing SWRST, which was present in v1.
> v2:Notes Looked very similar to v1.
Removed SWRST changes just to keep functionality same in ACP and DT mode,
I will post that change separately if It will be required. For tracking I
am adding this
point in notes
>
> Regards
> Ashish
> >
> > > >
> > > > Notes:
> > > >     1. Add ACPI match table, NXP members are added to confirm HID
> > > > for
> > FSPI
> > > >     2. Change the DT specific APIs to device property APIs
> > > >            so that same API can be used in DT and ACPi mode.
> > > >     3. Omit clock configuration part - in ACPI world, the firmware
> > > >            is responsible for clock maintenance.
> > > >     4. This patch is tested on LX2160A platform
5.  SWRST reset changes are removed from v1 as to keep functionality
same in ACP and DT mode, I will post that change separately if It will be
required
