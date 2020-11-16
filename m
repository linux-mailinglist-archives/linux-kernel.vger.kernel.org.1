Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036F12B3FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKPJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgKPJVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:21:44 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF0122245;
        Mon, 16 Nov 2020 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605518503;
        bh=b5byWLi73FIB4AkZaeHzRRJ6/KF11eEptbPH75qogh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TnG5uA3eK/QvdGhkKy3OUnW7b91tVESOLw4UE9JLxbDTiOUtwvol5t+8kBV5DmIeS
         CFVCOuMVzC5WaYzmROs9hpQKprzmT84jJEbsEu9pd5fpHaV0OybiV2wJTMHQ/jyADP
         iLAAq++9VD9ChhPIuLSM57WRogict59gtf9VJ1KA=
Received: by mail-ot1-f49.google.com with SMTP id i18so15361332ots.0;
        Mon, 16 Nov 2020 01:21:43 -0800 (PST)
X-Gm-Message-State: AOAM5310TxhJlib/wWJdYFjobVcCdMN2UqrBjYhHbHvb3Zt/s2sOF5ST
        d1VpsZ3CMXdA0FmT+BCfzn6T0ugKnsYdN/gdVbo=
X-Google-Smtp-Source: ABdhPJw8hxifcwiSuV+k4eFBQZpBpVQHZoG8dYZ2fJIQrqmB3LyX7wdsBigy5N1ph9GdpMX8FSObr1Z0+PwsS3bT95o=
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr9500038otb.210.1605518502891;
 Mon, 16 Nov 2020 01:21:42 -0800 (PST)
MIME-Version: 1.0
References: <202011140757.5QyVghe2-lkp@intel.com> <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com> <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
In-Reply-To: <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 16 Nov 2020 10:21:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
Message-ID: <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 9:37 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Nov 16, 2020 at 9:33 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Mon, Nov 16, 2020 at 5:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 11/13/20 3:27 PM, kernel test robot wrote:
> > (adding s390 folks to cc)
> >
> > I think fixing this requires a larger-scale effort. I tried building
> > an s390 allmodconfig
> > with CONFIG_PCI disabled, and got warnings and failures in many other places,
> > see full log at the end of this mail.
> >
> > While in theory, all of those should depend on 'HAS_IOMEM' or some other symbol,
> > keeping these dependencies sounds like an uphill battle, and there is not much
> > to be gained from building the drivers for s390 on top of compile-testing them
> > on more conventional architectures.
>
> Don't we need the dependencies on HAS_IOMEM for the CONFIG_UML=y
> case, too?

I would have expected that as well, but I don't see the problem when building
an arch/um kernel, all I get is

ERROR: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!
ERROR: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource_byname"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
ERROR: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
ERROR: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
ERROR: modpost: "__open64_2" [fs/hostfs/hostfs.ko] undefined!

If I disable those five drivers, I can build and link a uml kernel without
warnings. I could not find the difference compared to s390 here.

Looking a bit further, I now find that we ended up disabling CONFIG_COMPILE_TEST
entirely for arch/um, which is clearly an option that would also work for s390.

     Arnd
