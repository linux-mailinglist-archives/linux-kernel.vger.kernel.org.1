Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A32A67F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgKDPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgKDPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:42:17 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDAC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:42:16 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id b3so11705697vsc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/FtdeSUhs74nhRFArqfFNBt0MhUao+F2IwHVVHi0aS0=;
        b=R2E/Db42MGI+YnyGlaOGsgu2dpWlTR02Cg/FLj+Kp3JW23/91+RSpJo6HIb2Vd2OxD
         UhNWS7AO+DC76rP5D8KfB+CIk1uhYDJJ6pcTAwzO6R7MNOTDwKRNW11SbspmVk4xCsEn
         47OyYvCfBw3qGLbqq+IDebwZRM8ydfmrcxmdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/FtdeSUhs74nhRFArqfFNBt0MhUao+F2IwHVVHi0aS0=;
        b=UiWouJ2lACzDLuMYZP30PxRUidOoxZaRzo4bUS/4qOXDqkMevKjhQdnSObcWRq/RAZ
         /gWuljGMVNpiV/DL1L3vQef/jNN47kFmVt+QgcpKB3XrtdDXc5QXP2tHj29wlKliHdWF
         Qm1ZklP/NyDd1WsAZeOekXqcSjo7IBX+2+gGg9ioryEqCxQWpo8RXIpxTHIVbS6bK7IT
         wVGHu6fDaBWCC4C3zAe35D/hCUxQi4a/tkEqxRjv7swXGOCJ8CK47XJ4ss4qMT17fnTn
         tslkYdueorW8/dzx74nc7G8plS+V/4Az78gnPsXAqu1UBLaE98C0wBHNpFcotmuRRWih
         VqMA==
X-Gm-Message-State: AOAM532XLBURN1Ep1NoQaSYgTUAhZsqluX9yN1ZqJfQVFU3XZK4O8CHa
        jw/Ut8mOpsRbWuWvR5n6hmoLBriqcwxI0Q==
X-Google-Smtp-Source: ABdhPJx/LF/XcGeh61tconqfDSKAnbKM5lXL4Ryek2GP5DLpBjX9Ya/Fz7EQMFMs26DeCLzpd9d/yg==
X-Received: by 2002:a67:f8d3:: with SMTP id c19mr15467438vsp.36.1604504534916;
        Wed, 04 Nov 2020 07:42:14 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id i3sm307140vkp.6.2020.11.04.07.42.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:42:14 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id b3so11705631vsc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:42:14 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr8004994vsp.37.1604504533670;
 Wed, 04 Nov 2020 07:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20201104094950.2096-1-m.reichl@fivetechno.de> <4984701.vSXMUKeAfh@diego>
In-Reply-To: <4984701.vSXMUKeAfh@diego>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Nov 2020 07:42:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2Vv0bv-exiZ6VrOtfMM5TVpjATO04qaXeGWDRu+6vyw@mail.gmail.com>
Message-ID: <CAD=FV=V2Vv0bv-exiZ6VrOtfMM5TVpjATO04qaXeGWDRu+6vyw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices
 on rk3399-roc-pc boards.
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 4, 2020 at 2:51 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Markus,
>
> Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
> > Recently introduced async probe on mmc devices can shuffle block IDs.
> > Pin them to fixed values to ease booting in evironments where UUIDs
> > are not practical. Use newly introduced aliases for mmcblk devices from=
 [1].
> >
> > [1]
> > https://patchwork.kernel.org/patch/11747669/
> >
> > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm=
64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > index e7a459fa4322..bc9482b59428 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > @@ -13,6 +13,11 @@ / {
> >       model =3D "Firefly ROC-RK3399-PC Board";
> >       compatible =3D "firefly,roc-rk3399-pc", "rockchip,rk3399";
> >
> > +     aliases {
> > +             mmc0 =3D &sdmmc;
> > +             mmc1 =3D &sdhci;
> > +     };
> > +
>
> Any reason for this odering?
>
> I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
> This is also true for the ChromeOS out-of-tree usage of those, the
> rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc, sdi=
o.
>
> And I guess a further question would be when we're doing arbitary orderin=
gs
> anyway, why is this not in rk3399.dtsi ;-) ?

Though I personally like the idea of eMMC, which is typically
built-in, as being the "0" number, I'm personally happy with any
numbering scheme that's consistent.  Ordering them by base address is
OK w/ me and seems less controversial.  That seems like it could go in
rk3399.dtsi and then if a particular board wanted a different order
they could override it in their board file.  The downside of putting
in rk3399 is that boards that don't have all SD/MMC interfaces enabled
would definitely get a new number compared to old kernels, but
hopefully this is the last time?

-Doug
