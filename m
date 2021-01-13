Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231C42F4A00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbhAMLWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:22:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33762 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:22:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DBKrj0035137;
        Wed, 13 Jan 2021 05:20:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610536853;
        bh=havUQaE9Q8MtbPDZbuGxqyTauNzAHO2v8GAg9BET1bM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gpIS2oaQbOWVftAnTf4UfVP3sdN6OJYxqFDVOjQPdyAietiR3yuM2hQzNAp696JLC
         3Yc/ASmekjD8nn+vJRIgOY4IVLrShSMjVhFkXX83SbxB6g4AQ5n/uuvAPyMuTi9C6C
         2j9nprkduy/NNi5Icipn08SEJbPdXwY+1uCpVwRU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DBKrSi095401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 05:20:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 05:20:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 05:20:53 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DBKnJo111139;
        Wed, 13 Jan 2021 05:20:50 -0600
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM64 SoC
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210107055457.14948-1-a-govindraju@ti.com>
 <CAPDyKFp89zPwr-SS9wgR6C5RM+KhSLWbkXivxAttRqTxtiVGDQ@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9ad5f3a3-2175-8f43-2481-7bef17828ce2@ti.com>
Date:   Wed, 13 Jan 2021 16:50:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp89zPwr-SS9wgR6C5RM+KhSLWbkXivxAttRqTxtiVGDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 13/01/21 4:26 pm, Ulf Hansson wrote:
> On Thu, 7 Jan 2021 at 06:55, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
>> module as the same IP is used.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> 
> Do you have a corresponding patch for the driver as well? I would like
> to apply them together.
> 

Yes, I do. Here is the link to the patch,
https://lore.kernel.org/patchwork/patch/1364589/

Thanks,
Aswath

> Kind regards
> Uffe
> 
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> index 1ae945434c53..34e53db29428 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> @@ -21,6 +21,8 @@ properties:
>>        - ti,j721e-sdhci-4bit
>>        - ti,j7200-sdhci-8bit
>>        - ti,j721e-sdhci-4bit
>> +      - ti,am64-sdhci-8bit
>> +      - ti,am64-sdhci-4bit
>>
>>    reg:
>>      maxItems: 2
>> --
>> 2.17.1
>>

