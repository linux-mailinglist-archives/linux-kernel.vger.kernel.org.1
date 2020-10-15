Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3E28F664
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbgJOQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:07:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36610 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbgJOQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:07:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7D5DE1F45C3D
Subject: Re: [PATCH] arm64: dts: mediatek: Add smi_common node for MT8183
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, weiyi.lu@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, fparent@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001162823.3592352-1-enric.balletbo@collabora.com>
 <d937daf7-469f-8d74-4267-057b89cf1dd1@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <dbb00f05-6c1f-e5a2-12ae-aca494ecc6da@collabora.com>
Date:   Thu, 15 Oct 2020 18:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d937daf7-469f-8d74-4267-057b89cf1dd1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/10/20 11:17, Matthias Brugger wrote:
> 
> 
> On 01/10/2020 18:28, Enric Balletbo i Serra wrote:
>> The SMI (Smart Multimedia Interface) Common is a bridge between the m4u
>> (Multimedia Memory Management Unit) and the Multimedia HW. This block is
>> needed to support different multimedia features, like display, video
>> decode, and camera. Also is needed to control the power domains of such
>> HW blocks.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index c2fd141afcf6..9082bc65e15e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -916,6 +916,16 @@ mmsys: syscon@14000000 {
>>               #clock-cells = <1>;
>>           };
>>   +        smi_common: smi@14019000 {
>> +            compatible = "mediatek,mt8183-smi-common", "syscon";
>> +            reg = <0 0x14019000 0 0x1000>;
>> +            clocks = <&mmsys CLK_MM_SMI_COMMON>,
>> +                 <&mmsys CLK_MM_SMI_COMMON>,
>> +                 <&mmsys CLK_MM_GALS_COMM0>,
>> +                 <&mmsys CLK_MM_GALS_COMM1>;
>> +            clock-names = "apb", "smi", "gals0", "gals1";
>> +        };
>> +
> 
> Having a look at the bindings description, it states that the power-domains
> phandle is a required property.

Hmmm, this makes me think that there is a kind of circular dependency for
MT8183, so MT8183 power domains depends on smi_common and smi_common depends on
MT8183 power domains. Will take a deeper look.

Thanks
  Enric


> So I suppose you have to base this on the power domains series.
> 
> Regards,
> Matthias
> 
>>           imgsys: syscon@15020000 {
>>               compatible = "mediatek,mt8183-imgsys", "syscon";
>>               reg = <0 0x15020000 0 0x1000>;
>>
