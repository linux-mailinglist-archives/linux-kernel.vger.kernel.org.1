Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285FF2FB165
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbhASG0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbhASFnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:43:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809AC061574;
        Mon, 18 Jan 2021 21:43:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z22so10679607ioh.9;
        Mon, 18 Jan 2021 21:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BggHkrRWLT2l16SuuNADOT1SZ2Zhl07Cxhe/IHfhdrU=;
        b=ebmSUJ0cl35IRqE6v8r0fRWRD4pdGdMcKfVvcLsVh1aHxSpVs2bC9Qvj5MPUidZd7U
         5k5TJ+4xXrhnHU0cOozwvDvpdObL4iRwhzyaurSord7niOnrJeH8VCNTpleEMZ2wq3R/
         eG0MPUxNTREY7Tch1Ol/oK3mAsR0ti7s38e//Vyu5EFMdlQaG9GjB3OyO+PYPMjskE/N
         zCXNv8GcvayBtN1aCV0YgnYAjnR5fm7+SRi6UWVMU2RG7MXPXEy4v62CVcHq50xQVtHZ
         SwdrfabUM1wpDvewkdGqzYGz61V8P4GFWyID8YfH83LEm93MbngapSoWqcKNIfYMBSz5
         uiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BggHkrRWLT2l16SuuNADOT1SZ2Zhl07Cxhe/IHfhdrU=;
        b=ad1TwLVRbaCsImrPq35hh/dHY3DMTpgiJ/GjjqSxSVItXs2ggUWliTmvTgkGKCBbLt
         NwkuKMpWNnkp1hL4TAmjU6uNSZcoC3HsTsDycoHvJtW9Ky3KXW0HUeROKn9FfrmDo9oG
         cNmEXvV6l+vjK+u6VxBULYNS60/bZsC1NCR+JVrB3i+XFbAOyyVrBVg2xCQkXf0hdAVV
         +JPcg+byoyqPEer17hFOSwQK9eUswBnrT6bUhETCjPEYblKAOfRbdSXsf4grWjwniaB1
         h6cZjKhlPOkEwNttW+fdfoKoNjwhoQm6f1MqIGrz7J8wzivyZP+4XwbGqAA5PgsUCLzH
         7T3g==
X-Gm-Message-State: AOAM532uVxcpiI7CCJ41RAIRfdY4FDnN83lC4vx3vJK+nF/4kU3LWlq9
        /5JrGvVePElub+KkYmBBvt8ZOeLQrutYu4QZgzU=
X-Google-Smtp-Source: ABdhPJwtX87LV4HFD9byN1dXimJl3Qx1joDc1DGXDr0qnff3CHdsORysdNz0tYKu+QEwBxnEsk4Pn/cRyDnKwwJIyxk=
X-Received: by 2002:a92:8455:: with SMTP id l82mr2148791ild.40.1611034988763;
 Mon, 18 Jan 2021 21:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20210117035140.1437-1-alistair@alistair23.me> <20210117035140.1437-2-alistair@alistair23.me>
 <CAOesGMiLZGdjQTLj48B8dXV1vv2p-NG751m-bh61mJ-10N-rAw@mail.gmail.com>
 <CAKmqyKO_xxrzMHB7Fuxq_5xT6JH8sOudKAKgug_FiS08MiJ94w@mail.gmail.com> <CAOesGMh9X3OwzftRQYVsz6=Wv_wkm-wh_ucN91e6FCbjnG3X+g@mail.gmail.com>
In-Reply-To: <CAOesGMh9X3OwzftRQYVsz6=Wv_wkm-wh_ucN91e6FCbjnG3X+g@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 18 Jan 2021 21:42:42 -0800
Message-ID: <CAKmqyKNR3+9u966zvZUV8WOFdhPjje0cgkxrJs0F3oeZ8M=uaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] remarkable2_defconfig: Add initial support for the reMarkable2
To:     Olof Johansson <olof@lixom.net>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 6:03 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Sun, Jan 17, 2021 at 5:36 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sun, Jan 17, 2021 at 5:30 PM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Sun, Jan 17, 2021 at 3:09 PM Alistair Francis <alistair@alistair23.me> wrote:
> > > >
> > > > This defconfig is based on the one released by reMarkable with their
> > > > 4.14 kernel. I have updated it to match the latest kernels.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > >
> > > It's awesome to see upstream support for contemporary consumer
> > > products being posted, thanks!
> >
> > No worries!
> >
> > >
> > > When it comes to a dedicated defconfig, is that necessary in this
> > > case? The needed drivers should be possible to enable either in
> > > imx_v6_v7_defconfig, or in multi_v7_defconfig (or, rather, both)?
> >
> > Most of the defconfi could be shared with a standard imx7 config, but
> > some of the extra components like the Wacom digitiser,
> > cyttsp5_i2c_adapter, max77818 and bd71815 might be better off in it's
> > own defconfig.
> >
> > If the maintainers are happy with enabling some of those in a imx7
> > defconfig then I'm happy to do that. I have tried to split out the
> > config changes (I have two otehr series that build on this one) so it
> > should be easy to rebase it all on a standard one.
>
> Yeah, enabling those in imx_v6_v7_defconfig and multi_v7_defconfig is
> fine (or, really, desirable and preferred).
>
> Please enable as modules where possible (i.e anything that's fine to
> wait loading until after rootfs is mounted), to avoid kernel image
> growth on platforms that don't need those drivers.

I just sent a v2 of this series. Patch 1 is the same but I'm now using
the imx_v6_v7_defconfig in patch 2 and 3.

I only need a single change so hopefully that's fine. I'm sure more
features will need to be enabled but they can come with future
patches.

Alistair

>
> > > Adding new defconfigs is something we're avoiding as much as possible,
> > > since it adds CI overhead, and defconfigs easily get churny due to
> > > options moving around.
> > >
> > > In some cases we do it once per SoC family (i.e. the i.MX defconfigs),
> > > but we avoid it for products.
> >
> > Makes sense, I will update my patches not to use a custom defconfig.
>
> Awesome, thanks!
>
>
> -Olof
