Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD427FD8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgJAKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:40:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41118 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgJAKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:40:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091Aeeel060723;
        Thu, 1 Oct 2020 05:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601548840;
        bh=N9YEPqkdsieOwi0bDbR5PhkEgKwy0dRnGH8nrDktbwM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PEq+IhaA6pfFeLRh1ukujEcA4GiIQsuWzX9Gd1fi8gDRSJIFgAxi14XMNkBZr0Q1C
         CYQMYd8tbhUEDZ9Lq5aK1yEjXQTlIS6QCwOw46flMwlMiRFnfti4L1QJvZnpGjpEkI
         /BO6XyfNN12iOEQMLdiynGFAytRvDM3UaXXPzd64=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091Aee1j030734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 05:40:40 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 05:40:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 05:40:40 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091AebfS107891;
        Thu, 1 Oct 2020 05:40:38 -0500
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <523c3645-e37d-5d86-ba91-5c1be9e3881e@ti.com>
 <fb33aa707744ad6c25a4d332e7d73c58@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <58d1ffaa-53a0-d14a-6448-6203197d7b42@ti.com>
Date:   Thu, 1 Oct 2020 16:10:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb33aa707744ad6c25a4d332e7d73c58@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/20 4:21 AM, Michael Walle wrote:
> Am 2020-09-30 12:35, schrieb Vignesh Raghavendra:
> [..]
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>> changes since v2:
>>>  - add Kconfig option to be able to retain legacy behaviour
>>>  - rebased the patch due to the spi-nor rewrite
>>>  - dropped the Fixes: tag, it doens't make sense after the spi-nor
>>> rewrite
>>>  - mention commit 3e0930f109e76 which further modified the unlock
>>>    behaviour.
>>>
>>> changes since v1:
>>>  - completely rewrote patch, the first version used a device tree flag
>>>
>>>  drivers/mtd/spi-nor/Kconfig | 35 +++++++++++++++++++++++++++++
>>>  drivers/mtd/spi-nor/atmel.c | 24 +++++++++++++-------
>>>  drivers/mtd/spi-nor/core.c  | 44 ++++++++++++++++++++++++++++---------
>>>  drivers/mtd/spi-nor/core.h  |  6 +++++
>>>  drivers/mtd/spi-nor/esmt.c  |  6 ++---
>>>  drivers/mtd/spi-nor/intel.c |  6 ++---
>>>  drivers/mtd/spi-nor/sst.c   | 21 +++++++++---------
>>>  include/linux/mtd/spi-nor.h |  6 +++++
>>>  8 files changed, 114 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>>> index 6e816eafb312..647de17c81e2 100644
>>> --- a/drivers/mtd/spi-nor/Kconfig
>>> +++ b/drivers/mtd/spi-nor/Kconfig
>>> @@ -24,6 +24,41 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>>>        Please note that some tools/drivers/filesystems may not work with
>>>        4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>>>
>>> +choice
>>> +    prompt "Write protection at boot"
>>> +    default MTD_SPI_NOR_WP_DISABLE
>>
>> These choice control how BP0-X bits are manipulated on boot. Hence, to
>> be consistent should use Block Protection (BP) terminology throughout.
>>
>> This would also be inline with most flash datasheets which also use
>> term BP
> 
> Where should I mention the BP bits? In the choice or in the help text.

choice prompt and in help text.

> I tried to keep the choice prompt as easy to understand as possible, so an
> user who doesn't know anything about how the write protection actually
> works
> can still make that choice (without first reading a datasheet). Also
> keep in
> mind, that there is also the per sector locking. Wouldn't this option also
> apply to that?
> 

But, there is more than one way of achieving write protection in 
addition to BP bits such as Advanced Sector Protection which may be 
added in future. So we should be as specific as possible while making it 
easy for user.

How about 

		prompt "Write Protection (Legacy Block Protection based) at boot"




> Therefore, I'd mention in the help text, that (currently) the BP bits are
> affected.
> 
>>> +
>>> +config MTD_SPI_NOR_WP_DISABLE
>>> +    bool "Disable WP on any flashes (legacy behaviour)"
>>> +    help
>>> +      This option disables the write protection on any SPI flashes at
>>> +      boot-up.
>>> +
>>> +      Don't use this if you intent to use the write protection of your
>>> +      SPI flash. This is only to keep backwards compatibility.
>>> +
>>> +config MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE
>>> +    bool "Disable WP on flashes w/ volatile protection bits"
>>> +    help
>>> +      Some SPI flashes have volatile block protection bits, ie. after a
>>> +      power-up or a reset the flash is write protected by default.
>>> +
>>> +      This option disables the write protection for these kind of
>>> flashes
>>> +      while keeping it enabled for any other SPI flashes which have
>>> +      non-volatile block protection bits.
>>> +
>>> +      If you are unsure, select this option.
>>> +
>>> +config MTD_SPI_NOR_WP_KEEP
>>> +    bool "Keep write protection as is"
>>> +    help
>>> +      If you select this option the write protection of any SPI flashes
>>> +      will not be changed. If your flash is write protected or will be
>>> +      automatically write protected after power-up you have to manually
>>> +      unlock it before you are able to write to it.
>>> +
>>> +endchoice
>>> +
>>>  source "drivers/mtd/spi-nor/controllers/Kconfig"
>>>
>>>  endif # MTD_SPI_NOR
>>
>> [...]
>>
>>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>>> index 6f2f6b27173f..9a33c023717f 100644
>>> --- a/drivers/mtd/spi-nor/core.h
>>> +++ b/drivers/mtd/spi-nor/core.h
>>> @@ -26,6 +26,7 @@ enum spi_nor_option_flags {
>>>      SNOR_F_HAS_SR_TB_BIT6    = BIT(11),
>>>      SNOR_F_HAS_4BIT_BP      = BIT(12),
>>>      SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
>>> +    SNOR_F_NEED_UNPROTECT    = BIT(14),
>>>  };
>>>
>>>  struct spi_nor_read_command {
>>> @@ -311,6 +312,11 @@ struct flash_info {
>>>                       * BP3 is bit 6 of status register.
>>>                       * Must be used with SPI_NOR_4BIT_BP.
>>>                       */
>>> +#define SPI_NOR_UNPROTECT    BIT(19)    /*
>>> +                     * Flash is write-protected after
>>> +                     * power-up and needs a global
>>> +                     * unprotect.
>>> +                     */
>>>
>>
>> It would be better to name the flag to indicate BP bits are volatile or
>> powers up locked instead of SPI_NOR_UNPROTECT. This makes it easier to
>> understand what this flag means wrt flash HW feature. Maybe:
>>
>> SPI_NOR_LOCKED_ON_POWER_UP or SPI_NOR_BP_IS_VOLATILE
> 
> SPI_NOR_BP_IS_VOLATILE sounds good to me.
> 
> -michael
