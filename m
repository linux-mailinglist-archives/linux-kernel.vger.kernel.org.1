Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA6282DB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJDVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgJDVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:12:31 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A01C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 14:12:31 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kPBIx-00EA7v-EN
        for linux-kernel@vger.kernel.org; Sun, 04 Oct 2020 23:12:27 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:5de2:b8c9:f460:9716]
        by yawp.biot.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kPBIx-00EA7r-8V; Sun, 04 Oct 2020 23:12:27 +0200
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
To:     David Laight <David.Laight@ACULAB.COM>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
 <1c4ee46115854ce28b17935504f2fc78@AcuMS.aculab.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <2c7b03eb-58fa-73af-93d7-669bad2e57ef@biot.com>
Date:   Sun, 4 Oct 2020 23:12:26 +0200
MIME-Version: 1.0
In-Reply-To: <1c4ee46115854ce28b17935504f2fc78@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 9:50 AM, David Laight wrote:
> From: Bert Vermeulen
>> The SoCs I'm dealing with have an SPI_ADDR_SEL pin, indicating whether it
>> should be in 3 or 4-byte mode. The vendor's hacked-up U-Boot sets the mode
>> accordingly, as does their BSP. It seems to me like a misfeature, and I want
>> to just ignore it and do reasonable JEDEC things, but I have the problem
>> that the flash chip can be in 4-byte mode by the time it gets to my spi-nor
>> driver.
> 
> If these are the devices I think they are, can't you read the
> non-volatile config word (bit 0) to find out whether the device
> expects a 3 or 4 byte address and how many 'idle' clocks there
> are before the read data?

I'm working with Realtek RTL838x/RTL839x SoCs. Reading it out is a
pretty convoluted procedure involving different I/O registers depending
on the SoC model.


-- 
Bert Vermeulen
bert@biot.com
