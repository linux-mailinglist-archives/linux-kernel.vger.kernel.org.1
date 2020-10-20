Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53B9293BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406135AbgJTMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:33:20 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52766 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405887AbgJTMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:33:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D67B5803071B;
        Tue, 20 Oct 2020 12:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p-CM0Wfp74i7; Tue, 20 Oct 2020 15:33:16 +0300 (MSK)
Date:   Tue, 20 Oct 2020 15:33:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/29] usb: dwc3: Discard synopsys,dwc3 compatibility
 string
Message-ID: <20201020123315.636cwjrajowihxa6@mobilestation.baikal.int>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-2-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VfS-f39uyb7GcFXPzgZLktWmXTESv798LvKY3-+-GQPrw@mail.gmail.com>
 <20201020122801.GB126891@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201020122801.GB126891@kozik-lap>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:28:01PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 20, 2020 at 03:15:06PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 20, 2020 at 3:02 PM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
> > > Discard a DW USB3 compatible string with the deprecated prefix seeing
> > > one isn't used by any dts file anymore.
> > 

> > I'm afraid it's no go.
> > It's an ABI from the moment when the driver started supporting this
> > compatible string.
> 
> Exactly.
> 
> Please mark the compatible as deprecated in bindings, correct the DTSes
> and optionally after one or two years (or any time later) remove the
> support for deprecated bindings.

Ok. I'll just get the original patch back then:
https://lore.kernel.org/linux-usb/20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru/T/#m0f92acafbd740e63b7156efac58850e0757d2110
and resend the series later after the rest of the patchset have been cooked
a bit.

-Sergey

> 
> Best regards,
> Krzysztof
> 
