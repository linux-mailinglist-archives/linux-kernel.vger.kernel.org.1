Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4B2DF20F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgLSW7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 17:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgLSW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 17:59:39 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07553C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 14:58:59 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kqlBf-008jpy-3g
        for linux-kernel@vger.kernel.org; Sat, 19 Dec 2020 23:58:55 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kqlBU-008jpd-QG; Sat, 19 Dec 2020 23:58:44 +0100
Subject: Re: [PATCH] Add spi-nor driver for Realtek RTL838x/RTL839x switch
 SoCs
To:     Tudor.Ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        john.garry@huawei.com, bbrezillon@kernel.org, gch981213@gmail.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20201215214656.649896-1-bert@biot.com>
 <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <faaa83e9-e702-abfc-e298-fda1fa224b69@biot.com>
Date:   Sat, 19 Dec 2020 23:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 9:30 AM, Tudor.Ambarus@microchip.com wrote:
> On 12/15/20 11:46 PM, Bert Vermeulen wrote:
>> This driver supports the spiflash core in all RTL838x/RTL839x SoCs,
>> and likely some older models as well (RTL8196C).
>> 
> Can we use SPIMEM and move this under drivers/spi/ instead?

I wasn't aware spimem was the thing to use for new drivers. I will rewrite 
the driver to that API.


-- 
Bert Vermeulen
bert@biot.com
