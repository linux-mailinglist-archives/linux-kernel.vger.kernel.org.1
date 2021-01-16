Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393962F8F25
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 21:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAPUT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 15:19:26 -0500
Received: from vern.gendns.com ([98.142.107.122]:45694 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbhAPUTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 15:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dDBlo7fWVLQ4psoCP9puULsa0wiX1uMAgLwk8C8ViP4=; b=cniftJ/K2eMSWl89ytKsF9sFXP
        RjC1H23Mxb07KllTMIsTeeTjr9NiWGNZ2flsStXlGDhhOuygTP9oDmNyQLIs5V4+ZLB9+xYAaQ8E3
        6Zlax1e4Q/8J12ZVDOy3bY1670UmWq9n7n5hKTynTzEc8fTInWzVf+2RdiOJFLkMfkiMymJaLgQFz
        a3DUlduJ6Gegj4zTxnxQuDVIdhyLvXKUI488ryMam1ToAgw/CQTPvZdVzwpcZ03c0PkCg8ax1tZNV
        2GMrJ9zdpNbIfx21di+ySF8HVuoGUnf31YAC4Qwv4u70BV10FIeBkOW9uK5921H4wVtGeq1vs/VtB
        vYZD2HYA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52456 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1l0s1z-0003pa-EO; Sat, 16 Jan 2021 15:18:43 -0500
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
To:     Suman Anna <s-anna@ti.com>, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-2-david@lechnology.com>
 <f03b9e77-510a-2ad4-4cb8-4aa3919abeb5@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <8535db9a-5fd1-f2f2-086a-0f9d017e0e52@lechnology.com>
Date:   Sat, 16 Jan 2021 14:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f03b9e77-510a-2ad4-4cb8-4aa3919abeb5@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 10:45 AM, Suman Anna wrote:
> + Sekhar and Bartosz
> 
> Hi David,
> 
> On 1/4/21 12:30 PM, David Lechner wrote:
>> This adds a "ti,am1806-pruss" compatible type for the PRUSS found in
>> TI AM18xx/OMAP-L138 SoCs.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index 037c51b2f972..a6ed23fdbc00 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -61,6 +61,7 @@ properties:
>>   
>>     compatible:
>>       enum:
>> +      - ti,am1806-pruss  # for AM18xx/OMAP-L138 SoC family
> 
> Almost all the drivers for these SoCs use the prefix "ti,da850-xxx" for the
> compatibles. Can we switch to using those instead of ti,am1806?

I wasn't sure which chips exactly are "DA850". If someone can tell
me, I can look at the docs to see if they have a PRUSS.
