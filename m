Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55C27EA84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgI3OAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:00:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbgI3OAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:00:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UE0VBs038428;
        Wed, 30 Sep 2020 09:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601474431;
        bh=B4u4mPz3Mw0LWhoGuVNSTssSPC917P+CIGSb15A4hlk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HuLb35l3qVY0R4iQuUpbG12KK1BH1M14KiX+3CG0sEhVDnvsNV/C2lXv0MuGEOv/y
         mShBnIKWtxw06mQ7AB+tvkjZNmeKeNUtNA4frQHE8qI5EI5Iy1ekwtbUtoJl14N5pS
         E9lXlNd1YTIPpYFAde86ECU4VPFTMSC80ILBfsNE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UE0VoW017073;
        Wed, 30 Sep 2020 09:00:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 09:00:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 09:00:31 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UE0Srx039832;
        Wed, 30 Sep 2020 09:00:29 -0500
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: do not touch TB bit without
 SPI_NOR_HAS_TB
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
 <20200921112450.4824-2-i.mikhaylov@yadro.com>
 <9bfb10df-64d8-4a5e-b0ad-a8b5f4efc56f@ti.com>
 <4a5945534f7b41cb799c044ec8c9d31c61d5beda.camel@yadro.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <758b2772-3c44-1184-066e-df890d05a21a@ti.com>
Date:   Wed, 30 Sep 2020 19:30:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4a5945534f7b41cb799c044ec8c9d31c61d5beda.camel@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/20 6:37 PM, Ivan Mikhaylov wrote:
> On Wed, 2020-09-30 at 15:06 +0530, Vignesh Raghavendra wrote:
>>
>> On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
>>> Some chips like macronix don't have TB(Top/Bottom protection)
>>> bit in the status register. Do not write tb_mask inside status
>>> register, unless SPI_NOR_HAS_TB is present for the chip.
>>>
>>
>> Not entirely accurate.. Macronix chips have TB bit in config register
>> and is OTP and hence should not be touched ideally...
>>
>> You still need to "read" that bit to determine actual scheme (Top vs
>> Bottom). This is needs to be done before 2/2 enables SPI_NOR_HAS_LOCK
>> flag for macronix flashes.
> 
> Vignesh, that's the point about this commit to generalize this part about TB bit
> plus there is already exist SPI_NOR_HAS_TB flag which representing state of TB
> existence. I didn't add any support for macronix's TB bit, that's true but
> that's enough to make macronix chips able to use lock mechanism with default
> 'use_top' or any other chips which doesn't have TB bit.

Right, but 2/2 "enables" locking mechanism for Macronix flashes. Therefore its 
necessary to take TB bit into account so that implementation is correct. 
What if OTP bit is set as "use_bottom"? Although this is non default, 
we need to take care of this case for correctness.

> 
>> I guess macronix does not support SR_SRWD right? This needs special
>> treatment as well.
> 
> It does support SR_SRWD as well. No need any special treatment here.
> 

I did not find it in one Macronix datasheet at least:
https://www.macronix.com/Lists/Datasheet/Attachments/7902/MX25L25673G,%203V,%20256Mb,%20v1.6.pdf

Are you sure all Macronix flashes support SRWD?

> Thanks.
> 
