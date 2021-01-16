Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7992F8D51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbhAPMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAPMag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:30:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE41D22B2C;
        Sat, 16 Jan 2021 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610800195;
        bh=ca/vsPvRFA/ntU6GBtDeu7DGaoHGoSEFypY9fn+bOMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oa1m3BhEFVJy2PqeTdJ19sbOmBiVsdOqjyTpsXv8/pM7avEbGkN2qTk3QpXWc9NOw
         77pE68mq71Z0ALaDtDeL0hUPayL01QJ9VHiapMEQby24302RppdNKz2dxb+wdLx+vW
         eTu8OOlXgEmYMFrH85ztPlNJZbqSfO8BHbPeemp1oegZCCb+3n6GZ09jabegX4C28d
         fsBPU9uv9075pOmhkND7StIvKIkN85QCE0rYOiRXMORwCFnKpLwlzr33qbdHT/6kqq
         gtn15T5cG7HPDbdPxGYMpT0iG0C6dkdgWPzupnEE7MgK0sGk+DxaZHZczWQNWUOe6r
         x0mY1ubHOdUAA==
Received: by mail-ed1-f43.google.com with SMTP id r5so12467854eda.12;
        Sat, 16 Jan 2021 04:29:55 -0800 (PST)
X-Gm-Message-State: AOAM5339cwB8uz77knhN/MdxLKYkxFZkd5Da8vTUeFnL0e4SBPPgi3/s
        +t9saKfkRpiEEqxqbui67Iiv2epEbp7gegScDuo=
X-Google-Smtp-Source: ABdhPJx+XPnYmuybQza4UWKHnUO6kOMzX0j2xb2bV2NXIs8MTtwEfGbyZMADyXEFv92/B/CBUXe1yXfNYOieL9XP6iM=
X-Received: by 2002:aa7:cfd7:: with SMTP id r23mr13099975edy.298.1610800194368;
 Sat, 16 Jan 2021 04:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
 <20210115210124.507282-3-adrien.grassein@gmail.com> <20210116083122.GA3704@kozik-lap>
 <CABkfQAFz2LatEF6S5QXjreTiYy6RWC77ONYEZbOJreegx4yGHA@mail.gmail.com>
In-Reply-To: <CABkfQAFz2LatEF6S5QXjreTiYy6RWC77ONYEZbOJreegx4yGHA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 16 Jan 2021 13:29:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcSdRYOCjV8ZXYe4zmTWmigqzKvHM=N3L0h2-60dtHc+w@mail.gmail.com>
Message-ID: <CAJKOXPcSdRYOCjV8ZXYe4zmTWmigqzKvHM=N3L0h2-60dtHc+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 at 11:48, Adrien Grassein <adrien.grassein@gmail.com> w=
rote:
>
> Le sam. 16 janv. 2021 =C3=A0 09:31, Krzysztof Kozlowski <krzk@kernel.org>=
 a =C3=A9crit :
> >
> > On Fri, Jan 15, 2021 at 10:01:23PM +0100, Adrien Grassein wrote:
> > > Tested with a basic Build Root configuration booting from sdcard.
> > >
> > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > >  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 415 ++++++++++++++++=
++
> > >  2 files changed, 416 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_=
rev2.dts
> >
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Best regards,
> > Krzysztof
>
> What is the next step? Should I regenerate the patch set with your review=
 tag?
> Thanks a lot for your reviews.

No, review/tested/ack tags are not reasons to send a new version. If
accepted by the maintainer, the patches will be applied with my tags.
However if you ever resend the patches or send a new version, then you
should add all collected tags.

Best regards,
Krzysztof
