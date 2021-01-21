Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E32FEBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbhAUNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbhAUN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:28:15 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4EEC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:26:29 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id d23so503820vkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rf1qKfSAnHAbgFgODbsvDUcmat4RodOPJkqQcCf2Woo=;
        b=T97ehu1rk5uA0WZ+CdJ0MAe4iMMeCR0gBWgjDQVjb8wLOrxE1kEuX0B7y0udkEwOfH
         ievh1lJbEOcF5tomDF2bAWCnTYAThZjJay4CXcJ0bds9Z5u6vzMLdlx/9hQTlHoVIpRn
         FhhfGFJedS1swKUrQcU0ZeDOuIuH+jAuAaaqjqKbsa6Yg1NVrO1bJKCam8IMxOxGdsQR
         Rj/Nj1PkVlW+djkp8KtIMIO25Q+lVIxSYkBwEJ60XQOrjfiZk/E0X/2CUQP3EdmFu110
         W6fT6f/VJITSZ/vkt9qvl9mDGZqPOVQBMt1nk/ssLGwySkaeWF6pLQ+TBp7ZSNKlinPq
         +HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rf1qKfSAnHAbgFgODbsvDUcmat4RodOPJkqQcCf2Woo=;
        b=eXYnzAQNzU9nqdTIN2BeTQzDeextK2k+6flTvJI7INr+lL3Z1zBF/9LUzWZr43toGB
         D56pvUn4bjxRmUDUmSlmT8D88QR3fTzj+ZJUkYkUDZdUGm/0xdq1WLSy0FZS25CQKxoW
         L6hBETeiIfUBkPKaoCdSlUyv4aSMF8ufctjFTBSYIwzfCLghj2F0cYYa+2vNjWOqDU29
         AbCPEvHri1fWuTUeuFsxqbMsSn9EMCa05SRIpI3VDmgRei8EhcsIyNCr3Wdqqj4j9itY
         ab9GflsEEFiXMtN1loOBaiOr9wpjm7S5Ypua3w4uF0vgmIWexjFCgof2oWD+xpHz7hKx
         fCHg==
X-Gm-Message-State: AOAM532mx518pb9gAo8dhlMIIBJjhWd6yQ862j2Z1YeoJdAfw8UQlZRc
        F/ejo8RYtNJD+rTHn+FCtofavxcHJHh2sO9DmejtM5DXsva0LzMQ
X-Google-Smtp-Source: ABdhPJzOhzm6qoqtQhm6w1t4sBwg8GnWZKRJ/ZnZDG4y0uPCJ/DDG3kVxkPedLlZqB9dMpdp1Zo06lcHuxUSgxNBuEQ=
X-Received: by 2002:a1f:aecb:: with SMTP id x194mr870066vke.6.1611235588136;
 Thu, 21 Jan 2021 05:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com> <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jan 2021 14:25:51 +0100
Message-ID: <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
To:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fabio, Haibo

On Thu, 21 Jan 2021 at 10:54, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wr=
ote:
>
> Hi
>
> >Are you sure this is an eMMC problem and not a mmc host driver issue?
>
> >Can you elaborate more what happens?
>
> When I use the mkfs.f2fs tool to format the eMMC file system on the imx8q=
xp board,
> because mkfs.f2fs will use secdiscard first, when entering mmc_blk_issue_=
secdiscard_rq erase,
> once the parameters are passed into MMC_SECURE_TRIM1_ARG, this function w=
ill take a long time to return .
> The program has not ended, has been in TASK_UNINTERRUPTIBLE state.
>
> I compared the mkfs.ext4 tool to format the file system. Because it direc=
tly uses mmc_blk_issue_discard_rq,
> this is a normal formatting phenomenon.
>
> mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq are just differe=
nt commands and parameters sent by the host as a bus.
>  I did not see the description of trim in the data sheet. Could the host =
driver cause this problem?

Yes, it can - and we have had issues like these before. So before
adding a card quirk, I think we need to make sure this isn't the case.

When using MMC_SECURE_TRIM1_ARG, it's very likely that the request
takes longer to complete.

The mmc host is responsible for either dealing with busy detection
with the help of its HW/controller - or if that can't be supported,
the mmc core falls back to polling the card for busy with a CMD13.

See mmc_do_erase() in /drivers/mmc/core/core.c

>
> Note:
> The host driver I use is sdhci-esdhc-imx.c

Alright, I have looped in Fabio and Haibo that knows this driver,
let's see if they can help.

>
> Thanks
> Xiaolei

Kind regards
Uffe

>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, January 20, 2021 9:41 PM
> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> Cc: Pali Roh=C3=A1r <pali@kernel.org>; Lee Jones <lee.jones@linaro.org>; =
linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.ker=
nel.org>
> Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
>
> [Please note this e-mail is from an EXTERNAL e-mail address]
>
> On Mon, 18 Jan 2021 at 05:27, Xiaolei Wang <xiaolei.wang@windriver.com> w=
rote:
> >
> > R1J57L mmc chip hw capibility indicates that it supports trim
> > function, but this function does not work properly, the SDIO bus does
> > not respond, and the IO has been waiting so set quirks to skip trim
>
> Are you sure this is an eMMC problem and not a mmc host driver issue?
>
> Can you elaborate more what happens?
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
> >  drivers/mmc/core/quirks.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index d68e6e513a4f..63e02391c133 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_=
fixups[] =3D {
> >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> >         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quir=
k_mmc,
> >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk=
_mmc,
> > +                 MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> >
> >         /*
> >          *  On Some Kingston eMMCs, performing trim can result in @@
> > -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fi=
xups[] =3D {
> >                   MMC_QUIRK_TRIM_BROKEN),
> >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_qui=
rk_mmc,
> >                   MMC_QUIRK_TRIM_BROKEN),
> > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk=
_mmc,
> > +                 MMC_QUIRK_TRIM_BROKEN),
> >
> >         END_FIXUP
> >  };
> > --
> > 2.25.1
> >
