Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B629E710
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgJ2JPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:15:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgJ2JPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:15:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T6Q5x0017737;
        Thu, 29 Oct 2020 01:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603952765;
        bh=CdQ+oU4HVKo45/dvLJIgcfgX/8sXcvjXvY6BZKA2ODw=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=aIR24+4m66gqNqdxfq9RpZ7rb+/UfY11nKTnmDb3OKFi9KtKNlLrv0AtKkNlZtmTx
         fOEloGc3GRmGIQQxHd80drwH+937FEZPpS923DzWGrHa+0VqrjpdixYnyRxgXmP6Ts
         dHhAbib1Nn8KQ2WozqQUTQRqCCyJVKAweHhdewIw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T6Q5so116259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:26:05 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 01:26:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 01:26:05 -0500
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T6Q2KF067937;
        Thu, 29 Oct 2020 01:26:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "Yadav, Pratyush" <p.yadav@ti.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
 <20201028124920.pot77v4phkqiswhr@ti.com>
 <d9d96eda-4cb6-fe68-7469-e73dc7ba2fda@microchip.com>
Message-ID: <b7a18f2a-edd6-25e1-2f30-1a4427e67018@ti.com>
Date:   Thu, 29 Oct 2020 11:56:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9d96eda-4cb6-fe68-7469-e73dc7ba2fda@microchip.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/20 8:51 PM, Tudor.Ambarus@microchip.com wrote:
> On 10/28/20 2:49 PM, Pratyush Yadav wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi Tudor,
>>
>> On 28/10/20 07:53AM, Tudor.Ambarus@microchip.com wrote:
>>> Hi, Pratyush,
>>>
>>> On 10/5/20 6:31 PM, Pratyush Yadav wrote:
>>>> Tested on Micron MT35X and S28HS flashes for Octal DTR.
>>>
>>> Do these flashes define the "Command Sequences to Change to
>>> Octal DDR (8D-8D-8D) mode" table? Can't we use that table
>>> instead of defining our own octal dtr enable functions?
>>
>> The Micron flash does not have this table. The Cypress flash does. The
>> problem is that one of the samples of the Cypress flash I tested on had
>> incorrect data in that table which meant the sequence would fail. The
>> newer samples of the flash have the correct data.
> 
> Can we differentiate the Cypress flashes? Do you remember what
> was the incorrect data?
> 
>>
>> I don't know how many of those faulty flashes are out there in the wild.
>> IMO, to be on the safe side spi_nor_cypress_octal_dtr_enable() needs to
>> be implemented. So from the point of view of this series there is no
>> need to parse the Octal DDR enable table.
> 
> Meh, we cover manufacturer's mistakes. On the long run, our aim should be
> to follow the SFDP standard and if a flash implements it wrong, to either
> fix it via a fixup hook (if the fix is minimal), or to skip the faulty
> table.
> 
> Regarding "Command Sequences to Change to Octal DDR (8D-8D-8D) mode"
> table. Have you looked over
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1590737775-4798-4-git-send-email-masonccyang@mxic.com.tw/
> ?
> Is there a standard way to determine the offsets of opcode, addr and
> data in the cmd seq?
> 

There is no standard way of doing this and I recommend against it.
Each cmd seq has 0 to 7 Bytes. So the sequence maybe:
1 cmd byte-3 addr bytes- 3 data bytes 
or 
1 cmd byte-0 address bytes-6 data bytes 

We could just assume first byte to be command and rest to be data bytes always,
but one problem maybe that controller may not support data length to be so long
when address phase is absent. Eg.: Cadence OSPI controller supports only upto 8 bytes
length transfers in absence of address phase but other controllers may
limit the length further?

One more drawback of using "Command Sequences to Change to Octal DDR (8D-8D-8D) 
mode" table is that it not only switches flash to 8D mode 
but also configures flash to be in:

- 50 ohm I/O driver strength (Driver Type 0, mandatory for xSPI devices) 

- 20 dummy cycles for Read Fast commands

- Operation at 100MHz (or higher, if supported)

Note that 20 dummy cycles may not be enough for flashes to 
operate at 166/200MHz or higher and thus requiring flash specific fixups.

So, I am beginning to doubt if parsing "Command Sequences to Change to Octal DDR (8D-8D-8D) mode"
table is worth it. Not to mention we still need flash specific code to "verify" 
that mode switch is indeed successful.


Regards
Vignesh
