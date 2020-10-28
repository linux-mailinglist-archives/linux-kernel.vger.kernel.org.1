Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F174129D47F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgJ1Vwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgJ1VwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:24 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697B1247D6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603900296;
        bh=JoChdc22/lzEmuD6MlvdPOHMj4dkds+Jzu08+926d50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b0Sq2vNB74ESDTTbwNfZdyc/Rra83O89BizWQ1E0UBwWkMReK9DE5eJ00cG7wjpKn
         kgCL/Ny79uRwqxiSjR45hqanU+9t936lHXUcxdqKy+wOHaK1mw0K2W6AzysyhwYJJV
         XhkdqPf98uqzs7Ui5wsgSP4t1slguc45ANmlgQTg=
Received: by mail-qk1-f177.google.com with SMTP id a23so4923519qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 08:51:36 -0700 (PDT)
X-Gm-Message-State: AOAM533FaiVvKA1t/Qp/TDfm/NSUFxbbk7nBtLOYDPRzHDU3EidpnveE
        Dg8AG4UQWiIneLkCRPhA9EQ2pCPKgeVH5grmE+k=
X-Google-Smtp-Source: ABdhPJx2TW5/mPjgEOw3/KGkm7cEHBNii3GH9svtlUZbwy/bzy0V3MywWysSB+5uaPei4Z8ak09NSKb6VOoZHmJVH8o=
X-Received: by 2002:a05:620a:215d:: with SMTP id m29mr7928629qkm.138.1603900295527;
 Wed, 28 Oct 2020 08:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
 <20201027175806.20305-4-andriy.shevchenko@linux.intel.com> <CAK8P3a3XgTD2bFej0=WsD3a=uMur36_C71EiOvw3wb5A9QPAfQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3XgTD2bFej0=WsD3a=uMur36_C71EiOvw3wb5A9QPAfQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 28 Oct 2020 16:51:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2L2FWj2z6w_cgz41sg=AXJJ2gEC8Z+wC8FUY6Uq9TdDw@mail.gmail.com>
Message-ID: <CAK8P3a2L2FWj2z6w_cgz41sg=AXJJ2gEC8Z+wC8FUY6Uq9TdDw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] misc: pvpanic: Combine ACPI and platform drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending from the kernel.org address because of bounces)

On Tue, Oct 27, 2020 at 11:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 27, 2020 at 6:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> >  static int pvpanic_mmio_probe(struct platform_device *pdev)
> >  {
> > -       base = devm_platform_ioremap_resource(pdev, 0);
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *res;
> > +
> > +       res = platform_get_mem_or_io_resource(pdev, 0);
> > +       if (res && resource_type(res) == IORESOURCE_IO)
> > +               base = devm_ioport_map(dev, res->start, resource_size(res));
> > +       else
> > +               base = devm_ioremap_resource(dev, res);
>
> Maybe this could already be combined into a devm_platform_iomap_resource()
> similar to pci_iomap()?
>
>         Arnd
