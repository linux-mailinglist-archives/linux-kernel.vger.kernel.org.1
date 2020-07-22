Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD8229683
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGVKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 06:45:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34692 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgGVKpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:45:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595414710; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=L/nok2zwYApKKFOOLAMzwlNRkNWlD/HVZfZXAgUTZSw=; b=smNSSkTOeaqQEgGEVzNFdti2ftVRXzPciCkOSy6Judm8Ki6FxdRsnd++Y4bI300Xrg1FHy8O
 MGGsYH5RbafPzj5jNZXRICeGhw6VFwrbDyFrJpnMvZlgxcqrHpMlIGBlGU58U7LAAaLHMDYp
 EPPwpTJLc4v7qux2L5xUvIxG6z4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f1818b55912b3a4056cabde (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:45:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9623FC43395; Wed, 22 Jul 2020 10:45:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6553C433C9;
        Wed, 22 Jul 2020 10:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6553C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v3 8/8] dt-bindings: sound: lpass-cpu: Move to yaml format
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>
References: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
 <1594184896-10629-9-git-send-email-rohitkr@codeaurora.org>
 <20200713225328.GA778183@bogus>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <9a72a266-d861-a4a5-bf9c-4f1437c4b50e@codeaurora.org>
Date:   Wed, 22 Jul 2020 16:14:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713225328.GA778183@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for the review. Posted v4 with fixes.

On 7/14/2020 4:23 AM, Rob Herring wrote:
> On Wed, Jul 08, 2020 at 10:38:16AM +0530, Rohit kumar wrote:
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> Update lpass-cpu binding with yaml formats.
>>
>> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  80 -----------
>>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 154 +++++++++++++++++++++
>>   2 files changed, 154 insertions(+), 80 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>> deleted file mode 100644
>> index 04e34cc..00000000
>> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>> +++ /dev/null
>> @@ -1,80 +0,0 @@
>> -* Qualcomm Technologies LPASS CPU DAI
>> -
>> -This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
>> -
>> -Required properties:
>> -
>> -- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu" or
>> -			  "qcom,lpass-cpu-sc7180"
>> -- clocks		: Must contain an entry for each entry in clock-names.
>> -- clock-names		: A list which must include the following entries:
>> -				* "ahbix-clk"
>> -				* "mi2s-osr-clk"
>> -				* "mi2s-bit-clk"
>> -			: required clocks for "qcom,lpass-cpu-apq8016"
>> -				* "ahbix-clk"
>> -				* "mi2s-bit-clk0"
>> -				* "mi2s-bit-clk1"
>> -				* "mi2s-bit-clk2"
>> -				* "mi2s-bit-clk3"
>> -				* "pcnoc-mport-clk"
>> -				* "pcnoc-sway-clk"
>> -
>> -- interrupts		: Must contain an entry for each entry in
>> -			  interrupt-names.
>> -- interrupt-names	: A list which must include the following entries:
>> -				* "lpass-irq-lpaif"
>> -- pinctrl-N		: One property must exist for each entry in
>> -			  pinctrl-names.  See ../pinctrl/pinctrl-bindings.txt
>> -			  for details of the property values.
>> -- pinctrl-names		: Must contain a "default" entry.
>> -- reg			: Must contain an address for each entry in reg-names.
>> -- reg-names		: A list which must include the following entries:
>> -				* "lpass-lpaif"
>> -- #address-cells	: Must be 1
>> -- #size-cells		: Must be 0
>> -
>> -
>> -
>> -Optional properties:
>> -
>> -- qcom,adsp		: Phandle for the audio DSP node
>> -
>> -By default, the driver uses up to 4 MI2S SD lines, for a total of 8 channels.
>> -The SD lines to use can be configured by adding subnodes for each of the DAIs.
>> -
>> -Required properties for each DAI (represented by a subnode):
>> -- reg			: Must be one of the DAI IDs
>> -			  (usually part of dt-bindings header)
>> -- qcom,playback-sd-lines: List of serial data lines to use for playback
>> -			  Each SD line should be represented by a number from 0-3.
>> -- qcom,capture-sd-lines	: List of serial data lines to use for capture
>> -			  Each SD line should be represented by a number from 0-3.
>> -
>> -Note that adding a subnode changes the default to "no lines configured",
>> -so both playback and capture lines should be configured when a subnode is added.
>> -
>> -Example:
>> -
>> -lpass@28100000 {
>> -	compatible = "qcom,lpass-cpu";
>> -	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
>> -	clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
>> -	interrupts = <0 85 1>;
>> -	interrupt-names = "lpass-irq-lpaif";
>> -	pinctrl-names = "default", "idle";
>> -	pinctrl-0 = <&mi2s_default>;
>> -	pinctrl-1 = <&mi2s_idle>;
>> -	reg = <0x28100000 0x10000>;
>> -	reg-names = "lpass-lpaif";
>> -	qcom,adsp = <&adsp>;
>> -
>> -	#address-cells = <1>;
>> -	#size-cells = <0>;
>> -
>> -	/* Optional to set different MI2S SD lines */
>> -	dai@3 {
>> -		reg = <MI2S_QUATERNARY>;
>> -		qcom,playback-sd-lines = <0 1>;
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>> new file mode 100644
>> index 00000000..9c350bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
>> @@ -0,0 +1,154 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,lpass-cpu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm LPASS CPU dai driver bindings
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +  - Rohit kumar <rohitkr@codeaurora.org>
>> +
>> +description:
>> +  Qualcomm SOC Low-Power Audio SubSystem (LPASS) that consist of MI2S interface
>> +  for audio data transfer on external codecs. LPASS cpu driver is a module to
>> +  configure Low-Power Audio Interface(LPAIF) core registers across different
>> +  IP versions.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,lpass-cpu
>> +      - qcom,apq8016-lpass-cpu
>> +      - qcom,lpass-cpu-sc7180
>> +
>> +  reg:
>> +    items:
>> +      - description: LPAIF core registers
> Just: 'maxItems: 1' for a single entry.
pl
>
>> +
>> +  reg-names:
>> +    items:
>> +      - const: lpass-lpaif
> Not all that useful with only 1.
ok .. Removed in v4.
>
>> +
>> +  clocks:
>> +    items:
>> +      - description: AHBIX core clock
>> +      - description: oscillator clock for MI2S external interfaces
>> +      - description: Bit clock for single MI2S dai
>> +      - description: Bit clock for MI2S_PRIMARY dai interface
>> +      - description: Bit clock for MI2S_SECONDARY dai interface
>> +      - description: Bit clock for MI2S_TERTIARY dai interface
>> +      - description: Bit clock for MI2S_QUATERNARY dai interface
>> +      - description: NOC MPORT clock of LPASS core
>> +      - description: NOC SWAY clock of LPASS core
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ahbix-clk
>> +      - const: mi2s-osr-clk
>> +      - const: mi2s-bit-clk
>> +      - const: mi2s-bit-clk0
>> +      - const: mi2s-bit-clk1
>> +      - const: mi2s-bit-clk2
>> +      - const: mi2s-bit-clk3
>> +      - const: pcnoc-mport-clk
>> +      - const: pcnoc-sway-clk
>> +
>> +  interrupts:
>> +    items:
>> +      - description: LPAIF DMA buffer interrupt
> maxItems: 1
ok
>
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: lpass-irq-lpaif
>> +
>> +  qcom,adsp:
>> +    maxItems: 1
>> +    description: Phandle for the audio DSP node
> Needs a type $ref. And if just a phandle, 'maxItems: 1' is not
> appropriate.
>
>> +
>> +  iommus:
>> +    maxItems: 1
>> +    description: Phandle to apps_smmu node with sid mask
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +    description: Phandle for power domain node
> Drop. That's every 'power-domains' property.
ok
>> +
>> +  '#sound-dai-cells':
>> +    const: 1
>> +
>> +  child-node:
> I'm sure I said this on some review recently, but you are defining a
> child node named 'child-node'. You need this under patternProperties
> with the actual child node name.
Done in v4.
>
>> +    description: Required properties for each DAI
>> +    type: object
>> +    properties:
>> +      reg:
>> +        description: Must be one of the DAI ID
>> +                     (Usually part of dtbindings header)
> Ideally, you'd define the range of values here.
>
>> +      qcom,playback-sd-lines:
>> +        description: List of serial data lines to use for playback
>> +                     Each SD line should be represented by a number from 0-3.
> Needs a type $ref and 0-3 should be expressed as a schema.
>
> 'make dt_binding_check' should complain about this. You did run that,
> right?
Actually I reposted the Ajit's patch. Fixed all issues in v4.
>> +      qcom,capture-sd-lines :
>> +        description: List of serial data lines to use for capture
>> +                     Each SD line should be represented by a number from 0-3.
> ditto
>
>> +    required:
>> +      -reg
> space     ^
>
>> +    # Note that adding a subnode changes the default to "no lines configured",
>> +    # so both playback and capture lines should be configured when a subnode
>> +    # is added.
>> +
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - sound-dai-cells
> Not a valid property.
>
>> +
>> +optional:
>> +  - qcom,adsp
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: qcom,lpass-cpu-sc7180
>> +
>> +then:
>> +  required:
>> +    - iommus
>> +    - power-domains
>> +
>> +examples:
>> +  lpass@28100000 {
> This is not valid. 'examples' should be a list.
>
>> +	compatible = "qcom,lpass-cpu";
>> +	clocks = <&lcc AHBIX_CLK>,
>> +		 <&lcc MI2S_OSR_CLK>,
>> +		 <&lcc MI2S_BIT_CLK>;
> The example will not build because the includes are missing.
>
>> +
>> +	clock-names = "ahbix-clk",
>> +		      "mi2s-osr-clk",
>> +		      "mi2s-bit-clk";
>> +
>> +	interrupts = <0 85 1>;
>> +        interrupt-names = "lpass-irq-lpaif";
>> +
>> +	iommus = <&apps_smmu 0x1020 0>;
>> +	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>> +
>> +	reg = <0x28100000 0x10000>;
>> +	reg-names = "lpass-lpaif";
>> +	#sound-dai-cells = <1>;
>> +	qcom,adsp = <&adsp>;
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	/* Optional to set different MI2S SD lines */
>> +	mi2s-quaternary@3 {
>> +		reg = <MI2S_QUATERNARY>;
>> +		qcom,playback-sd-lines = <0 1>;
>> +  };
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

