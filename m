Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1B298789
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769979AbgJZHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769970AbgJZHjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:39:09 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33D7223EA;
        Mon, 26 Oct 2020 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603697948;
        bh=KtMkJ7nwQ38q/iA1mhWoniEbrFh5tS9XP1v8T2SqjsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UPrPGt4EO4jIor52LqpNzL90RZQzlllRp44EOZ2BvZZIqAMTkdKVHgCguL5DKNHW0
         M9I/jCVsChBQuzREHfCk4z/K3FSGJ/EU7mBaq2v1zikwbOfg13unGBFR9epb0x4stN
         qOl36rDdX03NHv1x7n2aTgOmXAnNdOAwd4FkdogM=
Received: by mail-oi1-f175.google.com with SMTP id f7so9640893oib.4;
        Mon, 26 Oct 2020 00:39:08 -0700 (PDT)
X-Gm-Message-State: AOAM530qnQgFtC6QnP/aRg4cKP6JvWD7kyzs6V4h3oa4ta6x4dPVBgxo
        uW8oP231vbz/YfCwzXyerjGWjiOZ8SFKlkod1h4=
X-Google-Smtp-Source: ABdhPJyabEPtHwS6evle82W//kYJRbOgvmepI59+zn/Cwz36p/IkrolcavYOjAKSO8q1zbmjN7eScsMmQXlHC0YwsxM=
X-Received: by 2002:aca:5a56:: with SMTP id o83mr9534366oib.47.1603697948024;
 Mon, 26 Oct 2020 00:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-2-wens@kernel.org>
 <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io> <2859076.BEgH6Mo0Pn@jernej-laptop>
 <9D317C52-5F28-41A9-80DA-DBADA142B042@aosc.io>
In-Reply-To: <9D317C52-5F28-41A9-80DA-DBADA142B042@aosc.io>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Oct 2020 08:38:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG2MOX4kWbN-zRVnGwpT3Mk7-1gitj0wUB9ZzwAazGPrw@mail.gmail.com>
Message-ID: <CAMj1kXG2MOX4kWbN-zRVnGwpT3Mk7-1gitj0wUB9ZzwAazGPrw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird:
 Enable RGMII RX/TX delay on Ethernet PHY
To:     Icenowy Zheng <icenowy@aosc.io>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        wens@kernel.org, Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Oct 2020 at 20:40, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2020=E5=B9=B410=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=882:30:35, "Jernej =C5=A0krabec" <jernej.skrabec@siol.net> =E5=86=99=E5=88=
=B0:
> >Dne sobota, 24. oktober 2020 ob 19:51:06 CEST je Icenowy Zheng
> >napisal(a):
> >> =E5=9C=A8 2020-10-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 00:25 +0800=
=EF=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> > From: Chen-Yu Tsai <wens@csie.org>
> >> >
> >> > The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
> >> > enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> >> >
> >> > Fix the phy-mode description to correct reflect this so that the
> >> > implementation doesn't reconfigure the delays incorrectly. This
> >> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> >> > rx/tx delay config").
> >>
> >> Personally I think they should revert this commit, and consider other
> >> solution.
> >>
> >> This commit breaks everything.
> >>
> >
> >Previously broken driver allowed inproper DT to work, so you have to
> >fix
> >everything eventually.
>
> There is no "improper DT" if it's already shipped, DT should suffer drive=
r
> change, not changed to match driver.
>
> I think at least Fedora tends to ship a DT with a system image that will
> not get updated when kernel gets updated.
>

This same issue is under discussion in other places as well:

The following commit from v5.2

f81dadbcf7fd ("net: phy: realtek: Add rtl8211e rx/tx delays config")

added handling of the TX/RX delay controls on the PHY, but did so
incorrectly, and therefore had no effect on any of these systems.

Commit

bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")

fixed TX/RX delay handling in v5.9, and now, incorrect phy-mode
settings in DT means losing Ethernet connectivity. This patch has been
backported to -stable, even though it is not clear at all that the
patch fixes any regressions, it only fixes some broken code that did
not turn out to be active in the first place.


The result of this is that affected systems in the field using v5.4 or
v5.8 stable kernels will lose their Ethernet connectivity once they
upgrade to a newer release of the same v5.x tree that they shipped
with. We may have ways to work around this more cleanly, but in the
meantime, the stable backports of bbc4d71d6354 should simply be
reverted (IMHO)
