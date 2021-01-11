Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AC2F0D99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAKIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:05:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEB6A22AAD;
        Mon, 11 Jan 2021 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610352311;
        bh=02v3tzqN9AzUV/0Va6HZhKJjrBRDGhuHYnwmkekIVnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mkTG3f/NF0dxGlMO5dJ2Jk3U01ihAxH/IDXNRhPmf+4iO4s/H+NOZ6jomrunpHE96
         LN9TKFPcYs0u+67CTArn0VsEQN68956SI/BAJ2XhNefnk1Wzq2eu+LjUJDGREARed/
         B1SFuGyPz8JucdQkgdeYDfu+o/pIKEQxHRyn4fYY1cqvR9pw2UrZ2gTpYJ5MEgfhb3
         Ju16J2nD7KI2KZWOwd3aOxjDxxbGN0Yawc3Nc430aN9O+3bI9OJBKfQBkSThTZzEl+
         4EtGHCIqSsy8ahSPqq6LlRRs1j9vSx9KdA9NSQoEreRTZfAO0yi6MR4aw4cniewj97
         L+GL3UKnvMUDw==
Received: by mail-lj1-f181.google.com with SMTP id n11so2503267lji.5;
        Mon, 11 Jan 2021 00:05:10 -0800 (PST)
X-Gm-Message-State: AOAM530sy+cZHQgLqQdSse/FMbybflbbKqLubnpXy7+2DMuHAw3zDHZT
        zYJEyoaXGD60rk2L7tHzIBOwsuWocIT34VIfSCU=
X-Google-Smtp-Source: ABdhPJwj85ZDfKme11UV/Voov4qWAa0P4jY5FCrsPJxXgJJEtzRu1NCCT5US+jtHkig72ciC9xKAgmf5Ha4C3FrHnos=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr7297395ljz.74.1610352308850;
 Mon, 11 Jan 2021 00:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20210110035846.9155-1-wens@kernel.org> <2241380.NG923GbCHz@diego>
 <CAGb2v67h3v4DdEY68BmHy263=L1tB0DuJnf_exHrLi57SiRjUA@mail.gmail.com> <2633022.BEx9A2HvPv@diego>
In-Reply-To: <2633022.BEx9A2HvPv@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 11 Jan 2021 16:04:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v678BgP_23oz+XMzw5B0U2hBy_fW9VK9mvVVhoXqchJmTg@mail.gmail.com>
Message-ID: <CAGb2v678BgP_23oz+XMzw5B0U2hBy_fW9VK9mvVVhoXqchJmTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 3:50 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 11. Januar 2021, 04:27:47 CET schrieb Chen-Yu Tsai:
> > On Mon, Jan 11, 2021 at 4:06 AM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Hi,
> > >
> > > Am Sonntag, 10. Januar 2021, 16:37:15 CET schrieb Chen-Yu Tsai:
> > > > > > +     vcc_sd: sdmmc-regulator {
> > > > > > +             compatible =3D "regulator-fixed";
> > > > > > +             gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> > > > > > +             pinctrl-names =3D "default";
> > > > > > +             pinctrl-0 =3D <&sdmmc0m1_pin>;
> > > > >
> > > > > > +             regulator-boot-on;
> > > > > > +             regulator-name =3D "vcc_sd";
> > > > >
> > > > > regulator-name above other regulator properties
> > > >
> > > > That is actually what I was used to, but some other rockchip dts fi=
les
> > > > have all the properties sorted alphabetically. So I stuck with what=
 I
> > > > saw.
> > >
> > > I try to keep it alphabetical except for the exceptions :-D .
> > >
> > > regulator-name is such an exception. Similar to compatibles, the
> > > regulator-name is an entry needed to see if you're at the right node,
> > > so I really like it being the topmost regulator-foo property - just m=
akes
> > > reading easier.
> > >
> > > (same for the compatible first, then regs, interrupts parts, as well
> > > as "status-last")
> > >
> > > But oftentimes, I just fix the ordering when applying - but seem to h=
ave
> > > missed this somewhere in those "other Rockchip dts files" ;-) .
> >
> > I was slightly confused. I looked again and yes regulator-name is alway=
s the
> > first regulator related property. What's off is that in some cases min/=
max
> > voltage comes before always-on/boot-on, and in others vice versa.
> >
> > For example in the Rock64 and ROC-RK3328-CC device trees, in the fixed
> > regulators, always-on/boot-on come before min/max voltage, while in the
> > PMIC the other order is used.
>
> That's likely undecidednes on my part ;-)
>
> There could be an argument for a "name, voltages, flags" sorting, but on
> the other hand just keeping it alphabetical with the naming on top
> creates less special cases.

And min before max? :D
