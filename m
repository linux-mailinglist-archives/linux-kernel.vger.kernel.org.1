Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4325A6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBHho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 03:37:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37210 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:37:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0827bakB010415;
        Wed, 2 Sep 2020 02:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599032256;
        bh=ioADAJbmdIrRMleIHtaIauggnI8c0YtChaGlXSHM/lw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=El+yaWgP+gQY7V1tM2WUYE0nDXqTVGMtciB/3sFL1qT3Lqvfxck2AFA6UUg1Elqni
         gvW7wTY7BeEqwmz6osRaLTyzc1djAvQgQOEkaHjSZvsfYvtqfefgCXITaXGl7mJ/+T
         hPpCawnKyJ6hAw82Zdy2KbUwdCG+FKfZ4omUhmaY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0827bard015843
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 02:37:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 02:37:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 02:37:36 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0827bXKs035768;
        Wed, 2 Sep 2020 02:37:34 -0500
Subject: Re: [RESEND PATCH 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe device
 tree nodes
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Tero Kristo <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200901140628.8800-1-kishon@ti.com>
 <20200901140628.8800-2-kishon@ti.com> <20200901145204.ayybrzqjcfhiqnfq@akan>
 <5f23246a-a9d7-495d-a4ec-d392ad95a450@ti.com>
Message-ID: <4b17cace-09d5-af8c-6e7f-9358cfdceb4d@ti.com>
Date:   Wed, 2 Sep 2020 13:07:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f23246a-a9d7-495d-a4ec-d392ad95a450@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 02/09/20 10:24 am, Kishon Vijay Abraham I wrote:
> Hi Nishanth,
> 
> On 01/09/20 8:22 pm, Nishanth Menon wrote:
>> On 19:36-20200901, Kishon Vijay Abraham I wrote:
>>> Add PCIe device tree node (both RC and EP) for the four
>>> PCIe instances here.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 218 ++++++++++++++++++++++
>>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
>>>   2 files changed, 222 insertions(+), 1 deletion(-)
>>
>>
>> Did you look at the diff of the dtbs_check before and after this
>> series? I see: https://pastebin.ubuntu.com/p/9fyfrTjx9M/
> 
> I didn't see any errors when I checked for individual bindings
> a0393678@a0393678-ssd:~/repos/linux$ mkconfig64 dtbs_check 
> DT_SCHEMA_FILES="Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml" 
> 
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>    DTC     arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
>    DTC     arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
>    CHECK   arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
>    CHECK   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
> a0393678@a0393678-ssd:~/repos/linux$ mkconfig64 dtbs_check 
> DT_SCHEMA_FILES="Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml" 
> 
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>    DTC     arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
>    DTC     arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
>    CHECK   arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
>    CHECK   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml

Can you give hint on why I get ranges is too long error
https://pastebin.ubuntu.com/p/cPm2tg3dcV/ which I give mkconfig64 
dtbs_check but don't see an error when I include "DT_SCHEMA_FILES"?

Thanks
Kishon

>>
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi 
>>> b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> index 00a36a14efe7..a36909d8b8c3 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> @@ -28,6 +28,26 @@
>>>           #size-cells = <1>;
>>>           ranges = <0x0 0x0 0x00100000 0x1c000>;
>>> +        pcie0_ctrl: pcie-ctrl@4070 {
>> https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf 
>>
>> Section 2.2.2: why not use syscon@4070 and so on?
> 
> okay, will change to generic name.
>>
>>> +            compatible = "syscon";
>>> +            reg = <0x00004070 0x4>;
>>> +        };
>>> +
>>> +        pcie1_ctrl: pcie-ctrl@4074 {
>>> +            compatible = "syscon";
>>> +            reg = <0x00004074 0x4>;
>>> +        };
>>> +
>>> +        pcie2_ctrl: pcie-ctrl@4078 {
>>> +            compatible = "syscon";
>>> +            reg = <0x00004078 0x4>;
>>> +        };
>>> +
>>> +        pcie3_ctrl: pcie-ctrl@407c {
>>> +            compatible = "syscon";
>>> +            reg = <0x0000407c 0x4>;
>>> +        };
>>> +
>>>           serdes_ln_ctrl: serdes-ln-ctrl@4080 {
>>>               compatible = "mmio-mux";
>>>               reg = <0x00004080 0x50>;
>>> @@ -576,6 +596,204 @@
>>>           };
>>>       };
>>> +    pcie0_rc: pcie@2900000 {
>>> +        compatible = "ti,j721e-pcie-host";
>>> +        reg = <0x00 0x02900000 0x00 0x1000>,
>>> +              <0x00 0x02907000 0x00 0x400>,
>>> +              <0x00 0x0d000000 0x00 0x00800000>,
>>> +              <0x00 0x10000000 0x00 0x00001000>;
>>> +        reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
>>> +        interrupt-names = "link_state";
>>> +        interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
>>> +        device_type = "pci";
>>> +        ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
>>> +        max-link-speed = <3>;
>>> +        num-lanes = <2>;
>>> +        power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
>>> +        clocks = <&k3_clks 239 1>;
>>> +        clock-names = "fck";
>>> +        #address-cells = <3>;
>>> +        #size-cells = <2>;
>>> +        bus-range = <0x0 0xf>;
>>> +        vendor-id = <0x104c>;
>>> +        device-id = <0xb00d>;
>>> +        msi-map = <0x0 &gic_its 0x0 0x10000>;
>>> +        dma-coherent;
>>> +        ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 
>>> 0x0010000>,
>>> +             <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
>>> +        dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>> +    };
>>> +
>>> +    pcie0_ep: pcie-ep@2900000 {
>> Not related to this patch, but just a suggestion: pcie-ep -> do we
>> need to add that to the Generic names in DT spec?
>>
>> [...]
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi 
>>> b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>> index f787aa73aaae..eeb02115b966 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>> @@ -132,9 +132,12 @@
>>>                <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* 
>>> USBSS1 */
>>>                <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* 
>>> Most peripherals */
>>>                <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* 
>>> MAIN NAVSS */
>>> -             <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* 
>>> PCIe Core*/
>>> +             <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* 
>>> PCIe Core*/
>>> +             <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* 
>>> PCIe Core*/
>>>                <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* 
>>> PCIe DAT */
>>                                         ^^
>>                                     should be PCIe1?
>> Just because you are introducing PCIe2,3 in this patch, the net result
>> does'nt look consistent? Also might want to cover this change in the
>> $commit_message.
> 
> yeah, we could have a separate patch for this change.
> 
> Thanks
> Kishon
> 
>> [...]
>>>                <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* 
>>> C71 */
>>> +             <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* 
>>> PCIe2 DAT */
>>> +             <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* 
>>> PCIe3 DAT */
>>>                <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* 
>>> C66_0 */
>>>                <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>, /* 
>>> C66_1 */
>>>                <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* 
>>> GPU */
>>> -- 
>>> 2.17.1
>>>
>>
