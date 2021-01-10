Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8772F08F0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhAJSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 13:02:14 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:42245 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 13:02:14 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 14D233EAE5;
        Sun, 10 Jan 2021 19:01:16 +0100 (CET)
Subject: Re: [PATCH 4/7] dt-bindings: regulator: qcom-labibb: Document soft
 start properties
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, martin.botka@somainline.org,
        broonie@kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, agross@kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com
References: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
 <20210109132921.140932-5-angelogioacchino.delregno@somainline.org>
 <1610299126.029858.785278.nullmailer@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <07b59c25-3a17-6646-bb21-ce898794c24b@somainline.org>
Date:   Sun, 10 Jan 2021 19:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610299126.029858.785278.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/21 18:18, Rob Herring ha scritto:
> On Sat, 09 Jan 2021 14:29:18 +0100, AngeloGioacchino Del Regno wrote:
>> Document properties to configure soft start and discharge resistor
>> for LAB and IBB respectively.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   .../bindings/regulator/qcom-labibb-regulator.yaml         | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml: properties:ibb:properties:qcom,discharge-resistor-kohms: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 	Additional properties are not allowed ('default', 'enum' were unexpected)
> 	Additional properties are not allowed ('default' was unexpected)
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml: properties:ibb:properties:qcom,discharge-resistor-kohms: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 	300 is not of type 'string'
> 	64 is not of type 'string'
> 	32 is not of type 'string'
> 	16 is not of type 'string'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml: ignoring, error in schema: properties: ibb: properties: qcom,discharge-resistor-kohms
> warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> 
> See https://patchwork.ozlabs.org/patch/1424112
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Fixing ASAP.
