Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99E2F68FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbhANSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:06:25 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:34513 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbhANSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:06:20 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8A9441F531;
        Thu, 14 Jan 2021 19:05:23 +0100 (CET)
Subject: Re: [PATCH v2 3/3] dt-bindings: i2c: qcom,i2c-qup: Document noise
 rejection properties
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, phone-devel@vger.kernel.org
References: <20210114174909.399284-1-angelogioacchino.delregno@somainline.org>
 <20210114174909.399284-4-angelogioacchino.delregno@somainline.org>
 <YACGU7Di1RnD9nYL@builder.lan>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <80ecc187-9694-9be9-a910-e03366968e0a@somainline.org>
Date:   Thu, 14 Jan 2021 19:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YACGU7Di1RnD9nYL@builder.lan>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/21 18:58, Bjorn Andersson ha scritto:
> On Thu 14 Jan 11:49 CST 2021, AngeloGioacchino Del Regno wrote:
> 
>> Document the new noise rejection properties "qcom,noise-reject-sda"
>> and "qcom,noise-reject-scl".
>>
> 
> I presume these are unit-less levels?
> 
> 
Yes, there is no unit.

Sorry, I've sent v3 before seeing your R-b on this.

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../devicetree/bindings/i2c/qcom,i2c-qup.yaml      | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
>> index c5c7db3ac2a6..3f14dd65c6b9 100644
>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
>> @@ -58,6 +58,20 @@ properties:
>>     '#size-cells':
>>       const: 0
>>   
>> +  qcom,noise-reject-sda:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Noise rejection level for the SDA line.
>> +    minimum: 0
>> +    maximum: 3
>> +    default: 0
>> +
>> +  qcom,noise-reject-scl:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Noise rejection level for the SCL line.
>> +    minimum: 0
>> +    maximum: 3
>> +    default: 0
>> +
>>   required:
>>     - compatible
>>     - clocks
>> -- 
>> 2.29.2
>>

