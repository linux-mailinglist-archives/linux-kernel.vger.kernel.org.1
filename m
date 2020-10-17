Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD032911C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 14:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437852AbgJQMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 08:08:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58538 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437821AbgJQMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 08:08:18 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kTl0H-0008Qe-Kg; Sat, 17 Oct 2020 14:08:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        jagan@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] ARM: dts: rk3188: correct interrupt flags
Date:   Sat, 17 Oct 2020 14:08:04 +0200
Message-ID: <2926877.yplJhP9KA3@diego>
In-Reply-To: <20201002161128.GB4542@kozik-lap>
References: <20200917185211.5483-1-krzk@kernel.org> <20201002161128.GB4542@kozik-lap>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 2. Oktober 2020, 18:11:28 CEST schrieb Krzysztof Kozlowski:
> On Thu, Sep 17, 2020 at 08:52:10PM +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning:
> > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> > 
> > Correct the interrupt flags without affecting the code:
> >   ACTIVE_HIGH => IRQ_TYPE_NONE
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Not tested on HW.
> > 
> > Changes since v1:
> > 1. Correct title
> > ---
> >  arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Hi,
> 
> Any comments/review/testing from Heiko or other Rockchip folks? Shall I
> cc here someone?

I'm actually wondering about this ... I somehow remember writing a response,
but don't see it in my history - so it might have gotten lost before I
actually sent it.

I think the biggest issue I have is that none of that is tested on any
hardware and looking at other brcm wifi drivers in the kernel, the
interrupt polarity seems to be all over the place, some set it high,
some low and I even have seen edge triggers.

As all changes are in regard to (copied) brcm wifi node, it would be
really interesting to actually know what trigger is the right one.

I've Cc'ed Jagan who I think has worked on an affected board,
maybe he can check which trigger is correct.


Heiko



