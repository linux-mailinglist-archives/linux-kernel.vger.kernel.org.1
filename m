Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1952D7700
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393884AbgLKNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgLKNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:54:27 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF5C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:53:47 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z11so8406532qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=am+2yk9rlqtbVhZwrF/QYG0TW4go4+v58RaDE0YJVkg=;
        b=sjiP97iCb6jEqk6pJZ3bNHdcNGmg/71IMWS9q4+NTagiACQCiHxHikgrxKMxKBHUhC
         sV6bN4wVP2WDjLSNk9zKtsoGacAjiZ0mSjtvtwpQyM9+rDgEKIpZCckS7BiQSyBfvkS8
         U9AKLvJr4jVOcuhwkZrWcZH7Rf28UJWFv4UdYT/tuvlR2qV4vDhmnnTKgX99RQrjAO9Y
         6rfoPEy1zuxvJ/YHMs0dANUbT2B2Va7pO1k18Mp8QG6jzkmDBY9r1X1YbCL93hX8ZFaU
         MnBISumAB6jg2oU/yTFzEELFnh3Uh/4qimiPRR6Dunf2OcZJsnPZ6IV3qdFQhJ0RzDHL
         O+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=am+2yk9rlqtbVhZwrF/QYG0TW4go4+v58RaDE0YJVkg=;
        b=aXECytg7hEg3dhTJkfr0aXFk9kRa840CdgflkzAl5a8UvmBpwTsW7WkVXohyVsunu8
         r8J9cIvQAqVcehQCItLt/goUw2LlNhxOoIgns8tixd3K0nzuDZLQsGF6TQWhsAEjpO4o
         i9Bd0pcfz39nIKoXy5ERsH8Rsh6m1sBs8bh9Gjajv+lVdP+N5p34yccA7DOTyjHv+swy
         ogjI+djzZh/pD9eu0bUFRS/CCQB0bhGOTVpywO6GKTY9wG7thVS5flk6l5Y/IHFbagjU
         MiSnTAbdNqPlsoSS523U805XM/GFGi96d7WJVlX46yYORJxx1ChdfiKZZeh4IVZdhvPb
         qIUw==
X-Gm-Message-State: AOAM533RZ1bOhe2FvN/X51fI5co0qWh1gmUdOp4WZ3BQL6zmUT0J1toS
        sAD7lcVoilWg2wk6Jd+l551pEIL+Qr7r9tOYGoZN0Q==
X-Google-Smtp-Source: ABdhPJyYWBakyT3hEXmuJsjvfwnz/oJCdb47wQHHewrJcLM78CiAQFbOrOyMziUWC7me0hhSdrQwgJD2iEBZ93bw08w=
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr15797755qkh.385.1607694826325;
 Fri, 11 Dec 2020 05:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20201204171626.10935-1-mw@semihalf.com> <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
In-Reply-To: <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 11 Dec 2020 14:53:35 +0100
Message-ID: <CAPv3WKevssDOq72xF+ciLdCGC5EZNpnSCb4Sw3PiEfnqb-ZG5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sdhci-xenon ACPI support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 11 gru 2020 o 14:47 Ulf Hansson <ulf.hansson@linaro.org> napisa=C5=82(=
a):
>
> On Fri, 4 Dec 2020 at 18:17, Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > Hi,
> >
> > The fourth version of the sdhci-xenon ACPI support
> > addresses a comment regarding clk handling in xenon_runtime_resume.
> >
> > The MacchiatoBin firmware for testing can be obtained from:
> > https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
> >
> > Changelog:
> > v3->v4
> >   * [3/4] Call clk_prepare_enable unconditionally in xenon_runtime_resu=
me.
> >   * Add Adrian's Acked-by to all patches.
> >
> > v2->v3
> >   * [3/4] Call clk_disable_unprepare unconditionally.
> >   * Add Adrian's Acked-by to all patches.
> >
> > v1->v2
> >   * Split single commit to 4
> >   * Use device_match_data and dedicated ACPI ID's per controller
> >     variant
> >
> > Marcin Wojtas (4):
> >   mmc: sdhci-xenon: use match data for controllers variants
> >   mmc: sdhci-xenon: switch to device_* API
> >   mmc: sdhci-xenon: use clk only with DT
> >   mmc: sdhci-xenon: introduce ACPI support
> >
> >  drivers/mmc/host/sdhci-xenon.h     | 12 ++-
> >  drivers/mmc/host/sdhci-xenon-phy.c | 40 +++++----
> >  drivers/mmc/host/sdhci-xenon.c     | 91 +++++++++++++-------
> >  3 files changed, 91 insertions(+), 52 deletions(-)
> >
>
> Applied for next, thanks!
>

Thanks a lot!

Best regards,
Marcin
