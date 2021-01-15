Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DA2F76C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbhAOKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:36:25 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61480 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727342AbhAOKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:36:24 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FAWmHZ026898;
        Fri, 15 Jan 2021 04:35:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=LD+LiuwpWXTb1D5hCBKo7VpoiE2Ui0ocmHD3tcAefJc=;
 b=pVCP/0Kn6scEb6JF03auF0HVcxZ9dSUIjyQQz6HD/fCr/4xaiVxvqTeaykXMpo3s3K2d
 2dyCsSW3bEqQk3X9CzSqLpY+vIrLVkBsmw478dK/88QrPfD+jb47NAi6YTzJeJwdqQJt
 Xcwn24q1DOHffZPUsmrBsofU/tkmRfh8laM5pUWaHIpijNu2sUm7ehcXkBEgaejrB0eD
 hmCdIobPSkr1lZDFJbJUIviVrrTXKIWxVki2K8JiMhJhLHrx6rPhwwMNQBnEgf+xro76
 F1Ljzl8rCIYk5+n7wBvDeDBT5uvfCzUtT/ExL4no1LBG99CtrkCQu07QjsAQi4Hne6O0 ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35y9sryh9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 04:35:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 15 Jan
 2021 10:35:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 15 Jan 2021 10:35:23 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.57])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6A48445;
        Fri, 15 Jan 2021 10:35:23 +0000 (UTC)
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
Date:   Fri, 15 Jan 2021 10:35:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113160917.GF4641@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2021 16:09, Mark Brown wrote:
> On Wed, Jan 13, 2021 at 09:22:25AM -0600, Rob Herring wrote:
> 
>> I'm not sure this makes sense to be generic, but if so, we already have
>> the clock binding and should use (and possibly extend) that.
> 
>> This appears to all be configuration of clocks within the codec, so
>> these properties belong in the codec or cpu nodes.
> 
> Right, I think this should just be the clock binding.
> 

Ok, so if the idea is to do this:

sound {
	clocks = <&audio_mclk>, <&pll>;
	clock-names = "mclk", "pll";
}

some_codec {
	pll: pll {
		compatible = "fixed-clock";
		clocks = <&audio_mclk>;
		clock-frequency = <98304000>;
	}
};

For this to work the clock binding must be a real clock object (so needs
a valid compatible=). But I need to somehow specify the PLL ID and
source pin for the PLL configuration. The schema for "fixed-clock" has
"additionalProperties: false" so I can't add extra custom properties to
the clock node.

Of course if we were able to use the clock framework to provide real
clock drivers for the plls and sysclks, the ID would be inherent in
the binding, and it can define a custom property for the source pin.

Some options:

1) Remove "additionalProperties: false" from the "fixed-clock" binding.

2) Add new core clock properties. Well, source-pin might legitimately be
meaningful, but for a real clock provider the clock ID is implicit.

3) Use 'reg' as fixed-clock doesn't use it. This works, but I suspect it
will be seen as an abuse of reg.

4) Put some extra properties in the sound node to define the <id,source>
pair for each clock. But that's clumsy to have some of the config in a
clock binding and a couple of extra elsewhere.

5) Use a bare clock binding that isn't a real clock provider, like:

sound {
	plls = <&pll>;
}

some_codec {
	pll: pll {
		reg = <1>; /* PLL ID */
	 	audio-graph-card,source-pin = <4>;
		clocks = <&audio_mclk>;
		clock-frequency = <98304000>;
		
	}
};


>>> +      The PLL id and clock source id are specific to the particular component
>>> +      so see the relevant component driver for the ids. Typically the
> 
> This should refer to the bindings for components, not to their drivers.
> 
>>> +      clock source id indicates the pin the source clock is connected to.
>>> +      The same phandle can appear in multiple entries so that several plls
>>> +      can be set in the same component.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +
>>> +  plls-clocks:
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>> +    description: |
>>> +      A list of clock names giving the source clock for each setting
>>> +      in the plls property.
>>> +
>>> +  sysclks:
>>> +    description: |
>>> +      A list of component sysclk settings. There are 4 cells per sysclk
>>> +      setting:
>>> +        - phandle to the node of the codec or cpu component,
>>> +        - component sysclk id,
>>> +        - component clock source id,
>>> +        - direction of the clock: 0 if the clock is an input to the component,
>>> +          1 if it is an output.
>>
>> A clock provider and consumer would provide the direction.
>>
>>> +      The sysclk id and clock source id are specific to the particular
>>> +      component so see the relevant component driver for the ids. Typically
>>> +      the clock source id indicates the pin the source clock is connected to.
>>> +      The same phandle can appear in multiple entries so that several sysclks
>>> +      can be set in the same component.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +
>>> +  sysclks-clocks:
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>> +    description: |
>>> +      A list of clock names giving the source clock for each setting
>>> +      in the sysclks property.
>>> +
>>> +dependencies:
>>> +  plls: [ plls-clocks ]
>>> +  sysclks: [ sysclks-clocks ]
>>> +
>>>   required:
>>>     - dais
>>>   
>>> -- 
>>> 2.20.1
>>>
