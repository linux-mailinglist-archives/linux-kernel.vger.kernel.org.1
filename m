Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA224F060
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHWW7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 18:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHWW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:59:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:59:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s1so6825728iot.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMBkmv0QmaZUXjMTcydv1MvAQ17m/air8AA2TKonhbk=;
        b=xUqk7lJmfQL+W6Y/yVEN1nr4YOva5j95dPVccDsw4YrsizctfrTagnEDzeYuiv7CO3
         bmCwF9r81iE+EN9gz1U8xyFIbgQHWFnENIurKB/4PvDuKkFuQbN6qlFwY0FpeGtvd+6V
         35t8bELtqc+1fpUkc/KHGrMgMDpwSH7P5ef/0/YYFwvB5PTqfMkD/WqmxMebAvtWHbZf
         yV2sbG0Y7qAN4o5NCfkcA84LhQC8M6TPsxoXuwHnSwm3OfV4mddWJVFX94bsxVG++Z/j
         /hKt7w09ivoOfqHY7sQatOvc8ulYpCFsd2R15v5ZfqTflzSQjbTbLqdPwUg8nhsTNgIV
         t0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMBkmv0QmaZUXjMTcydv1MvAQ17m/air8AA2TKonhbk=;
        b=gxT4CmVLwnMi3XDcQyW3KTQEDMPRxEoymW6ojVpI0Q9SilALt7jvC+OBKEYz4Ub+kb
         1TiOX+x4KxoG5yDMvo+lbgv1yH40475XDIjuKOgLQGbtp4gZIU4socbhByIKosAR5WX4
         qxvhOJvLFbe76tamlJbQ9nHGVYr7ARwcrl4xW1T7Vmd1TV8d80pxmFA2DInXqn6w/LPM
         cyv6GCsQjnL3AwK73k8zHIENErgcy3vz3tFv7oBUel2BpQ38T4JkqPMRIyXtq6s36XuG
         X6xqWtAqlHKw1+ItoBpqBdwFSj/cB0TWerjgv/345NNzx4ZkbsmogxPi9z9odMryGXSr
         lfnw==
X-Gm-Message-State: AOAM532QCe3cIC7SHwhOim8aGyYLpwVEUiYzCY2YJuwYY7xBJnA7eXJi
        kx/BBuS6BEfR1iSW8FRBEH+2RKToY8s28wp9Li7Xvg==
X-Google-Smtp-Source: ABdhPJxZDAxn1LzOKezHkNZB1x2PKPPIIfZnkKnRgW8p3oI1Zv5UOzASaFY2I9OCzjHFeqCyhCTIWI/uqplIdTc/Qrk=
X-Received: by 2002:a02:730b:: with SMTP id y11mr2987869jab.126.1598223539443;
 Sun, 23 Aug 2020 15:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200817065654.4419-1-krzk@kernel.org> <20200823014600.GH30094@dragon>
 <20200823084241.GA2886@kozik-lap>
In-Reply-To: <20200823084241.GA2886@kozik-lap>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 23 Aug 2020 15:58:48 -0700
Message-ID: <CAOesGMhL887y5WaW=yM8Bh9RZGsO6mZzC=Giv_Ai4=_Z=YZhAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: defconfig: Enable USB gadget with configfs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 23, 2020 at 1:42 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Aug 23, 2020 at 09:46:01AM +0800, Shawn Guo wrote:
> > On Mon, Aug 17, 2020 at 08:56:53AM +0200, Krzysztof Kozlowski wrote:
> > > USB OTG connections are pretty common for embedded and development
> > > boards, for example to have networking or serial access to the device.
> > > Build as a module the USB gadget configfs options so the defconfig can
> > > be used in such development configurations.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Applied both, thanks.
>
> Thanks, although few days ago I got confirmation from patchwork that
> Olof already applied them to arm-soc.  I cannot find them in arm-soc
> or next trees, though.
>
> Dear Olof,
> Did you pick these up already?

Yes, I applied them to the arm/fixes in the soc tree:
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=arm/fixes


-Olof
