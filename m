Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE862FD810
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404345AbhATSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:15:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:58205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404261AbhATSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611166012;
        bh=s728wzYIbYdle5xfYbWqiOhEQoRKoBch7rtQAFbwFyc=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=a/0YOn9N7VKS1HAB8zp3cEuu4kYcnlrZMCShigvLyUdLU0hjvTsW2VnT576ftsz/P
         FkqX4IKkYPc+iVBDof8vkR9lEDYjt6GHH1+ldmxNplm6Xwd8N0H7E3T3y7B6d8xeps
         4Yio1stD5csP0HTUvf+JeSirvF/G12uqo7XW0ZEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXtS-1lSaBo2iRs-00QSGC; Wed, 20
 Jan 2021 19:06:52 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <ce5692a9-e716-514a-f196-b0645bb03eb8@amazon.com>
Date:   Wed, 20 Jan 2021 19:06:48 +0100
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17579DC5-13AF-48E1-9B72-91B14AB485FA@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <ce5692a9-e716-514a-f196-b0645bb03eb8@amazon.com>
To:     Alexander Graf <graf@amazon.com>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:36mGhOIdaMFgmUcK9u+kNwy2WxgGVcBd6pCQBkv5WOo0+YK+QWn
 +IS0caAGOcJWfoYXbt0ai6X8q83BdvY6iRmjCs50rG6m47EdZEFEXFBVmjxxHQgwwn8OSIj
 ww3UyLxpOr874lovA2G0OlpNnkOFtvXXQjzeR7IroPnxxUuPEsodai2WthUZ8C7xklWItGM
 faDGxVHndMmUy7/LEV24Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNOjvAUoCog=:8Q0CgovfE+ZQtsbjcvjrGw
 rVsIdD5n9xlThuKdqsWGIIkOmxkbhUFn9NoCiKJQoJEKAB4P9/RyQZ1qVLDnkSVb92lqEqbAu
 mja1f2YAFS3IrEn8CprEXIYYr6U1+Q0PRJ4PiTfjMpE0fyNccPWOjkSnXHGVPXSL3qf3GEd1h
 Mt13THYTY/I6e9oNjIluTaCj40srXwxwA+n8dTkbCMlAeClIl868ql/cS+ItTlESCANCeHXDY
 U8Yn64S7sQZtySN/pZGLwnPXgBAkkQ4tS697qWiyeTIJwcgaXmw6OIuJnVvjki1kz6Wp6HXwR
 d5CPiQDSAMib6BQdETabra/0loQwubEu3CwLD6wcZTrv+aqdpnWPQnUCwuD5eqX3cxT2vudUy
 DTVe/TWBlQSi41rQkDD5SWnAqsWI2emuHc1TEOrrES6ZexAvbH3+a3dCLyBJwkGgu02nUV/R5
 qLhjgDEvzu/hhVK4DzLLCn36QK6vXigXk7u3Dujf57o++y7Z+e3bFovxmmbCwm7uLAKHYMPXD
 cjqAtsaKX7RWF1B3kKqJ8zeA64TXrAW4zYjPQxf6i6NlIkqMM0Qg78OAdIt0haDlEdkryllWT
 lGCrqdxOxooA6K0SC4smPnMcd/ZHD4cGswwwf5iddOTQQa6Jrwg27XU4Eri20xtZ4cLGmlJjs
 XBfvKsndujoSFM+4J6Qkus4sbip76jJOJkVE6wFGaa79dWl5TVmaqO3IixY8LyEUbP8IA1cmm
 N5vvlR8WEnvu+ddyM7K/2A1PAgXIxpLbsot9iWQzKsh37RPbIPShiz7QfmHd5Pq5s8hJzjAdV
 qlHKialNf+x7+VY61ZrYenGXBdF9yrpVeHe6CGSSSYH8JVn3nwM3/4YOFFUxlNaP+uatU5zW8
 5KaHKYEHK1wUvvBqSV8D/fBazvcsesBV4j/mhxwFk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Jan 2021, at 17:47, Alexander Graf <graf@amazon.com> wrote:
>=20
> On 20.01.21 14:27, Mohamed Mediouni wrote:
>> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious =
hardware quirk.
>> On Apple processors, writes using the nGnRE device memory type get =
dropped in flight,
>> getting to nowhere.
>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
>> ---
>>  arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 1f7ee8c8b7b8..06436916f137 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -51,6 +51,25 @@
>>  #define TCR_KASAN_HW_FLAGS 0
>>  #endif
>> +#ifdef CONFIG_ARCH_APPLE
>=20
> Is there any particular reason for this #ifdef?
>=20
>=20
> Alex
>=20
Not a particular reason, as we explicitly check for the implementer ID. =
However,
without CONFIG_ARCH_APPLE, other parts of the support for Apple CPUs
will not be available anyway.
>> +
>> +/*
>> + * Apple cores appear to black-hole writes done with nGnRE.
>> + * We settled on a work-around that uses MAIR vs changing every =
single user of
>> + * nGnRE across the arm64 code.
>> + */
>> +
>> +#define MAIR_EL1_SET_APPLE						=
\
>> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		=
\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
>> +
>> +#endif
>> +
>>  /*
>>   * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal =
memory and
>>   * changed during __cpu_setup to Normal Tagged if the system =
supports MTE.
>> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>>  	 * Memory region attributes
>>  	 */
>>  	mov_q	x5, MAIR_EL1_SET
>> +#ifdef CONFIG_ARCH_APPLE
>> +	mrs	x0, MIDR_EL1
>> +	lsr	w0, w0, #24
>> +	mov_q	x1, MAIR_EL1_SET_APPLE
>> +	cmp	x0, #0x61			// 0x61 =3D Implementer: =
Apple
>> +	csel	x5, x1, x5, eq
>> +#endif
>>  #ifdef CONFIG_ARM64_MTE
>>  	mte_tcr	.req	x20
>> --
>> 2.29.2
>=20
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

