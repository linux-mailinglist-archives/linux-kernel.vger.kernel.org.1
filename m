Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74729528F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504555AbgJUS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395162AbgJUS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:58:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67270C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:58:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so4790597ejj.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RD6Pe7uFsqq6lLUnSY5SK+FGVJWIcdwyWReVf1JamtI=;
        b=FPt5Dr2PZVxmcHgGu0EzzWnbd0bBvRHH6JgMV3HonwzIQVLkhj4B4muP3EYJzeuWZH
         R1WTUDZv7Td6B59Tjr6IplLiSgIvMuPgUMzeQkhjuE+qJ/QNXPBSpn59Je+EjX1RXyU4
         IRHj/pG29Ey6zFbGxa4sArGg1YWSAupQ3kKoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RD6Pe7uFsqq6lLUnSY5SK+FGVJWIcdwyWReVf1JamtI=;
        b=FX4VKQnziw+QOLS15u3Z7o9lJTb58I7j/AsIPEPYhBsAVimIZ5u9cj6gQ8dB9ByYo4
         zCvIP5sw6/z0mipW3cOOrbYL8vEf/71D1WpYmWK7Vhpyw0MxVbNpj/Iye2YR/Fa2wasp
         5s7QZt+TuY3LdeZy+6PRPYxWlQ80KdhsroQlq4K+UARMeCyzXk9du3rc+f4+g16l8RQs
         tPJPayWyvXb8e8iaOmlsnO2NlVGopVE4R84Nx7X2KsBYag4SUmjd9IGeiXEtujsYLT5P
         TewLHSkQ7tfq4BsvzKvrAXqXiM5najiGa5KEEdiYAPTasr6kVVY7r1r82v9std4oZMv0
         VOog==
X-Gm-Message-State: AOAM5308yhc2eWRyYVprQ4MEPmk3uASI9N/wyyBg1tp40W3GrbGT+3pO
        JALyDlY6UP9zULeWnuwqW+PyFdGdFoezLNqg+pL7aA==
X-Google-Smtp-Source: ABdhPJxxfUjj7Hta8BePOHoLY9p4KODnXrLobEgMBRj1B+m1IjCAXKJZnnKVfNnNHt3piiQTSKReHx4YebGVv6yUsHk=
X-Received: by 2002:a17:907:a8d:: with SMTP id by13mr4710348ejc.295.1603306689022;
 Wed, 21 Oct 2020 11:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 22 Oct 2020 00:27:57 +0530
Message-ID: <CAMty3ZDHDC5TMF=8HJRmZd7HijOM6RP-k4y9JkdWVQGgPKyGvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, Sep 29, 2020 at 2:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
>
> PX30.Core needs to mount on top of Engicam baseboards for creating
> complete platform boards.
>
> Possible baseboards are,
> - EDIMM2.2 Starter Kit
> - C.TOUCH 2.0 Carrier Board
>
> Changes for v4:
> - collect Rob A-b
> Changes for v3:
> - resolved Johan comments about sorting node properties
> - add copyright to Amarula Solutions
> - update px30 dtsi author
> Changes for v2:
> - include C.TOUCH 2.0 carrier board
> - skip 10" OF LCD as it requires separate dts with panel support.
>
> Note: These baseboards can be used for i.MX8 SOM's as well. So having
> baseboard on respective SoC seems to be easy rather than making it
> common across all.
>
> Any inputs?
> Jagan.
>
> Jagan Teki (6):
>   dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
>   arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
>   arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
>   dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
>   arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
>   arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
>
> Michael Trimarchi (1):
>   arm64: dts: rockchip: Add Engicam PX30.Core SOM
>
>  .../devicetree/bindings/arm/rockchip.yaml     |  12 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
>  .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   8 +
>  .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
>  .../dts/rockchip/px30-px30-core-ctouch2.dts   |  22 ++
>  .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
>  .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
>  8 files changed, 343 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

Any further comments?

Jagan.
