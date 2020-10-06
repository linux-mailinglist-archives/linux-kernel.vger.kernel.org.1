Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74905284C25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFNDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:03:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35860 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:03:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096D3UA9064584;
        Tue, 6 Oct 2020 08:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601989410;
        bh=eZI+cKxeShhAhXTJ8XVT3nnJ27k854fNyJk5dxb5cQ8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sTNMp0LkbRwReq3YeJvEkGGngfjBgnuVzOy762MmDj2jpy7n+GX91tWnKwvZ4fbEa
         i7Qjng6C6GOhH78PfEHL1SFvIxRyHmI0uRmij+lDsX2e+QOLi7czwi6z/Gyw8ZjGLF
         wRYlwLM03tFY5f+SdSGv2aKrJfLK6gZ/LD461PMo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096D3UuP115995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 08:03:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 08:03:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 08:03:29 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096D3Oju097645;
        Tue, 6 Oct 2020 08:03:25 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
Date:   Tue, 6 Oct 2020 18:33:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On 06/10/20 5:21 pm, Tero Kristo wrote:
> On 02/10/2020 19:45, Faiz Abbas wrote:
>> The following patches enable configs in the arm64 defconfig to support
>> GPIO and I2C support on TI's J721e platform.
>>
>> Faiz Abbas (2):
>>    arm64: defconfig: Enable OMAP I2C driver
>>    arm64: defconfig: Enable DAVINCI_GPIO driver
>>
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> 
> Why are you enabling these?
> 
> Are they required for booting the board?
> 
> If not, they shall not be enabled, as it just clutters the arm64 defconfig unnecessarily.
> 

They are required because the SD card regulators need gpio over i2c expander and also
soc gpio support to come up in UHS modes.

But in general isn't any feature we add supposed to be enabled in the arm64 defconfig?

Thanks,
Faiz
