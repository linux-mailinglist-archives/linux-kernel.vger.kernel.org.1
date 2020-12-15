Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E523A2DB4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLOTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgLOTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:55:05 -0500
X-Gm-Message-State: AOAM533pqk+EZNgornYxD5KyFdcLeRzJZxCMoaOFzpQJtxMaefHGWUYh
        J1Fvo51Sok9kLvkRRwcLmbcbS9jh6lObk53pWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608062065;
        bh=18sB+I2TiNDy9kX1hjtB0rhjFr3VDTG6jAxyNvY39wA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f+iCtE+TdnFo6Sfq2hOcFR6WJuCtZffDIeT/aHJS015z4K9qcZ5SpL0g1426j/RoB
         aHrthS2fPlhdv1y6GhmoH3zOIeVYB/2Ak95ZAYO/NFjzIzAKd+wzD5Qm/9ZUzssv5n
         r2njr1HQUPrJFrVSRK54DjrA/57Ls6NWpaPcj6FppGSeGdpXH2bwNLCsyvoJ/n+yUD
         c23XdESprqdroaF8EStpY/PraY5GMJbaSIE7XeEQatlJMdB+8NxSiW3KF6aoXPnGQe
         0+I7MIqMU49xRj41oR0soA8gCmg0X3o8N66VFV+6zq8C5PTEiPrqfTn3eWhLEwQblY
         K+k07TcBesjSQ==
X-Google-Smtp-Source: ABdhPJxDw7Ew29rP1Ct1BjvsIzMnGFJf5ITeYRP8RHWmBzY/KLqQ/8v1gnS5rktFU/5uW88LnC4Hm0oAsnqOEGqnnSk=
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr27585021ejb.360.1608062063367;
 Tue, 15 Dec 2020 11:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20201215155627.2513-1-nsaenzjulienne@suse.de> <20201215184407.GA44849@C02TF0J2HF1T.local>
 <1e0ad098ca7b1c13dbc6602285b77790b9cd54a1.camel@suse.de>
In-Reply-To: <1e0ad098ca7b1c13dbc6602285b77790b9cd54a1.camel@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Dec 2020 13:54:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJwUzBL+9E0jsTzAr4hTnGbGFUkD=xdTMJiFgYfpo4aFA@mail.gmail.com>
Message-ID: <CAL_JsqJwUzBL+9E0jsTzAr4hTnGbGFUkD=xdTMJiFgYfpo4aFA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Expose RPi4'd bootloader configuration
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 1:01 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Catalin,
>
> On Tue, 2020-12-15 at 18:44 +0000, Catalin Marinas wrote:
> > On Tue, Dec 15, 2020 at 04:56:20PM +0100, Nicolas Saenz Julienne wrote:
> > > Soon to be released versions of RPi4's firmware will take of care
> > > passing their bootloader's configuration to the OS by copying it into
> > > memory and creating a reserved memory node in the board's DT. In order
> > > to make use of this information, this series introduces a new generic
> > > nvmem driver that maps reserved-memory nodes into nvmem devices.
> > >
> > > An alternative approach, less nice IMO, would be to create a
> > > platform-specific 'soc' driver.
> >
> > What kind of information is this and how would the kernel use it?
>
> Sorry, I wasn't clear enough, the ultimate goal is to use this information from
> user-space, through nvmem's sysfs interface. The kernel itself has no use for
> it.

That still leaves the first question.

Rob
