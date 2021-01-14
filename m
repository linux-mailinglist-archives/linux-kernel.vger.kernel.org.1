Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6AE2F5EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbhANKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:32:16 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53232 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbhANKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:32:14 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EAR9QX031652;
        Thu, 14 Jan 2021 04:31:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=7EbSzPs1PWHZQ4mjZAxZUcYIFc5DWtSabTvzQh1Wk1E=;
 b=GoeswMA8NIb9lEwq4mTPP6NCghn5BJKb2bPQ1C8Dgu0itz5MxQWaptmjLeaj+mOkFil4
 uZj9RHkiBSENhRZg/6SfOaR5k7QFwNnUaoI6OjNegaq+CjzgOm0idBEIVJibyF0n7vS3
 N0D7Nn1Ao1nBwrNKjTc8eeM5M6/CJze+PvYHfEbReBxDJb+Q9CJzx+Xxjv8CxKB6Fo8g
 jzx0DmZswOv02wKfskVvSii2lbOKl6rFZAUn0nPaNHmZswexL63b6F5KyfAgTY8bhJ2N
 hra9mmcQpcYDhPWwsnmdJZJ5s6D+nGgfSM0Ie2C5YVHjBD8zI9CnDqHqWd1uNtklgWoZ zg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35y9srx4fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 04:31:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 14 Jan
 2021 10:31:11 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 14 Jan 2021 10:31:11 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.57])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ACE8645;
        Thu, 14 Jan 2021 10:31:10 +0000 (UTC)
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <nsaenzjulienne@suse.de>, <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <c12a846f-9e79-4646-e7f4-397f074eb613@opensource.cirrus.com>
Date:   Thu, 14 Jan 2021 10:31:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113152225.GA2334778@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2021 15:22, Rob Herring wrote:
> On Fri, Jan 08, 2021 at 04:04:57PM +0000, Richard Fitzgerald wrote:
>> The audio-graph-card driver has properties for configuring the clocking
>> for DAIs within a component, but is missing properties for setting
>> up the PLLs and sysclks of the component.
>>
>> This patch adds the two new properties 'plls' and 'sysclks' so that the
>> audio-graph-driver can fully configure the component clocking.
> 
> I'm not sure this makes sense to be generic, but if so, we already have
> the clock binding and should use (and possibly extend) that.
> 
> This appears to all be configuration of clocks within the codec, so
> these properties belong in the codec or cpu nodes.
>

audio-graph-card doesn't have codec or cpu nodes. Those were in
simple-card but are replaced in audio-graph-card by a simple phandle
array forming a graph.

I could assume that all clock settings apply to the codec and that there
is only ever one codec in an audio-graph-card configuration.

>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   .../bindings/sound/audio-graph.yaml           | 46 +++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
>> index 4b46794e5153..9e0819205a17 100644
>> --- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
>> +++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
>> @@ -39,6 +39,52 @@ properties:
>>     mic-det-gpio:
>>       maxItems: 1
>>   
>> +  plls:
>> +    description: |
>> +      A list of component pll settings. There are 4 cells per PLL setting:
>> +        - phandle to the node of the codec or cpu component,
>> +        - component PLL id,
>> +        - component clock source id,
>> +        - frequency (in Hz) of the PLL output clock.
> 
> assigned-clocks binding can set frequencies and parent clocks.
> 
> 'pll' is too specific to the implementation. You may want to configure
> the freq and parent of something that's not a pll.
> 
>> +      The PLL id and clock source id are specific to the particular component
>> +      so see the relevant component driver for the ids. Typically the
>> +      clock source id indicates the pin the source clock is connected to.
>> +      The same phandle can appear in multiple entries so that several plls
>> +      can be set in the same component.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +  plls-clocks:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description: |
>> +      A list of clock names giving the source clock for each setting
>> +      in the plls property.
>> +
>> +  sysclks:
>> +    description: |
>> +      A list of component sysclk settings. There are 4 cells per sysclk
>> +      setting:
>> +        - phandle to the node of the codec or cpu component,
>> +        - component sysclk id,
>> +        - component clock source id,
>> +        - direction of the clock: 0 if the clock is an input to the component,
>> +          1 if it is an output.
> 
> A clock provider and consumer would provide the direction.
> 
>> +      The sysclk id and clock source id are specific to the particular
>> +      component so see the relevant component driver for the ids. Typically
>> +      the clock source id indicates the pin the source clock is connected to.
>> +      The same phandle can appear in multiple entries so that several sysclks
>> +      can be set in the same component.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +  sysclks-clocks:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description: |
>> +      A list of clock names giving the source clock for each setting
>> +      in the sysclks property.
>> +
>> +dependencies:
>> +  plls: [ plls-clocks ]
>> +  sysclks: [ sysclks-clocks ]
>> +
>>   required:
>>     - dais
>>   
>> -- 
>> 2.20.1
>>
