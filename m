Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDFF29A9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416639AbgJ0KnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416459AbgJ0KnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:43:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF3920878;
        Tue, 27 Oct 2020 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603795398;
        bh=9xct4VMCLTysA5w62/oZl+mDE0ef0nCaSzhqCDmXkq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FIwpp9hh8WoXKbWxP3ISKbkoJJlp285sqgNnjAyr2LsNSMyWU/B/9/aycCet7fvlv
         ujUJ9BSc9PyXPMdLOedWByabA01gdgt476UqAM+b7pChaVxkT7jwKghYKO8clhhVpz
         Hzvm2edI+BgRgEpJkS1RXgcWjGGp38TJ/qSixT1k=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kXMRg-004ejb-Qd; Tue, 27 Oct 2020 10:43:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 10:43:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
Cc:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Leo Li <leoyang.li@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>, tglx@linutronix.de,
        jason@lakedaemon.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
In-Reply-To: <HE1PR0401MB2444AA759104F4A34F91B61F8F160@HE1PR0401MB2444.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <d5d6deb90b4b3d086024fcf01b737da9@kernel.org>
 <HE1PR0401MB2444AA759104F4A34F91B61F8F160@HE1PR0401MB2444.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e6cd6eecb0221742548e657faf211733@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 10:35, Biwen Li (OSS) wrote:
>> 
>> On 2020-10-27 04:46, Biwen Li wrote:
>> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> >
>> > Add an new IRQ chip declaration for LS1043A and LS1088A
>> > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
>> > SCFG_INTPCR[31:0]
>> >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
>> >   reverse)
>> > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
>> >
>> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
>> 
>> You clearly couldn't be bothered to read what I wrote in my earlier 
>> replies. I'm
>> thus ignoring this series...
> Okay, got it.
>> 
>> > ---
>> > Change in v2:
>> > 	- add despcription of bit reverse
>> > 	- update copyright
>> >
>> >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
>> >  1 file changed, 9 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/irqchip/irq-ls-extirq.c
>> > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
>> > 100644
>> > --- a/drivers/irqchip/irq-ls-extirq.c
>> > +++ b/drivers/irqchip/irq-ls-extirq.c
>> > @@ -1,5 +1,8 @@
>> >  // SPDX-License-Identifier: GPL-2.0
>> > -
>> > +/*
>> > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> > + * Copyright 2020 NXP
>> 
>> ... specially when you keep attributing someone else's copyright to 
>> NXP.
> Then I don't know how to add the copyright, any suggestions?

Simple. You don't add anything. NXP's copyright doesn't apply to this
file before this patch, and your changes are so trivial that they don't
really warrant a mention. Furthermore, the git history already keeps 
track
of who did what.

         M.
-- 
Jazz is not dead. It just smells funny...
