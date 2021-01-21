Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F72FE0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbhAUEmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbhAUElE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:41:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5004E238EB;
        Thu, 21 Jan 2021 04:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611204022;
        bh=uqaKgj8ERy+L2vgyvOGN9yOlUjntHTGqoSn1YcsOB4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChtW9EXEiiWJxlBj7fuIxQ7XefenOGQVnbZqWkrO87TFGKbgemZLagxOHaZk/4kka
         wxn06cX0D3wv2w38+MTLz5PH0TMf+N8DTO/XWbcON0F0f5bgamdV7Y8iMGdk/AMorf
         t3fgbd4G1m86rNagSTgGmIhTRUnzUIT3hpT1e57SJdix3NxDf7Ncdb5bt0DxSNpxJO
         9mH00TP+bdGAuuW1b2I6VsPAnURpTfX+lcNsBa+Gka2wdFHnJ2qDOK+RmOIoSlYe54
         u0jEVjLSe6PRr7h3UsAwBv+4mGImUl/2QU2+2cnJhs2YaoToBeVf93khK4kLQnQhEp
         e9UDpSh9Drs9w==
Received: by mail-lf1-f53.google.com with SMTP id v24so717272lfr.7;
        Wed, 20 Jan 2021 20:40:22 -0800 (PST)
X-Gm-Message-State: AOAM533GtWUJa27noS14tDl2kUVw8BuM9+Bde9aYe9sSSMrLLcxIlMLX
        +q7etbmVIcd+t92Yz8El6cueZbKdMOcDCgS4R/Y=
X-Google-Smtp-Source: ABdhPJy8qhijve3RxQKPzmAsfsPdPAN5DUoEmElkmffNcBcnxlrBtAU2YthDmaPnmQr4komT5WSroZndwC/ucSf4o2w=
X-Received: by 2002:a19:810:: with SMTP id 16mr5771851lfi.233.1611204020484;
 Wed, 20 Jan 2021 20:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
 <CAEr9=gsH2UhjMO_55FKmGKS0DYrT_-XKf0iwCKCNc93epbiXNw@mail.gmail.com>
 <87ft5ly5nh.fsf@kernel.org> <CAEr9=gsc0L=rn5YDLrArqbOMSt25HhHF7cwhp7sxdPa6-PQGpg@mail.gmail.com>
In-Reply-To: <CAEr9=gsc0L=rn5YDLrArqbOMSt25HhHF7cwhp7sxdPa6-PQGpg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 21 Jan 2021 12:40:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64L94oudNnjhumEE6P6B=MjyOpmbYuZFfDc-fDDBZ_+jQ@mail.gmail.com>
Message-ID: <CAGb2v64L94oudNnjhumEE6P6B=MjyOpmbYuZFfDc-fDDBZ_+jQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
To:     Lindsey Stanpoor <lindsey.stanpoor@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        cnemo@tutanota.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:30 PM Lindsey Stanpoor
<lindsey.stanpoor@gmail.com> wrote:
>
> On Fri, Nov 6, 2020 at 11:42 PM Felipe Balbi <balbi@kernel.org> wrote:
> >
> >
> > Hi,
> >
> > Lindsey Stanpoor <lindsey.stanpoor@gmail.com> writes:
> > > On Wed, Sep 2, 2020 at 11:12 AM <lindsey.stanpoor@gmail.com> wrote:
> > >>
> > >> From: Cameron Nemo <cnemo@tutanota.com>
> > >>
> > >> Document compatible for dwc3 on the Rockchip rk3328 platform.
> > >
> > > Hi all,
> > >
> > > Wanted to give this patch submission a gentle ping.
> > >
> > > Rob Herring acked the documentation changes, but I have not heard
> > > anything
> > > from the USB or Rockchip maintainers. This patchset would facilitate USB3
> > > support for Rockchip rk3328 devices like the Pine Rock64.
> > >
> > > If there is anything I can do to help move this along, please let me know.
> >
> > Sorry, it had fallen through the cracks. It's now in my testing/next.
>
> Following up on this. Will this move out of your testing/next?

The binding changes are likely stale now that the dwc3 binding has been
converted to YAML. See Greg's USB tree.

Also the DT changes should go through the arm-soc tree separately, so
we can stack on additional changes enabling USB3 on other boards.

ChenYu



> --
> Cameron
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
