Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BEA28B05F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJLIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJLIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:37:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17886C0613CE;
        Mon, 12 Oct 2020 01:37:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so15163771ilo.12;
        Mon, 12 Oct 2020 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XQa+ZKetpKNyqsXxHknqzWjiajoAzgNjasTwE2NcQhc=;
        b=Xd3X92epyOz/n6HosS67yuotOqdvqwAc0DyQgUZXzVM29qb2YmQGklwskftAbMI1WB
         V0xSeNyJWkcuWE4xwZneWuMpur+HwE8lCzXDVuu/38YY+8qa6EmJZoqKgqigW8uBuGhz
         FBV8QucPg/s0i45oRA5DLwWv1XsS6BpKYYcTOvqoJHnYqaeIF7ime7MPVOWn3bwr6y7G
         q5+eaKWbd/CKiffJdnXvRUsXnpKosjOoIWdmflfjjw+PaNfUXAl3t0YUuFHNh1K51B2g
         IAA1KHhl0LxG0InOKvqgZyJWMsZuh98fJPKGe9Ecd+FA3C62Q/lK6/f4UsDGNxT8eHE3
         vdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XQa+ZKetpKNyqsXxHknqzWjiajoAzgNjasTwE2NcQhc=;
        b=hX2IbvSM4F36HckPa0tOV2h/GO2dbb254rSoULnmuh+3fPcWDtJ5yWgUv2dmSrSHRZ
         NYguj1b/eflhAJNOMfKpQb9XiR4INb7CMGuUxVCl3d4c6CxZghdTxT4A9sfgJbHvOpo3
         et+E8Pd2Lfjzd7q9CO34HcvJ4Ow8t2Fc8qT9w4Bhs+8/6+4CxEVrdJuSiOIL2MJcxiAw
         tFwbEVH5FcqHqJReFBlv9Fdcp/4vPiOIpnFJ/GedtagzQlxNPGhh2SRTfcTkAGnixrDf
         fQaPdj62qNxqIwb5WKy3QS+j0XIwZdBtZGzhWhMyGn059g0Ut4+BBwymqGT5/mQrxB1p
         UR+w==
X-Gm-Message-State: AOAM5301grX9D7BgfyhaS2Yob5nNH6YVrXzJ2G/XpaXD9K0PKPFgI3An
        qpu2RwkEfaVJf0pX4xwbP95L1LGFnX2qHKyRFIo=
X-Google-Smtp-Source: ABdhPJwf2I6ZksAa5l2K0+Z5/QUgq9GSXoy+3KeP8yiBDlA9gK740Ri5QtRU0Oj/kCVKSoSHeGlLW2YFT1dEdVoTc1w=
X-Received: by 2002:a92:a80f:: with SMTP id o15mr18950865ilh.118.1602491876324;
 Mon, 12 Oct 2020 01:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201011211543.155561-1-peron.clem@gmail.com> <20201012075013.yrpknpbrzl5f5eah@gilmour.lan>
In-Reply-To: <20201012075013.yrpknpbrzl5f5eah@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 12 Oct 2020 10:37:45 +0200
Message-ID: <CAJiuCcdg67ZN5xd58y9DmM3Ei28NPe5DSPpSgt2NY1j3rSEUVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: sun8i-a33-codec: Add Allwinner A64
 codec compatible fallback
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and all,

On Mon, 12 Oct 2020 at 09:50, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi!
>
> On Sun, Oct 11, 2020 at 11:15:42PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > make dtbs_check report a warning because the documentation
> > for the A64 codec compatible is missing.
> >
> > The A64 codec compatible is actually a simple fallback to the A33.
> >
> > Reflect this in the dt-bindings Documentation.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> This patch is already in the ASoC tree and linux-next:

I was indeed on top of sunxi/for-next and not linux-next/master

I will test on top of linux-next for the next ones.

Sorry for the duplicate patch and the noise :(.
Clement

>
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/=
Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml?id=
=3Dcef305d4eb0733f25215793ed30b056a7db9bb62
>
> Maxime
