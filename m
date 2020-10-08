Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C774287CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgJHUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgJHUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:00:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA2C0613D2;
        Thu,  8 Oct 2020 13:00:18 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so6988069ilt.6;
        Thu, 08 Oct 2020 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3Mr8+U+4/KGRAdQE+aircAGaTvbmEC+LOyr0gmrcjw=;
        b=EOFo+tbUFaNIgTKD3WnUp8ygdSni+FCHgiZkMXo1r2RkRuPU7L1mBAOUT9r7PezSYM
         0iD9ckYiLMGYe3xtuM4SOuQtxQIGmTyDDE76rC+OszaZS2H4Q5SgPe7bqQu96je8mOvo
         U4iZb3otd4YuRowitUVnk1zYY+fuZYLKSMlKaGBvj1PjKJfY9fPdKh0nzbtF+s22YwQH
         zhDDMJhfhBXKcyQYdlLGBhGF+DwXuVjvdkZtNRESlQp3oTJRqHjooWX/UmFF78H0DrZk
         QLROP7hoGTfLsH2Jqhxq4Jz1+XqSM6d/Fw3/054EhDcGLgVC8AZjGqcYb8ayqHUYPYOA
         z6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3Mr8+U+4/KGRAdQE+aircAGaTvbmEC+LOyr0gmrcjw=;
        b=CLhR65jSxAJ3zjli33vNa83bPk57s74U04k0/rMbomTRA0mx083LNgBJQlIPjdTn8Q
         xXiIVF2vdrVJQAlkGzVFd6PSSwGKtPwifirZzwEZTmlYZ4ssj0kQGJhs/s+Cq1OxIydL
         6P8s2LsePz4r6/i2AXey2BNofs6sX70Spztp2eGwo+OWAf63Bn4NuJxN6RCpX+5UaTcM
         C/n9H+fwTdb/InnmyZ9OKWoO8w5qpSzXJGBh5eRXWtmq0e6EP9gZrX7CzOmP+B3BiBFf
         g8yKnloYk+XeEopTPa8tMWXjGEQ4XAKyrEewIOi6+6z0In2QGPtG4WBviY0vTA7O4gJG
         yVFg==
X-Gm-Message-State: AOAM533vUDG8WJs/VgonJ89yBNcQ4la7ik6oOVVImmBbPg0+yXbTeA9D
        aIsMMnMeFzJa1Z2R8TSo2JaHZk1x0rfkK3qpgN4=
X-Google-Smtp-Source: ABdhPJxsN4aGj0K4AWunsp9MnG6H64zCW0kZ+MeZ2RyBLlOHCZz5CM0+v1SO72hmYyUj0BqDaHwC54Cn/S6suZD2KG8=
X-Received: by 2002:a92:484e:: with SMTP id v75mr8048490ila.293.1602187217274;
 Thu, 08 Oct 2020 13:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201003092001.405238-1-peron.clem@gmail.com> <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
 <CAJiuCcfydz4GS3fUTampBLkDC4f6xVWmRpSRJ55TiDStdRCFmA@mail.gmail.com> <20201008151022.ryhijbj42y7kgzvb@gilmour.lan>
In-Reply-To: <20201008151022.ryhijbj42y7kgzvb@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Oct 2020 22:00:06 +0200
Message-ID: <CAJiuCcf8rk4t2GrS3+ANEuCtRmXoCMyzP+-x_rKrAfR-FaMaWA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Adding linux-sunxi and Jernej Skrabec to this discussion.

On Thu, 8 Oct 2020 at 17:10, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Mon, Oct 05, 2020 at 08:47:19PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi Cl=C3=A9ment,
> > >
> > > On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Sunxi MMC driver can't distinguish at runtime what's the I/O voltag=
e
> > > > for HS200 mode.
> > >
> > > Unfortunately, that's not true (or at least, that's not related to yo=
ur patch).
> > >
> > > > Add a property in the device-tree to notify MMC core about this
> > > > configuration.
> > > >
> > > > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink =
GS1 board")
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > index 049c21718846..3f20d2c9bbbb 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > @@ -145,6 +145,7 @@ &mmc2 {
> > > >       vqmmc-supply =3D <&reg_bldo2>;
> > > >       non-removable;
> > > >       cap-mmc-hw-reset;
> > > > +     mmc-hs200-1_8v;
> > > >       bus-width =3D <8>;
> > > >       status =3D "okay";
> > > >  };
> > >
> > > I'm not really sure what you're trying to fix here, but as far as MMC
> > > goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up un=
til
> > > HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed mo=
des
> > > (HS200 and HS400) supporting 1.8V and 1.2V.
> >
> > Some users report that the eMMC is not working properly on their
> > Beelink GS1 boards.
> >
> > > The mmc-hs200-1_8v property states that the MMC controller supports t=
he
> > > HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set up=
 at
> > > 1.8V then otherwise, the MMC core will rightfully decide to use the
> > > highest supported mode. In this case, since the driver sets it, it wo=
uld
> > > be HS-DDR at 3.3V, which won't work with that fixed regulator.
> > >
> > > I can only assume that enabling HS200 at 1.8V only fixes the issue yo=
u
> > > have because otherwise it would use HS-DDR at 3.3V, ie not actually
> > > fixing the issue but sweeping it under the rug.
> > >
> > > Trying to add mmc-ddr-1_8v would be a good idea
> >
> > Thanks for the explanation, this is indeed the correct one.
> > So It looks like the SDIO controller has an issue on some boards when
> > using HS-DDR mode.
> >
> > Is this patch acceptable with the proper commit log?
>
> If HS-DDR works, yes, but I assume it doesn't?

After discussing with Jernej about this issue, I understood that:
- Automatic delay calibration is not implemented
- We also miss some handling of DDR related bits in control register

So none of H5/H6 boards should actually work.
(Some 'lucky' boards seem to work enough to switch to HS200 mode...)

To "fix" this the H5 disable the HS-DDR mode in sunxi mmc driver :
https://github.com/torvalds/linux/blob/master/drivers/mmc/host/sunxi-mmc.c#=
L1409

I'm not sure about A64 but it looks like the property "mmc-hs200-1_8v"
for the PineBook shows the same issue.

The proper way would of course be to implement the missing feature
mentioned above.
But this could take some time and as the eMMC driver is actually
broken wouldn't it be better to disable the HS-DDR for H6 in the mmc
driver like it's done for H5 ?

Regards,
Clement

>
> Maxime
