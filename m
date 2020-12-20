Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3E2DF5E5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgLTPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgLTPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:37:15 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19641C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:36:11 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kr0kj-008r8Z-9Y
        for linux-kernel@vger.kernel.org; Sun, 20 Dec 2020 16:36:09 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kr0kb-008r8J-6X; Sun, 20 Dec 2020 16:36:01 +0100
Subject: Re: [PATCH] Add spi-nor driver for Realtek RTL838x/RTL839x switch
 SoCs
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, john.garry@huawei.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
References: <20201215214656.649896-1-bert@biot.com>
 <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
 <faaa83e9-e702-abfc-e298-fda1fa224b69@biot.com>
 <CAJsYDVLEggVBAm2zXe1V7jeAAwXACHrEj6UgiL9Wc-cNq=Zuww@mail.gmail.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <df136529-67aa-fdbd-5283-c5924d3e9b17@biot.com>
Date:   Sun, 20 Dec 2020 16:36:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAJsYDVLEggVBAm2zXe1V7jeAAwXACHrEj6UgiL9Wc-cNq=Zuww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/20 9:51 AM, Chuanhong Guo wrote:
> Hi!
> 
> On Sun, Dec 20, 2020 at 7:01 AM Bert Vermeulen <bert@biot.com> wrote:
>>
>> On 12/16/20 9:30 AM, Tudor.Ambarus@microchip.com wrote:
>> > On 12/15/20 11:46 PM, Bert Vermeulen wrote:
>> >> This driver supports the spiflash core in all RTL838x/RTL839x SoCs,
>> >> and likely some older models as well (RTL8196C).
>> >>
>> > Can we use SPIMEM and move this under drivers/spi/ instead?
>>
>> I wasn't aware spimem was the thing to use for new drivers. I will rewrite
>> the driver to that API.
> 
> Are there any limitations preventing this from being implemented as a
> generic SPI controller?
> spi-nor and spi-mem are designed for controllers which can only perform
> spi-mem/spi-nor specific transfers. I can't find such limitations from
> your current driver code.
 >
 > BTW I found a SPI controller driver for RTL8196C here: [0]
 > It seems pretty similar to the controller you are working on.
 >
 > [0]: 
https://github.com/hackpascal/lede-rtl8196c/blob/realtek/target/linux/realtek/files/drivers/spi/spi-realtek.c

The SoC's SPI core is very much intended for SPI flash use only, and indeed 
we haven't come across anything else connected to that SPI bus in dozens of 
devices.

I wrote my driver based on Realtek code and a datasheet for the (older) 
RTL8196C found floating around the net, and found no inconsistencies.

I hadn't seen that RTL8196C driver, but if it works that proves a plain SPI 
driver will do. I'll investigate.


-- 
Bert Vermeulen
bert@biot.com
