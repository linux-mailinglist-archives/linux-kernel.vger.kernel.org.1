Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A012F4DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbhAMOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhAMOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:54:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0BC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:53:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so3140807lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+b7f02MiBmx2lZQBiGMNU58ibtXi2zvPNBXTZUqvAQ=;
        b=cA7QpnW2m1SNn4CNyxSmpklXBBDe+KJzyw24ghIxvTcZ8IeiQfEw5cX1bPjtirxYrp
         9p/pDszQqNaDL1YpKnLmV9CJXARNMvc9V9eLIaVXC2g6IqGJ2ENcbmnavpwocDc6MMjI
         gK2FLBK2osljXtbAMi/o7OsGr1K896WLV1G2o3OSpunfxXINLyvk7w982WIH22oxHKgE
         hAOWVFGt0qylysb2K3+1XPmcHsNqAkYcvfnfWJoYmOycXN5sRx0iqtsUWMxUolA57DvQ
         LShciDakGme2nwv9zrz9oyMVhPxyNpSCdCC8uFEYR7xEIQmuAvi0pE9nzsM/RUtWmA1O
         Cq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+b7f02MiBmx2lZQBiGMNU58ibtXi2zvPNBXTZUqvAQ=;
        b=mKv+xPFGV4n2ndsQLPa9tfCqIj/NIWkzOZLg77qva/HKxTK01eEjRBCHstSVL6D5A5
         rOuvUfTlva1QhMMT6sB6NL8m5uwePOkrIWWk47EyY+02SAGHIBMley0lsO39ctgfr0y0
         fV6Yy6uPfnkQgpou3HwSHseVhMjaHxwfA2Hiu3Rob5V3YANvzi32F15pL7+qJ5lt1Fev
         mqce6STLXJhP1/rv2hf4Ep1PNRYRgeJiOYLvF7m8zAEry/FwCJ7GPgqf0wVJTVTY/px2
         v0Ku8lAFu1ZzoeSjih3FlTRvSWXzyRNVk5f4MPrq7Wg56a67HLO8APkC7uWV5L1kHw06
         6gcA==
X-Gm-Message-State: AOAM531H5TjC0xMwCzRykIkftFGYwGsUCuM49Mt6rhAtpKOVJULHwlIp
        X/OQ9v3M5as8hSpnGjhyNQdp9pB7VazCmLmbVMKieg==
X-Google-Smtp-Source: ABdhPJwfIY1rTI/rj4YhhqkxjWRkr/g/mtLd0D+X1NiT0FMe8hBt6wBrg+wl8lNl/rehfEqYeHVOHzQjlB7RXXYvMUo=
X-Received: by 2002:a19:810:: with SMTP id 16mr1057455lfi.233.1610549623886;
 Wed, 13 Jan 2021 06:53:43 -0800 (PST)
MIME-Version: 1.0
References: <5ffbe3de.1c69fb81.ea87c.a145@mx.google.com> <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
 <CAKfTPtA9Z+dCskqSh3atgOxMRdJi-nzQD_MrUpL8yuRw_UrCCw@mail.gmail.com> <CAK8P3a1PFe9OcGV0==5JL3jdt1y3ZhEtGmO+CYfqWgz=htvCrg@mail.gmail.com>
In-Reply-To: <CAK8P3a1PFe9OcGV0==5JL3jdt1y3ZhEtGmO+CYfqWgz=htvCrg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Jan 2021 15:53:32 +0100
Message-ID: <CAKfTPtAeNCfqRJ8F3ZGTv1-q0fntXVJizOEmC6oqqXssiy6GfQ@mail.gmail.com>
Subject: Re: pmwg/integ bisection: baseline.login on rk3328-rock64
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Anson Huang <Anson.Huang@nxp.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 15:49, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jan 12, 2021 at 2:46 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > On Tue, 12 Jan 2021 at 12:25, Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> > >
> > > Some details can be found here:
> > >
> > >   https://kernelci.org/test/case/id/5ffb978de38e717501c94cd8/
> > >
> > > The bisection was run with CONFIG_RANDOMIZE_BASE=y enabled, but
> > > the same issue occurs with a plain defconfig from that branch.
> > > Results with other configs and platforms can be compared here:
> > >
> > >   https://kernelci.org/test/job/pmwg/branch/integ/kernel/v5.11-rc3-13-gcea05edf93998/plan/baseline/
> > >
> > > Please let us know if you need some help to test a fix or debug
> > > the issue.
> >
> > I don't have any rockchip board on which I can run tests but I can
> > push an updated version of the patch without trace events if this can
> > then be then tested on kernelci rockchip board.
>
> It's odd that there is no output from the kernel at all, which
> rules out most of the options that change, as they should only
> have an effect later during boot.
>
> One thing I noticed is that the last successful boot has a kernel
> image size just under 32MB for the vmlinux, while the failing
> configurations have more than 34MB.
>
> I looked at the loadaddress as well:
>
> 11:43:57.119234  Filename '536723/tftp-deploy-j462agcw/kernel/Image'.
> 11:43:57.122622  Load address: 0x2000000
> 11:43:59.708404  Bytes transferred = 34361856 (20c5200 hex)
> ...
> 11:43:59.814346  Filename
> '536723/tftp-deploy-j462agcw/ramdisk/ramdisk.cpio.gz.uboot'.
> 11:43:59.814638  Load address: 0x4000000
> 11:44:00.447924  Bytes transferred = 8517374 (81f6fe hex)
>
> So the ramdisk and the kernel overlap when the kernel is larger than 32MB!

Good catch Arnd.
Thanks

>
>      Arnd
