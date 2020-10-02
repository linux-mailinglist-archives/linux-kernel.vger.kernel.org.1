Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C9280CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 06:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJBEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 00:44:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34246 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgJBEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 00:44:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0924ihcj113573;
        Thu, 1 Oct 2020 23:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601613883;
        bh=oTFOrzXAvY5Ac56F327Vdk5wwHH/y+RSLm2CAxjGNrs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jBSfvcqCYjfec/4WolrZMXT0jECaZNftvlbuETaj7FmbHyzDEoqpvHxpteZyFuOfU
         14O9e33ZdBNJR7Qyz+kzVPQXqkPUE+K/FKFuzrkPqAigB7Foe0HdPmmBLX6oAWLlha
         /IPt89nXPp/nqohdPJ8OCTe9GuXNMj1l+NzvbsQQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0924ihov036743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 23:44:43 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 23:44:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 23:44:43 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0924idZk088546;
        Thu, 1 Oct 2020 23:44:40 -0500
Subject: Re: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200
 boards
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
 <20201001191302.dlp2tzbvkk35vzgd@akan>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <2a7ceab9-37ec-9117-1d98-9f307b4b5390@ti.com>
Date:   Fri, 2 Oct 2020 10:14:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001191302.dlp2tzbvkk35vzgd@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 02/10/20 12:43 am, Nishanth Menon wrote:
> On 00:35-20201002, Faiz Abbas wrote:
>> The following patches add support for UHS modes for TI's j721e and j7200
>> boards.
>>
>> Patches 1-3 add support for gpios to j7200-evm
>>
>> Patches 4-6 add support for voltage regulators for required by the
>> SD card in both devices as well as enable UHS modes at 1.8V
>>
>> Patches 5-6 add some required configs to the arm64 defconfig.
>>
>> This series depends on driver patches adding tuning support here:
>> https://lore.kernel.org/linux-arm-kernel/20200923105206.7988-1-faiz_abbas@ti.com/
>>
>> Faiz Abbas (8):
>>   arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
>>   arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
>>   arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
>>     modules
>>   arm64: dts: ti: k3-j721e-main: Add output tap delay values
>>   arm64: dts: ti: k3-j721e-common-proc-board: Add support SD card UHS
>>     modes
>>   arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS
>>     modes
> 
> Split these up please!

Into SD card UHS and gpio series?

>>   arm64: defconfig: Enable OMAP I2C driver
>>   arm64: defconfig: Enable DAVINCI_GPIO driver
>>
> 
> defconfig patches can be posted independent of dts patches, they go to
> different branches.

I was trying to follow Arnd's advice here:
https://lore.kernel.org/linux-arm-kernel/CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com/

He says that defconfig patches can be sent at the same time as dts updates and maintainers can send those
as separate pull requests.

Thanks,
Faiz
