Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742A22A7ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgKEJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgKEJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:42:42 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58477C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:42:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so1349609lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHdJ9O/eb7sklBU/l07atiLZ4vkrCEwrngihboUUROU=;
        b=iiRTzja+wq6lUOKKm42/j/gHbiF5SodCPbvKvogg5CAHNsdau6W+T8LTLaDExfQN0m
         xsXSSkIcgtMb9/TadZq7F5dqrG4LhofhNMCD55eZsf3QuxcYNOVfttkQCmp0XmLrOEUY
         5EJ7LqF+32FwOjC1NNLm5rd2MjaqYhthDMUF1ijtui+nSsajeLVrDwj3wO/rvjlumvBn
         a3dtTSx3kUcFdqkC9u1imv9XL2EcRDUEg2/E/NMV1zTFrE4qppRbF9cmgAXsB+gPcG0H
         EPEkxSM9KeXyPRunaiRtHElWwlfYfXJg1P3XvcVxtjYsqwZ4jE7uDIoXP+S9kJ5S95X3
         44Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHdJ9O/eb7sklBU/l07atiLZ4vkrCEwrngihboUUROU=;
        b=fqb8yShdJaxGTK2JffjiNcxY01zVBYPONXanPKNRQ6CtzWhctka9HcZ2AGWTWXXLZb
         QbGUvXnr71UXNJGnaWrQb3dhDCuN66S4kOj79XYlr8loAoSNtzo4PoutmmvFBxUsxcqL
         IhJjQ4Sq+sOgHnUbipe6kXyP7xcG4ZCZYs85KO8T13VtmqObx/mKwKSoSS+EFe0IQdr3
         Pdg3Dr0eyOpdNUVvX5SVy+mMcu+nKG2E90RYyS/fjtsXt3viE1tGKlrtoNHGN/9fu5dx
         Lw4FRNbIYKmBJkWW4523uz0uDFDlQ4pPr1TOXR3RBondAxgXSiRvJlMwxrIsQW5aYXET
         2Qeg==
X-Gm-Message-State: AOAM530QkV9IuwrNeZkzuND3e/ki0OvPqkEH+Czx3t8rM64KNqv7lCeJ
        9/2JOtx39qfU/pNWqnxb3yj0erCHti4b6/hTiPYX/IFWT47/xg==
X-Google-Smtp-Source: ABdhPJyvHqbBfOH4pjVDXcDPP+SU3DUauVr3d4hoArhgygLP7IJAFteeJwECsCh7xRspygPGZoUQ3+4+8VofUysPWYY=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr608257lfe.441.1604569360750;
 Thu, 05 Nov 2020 01:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20201011024831.3868571-1-daniel@0x0f.com> <20201011024831.3868571-4-daniel@0x0f.com>
 <CACRpkdYmdZ81q_tsXRQ56aFjGsvV3AwJ8_hiu31mD14DGiK84A@mail.gmail.com>
 <CAFr9PXnX7QyM0VUmosFYueSe4ewA7uT2VZMfxFPaFt6-jUhoSw@mail.gmail.com>
 <CACRpkdbx+T3uX9taZNjsURHGc6qVLvGGC2boEC4=NaOi4_uZTQ@mail.gmail.com> <20201105093107.GB21245@1wt.eu>
In-Reply-To: <20201105093107.GB21245@1wt.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 10:42:29 +0100
Message-ID: <CACRpkdbCB_n_jNJ+wqWWMKHG80du3kqya0vdOu41Cb4vdvOtyg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: msc313: MStar MSC313 GPIO driver
To:     Willy Tarreau <w@1wt.eu>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:31 AM Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Nov 05, 2020 at 10:21:27AM +0100, Linus Walleij wrote:

> > If your SoC is only used by OpenWrt (like ixp4xx) then it is fine
> > to just use bool because that distribution is always built with an
> > image for a specific hardware, whereas distributions are generic.
>
> Speaking for myself (since I have a few now), I'm not running OpenWRT
> on mine but my own distro, and I guess most users will run either
> Buildroot or their own distro. It's unlikely that we'll see very
> generic distros there given the limited storage you'd typically have
> in an SPI NOR (16-32 MB) and the small RAM (64MB) which tends to
> discourage anyone from booting a regular distro over other storage
> anyway.
>
> Thus my guess is that most users will keep building their own kernels.
>
> But this just emphasizes your points :-)

I think that is a good argument to keep this as bool.

Yours,
Linus Walleij
