Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4535322C542
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:36:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20322C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:36:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id o25so2902565uar.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VftDmbB8Ud1ZSQ0uFmjC2WhTXELW8gG/O7WqgzrTKnw=;
        b=dbCtzIDTe3syfkmmbXaYNDCU3VU6CNk3BbPQyI73ePoB9EvjCKfc+XS5/Kh9MEnAmK
         l6AqNBqwCq/spVUru270eMqgfF98cW9LYV5Fv+i1g567cHa4XJCD5BnYnMFt4O9KEsIS
         cRz6ZK3rxVp9bK4oZwAH7F6BKMq5zBAHt0jCalXSoLehb3j746eTPRU+60ns7/JPw9fX
         AvO3cULsej6kh8foYSh5Nb78j9V/j+EHEwG6e5nzWawoxK2H5jDrLRChIN0PBiTeSixU
         fhOtxd+VMZNxe6Sp733CN6WNLTzVHMleRXfcQ+5+80ZZmKrg7FC71ivfWm6b+f+m8mJ/
         wuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VftDmbB8Ud1ZSQ0uFmjC2WhTXELW8gG/O7WqgzrTKnw=;
        b=Dz/w0gvJ780r42GYB5ujx5h5PL8gsYUoPcis7Gp70YdUm6qLQ8i5EVeHn+YJ9bPYuZ
         kSFMfmYCXi4tr+fEpjL+Z9CxIXWhuSI0QERz6vsiuEDYs8d6NQ5MdWBpf5gOkiYrYaFr
         H6/Kj3NKlmfol8uoD6lUmRRarF8U6H7Wo+1XjGMvgl3ioOBpegxldaIF9D5w4JabpplT
         BnXIw+JvXXpRNzbAemC9SZNzHJVtjqbuho3oLVPwwQqTQmjFn7D0gyIjdcYiiCQWMZ7H
         7FawgH9kORAkxOPab9NE9a0A7ipT3mCeaXoYJIX9IYZFxMGJUiaKLa3VA83UkrPZpPTU
         XeYw==
X-Gm-Message-State: AOAM5325hLFIxQw4rbzN1QnowEh61O+E0hTYOPW///chJAhjpY6fbG2A
        Ld++Ks2Ff7kgBJBhI5TK5v+6ktVUHxnXWkfiijSQAg==
X-Google-Smtp-Source: ABdhPJw6n17wJnJYJRe9z13TI3lGRjCuFP0T3Mv69JWj8g6b5k1GzjYMTS94LNSYvjvN7XMu5HexynC5sfoYlUjmrwM=
X-Received: by 2002:ab0:4e98:: with SMTP id l24mr7911384uah.15.1595594161102;
 Fri, 24 Jul 2020 05:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110819.28965-1-benchuanggli@gmail.com>
 <CAPDyKFrvzZSYWkqD_JgZSCmF8p+Bj7JXfdbZ5D=OsszTPsSDdw@mail.gmail.com> <CACT4zj989TsK9CMtPwEVOwBr-HtLVqQyt_EPAdkEexGuGNfatQ@mail.gmail.com>
In-Reply-To: <CACT4zj989TsK9CMtPwEVOwBr-HtLVqQyt_EPAdkEexGuGNfatQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 14:35:24 +0200
Message-ID: <CAPDyKFqpy-+sL-8ai2v-Br1n8MC88u3wTF7r=8Lt3qyLwCxRKg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 02/21] mmc: core: UHS-II support, modify power-up sequence
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 13:11, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Ulf,
>
> On Fri, Jul 17, 2020 at 7:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >
> > On Fri, 10 Jul 2020 at 13:07, Ben Chuang <benchuanggli@gmail.com> wrote=
:
> > >
> > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >
> > > According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4.2=
0":
> > > - Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
> > > - chip_select is not used in UHS-II, used to return to the legacy flo=
w
> >
> > Thanks for pointing to the spec, but please explain why/what/how for
> > the change - as this helps me to review.
> >
> > I am going to stop commenting on each patch's commit message, beyond
> > this patch - as it seems the same comment applies to more patches.
> >
> > >
> > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  drivers/mmc/core/core.c      | 62 ++++++++++++++++++++++++----------=
--
> > >  drivers/mmc/core/regulator.c | 14 ++++++++
> > >  2 files changed, 56 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index 8d2b808e9b58..85c83c82ad0c 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -1315,33 +1315,51 @@ void mmc_power_up(struct mmc_host *host, u32 =
ocr)
> > >         if (host->ios.power_mode =3D=3D MMC_POWER_ON)
> > >                 return;
> > >
> > > -       mmc_pwrseq_pre_power_on(host);
> > > +       if (host->flags & MMC_UHS2_SUPPORT) {
> > > +               /* TODO: handle 'ocr' parameter */
> > > +               host->ios.vdd =3D fls(host->ocr_avail) - 1;
> > > +               host->ios.vdd2 =3D fls(host->ocr_avail_uhs2) - 1;
> > > +               if (mmc_host_is_spi(host))
> > > +                       host->ios.chip_select =3D MMC_CS_HIGH;
> > > +               else
> > > +                       host->ios.chip_select =3D MMC_CS_DONTCARE;
> > > +               host->ios.timing =3D MMC_TIMING_UHS2;
> >
> > If I understand correctly, the intent is to always try to initialize
> > the UHS-II interface/phy if that is supported. That doesn't seem
> > correct to me. What about if the SD card doesn't support UHS-II, then
> > we should use the legacy SD interface instead right?
>
> Please always try UHS-II I/F first, then if UHS-II I/F fails, then
> switch to SD I/F.
>
> >
> > Or perhaps the MMC_UHS2_SUPPORT bit becomes cleared somewhere in the
> > error path when first trying to initialize an UHS-II card, from
> > subsequent changes?
>
> Yes, MMC_UHS2_SUPPORT will be cleared in some cases.
>
> >
> > So, assuming that is the intent then, I am still not sure about this ap=
proach.
> >
> > What about if we instead always start with legacy SD initialization?
> > When we have read the OCR register, via mmc_send_app_op_cond(), we can
> > check if the card supports UHS-II by looking at the UHS-II Card Status
> > (bit 29).
>
> UHS-II spec recommends to detect UHS-II first.
> Or in Host controller spec, section 3.13.2 card interface detection seque=
nce,
> it also starts from UHS-II path, then go SD legacy path if UHS-II
> initialization fails.

I have carefully read the specs. While you are right, that the flow
charts seem to prefer to start with UHS-II - I don't think it's a good
idea.

Have a look at "7.2.3.2 Interface Selection after Power Up", in the
UHS-II Addendum Version 2.00. This section states this:

"If Host intends to use only Legacy SD interface or detects that
Legacy SD Card is inserted, it is allowed to supply only VDD1 and
SDCLK, and issue CMD8 in order to accelerate initialization of Legacy
SD interface. Note that once UHS-II I/F is disabled, Host requires
power cycle to enable UHS-II again."

That said, I am also concerned about the case when a bootloader has
initialized the SD card. When the kernel tries to re-initialize the
card during boot, it may fail with UHS-II - unless the legacy SD init
path is tried first.

>
> The bit29 in response of ACMD41 is defined as =E2=80=9CUHS-II Card Status=
=E2=80=9D,
> not UHS-II supported.
> We have experience using this value to determine whether a card supports =
UHS-II,
> but not every card reports if they support UHS-II by the response of
> ACMD41 correctly.

I see.

If that is the case, I think we should invent an SD quirk for that
particular card. Along the lines of what already exists for SDIO and
eMMC.

So, when a card with this kind of quirk is found, we should simply
bail out in the SD legacy init path and try the UHS-II path instead.

What card have you found missing to set the bit29?

>
> >
> > If it turns out that the card supports UHS-II and the host does as
> > well, then we do a mmc_power_off() to completely reset the
> > card/host/phy. Then we can call into a UHS-II specific path, that
> > tries to power on and initialize things according to the UHS-II spec.
> >
> > In this way, we are going to prioritize initialization of legacy SD
> > cards to remain quick, as we won't try to use UHS-II unless the card
> > supports it. Moreover, I get the impression that we can keep the
> > existing code more as is - and instead introduce UHS-II specifics in a
> > separate path. This also also for UHS-II specific optimizations, I
> > think.
>
> Agree that we can try to keep the existing code and also need your advice=
/help.

Sure, I will help the best I can.

I will have a look at the next patch in the series as well, but it may
take some time as I am currently trying to get some time off for
holidays.

>
> >
> > > +       } else {
> > > +               mmc_pwrseq_pre_power_on(host);
> > >
> > > -       host->ios.vdd =3D fls(ocr) - 1;
> > > -       host->ios.power_mode =3D MMC_POWER_UP;
> > > -       /* Set initial state and call mmc_set_ios */
> > > -       mmc_set_initial_state(host);
> > > +               host->ios.vdd =3D fls(ocr) - 1;
> > > +               host->ios.power_mode =3D MMC_POWER_UP;
> > > +               /* Set initial state and call mmc_set_ios */
> > > +               mmc_set_initial_state(host);
> > >
> > > -       mmc_set_initial_signal_voltage(host);
> > > +               mmc_set_initial_signal_voltage(host);
> > >
> > > -       /*
> > > -        * This delay should be sufficient to allow the power supply
> > > -        * to reach the minimum voltage.
> > > -        */
> > > -       mmc_delay(host->ios.power_delay_ms);
> > > -
> > > -       mmc_pwrseq_post_power_on(host);
> > > +               /*
> > > +                * This delay should be sufficient to allow the power=
 supply
> > > +                * to reach the minimum voltage.
> > > +                */
> > > +               mmc_delay(host->ios.power_delay_ms);
> > >
> > > +               mmc_pwrseq_post_power_on(host);
> > > +       }
> > >         host->ios.clock =3D host->f_init;
> > > -
> > >         host->ios.power_mode =3D MMC_POWER_ON;
> > > +
> > >         mmc_set_ios(host);
> > >
> > > -       /*
> > > -        * This delay must be at least 74 clock sizes, or 1 ms, or th=
e
> > > -        * time required to reach a stable voltage.
> > > -        */
> > > -       mmc_delay(host->ios.power_delay_ms);
> > > +       if (host->flags & MMC_UHS2_SUPPORT)
> > > +               /*
> > > +                * This delay should be sufficient to allow the power=
 supply
> > > +                * to reach the minimum voltage.
> > > +                */
> > > +               /*  TODO: avoid an immediate value */
> > > +               mmc_delay(10);
> > > +       else
> > > +               /*
> > > +                * This delay must be at least 74 clock sizes, or 1 m=
s, or the
> > > +                * time required to reach a stable voltage.
> > > +                */
> > > +               mmc_delay(host->ios.power_delay_ms);
> > >  }
> > >
> > >  void mmc_power_off(struct mmc_host *host)
> > > @@ -2307,7 +2325,11 @@ void mmc_start_host(struct mmc_host *host)
> > >
> > >         if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
> > >                 mmc_claim_host(host);
> > > -               mmc_power_up(host, host->ocr_avail);
> > > +
> > > +               /* Power up here will make UHS2 init ugly. */
> > > +               if (!(host->caps & MMC_CAP_UHS2))
> > > +                       mmc_power_up(host, host->ocr_avail);
> > > +
> >
> > According to my suggestions, then this would not be needed.
>
> This should not be needed. Thank you.
>
> >
> > >                 mmc_release_host(host);
> > >         }
> > >
> > > diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulato=
r.c
> > > index 96b1d15045d6..05556225d9ac 100644
> > > --- a/drivers/mmc/core/regulator.c
> > > +++ b/drivers/mmc/core/regulator.c
> > > @@ -247,6 +247,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc=
)
> > >
> > >         mmc->supply.vmmc =3D devm_regulator_get_optional(dev, "vmmc")=
;
> > >         mmc->supply.vqmmc =3D devm_regulator_get_optional(dev, "vqmmc=
");
> > > +       mmc->supply.vmmc2 =3D devm_regulator_get_optional(dev, "vmmc2=
");
> >
> > Please move the regulator thingy here into a separate patch. Please
> > make sure corresponding header file, adding the vmmc2 to it is part of
> > that change as well.
>
> Yes. will do it.
>
> >
> > >
> > >         if (IS_ERR(mmc->supply.vmmc)) {
> > >                 if (PTR_ERR(mmc->supply.vmmc) =3D=3D -EPROBE_DEFER)
> > > @@ -266,6 +267,19 @@ int mmc_regulator_get_supply(struct mmc_host *mm=
c)
> > >                 dev_dbg(dev, "No vqmmc regulator found\n");
> > >         }
> > >
> > > +       if (IS_ERR(mmc->supply.vmmc2)) {
> > > +               if (PTR_ERR(mmc->supply.vmmc2) =3D=3D -EPROBE_DEFER)
> > > +                       return -EPROBE_DEFER;
> > > +               dev_dbg(dev, "No vmmc2 regulator found\n");
> > > +       } else {
> > > +               ret =3D mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
> > > +               if (ret > 0)
> > > +                       mmc->ocr_avail_uhs2 =3D ret;
> > > +               else
> > > +                       dev_warn(dev, "Failed getting UHS2 OCR mask: =
%d\n",
> > > +                                ret);
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> > > --
> > > 2.27.0
> > >

Kind regards
Uffe
