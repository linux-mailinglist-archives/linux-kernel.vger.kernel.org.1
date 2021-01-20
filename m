Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCE2FD7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391905AbhATSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:08:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:59725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404304AbhATSGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611165873;
        bh=IrAz5mOTQmsM3rsPA45KaPwOEB3FHXkB2MRnguBbGww=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=KmBiDG+Z5gHR0SUFcO/9PuKAivZLXzglGFZPZE55kByxr1rpgydAhvosSuQ2Rv5Xc
         W9bOCn+c6UorY8XWNJkW2SHlKlP2KQdWGNarOoG9BCA0LZClwaVuhMjgk+j69Z0WSh
         PhrpC/7nqEb/l2OJPEkCvbpGphkx6tfpipXSVRIc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1lhf0B0z6k-00fWGg; Wed, 20
 Jan 2021 19:04:33 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <171d8c3f-aa0c-4416-b0d7-d35a47c7acc3@amazon.com>
Date:   Wed, 20 Jan 2021 19:04:28 +0100
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78D5E843-42FC-4186-9D94-30F067FA9EAD@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
 <171d8c3f-aa0c-4416-b0d7-d35a47c7acc3@amazon.com>
To:     Alexander Graf <graf@amazon.com>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:khflWZYUyO9KxEBLFkUpj+hzYUKIv+CRC+tFI+L9NwEbo7MhNAW
 9cykUCMQVYhi8pvgk6qAfptW6yhtxSKzg6c7e+upqNMIggtglHd7kHEFWY+sDtizmv/O7jg
 NX+Lep2wUMo7Gn39a4IGYRERSfewFvSokMKlEMrt7VXLq8bVbxIkjnWrKiewoNvI8VV9mID
 l6/mPoROrmk+Qc6AIX38g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gKhJj9jjUNE=:IIoyMmaf0OsPcOAwbQoYZF
 7KjXN1Dp8OSHZeNnOdXVHsGH5xdTnAzgg33NJclFPWvbWYRiX7ucyUATf7szuKDNzP6venbPB
 w4hDsARA2EpZN+OAZP/dI5tvuzkRF2B9jn6FO6WAbB3SnjNSR9mSRUb0o6FI2suzuHj5ffssa
 jZTgUvE0rrlv6l1fGj+iUY5nuYBLdW9gkHn9qUIREzAA00Q9si56JC90av134jNdpp+TKet1q
 548fL7HKe3qeKnAgA8RshdG17NLYnDwrWhzt48oZinA22GY3WOCLvDxqFtB2LCO16AG7B6JZG
 84Whh+XxNYe4J6ffeufn9MFG1bj/3g+V49aO9MmWw7puZGkfEymBA5ZwBBYjv/G35Js1fiXM+
 lQVry4HoK9RG0l6QQE9zWjNrDrk2JL8ylUN+I85ps+wimaEo1CQ4IAv5lMLev5d7nydg9mJkE
 QEG5pRqZqN7qVoAeTe2GMOPvTweR6sKx+3Dyrb0WULiAcN7b0/6YrM5pWXeoYuHihCEOewMjO
 gLkx/88uG0ZGMr5B5pRUbzi7jZc80D5F/pbzU4W0JpEgD61gcBUfYIKJYD9ZPJ7P5KAdRV8ah
 BFR3hJwZ03WQJW46E9Np3DjToC6madRfs11VbJJsD7sS6STDMOQT09b82h1aOy88Rb3Rgl8Av
 fE8i4UeHVQg5BELtS4OZzd+X9fSejV+GVH2jxWqerC8VqjubhwQgVtcEiM3aMmhs5F4MbQISX
 hK9e0DP2SIWifZozlj5jU6DHAaGqBYmKEkVIy0JMSpcwSWh4wPXPLqt1hEMtjxuEfJThaUav/
 d5GNvSqoivrRi6hauwykcjmrjO3DjlBGe8elH9LlkHVySrmmNbubY3rFiQ6CbppBNfUT1R+2x
 yhhorEUemZ29PS+8yxMweKsKiNcYhSnyrUroCtDSY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Jan 2021, at 18:11, Alexander Graf <graf@amazon.com> wrote:
>=20
> On 20.01.21 14:27, Mohamed Mediouni wrote:
>> From: Stan Skowronek <stan@corellium.com>
>> Apple SoCs use the Apple AIC interrupt controller.
>> The Arm architectural timers is wired over FIQ on that hardware.
>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
>> ---
>>  .../interrupt-controller/apple,aic.yaml       |  49 ++++
>>  MAINTAINERS                                   |   6 +
>>  drivers/irqchip/Kconfig                       |   6 +
>>  drivers/irqchip/Makefile                      |   1 +
>>  drivers/irqchip/irq-apple-aic.c               | 211 =
++++++++++++++++++
>>  5 files changed, 273 insertions(+)
>>  create mode 100644 =
Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>>  create mode 100644 drivers/irqchip/irq-apple-aic.c
>> diff --git =
a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml =
b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> new file mode 100644
>> index 000000000000..e615eaaca869
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: =
http://devicetree.org/schemas/interrupt-controller/apple,aic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple Advanced Interrupt Controller (AIC)
>> +
>> +description:
>> +  Interrupt controller present on Apple processors. AIC
>> +  is used by Apple on their AArch64 SoCs since the Apple A7.
>> +
>> +maintainers:
>> +  - Stan Skowronek <stan@corellium.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: apple,aic
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#interrupt-cells':
>> +    const: 3
>> +
>> +  interrupt-controller: true
>> +
>> +  fast-ipi:
>> +    description:
>> +      Fast IPI support.
>> +
>> +required:
>> +  - compatible
>> +  - '#interrupt-cells'
>> +  - interrupt-controller
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +        aic: interrupt-controller@23b100000 {
>> +             compatible =3D "apple,aic";
>> +             #interrupt-cells =3D <3>;
>> +             interrupt-controller;
>> +             reg =3D <0x2 0x3b100000 0x0 0x8000>;
>> +             fast-ipi;
>> +         };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00836f6452f0..e609ede99dd4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1218,6 +1218,12 @@ T:	git =
git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
>>  F:	Documentation/admin-guide/LSM/apparmor.rst
>>  F:	security/apparmor/
>> +APPLE ADVANCED INTERRUPT CONTROLLER DRIVER
>> +M:	Stan Skowronek <stan@corellium.com>
>=20
> Signing someone else up for maintainership is ... unusual :). Do you =
have buy in from Stan that he'll be responsive and handle patch reviews?

Yeah, I asked Corellium about it explicitly. :)

>> +L:	linux-arm-kernel@lists.infradead.org
>> +S:	Maintained
>> +F:	drivers/irqchip/irq-apple-aic.c
>> +
>=20
>=20
> Alex
>=20
>=20
>=20
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879

