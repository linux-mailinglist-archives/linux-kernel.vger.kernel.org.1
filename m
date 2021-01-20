Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E982FD6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391054AbhATRQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:16:32 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:48863 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbhATRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611162767; x=1642698767;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cdvhdSc+KJ2muMQJyh5ViJwhF3It4JZRnpRi6+TvWVQ=;
  b=L8FX8NlLlqtuJJdKd/DnB1v0pK18MN3H799Bp7UxPEDA3l5GA/vLRWLv
   efU8OUyOdusrqSWwf+HrEccI/pedYYbS1z9Kou9E+m8RAzSFUdtet/6qy
   InA7R0rYMsrv9Z5RcBTkVRRMgVohx1JOXmILedC78B/m+M7f2+bnLJDhc
   I=;
X-IronPort-AV: E=Sophos;i="5.79,361,1602547200"; 
   d="scan'208";a="912082822"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 20 Jan 2021 17:11:25 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id 12F8FA26B9;
        Wed, 20 Jan 2021 17:11:22 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 17:11:22 +0000
Received: from edge-m1-r3-201.e-iad16.amazon.com (10.43.160.66) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 17:11:20 +0000
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <171d8c3f-aa0c-4416-b0d7-d35a47c7acc3@amazon.com>
Date:   Wed, 20 Jan 2021 18:11:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120132717.395873-5-mohamed.mediouni@caramail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D36UWB004.ant.amazon.com (10.43.161.49) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 14:27, Mohamed Mediouni wrote:
> From: Stan Skowronek <stan@corellium.com>
> =

> Apple SoCs use the Apple AIC interrupt controller.
> The Arm architectural timers is wired over FIQ on that hardware.
> =

> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> ---
>   .../interrupt-controller/apple,aic.yaml       |  49 ++++
>   MAINTAINERS                                   |   6 +
>   drivers/irqchip/Kconfig                       |   6 +
>   drivers/irqchip/Makefile                      |   1 +
>   drivers/irqchip/irq-apple-aic.c               | 211 ++++++++++++++++++
>   5 files changed, 273 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controll=
er/apple,aic.yaml
>   create mode 100644 drivers/irqchip/irq-apple-aic.c
> =

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,ai=
c.yaml
> new file mode 100644
> index 000000000000..e615eaaca869
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.ya=
ml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/apple,aic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Advanced Interrupt Controller (AIC)
> +
> +description:
> +  Interrupt controller present on Apple processors. AIC
> +  is used by Apple on their AArch64 SoCs since the Apple A7.
> +
> +maintainers:
> +  - Stan Skowronek <stan@corellium.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: apple,aic
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 3
> +
> +  interrupt-controller: true
> +
> +  fast-ipi:
> +    description:
> +      Fast IPI support.
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        aic: interrupt-controller@23b100000 {
> +             compatible =3D "apple,aic";
> +             #interrupt-cells =3D <3>;
> +             interrupt-controller;
> +             reg =3D <0x2 0x3b100000 0x0 0x8000>;
> +             fast-ipi;
> +         };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00836f6452f0..e609ede99dd4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1218,6 +1218,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/g=
it/jj/linux-apparmor
>   F:	Documentation/admin-guide/LSM/apparmor.rst
>   F:	security/apparmor/
> =

> +APPLE ADVANCED INTERRUPT CONTROLLER DRIVER
> +M:	Stan Skowronek <stan@corellium.com>

Signing someone else up for maintainership is ... unusual :). Do you =

have buy in from Stan that he'll be responsive and handle patch reviews?

> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/irqchip/irq-apple-aic.c
> +


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



