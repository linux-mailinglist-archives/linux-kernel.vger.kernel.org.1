Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945562F4D99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAMOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbhAMOtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:49:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F94323441
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610549342;
        bh=rmV8owGCpFXhOYGxvXH4BciLrbTOCUh6TbLgnrlRO9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvg6oFhX2hJv5CDD5bcSfWJN7vUElTIg0iS60jQ83HfDM/uT9b9u2vSzszcDACO5z
         IUvtCRvc7/DZRhul9bzxhgRdCGHUy5ym2BNJiNNJHMr+KsmNH+S1fIuB08Z9EkXCTc
         QihPMFbU4JzjmOqfEh7He/FXFlgQS2AEjOL9OSjz+xRYiilKkoOcnHjBVe8v5+H8pS
         uhWjlX0mahXxkpwOAm7doPkwIN6UcG6Diw12TMwtfu/T3Z9f+jOEuxC7S+mQBo3ee6
         ICOAy2wyQLoQLMmzClNNK3YgFZe+EqApFgyBFqWDMqQ1FaxRLM3kkVI3TiqycLVNID
         CRCwIC+qb1Opw==
Received: by mail-oo1-f45.google.com with SMTP id o5so562537oop.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:49:02 -0800 (PST)
X-Gm-Message-State: AOAM530491lxTlVzcAnVC+81/WEGOygyeDG3F4eKhILjF4QTe5rGRI2J
        2R5kyY8eZLO9ElmIOuUjophWC60JFUm35v+gY1U=
X-Google-Smtp-Source: ABdhPJy7hAXwvhKYnoz7qGktT1NwoOyJwoy2bWA1HMbx4xYCgFxTCSZ9y+vn8/UcKJjmfHnQFjv5Smo59BLlMtAmWNg=
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr1518016ooo.66.1610549341686;
 Wed, 13 Jan 2021 06:49:01 -0800 (PST)
MIME-Version: 1.0
References: <5ffbe3de.1c69fb81.ea87c.a145@mx.google.com> <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
 <CAKfTPtA9Z+dCskqSh3atgOxMRdJi-nzQD_MrUpL8yuRw_UrCCw@mail.gmail.com>
In-Reply-To: <CAKfTPtA9Z+dCskqSh3atgOxMRdJi-nzQD_MrUpL8yuRw_UrCCw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 15:48:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1PFe9OcGV0==5JL3jdt1y3ZhEtGmO+CYfqWgz=htvCrg@mail.gmail.com>
Message-ID: <CAK8P3a1PFe9OcGV0==5JL3jdt1y3ZhEtGmO+CYfqWgz=htvCrg@mail.gmail.com>
Subject: Re: pmwg/integ bisection: baseline.login on rk3328-rock64
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, Jan 12, 2021 at 2:46 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> On Tue, 12 Jan 2021 at 12:25, Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> >
> > Some details can be found here:
> >
> >   https://kernelci.org/test/case/id/5ffb978de38e717501c94cd8/
> >
> > The bisection was run with CONFIG_RANDOMIZE_BASE=y enabled, but
> > the same issue occurs with a plain defconfig from that branch.
> > Results with other configs and platforms can be compared here:
> >
> >   https://kernelci.org/test/job/pmwg/branch/integ/kernel/v5.11-rc3-13-gcea05edf93998/plan/baseline/
> >
> > Please let us know if you need some help to test a fix or debug
> > the issue.
>
> I don't have any rockchip board on which I can run tests but I can
> push an updated version of the patch without trace events if this can
> then be then tested on kernelci rockchip board.

It's odd that there is no output from the kernel at all, which
rules out most of the options that change, as they should only
have an effect later during boot.

One thing I noticed is that the last successful boot has a kernel
image size just under 32MB for the vmlinux, while the failing
configurations have more than 34MB.

I looked at the loadaddress as well:

11:43:57.119234  Filename '536723/tftp-deploy-j462agcw/kernel/Image'.
11:43:57.122622  Load address: 0x2000000
11:43:59.708404  Bytes transferred = 34361856 (20c5200 hex)
...
11:43:59.814346  Filename
'536723/tftp-deploy-j462agcw/ramdisk/ramdisk.cpio.gz.uboot'.
11:43:59.814638  Load address: 0x4000000
11:44:00.447924  Bytes transferred = 8517374 (81f6fe hex)

So the ramdisk and the kernel overlap when the kernel is larger than 32MB!

     Arnd
