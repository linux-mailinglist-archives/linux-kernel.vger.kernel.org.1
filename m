Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E968426E327
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIQSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:05:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50500 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIQSEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:04:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HI4Pwo132430;
        Thu, 17 Sep 2020 18:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AgmV/y+LF8mXPDnVjEBzoGjKPMcGmk0BeS1TT7N1nXQ=;
 b=J3kw/L3t1HES2NX9hsXCa/y7nyYfKql3XreB51IpzdGc/I+YTgq4uDzz7k+wTt9nOJXc
 TrxsCWUaD2bpZ7LWI95LBshOH6KMpPU+uH0i+4FtjOGE+tzP/DdWPjBCZ/DHfQzskcGd
 I8P+NNZ3ywTllionkEjjkMB+KfeizPAh01Rh2nvRi3b+Qu5tsM1YZBgSZButSqrpqCTR
 ms43NfmZ8JzNTGTku0ziuXAXXsVGlH2VygBg1ZVadRxsd2O4V1V0fbk5/VnHSOmTIGAO
 AxEWpuUMrpbZwdu9nojfahpX4vmVL+6hSwhbsVPk4dk3fQu8ruKe6SiY41tKBJzaY5ZC 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33j91dvjh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 18:04:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HHxv6g009853;
        Thu, 17 Sep 2020 18:04:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33hm359ngk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 18:04:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08HI4lV4024534;
        Thu, 17 Sep 2020 18:04:47 GMT
Received: from [10.74.106.99] (/10.74.106.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 18:04:47 +0000
Subject: Re: [PATCH] dt-bindings: soc: ti: ti,pruss: fix schema ID
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200917070543.19064-1-krzk@kernel.org>
 <CAMxfBF5WWQX3ZH0YcRZ_N8q4njTdG-RA4eM+zyQwmK7tYvw6DQ@mail.gmail.com>
 <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <e022fdc2-f33d-da13-fb35-b3c04d38e736@oracle.com>
Date:   Thu, 17 Sep 2020 11:04:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 1:35 AM, Krzysztof Kozlowski wrote:
> On Thu, 17 Sep 2020 at 10:32, Grzegorz Jaszczyk
> <grzegorz.jaszczyk@linaro.org> wrote:
>>
>> On Thu, 17 Sep 2020 at 09:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Add missing '#' to fix schema errors:
>>>
>>>    $id: 'https://urldefense.com/v3/__http://devicetree.org/schemas/soc/ti/ti,pruss.yaml__;!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIG6IBFwLA$ ' does not match 'https://urldefense.com/v3/__http://devicetree.org/schemas/.**A5C*5C.yaml*__;KiUlIw!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIGpNPP7ig$ '
>>>    $schema: 'https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml__;!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIEdWH0Bzw$ ' is not one of ['https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIHcNI2bOQ$ ', 'https://urldefense.com/v3/__http://devicetree.org/meta-schemas/base.yaml*__;Iw!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIFH0HvA-g$ ']
>>>    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml: ignoring, error in schema: $id
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> index cf7dc83f724f..037c51b2f972 100644
>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> @@ -1,8 +1,8 @@
>>>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>   %YAML 1.2
>>>   ---
>>> -$id: https://urldefense.com/v3/__http://devicetree.org/schemas/soc/ti/ti,pruss.yaml__;!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIG6IBFwLA$
>>> -$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml__;!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIEdWH0Bzw$
>>> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/soc/ti/ti,pruss.yaml*__;Iw!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIHAb7bLvA$
>>> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIHcNI2bOQ$
>>
>> I've double checked and "#" was present in the original patch sent and
>> ack for upstream: https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11729649/__;!!GqivPVa7Brio!NF67-KbyQr0smc7iM86dsdgoOaQrQRN4F2aNdLndleTjLn6BhqrmDBL4ekWiVIEaRPpx1g$
>> It seems like something got wrong on linux-next but this is the only
>> diff between original patch and one found in linux-next. Thank you for
>> taking care of it.
> 
> Indeed that's weird. It must get lost when applying...
> 
These URLs get mangled sometimes and I needed to fix them. Will fix the
original commit. Thanks for reporting.
