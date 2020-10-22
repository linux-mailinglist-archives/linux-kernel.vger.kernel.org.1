Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4B295E08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897889AbgJVMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897878AbgJVMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:08:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:08:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m65so784136qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS6+CP1ltilZOm3pmrV9A+jmYbWMo1I1JmCFycZs1zk=;
        b=SeMf5i/aS2x9E5JTzW3LT5KVl9x8FyRNR1mSVpUsz3xKT5ADHkCb0oEd7k7DUAdW7c
         yIeeS22Q7HZ1yISUQzxNrBG+F/7rXFXUB2clr8+fhVX1Y0ceTHVqJmNpift8KynZzVXI
         8ryJEoTDOWhZUq4VoGhtkw33YprrTupX4SfroqeYAMTeY6D8s5ODDW8as1yI9+OqxDNy
         BIILIT0mXBMO3YhyZHjdGSSeU4GmsrK+JVscmJSF/4MZTx3vOmTZ6dqdY9NfBkX80aBv
         8V0W2dRQmX6g1KswyVmkSUU5hA5lH42JMGvDHwwaYskUZ0y0+F1XS8JKG0+VMmQU/zxv
         zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS6+CP1ltilZOm3pmrV9A+jmYbWMo1I1JmCFycZs1zk=;
        b=p009il7bOy0p6IHo0EduwI9NNwsOzNNrbXFuhOM2hEGAw0RXGNVx5e11/S4mxCYwfb
         gf5Zp2Etpmf+jRlMdV9yWL4tHk3lHDUvwuymCO8NKiD0KsjrueUqnQOi5oZPpzQ0Hgor
         LXzyItZIQVstc8TqHdDB+Xfpe50fTIOhjZ+duCzmSm8yPqWkDINnl7ah1k50zpUz5nZo
         MJlq/oWr1EyOYdvRj96F/b3SK8a3wFxMy20suEicinQCte4gVnSZ17ivs6QOUqOp+1wY
         7RPGFusqQTz7HHBTJ4KDb7QIrboA8eIkpA9yc1lsiHYxrxJ2quiZDJlxOt1aIiXObIN7
         dJEA==
X-Gm-Message-State: AOAM533zJqFrN5G0we+vNq4eCMMa7vhsVRCeYp2MaaLE7n39rYm+fcz2
        iCGaYcOfKihchKY6CqGrapPNAvD+gmT2LT09t/44xQ==
X-Google-Smtp-Source: ABdhPJwae4PbdaLza2pUQScdJt3BcKYNVW6EIEDp6C+VH8PT5g6A2k1eYi21e5cMTqW0LbvJxRs0X1kQkhPUYyTRLLg=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr1571445qtq.193.1603368504565;
 Thu, 22 Oct 2020 05:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
 <20200930163714.12879-3-daniel.gutson@eclypsium.com> <82bb95bd-988f-3cc2-40f7-8ebfd20b09d9@infradead.org>
In-Reply-To: <82bb95bd-988f-3cc2-40f7-8ebfd20b09d9@infradead.org>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 22 Oct 2020 09:08:13 -0300
Message-ID: <CAFmMkTFs-eOhyofpzEUusbx01HCbNmke6nct3HDqD3dsAmT_Nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Platform integrity information in sysfs (version 9)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 4, 2020 at 1:01 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/30/20 9:37 AM, Daniel Gutson wrote:
> > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > index 5c0e0ec2e6d1..e7eaef506fc2 100644
> > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
> >
> >  config SPI_INTEL_SPI
> >       tristate
> > +     depends on PLATFORM_INTEGRITY_DATA
>
> So SPI_INTEL_SPI_PCI selects SPI_INTEL_SPI:
>
> config SPI_INTEL_SPI_PCI
>         tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
>         depends on X86 && PCI
>         select SPI_INTEL_SPI
>
> without checking that PLATFORM_INTEGRITY_DATA is set/enabled.
>
> "select" does not follow any kconfig dependency chains, so when
> PLATFORM_INTEGRITY_DATA is not enabled, this should be causing
> a kconfig warning, which is not OK.

Since now SPI_INTEL_SPI_PCI can be enabled without PLATFORM_INTEGRITY_DATA
(thanks to the #ifdefs), I think I'll just remove the 'depends' and
will leave this as it was.

>
>
> --
> ~Randy
>


-- 


Daniel Gutson
Engineering Director
Eclypsium, Inc.


Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
