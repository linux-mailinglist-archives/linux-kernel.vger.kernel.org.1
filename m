Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD02A6E57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgKDTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgKDTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:54:54 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:54:53 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id w1so22629709edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYADTYJrthOK2FgDOSfisjNfho6lkFoYFvTmRS3AF6o=;
        b=SaylY8xYIN/kn6pp6vqgZKWFPI3aMZEDuGl40Neby3UAsh/OdwbL/BOL6VIMd1xr54
         u1lN0DgFxGMEutrFHArJ0+jAUUmRPp+XeZlWdBtTzx09tswaSsx7r/lNGnGT2jBgUTok
         zbibiQOU8l2pYWkCZ1XrGFaXIxEfntBR1qvWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYADTYJrthOK2FgDOSfisjNfho6lkFoYFvTmRS3AF6o=;
        b=Ezx63CpbvJxHytxOuDB8mqPUrTPQWS9mu/IqBhL9j7I8iWx/uMjNexkmn/NVpvf8UJ
         6d5nb/i0XZq9FRSJry9+4kl89UPs/Fx2sSgEUlVyQRKFRR8j6v1L+qScNQ+31u5Zksdt
         EonVbQKds4kOz9KCIgGTwvS++0QmTgSi2WngrjlyU5S7zh6iQRSYIjMCtu0/hGY28hUD
         HL/EbH0yCgOFu/u7OPL7S8/CuOP64i+oahrYiUEFlyrsJlGoPNbqnJMz+41u1nSE6pC3
         9u7ySR91EDNy8fnz3WvzVMLzsl2CJ8tPZiCz2IqxBw77eleCfNh36STxAmZYKDw6gZ0K
         k3/w==
X-Gm-Message-State: AOAM532Ad8e3wf2ja95PACsBrfsMJBfSa3lBgZbjhAcnt5H7Wkd060gm
        T6ZzPB4M0MVeufSH8Xz8gcdPg3RvJdCp8FDtlzs21Q==
X-Google-Smtp-Source: ABdhPJyH3fRc/wAho0q8pS/XUNnVezYAhmkOPcUqHUyfU9i2UwdS5LOu0HHusgD6sVSsJlGpr/H/BfOWEDafPK6G6Qc=
X-Received: by 2002:a05:6402:4c6:: with SMTP id n6mr29304524edw.204.1604519692471;
 Wed, 04 Nov 2020 11:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20200929083217.25406-1-jagan@amarulasolutions.com> <CAMty3ZDHDC5TMF=8HJRmZd7HijOM6RP-k4y9JkdWVQGgPKyGvg@mail.gmail.com>
In-Reply-To: <CAMty3ZDHDC5TMF=8HJRmZd7HijOM6RP-k4y9JkdWVQGgPKyGvg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 5 Nov 2020 01:24:40 +0530
Message-ID: <CAMty3ZCib5TiQdzU95WS1Xiq1tAQ7FHEQcbf5JhUZYYvofb_MQ@mail.gmail.com>
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

On Thu, Oct 22, 2020 at 12:27 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Heiko,
>
> On Tue, Sep 29, 2020 at 2:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> >
> > PX30.Core needs to mount on top of Engicam baseboards for creating
> > complete platform boards.
> >
> > Possible baseboards are,
> > - EDIMM2.2 Starter Kit
> > - C.TOUCH 2.0 Carrier Board
> >
> > Changes for v4:
> > - collect Rob A-b
> > Changes for v3:
> > - resolved Johan comments about sorting node properties
> > - add copyright to Amarula Solutions
> > - update px30 dtsi author
> > Changes for v2:
> > - include C.TOUCH 2.0 carrier board
> > - skip 10" OF LCD as it requires separate dts with panel support.
> >
> > Note: These baseboards can be used for i.MX8 SOM's as well. So having
> > baseboard on respective SoC seems to be easy rather than making it
> > common across all.
> >
> > Any inputs?
> > Jagan.
> >
> > Jagan Teki (6):
> >   dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> >   arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
> >   arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> >   dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> >   arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
> >   arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> >
> > Michael Trimarchi (1):
> >   arm64: dts: rockchip: Add Engicam PX30.Core SOM
> >
> >  .../devicetree/bindings/arm/rockchip.yaml     |  12 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> >  .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
> >  .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   8 +
> >  .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
> >  .../dts/rockchip/px30-px30-core-ctouch2.dts   |  22 ++
> >  .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
> >  .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
> >  8 files changed, 343 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
>
> Any further comments?

Gentle ping.
