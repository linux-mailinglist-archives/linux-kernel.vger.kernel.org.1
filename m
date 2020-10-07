Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A26285836
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgJGFpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:45:00 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33147 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgJGFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:44:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.114])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 17B006974A95;
        Wed,  7 Oct 2020 07:44:56 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 07:44:55 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-105G0064af6da83-515b-414c-86c4-642b6e60958a,
                    A1FB6DEFD4FFF4B2E39ADAD8D1A9CF0B60FA0B96) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2] mtd: spi-nor: Fix address width on flash chips > 16MB
To:     Joel Stanley <joel@jms.id.au>, Bert Vermeulen <bert@biot.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201004213204.11584-1-bert@biot.com>
 <CACPK8XceL_QHCQOhfus27rei0vwfRJAFjfL6JkVw9pwxJj2d6Q@mail.gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <df901923-ede9-baf0-b82d-517839305d12@kaod.org>
Date:   Wed, 7 Oct 2020 07:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XceL_QHCQOhfus27rei0vwfRJAFjfL6JkVw9pwxJj2d6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 7bbe3df6-b180-4240-b832-b998933fa573
X-Ovh-Tracer-Id: 6185412613786995564
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeehgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 3:51 AM, Joel Stanley wrote:
> On Sun, 4 Oct 2020 at 21:33, Bert Vermeulen <bert@biot.com> wrote:
>>
>> If a flash chip has more than 16MB capacity but its BFPT reports
>> BFPT_DWORD1_ADDRESS_BYTES_3_OR_4, the spi-nor framework defaults to 3.
>>
>> The check in spi_nor_set_addr_width() doesn't catch it because addr_width
>> did get set. This fixes that check.
>>
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
> 
> After replying to the other thread, I just saw this one.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks Bert!


Yes. I was starting to add bfpt-fixups for all chips we use on Aspeed 
based system.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 



> Cheers,
> 
> Joel
> 
>> ---
>>  drivers/mtd/spi-nor/core.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0369d98b2d12..a2c35ad9645c 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3009,13 +3009,15 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>>                 /* already configured from SFDP */
>>         } else if (nor->info->addr_width) {
>>                 nor->addr_width = nor->info->addr_width;
>> -       } else if (nor->mtd.size > 0x1000000) {
>> -               /* enable 4-byte addressing if the device exceeds 16MiB */
>> -               nor->addr_width = 4;
>>         } else {
>>                 nor->addr_width = 3;
>>         }
>>
>> +       if (nor->addr_width == 3 && nor->mtd.size > 0x1000000) {
>> +               /* enable 4-byte addressing if the device exceeds 16MiB */
>> +               nor->addr_width = 4;
>> +       }
>> +
>>         if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
>>                 dev_dbg(nor->dev, "address width is too large: %u\n",
>>                         nor->addr_width);
>> --
>> 2.17.1
>>

