Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB72F98E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhARFBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:01:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhARFBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:01:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10I4wcNw087118;
        Sun, 17 Jan 2021 22:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610945918;
        bh=FZFsA/XJzBlLNzf6/Dmk9x9gW0UhtWRu13aOk1GEEK4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VWUOwKh9PKciy/+T6TedBSNWQvedGNfsszf0+YhIZ7BGUo0jAX0XLzADLJO8+jVJl
         KeFdSmWnhVpOBinsOPQParSW+8jnrai8JUDtRcG1ok8SR6Xdtmr9uqy7GXRu+UyH0B
         t4/xEzrBQU+Fhxcgwets8UXsbsN7kFzhKG5FvtsQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10I4wcAE014025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 17 Jan 2021 22:58:38 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 17
 Jan 2021 22:58:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 17 Jan 2021 22:58:37 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10I4wYvJ088286;
        Sun, 17 Jan 2021 22:58:35 -0600
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
To:     David Lechner <david@lechnology.com>, Suman Anna <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-2-david@lechnology.com>
 <f03b9e77-510a-2ad4-4cb8-4aa3919abeb5@ti.com>
 <8535db9a-5fd1-f2f2-086a-0f9d017e0e52@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5ad2d9a8-d60f-6541-6efd-2fa036ec7517@ti.com>
Date:   Mon, 18 Jan 2021 10:28:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8535db9a-5fd1-f2f2-086a-0f9d017e0e52@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/21 1:48 AM, David Lechner wrote:
> On 1/15/21 10:45 AM, Suman Anna wrote:
>> + Sekhar and Bartosz
>>
>> Hi David,
>>
>> On 1/4/21 12:30 PM, David Lechner wrote:
>>> This adds a "ti,am1806-pruss" compatible type for the PRUSS found in
>>> TI AM18xx/OMAP-L138 SoCs.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> index 037c51b2f972..a6ed23fdbc00 100644
>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> @@ -61,6 +61,7 @@ properties:
>>>       compatible:
>>>       enum:
>>> +      - ti,am1806-pruss  # for AM18xx/OMAP-L138 SoC family
>>
>> Almost all the drivers for these SoCs use the prefix "ti,da850-xxx"
>> for the
>> compatibles. Can we switch to using those instead of ti,am1806?
> 
> I wasn't sure which chips exactly are "DA850". If someone can tell
> me, I can look at the docs to see if they have a PRUSS.

Hi David, you can treat DA850 is same as OMAP-L138 for all purposes in
kernel.

Thanks,
Sekhar

