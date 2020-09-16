Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6126BC74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIPGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:17:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35254 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIPGRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:17:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08G6GsKm105157;
        Wed, 16 Sep 2020 01:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600237014;
        bh=JkvZZE/7TajQ1Ag1zDg2OOuvEmolACGaWWAYZnR3LPI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ftzmHZQVNqgihpu/IhCSlDNSEyKdG91woGLYPfZuAF8WgpVsyz4IuPxfo8eQLKqkJ
         U0LiBJPgRmO4/p9u10USTP7EI0HpHTB44syf74ekmaLxnyV7VdSwFTglPmGJ9kArCx
         xIIt7XZN3yCPv6O0GYVKAj2fr3VhFw9/MRTlBYA4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08G6GsIG043681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:16:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 01:16:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 01:16:54 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08G6Go6J088464;
        Wed, 16 Sep 2020 01:16:51 -0500
Subject: Re: [PATCH v12 00/14] mtd: spi-nor: add xSPI Octal DTR support
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20200903171313.18741-1-p.yadav@ti.com>
 <973eac67-fa01-309f-c4d1-7983f404d507@ti.com>
 <20200915074727.o4drgfgdabhozjb5@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c56f3517-383c-2e45-d5cc-fde5a44ac34f@ti.com>
Date:   Wed, 16 Sep 2020 11:46:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915074727.o4drgfgdabhozjb5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/20 1:17 PM, Pratyush Yadav wrote:
> On 15/09/20 12:16PM, Vignesh Raghavendra wrote:
>>
>>
>> On 9/3/20 10:42 PM, Pratyush Yadav wrote:
>>> Hi,
>>>
>>> This series adds support for Octal DTR flashes in the SPI NOR framework,
>>> and then adds hooks for the Cypress Semper and Micron Xcella flashes to
>>> allow running them in Octal DTR mode. This series assumes that the flash
>>> is handed to the kernel in Legacy SPI mode.
>>>
>>> Tested on TI J721E EVM with 1-bit ECC on the Cypress flash.
>>>
>> [...]
>>
>> Please fix checkpatch issues on patch 1, 3, 4 and 5
> 
> I ran checkpatch on my patches based on top of next-20200914 just now. I 
> only see issues with patches 3 and 4. Patches 1 and 5 report no issues. 
> What problems do you see on patches 1 and 5?
> 

Please run with --strict argument to checkpatch. You can see the issues
at: https://pastebin.ubuntu.com/p/5pPWcGNsmp/

> As for patches 3 and 4, the error I see is "ENOTSUPP is not a SUSV4 
> error code, prefer EOPNOTSUPP". I left it in intentionally. There a 
> couple other functions in SPI NOR that use ENOTSUPP instead of 
> EOPNOTSUPP so I followed the local convention.
> 

This is a recent addition to checkpatch: 6b9ea5ff5abd ("checkpatch: warn
about uses of ENOTSUPP").

> If you insist, I can add a preparatory patch that first changes those 
> uses of ENOTSUPP to EOPNOTSUPP and then update patches 3 and 4 to do the 
> same. Let me know.
>  

Changing existing usage of ENOTSUPP to EOPNOTSUPP is a separate exercise
and patches are welcome. But any new addition of ENOTSUPP would need to
be avoided.

Regards
Vignesh
