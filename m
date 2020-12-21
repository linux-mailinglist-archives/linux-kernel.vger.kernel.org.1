Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA72DF7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgLUDMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 22:12:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46588 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgLUDMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 22:12:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BL3AfZr117456;
        Sun, 20 Dec 2020 21:10:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608520241;
        bh=SMyjN5z/FXWUBO/i/3i4kOx6PLSGxqxTjKv9nr6JzJc=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=aWfWDJnuHuyKHIea6mbzz8M9ZifEGRtOmRrjGzrparYtMS8SdO8lVIG1+D0lm1DMc
         hPuvXbUujm4Tm7RbKkD3mPdL6ORcxU1Twg8VKPOqAL8P4+N32YokNynFt2mOH/RI3f
         r/AA+FRv4fn9BJatbwWZ7DBTSShPZ+r35L4hvhKM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BL3AfYs115093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Dec 2020 21:10:41 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 20
 Dec 2020 21:10:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 20 Dec 2020 21:10:40 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BL3AbZM095093;
        Sun, 20 Dec 2020 21:10:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/9] dt-bindings: phy: cadence-sierra: Add bindings for
 the PLLs within SERDES
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20201103035556.21260-1-kishon@ti.com>
 <20201103035556.21260-2-kishon@ti.com> <20201105180308.GA1540220@bogus>
Message-ID: <c3146272-8108-7f12-f465-f6c5c7556112@ti.com>
Date:   Mon, 21 Dec 2020 08:40:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105180308.GA1540220@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 05/11/20 11:33 pm, Rob Herring wrote:
> On Tue, Nov 03, 2020 at 09:25:48AM +0530, Kishon Vijay Abraham I wrote:
>> Add binding for the PLLs within SERDES.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/phy/phy-cadence-sierra.yaml      | 89 ++++++++++++++++++-
>>  1 file changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
>> index d210843863df..f574b8ed358c 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
>> @@ -49,12 +49,14 @@ properties:
>>      const: serdes
>>  
>>    clocks:
>> -    maxItems: 2
>> +    maxItems: 4
>>  
>>    clock-names:
>>      items:
>>        - const: cmn_refclk_dig_div
>>        - const: cmn_refclk1_dig_div
>> +      - const: pll_cmnlc
>> +      - const: pll_cmnlc1
>>  
>>    cdns,autoconf:
>>      type: boolean
>> @@ -107,6 +109,58 @@ patternProperties:
>>  
>>      additionalProperties: false
>>  
>> +  "^refrcv1?$":
>> +    type: object
>> +    description: |
>> +      Reference receivers that enables routing external clocks to the alternate
>> +      PLLCMNLC.
>> +    properties:
>> +      clocks:
>> +        maxItems: 1
>> +        description: Phandle to clock nodes representing the input to the
>> +          reference receiver.
>> +
>> +      clock-names:
>> +        items:
>> +          - const: pll_refclk
>> +
>> +      "#clock-cells":
>> +        const: 0
>> +
>> +    required:
>> +      - clocks
>> +      - "#clock-cells"
>> +
>> +  "^pll_cmnlc1?$":
>> +    type: object
>> +    description: |
>> +      SERDES node should have subnodes for each of the PLLs present in
>> +      the SERDES.
>> +    properties:
>> +      clocks:
>> +        maxItems: 2
>> +        description: Phandle to clock nodes representing the two inputs to PLL.
>> +
>> +      clock-names:
>> +        items:
>> +          - const: pll_refclk
>> +          - const: refrcv
>> +
>> +      "#clock-cells":
>> +        const: 0
>> +
>> +      assigned-clocks:
>> +        maxItems: 1
>> +
>> +      assigned-clock-parents:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - clocks
>> +      - "#clock-cells"
>> +      - assigned-clocks
>> +      - assigned-clock-parents
>> +
>>  required:
>>    - compatible
>>    - "#address-cells"
>> @@ -130,10 +184,39 @@ examples:
>>              reg = <0x0 0xfd240000 0x0 0x40000>;
>>              resets = <&phyrst 0>, <&phyrst 1>;
>>              reset-names = "sierra_reset", "sierra_apb";
>> -            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>;
>> -            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
>> +            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>, <&serdes_pll_cmnlc>, <&serdes_pll_cmnlc1>;
>> +            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
>>              #address-cells = <1>;
>>              #size-cells = <0>;
>> +
>> +            serdes_refrcv: refrcv {
>> +                    clocks = <&pll0_refclk>;
>> +                    clock-names = "pll_refclk";
>> +                    #clock-cells = <0>;
>> +            };
>> +
>> +            serdes_refrcv1: refrcv1 {
>> +                    clocks = <&pll1_refclk>;
>> +                    clock-names = "pll_refclk";
>> +                    #clock-cells = <0>;
>> +            };
>> +
>> +            serdes_pll_cmnlc: pll_cmnlc {
>> +                    clocks = <&pll0_refclk>, <&serdes_refrcv1>;
>> +                    clock-names = "pll_refclk", "refrcv";
>> +                    #clock-cells = <0>;
>> +                    assigned-clocks = <&serdes_pll_cmnlc>;
> 
> Isn't assigned-clocks supposed to be one of the clocks in 'clocks'?
> 
>> +                    assigned-clock-parents = <&pll0_refclk>;
> 
> And this should not be a clock in 'clocks'...
> 
> 
> More generally, why do we need to expose all these details in DT?

Sierra serdes is highly configurable w.r.t which clock can be used for
its internal PLL. The Same SoC, depending on how it is configured in the
EVM can either use internal clock or external clock. In order to
flexible support all the options, have to expose these in DT.

Thank You,
Kishon
