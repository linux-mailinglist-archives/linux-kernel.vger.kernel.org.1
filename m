Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24842F0B73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbhAKD2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbhAKD2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:28:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD28722582;
        Mon, 11 Jan 2021 03:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610335678;
        bh=+IJTwQXfUOjC47u3kJJ5xfioClx6iqnW8AtMz/ilyYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vC+/XqIJpviNUrUgBE6aZgLlbGuNmDDdRdyzRc44p99jaV1ErK3vfllXWOtzCBDSA
         gkz/SzSSw1zMvtuuuhIkivIpjAoBMmCy5AoehqhOzMpg4lzeikQZ7hY8F/oSuEAdQS
         Tq9R/mdDBaX7eOEhMeBImcaTZOYkzcjspOGbnkigWAWiZyIZZHOfxIHOCJ7+LZmQ4W
         3qO0ZNnelSM+wBh0t5bvQzJxmnYFwdjJqmxPt5S2XLbQcjs/ZhwDBzaIFQ4Ac2CuIF
         fQbMk/nS76bG1xh5E4NVU4QcdwEV0NhPxhb7xnbxmrn6YX+HQiQZbfRmqo+zgYlOBJ
         HvlMq+OrUxF4Q==
Received: by mail-lj1-f178.google.com with SMTP id p13so1968487ljg.2;
        Sun, 10 Jan 2021 19:27:57 -0800 (PST)
X-Gm-Message-State: AOAM533gSekiURIPgERGBdp46y7C+VrI3UHhf2G56nYtj/hTgQuMaMzl
        ZGqiteSwqci2BB8s3VSAcf9Drqf4T1vq+jRtPR8=
X-Google-Smtp-Source: ABdhPJx+QJLTIR+/b8gx1a/zGX/AFEeyqjUrB+/I8gyRM2KTyu8W5advO2PE43Uj0MDQYlfyc6jU+6Efhz5WjSpZutY=
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr6270072ljk.282.1610335676076;
 Sun, 10 Jan 2021 19:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20210110035846.9155-1-wens@kernel.org> <381648f9-d650-dddf-59e6-ef32d1e1bb43@gmail.com>
 <CAGb2v67=uO4HqRNEbhAJs2-d4mhL8URoijwE4ni9J8cYXrmAtQ@mail.gmail.com> <2241380.NG923GbCHz@diego>
In-Reply-To: <2241380.NG923GbCHz@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 11 Jan 2021 11:27:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v67h3v4DdEY68BmHy263=L1tB0DuJnf_exHrLi57SiRjUA@mail.gmail.com>
Message-ID: <CAGb2v67h3v4DdEY68BmHy263=L1tB0DuJnf_exHrLi57SiRjUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
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

On Mon, Jan 11, 2021 at 4:06 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Sonntag, 10. Januar 2021, 16:37:15 CET schrieb Chen-Yu Tsai:
> > > > +     vcc_sd: sdmmc-regulator {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&sdmmc0m1_pin>;
> > >
> > > > +             regulator-boot-on;
> > > > +             regulator-name =3D "vcc_sd";
> > >
> > > regulator-name above other regulator properties
> >
> > That is actually what I was used to, but some other rockchip dts files
> > have all the properties sorted alphabetically. So I stuck with what I
> > saw.
>
> I try to keep it alphabetical except for the exceptions :-D .
>
> regulator-name is such an exception. Similar to compatibles, the
> regulator-name is an entry needed to see if you're at the right node,
> so I really like it being the topmost regulator-foo property - just makes
> reading easier.
>
> (same for the compatible first, then regs, interrupts parts, as well
> as "status-last")
>
> But oftentimes, I just fix the ordering when applying - but seem to have
> missed this somewhere in those "other Rockchip dts files" ;-) .

I was slightly confused. I looked again and yes regulator-name is always th=
e
first regulator related property. What's off is that in some cases min/max
voltage comes before always-on/boot-on, and in others vice versa.

For example in the Rock64 and ROC-RK3328-CC device trees, in the fixed
regulators, always-on/boot-on come before min/max voltage, while in the
PMIC the other order is used.


ChenYu
