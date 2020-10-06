Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0941284C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJFNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:10:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37330 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:10:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096DAqjP067210;
        Tue, 6 Oct 2020 08:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601989852;
        bh=wXYej7kHKz/S7upJVmm0fCftqCmHyaYzVlDlMTvs1Mc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=azraLYS2AZaJwnVgtxF/BL2MfkCgBc0+OOrGQwHUsde8qV7vdMzV/KAeFqMDQHPCT
         TysCDaze8mZOlTzJDVzCKF9VM691GyGCrBc1l65J5NjjIlBrn6W3st48skCQArOExT
         bNL0iKlGXPFmDG1F/OSdFBzfHSvQrB/ddId1y7qA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096DAq0I010328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 08:10:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 08:10:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 08:10:52 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096DAn1b112932;
        Tue, 6 Oct 2020 08:10:50 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
 <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <f8877ca8-fe32-29e5-cb0c-2ce0af3eb73a@ti.com>
Date:   Tue, 6 Oct 2020 16:10:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2020 16:03, Faiz Abbas wrote:
> Hi Tero,
> 
> On 06/10/20 5:21 pm, Tero Kristo wrote:
>> On 02/10/2020 19:45, Faiz Abbas wrote:
>>> The following patches enable configs in the arm64 defconfig to support
>>> GPIO and I2C support on TI's J721e platform.
>>>
>>> Faiz Abbas (2):
>>>     arm64: defconfig: Enable OMAP I2C driver
>>>     arm64: defconfig: Enable DAVINCI_GPIO driver
>>>
>>>    arch/arm64/configs/defconfig | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>
>> Why are you enabling these?
>>
>> Are they required for booting the board?
>>
>> If not, they shall not be enabled, as it just clutters the arm64 defconfig unnecessarily.
>>
> 
> They are required because the SD card regulators need gpio over i2c expander and also
> soc gpio support to come up in UHS modes.

Is that needed for boot support? If it is only needed with UHS cards, 
that does not seem important enough for me. We can already boot the 
board via other means.

> 
> But in general isn't any feature we add supposed to be enabled in the arm64 defconfig?

That is debatable, as it just increases the kernel size / build time for 
everybody. Personally I would merge only things that are absolutely 
necessary, for everything else we can just do local config modifications.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
