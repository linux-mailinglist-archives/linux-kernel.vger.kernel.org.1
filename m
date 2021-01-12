Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D343A2F28D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbhALHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:21:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43224 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbhALHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:21:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10C7JD78009966;
        Tue, 12 Jan 2021 01:19:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610435953;
        bh=HpyE5VMmSTs3TTYDDJkmlM9Cie84m31ok7i7jYsfjiU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xKfT4XpTDkgbDOLbVClwvQJcpfc8J3AazSBGwnr86ziu6p+wxK/BsKIKVCvIJq2Sw
         WfwQxbTw5X++62hoaSL7TST+gG56TjZTP7xbJ4jM1ZOdHwRrvBSQyMiVPmn8AwDBWS
         BZ3KzoXsjF/rcLq3YuouOFB/PFL73KlVaH80Dm8c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10C7JDPf118309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 01:19:13 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 01:19:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 01:19:12 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10C7J8mm101060;
        Tue, 12 Jan 2021 01:19:09 -0600
Subject: Re: [PATCH 1/2] misc: eeprom_93xx46: Fix module alias to enable
 module autoprobe
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anatolij Gustschin <agust@denx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210107163957.28664-1-a-govindraju@ti.com>
 <20210107163957.28664-2-a-govindraju@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <5c719840-7fa2-6b90-21a8-351f8460d938@ti.com>
Date:   Tue, 12 Jan 2021 12:49:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107163957.28664-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/21 10:09 PM, Aswath Govindraju wrote:
> Fix module autoprobe by correcting module alias to match the string from
> /sys/class/.../spi1.0/modalias content.
> 
> Fixes: 06b4501e88ad ("misc/eeprom: add driver for microwire 93xx46 EEPROMs")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/misc/eeprom/eeprom_93xx46.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
> index a18247696ce7..890624d97774 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -526,4 +526,4 @@ module_spi_driver(eeprom_93xx46_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Driver for 93xx46 EEPROMs");
>  MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
> -MODULE_ALIAS("spi:93xx46");

This will break non DT users of this driver like
drivers/misc/eeprom/digsy_mtc_eeprom.c

> +MODULE_ALIAS("spi:eeprom-93xx46");
> 

Can be a new entry.

Regards
Vignesh
