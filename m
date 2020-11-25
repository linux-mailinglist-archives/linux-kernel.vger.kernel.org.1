Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA02C3BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKYJVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:21:41 -0500
Received: from smtp2.axis.com ([195.60.68.18]:59156 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgKYJVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=axis.com; l=1892; q=dns/txt; s=axis-central1;
  t=1606296099; x=1637832099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UN8d/Bn7UE75hgj+WxoXrW2QClIbhvnJu5cEVB3OKUY=;
  b=XisgcOEwCo6Mg46ZbrB8cLhZtE3Uo787Zf1WQ/Wh1fOYGG4ueuG2o8DT
   zPXb/r5blsINwVoZgla2oVSkQjDvcOjjzOQZEoWs+P5kx6G82Y2m3Gvk9
   7M7UCNoN482+EsWNj4YJKBB8FMEeOSTckT3WnM/YsaCWlFcbt6FZ1ikhi
   RwDLwfaZscAsxmsnpUKL0bf5OBLQQYZ0JbDp+8W3oJB+gGPcgCcxMsGaW
   wo9MZYFFhDXmGqRGtzSjRyKSot0XC2/odqUEPjkTfthWNSwtkQ92tFvMa
   VYS9Ki2l7b+vq0zD8RLfOAfuF7iaZb0+GRXKlmK/wF77y+k9Pfgbg/dbm
   g==;
IronPort-SDR: dzZ2pIx/Y4ya22PBk098LfDD27sHrDT0bV66IMpO+kyWTB6kyuURO9K1zs4BcWX/kAyZdfkmIW
 Koj8m/nfuWeNvx8bHXB0JWbv/0s0XJTQqACXxhfWZ0TqTW9a7AEFs6UUEshwIPPNziUf12NArx
 kpgCE5b8oSKFhvhmkXSZVBmfXi8EayiXu3O/S/UvyppzU5O3KrTCOZEYZhm53nrVM0XdJFeSBf
 deLELar44inV06r1ZhrqeajQWl9RzbyvObkElPdcGy2m+NmI0tip/N+aHAB2LWamwmEQ7w/nxu
 On8=
X-IronPort-AV: E=Sophos;i="5.78,368,1599516000"; 
   d="scan'208";a="14872264"
Date:   Wed, 25 Nov 2020 10:21:37 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Adam Ward <adam.ward@diasemi.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/9] regulator: Update DA9121 dt-bindings
Message-ID: <20201125092137.ehwfytsrr3x5vkiy@axis.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <20201120134742.y7bocaok3gcahbxt@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201120134742.y7bocaok3gcahbxt@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:47:42PM +0100, Vincent Whitchurch wrote:
> On Fri, Nov 20, 2020 at 01:14:50PM +0100, Adam Ward wrote:
> > -  buck1:
> > -    description:
> > -      Initial data for the Buck1 regulator.
> > -    $ref: "regulator.yaml#"
> > +  interrupt-parent:
> > +    maxItems: 1
> > +    description: Specifies the reference to the interrupt controller.
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: IRQ line information.
> > +
> > +  dlg,irq-polling-delay-passive:
> > +    maxItems: 1
> > +    description: |
> > +      Specify the polling period, measured in milliseconds, between interrupt status
> > +      update checks. Range 1000-10000 ms.
> > +
> > +  regulators:
> >      type: object
> > +    $ref: regulator.yaml#
> > +    description: |
> > +      This node defines the settings for the BUCK. The content of the
> > +      sub-node is defined by the standard binding for regulators; see regulator.yaml.
> > +      The DA9121 regulator is bound using their names listed below
> > +      buck1 - BUCK1
> > +      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
> 
> This move to a sub-node means that older devicetrees won't work. I
> assume that's fine since the driver is only in linux-next at the moment,
> but perhaps it's worth mentioning this in the commit message?

Actually, perhaps I'm missing something, but I don't quite see why this
move to a sub-node is needed.  There is some flexibility in the
regulator framework for this as I noted earlier
(https://lore.kernel.org/lkml/20201102154848.tm5nsydaukyd7rrw@axis.com/).
For the case of an MFD it certainly makes sense to have a "regulators"
sub-node but for these chips it seems rather redundant.

Also, perhaps you could split this patch into logical pieces too as Mark
has suggested for some of the other patches in this series?
