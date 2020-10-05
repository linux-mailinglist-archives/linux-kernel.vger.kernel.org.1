Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53A28354B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJEMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:02:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:02:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095C2VYW003925;
        Mon, 5 Oct 2020 07:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601899351;
        bh=7e6FoBB+l9eBlwfzRMeBLOM9X8Im0mRKKOhVL5kZdTc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VvmExfSLkJYJLFG2iokpftPXH/2t4Sq4PjrIiQkONokzYZBLzfXGSirSoWMj63J0E
         PaRgDC30PpymXs3Oze06idfpkmPrCVyiqv8x2EmTaSrcNMZg33UFCSe+bCNdr40LCU
         TPus9wgxnV35FUrXoxE3bErLGcF2OJd047T1xihg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095C2VrM073032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 07:02:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 07:02:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 07:02:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095C2TcU023448;
        Mon, 5 Oct 2020 07:02:30 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
To:     Nishanth Menon <nm@ti.com>
CC:     <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
Date:   Mon, 5 Oct 2020 15:02:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005115805.d6yhykn7oc6x2tbu@charm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2020 14.58, Nishanth Menon wrote:
> On 10:48-20201005, Peter Ujfalusi wrote:
>> Add the nodes for McASP 0-2 and keep them disabled because several
>> required properties are not present as they are board specific.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 57 ++++++++++++++++++++++=
+
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/bo=
ot/dts/ti/k3-j7200-main.dtsi
>> index 72d6496e88dd..cc6c2a81887a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -446,4 +446,61 @@ usb0: usb@6000000 {
>>  			dr_mode =3D "otg";
>>  		};
>>  	};
>> +x
>> +	mcasp0: mcasp@02b00000 {
>> +		compatible =3D "ti,am33xx-mcasp-audio";
>> +		reg =3D <0x0 0x02b00000 0x0 0x2000>,
>> +			<0x0 0x02b08000 0x0 0x1000>;
>> +		reg-names =3D "mpu","dat";
>> +		interrupts =3D <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
>> +				<GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names =3D "tx", "rx";
>> +
>> +		dmas =3D <&main_udmap 0xc400>, <&main_udmap 0x4400>;
>> +		dma-names =3D "tx", "rx";
>> +
>> +		clocks =3D <&k3_clks 174 40>;
>> +		clock-names =3D "fck";
>> +		power-domains =3D <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
>> +
>> +		status =3D "disabled";
>=20
> I see that there is inconsistent usage of "disabled" in our SoC.dts
>=20
> Our generic rule has been set them to disabled in board.dtsi
> McASP and DSS for existing SoC dts do not follow this.. which is a tad
> confusing.. (considering that not even all uarts come out on every boar=
d
> and every uart needs pinmux to function..)

"keep them disabled because several required properties are not present
as they are board specific."

In board file the enabled mcasp must be updated with options that is
required for operation. Without those option the McASP can not be
initialized.

I think we have been revisiting the very same discussion every time we
have a new SoC with McASP...

>=20
> Tero: Thoughts?
>=20
> [...]
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

