Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6C2FEE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbhAUPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:15:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:44433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732585AbhAUPOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611241929;
        bh=VZZt5/tYu9Y8TbzRi7bwy/UykC8836/8CYl6jj8EU4A=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Qpelg0l2s1MuBxenZi1JeQusZi8qXNvIrkZrhkqV/bHnhLv9R/k8N9gDXPq7Q74Zi
         O/A6QEEtuLpIY1OrnZg4wwQZkCvMF7KoSOAlkVpAf3D0fFcqqPbjwvqqCPjzrwynYz
         zE8QL/h76P035zxUTlmocbNtqIiP9JfGawPURITE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ygz-1l0foo01rn-0036VC; Thu, 21
 Jan 2021 16:12:09 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <20210121124742.GA22123@willie-the-truck>
Date:   Thu, 21 Jan 2021 16:12:04 +0100
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39067FDD-F7D3-4F37-8B43-1A9FCF80EEE5@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
 <20210121124742.GA22123@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:Lfzx9BQBL4XONDrOMjPKRKcebLeFvTdWkCc+LrVGXBKUw+LPD5n
 9pNSHlkRAEdNF91pw+JhiQ/m7Eywn+FcQiSw8alkmeI0NQm2OPrNZIA+YtFyc2mIpe+dGIf
 0lxjExHTlggVDI4WAYd1AId1bMdF9LZndrOVS9MrREEepf5L3CTciefenN1kLDH2eMrSCmB
 fPjFnoa9i+T47TD45uTWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8E7dhoj/u0=:zW2KodPpMLkBjXeQ2oQXTL
 VSP2qrNtrqxGdZTAomTywAGroVixBV/NAODD4yUjn4cU/kgpD2CsYRCyPZpdBdDWwESWussPS
 Awq1AL3pwwPURi57Q3+E5xgzTFMbSYSQQHjNiAgxZrBPpIO3X6xddgN+Sc5wBgSPF8j4jWiQY
 Qg8+oCeDpJgUOUIxDmAGJYILvqSC1udPl+teksIGhVVH7CqTWJBnb1MthHg+gie7olIvTGul/
 pav+U4Gw25Ey7WzifIqzNVszRlB+ePxIx6LViGCsZqoL1zu0GhzLUoCrfT9xMN07uKfzfyQQK
 uHlD+kDzpQjRojR1hrOUzIvFCZFZwpcrIYMZxjSaMG48F9OMsT1rlvaYjM/ox9q/b93OWwfPH
 Y9+DapcG0yjw4RS1mr237wCNydxeMK1InT1SghPVFPTPpOIVtjfKsyq3LxtXu8NYjD6LI/mZj
 JCDXfXT/HCWHmMq8XwyxqAKvqR0Z343j8L6RNsCyjZqOWsTJSOjR+G1nc9v6NQ4TeHGysVn6U
 w6Rx/F2djTISrYMUHSeLRiW1jq5PnHWCT+aVtGq/8U87LNFaquSg/8zKNo+aJLswHaXIzjdr0
 0LhgSV7VSiHWAvnpHSNZOoNfZ57nJaVqH3vQlVzw7159vGDbNxEL6yaF/IATlXENGx9UXNCIL
 04PGodc5IqeB9g2MPAJ4NlR9Nip/duPqKZ7NIA081O18QpDs8rydbsjaU2Uwfc/rNarijpMLA
 gYmDV1D3Soqyx9fly516mIxQwEfQEefffqgCFD+hukUFON/24t30r2yyX/rxokoB8dnHy0Ldz
 LooKkPNUsbKCtIGPlfxpUK8R/0Pf29GZxawwvhR5yHmNuZOq3whtJZl3GVeVkUAQGOFrzquMV
 36UZoliCHZbUfiSKGQoKCiM80f4XmppOksYIl2WIM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 13:47, Will Deacon <will@kernel.org> wrote:
>=20
> On Thu, Jan 21, 2021 at 11:44:23AM +0000, Marc Zyngier wrote:
>> On 2021-01-21 11:27, Will Deacon wrote:
>>> On Wed, Jan 20, 2021 at 02:27:13PM +0100, Mohamed Mediouni wrote:
>>>> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious
>>>> hardware quirk.
>>>>=20
>>>> On Apple processors, writes using the nGnRE device memory type get
>>>> dropped in flight,
>>>> getting to nowhere.
>>>>=20
>>>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>>>> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
>>>> ---
>>>> arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>>>> 1 file changed, 26 insertions(+)
>>>>=20
>>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>>> index 1f7ee8c8b7b8..06436916f137 100644
>>>> --- a/arch/arm64/mm/proc.S
>>>> +++ b/arch/arm64/mm/proc.S
>>>> @@ -51,6 +51,25 @@
>>>> #define TCR_KASAN_HW_FLAGS 0
>>>> #endif
>>>>=20
>>>> +#ifdef CONFIG_ARCH_APPLE
>>>> +
>>>> +/*
>>>> + * Apple cores appear to black-hole writes done with nGnRE.
>>>> + * We settled on a work-around that uses MAIR vs changing every
>>>> single user of
>>>> + * nGnRE across the arm64 code.
>>>> + */
>>>> +
>>>> +#define MAIR_EL1_SET_APPLE						=
\
>>>> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		=
\
>>>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
>>>> +
>>>> +#endif
>>>> +
>>>> /*
>>>>  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal
>>>> memory and
>>>>  * changed during __cpu_setup to Normal Tagged if the system
>>>> supports MTE.
>>>> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>>>> 	 * Memory region attributes
>>>> 	 */
>>>> 	mov_q	x5, MAIR_EL1_SET
>>>> +#ifdef CONFIG_ARCH_APPLE
>>>> +	mrs	x0, MIDR_EL1
>>>> +	lsr	w0, w0, #24
>>>> +	mov_q	x1, MAIR_EL1_SET_APPLE
>>>> +	cmp	x0, #0x61			// 0x61 =3D Implementer: =
Apple
>>>> +	csel	x5, x1, x5, eq
>>>=20
>>> Why does this need to be done so early? It would be a lot cleaner if =
we
>>> could detect this in a similar fashion to other errata and update =
the
>>> MAIR
>>> appropriately. If that's not possible because of early IO mappings
>>> (which
>>> ones?), then we could instead initialise to nGnRnE unconditionally, =
but
>>> relax it to nGnRE if we detect that we _don't_ have the erratum.
>>=20
>> Would that imply another round-trip into the idmap, much like we do
>> when we switch to non-global mappings? Or do you expect that we can =
change
>> the MAIR with live mappings?
>=20
> I think we should be able to change it live and then invalidate the =
TLB. At
> least, my reading of the BBM requirements suggests that it isn't =
required
> for changing between different types of device memory. I can seek
> clarification from Arm if necessary.
>=20
Please ignore that patch.

It turns out that the PCIe controller on Apple M1 expects posted writes =
and so the memory range for it ought to be set nGnRE.=20
So, we need to use nGnRnE for on-chip MMIO and nGnRE for PCIe BARs.

The MAIR approach isn=E2=80=99t adequate for such a thing, so we=E2=80=99l=
l have to look elsewhere.

Thank you,
> Will

