Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD12D9DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgLNRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgLNRdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:33:12 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB3C061793;
        Mon, 14 Dec 2020 09:32:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id r4so8995537pls.11;
        Mon, 14 Dec 2020 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TfwxQFi/fSDA4q4SqOKG+D3Wxhg5vJQI103NpWc2w8k=;
        b=Jv9nMhj0JMx5lvzypklQCyMgkMUx3MgOf1dFZYHXGNEpFi2M6G2rNT/QfIVwMVnIT2
         gQdlUb60YheZmqqnlZCiwWWhV/E1vvGKdzSayUkSedZ9IfMows4NJFplWVtvVznIigfs
         DvxsycGUXx+NhyaOatv+M+OsupWtE10TniHWad05RdMrpbdcHzF/ujZLTUgOVvyv+nfr
         PcIEGRs3pHbFE+BT/51oQ15qiKOyAD7Hkv/zFguWcIfORjOWmC9DtCf1w22j8ALzCq0I
         7XuQ5y3QwjduxJ5VIc3pFQD0sobbVvxTgnz9rMiketBEAjSML6v/akgwZxzwo9IqK7gt
         lKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TfwxQFi/fSDA4q4SqOKG+D3Wxhg5vJQI103NpWc2w8k=;
        b=VxV7L04Gmk3a7iYM6PULEWzVvj4rFlR6XUVWpOF2osPUEAqz1ADw0rtMapanuoytot
         xMwc3ucwZYAVrT8zl2LIvxQ+EvJGKxIWRClCFSe2qah0ZI8u2LYtfr+Z2o+7df46Bm/I
         GeAVoRpZsRV1JFG3rxClY4UYG0Zvxq6suDFY7uDmpO70hrRW9yai9eIBkqpWzc+xXi7x
         VcNqGexSuxhSZAdZdt78Sz1/Bs1FNf+bD4Qw3319tIip7UcbCEI/0k8W1NHwEcCJlZvr
         UCghhhb4DBNVVTmkZi+tuYCzwopVxD5zhbimfIGRzoMuD47XYMXNU31FA/Y/AWBe0BHp
         VAUA==
X-Gm-Message-State: AOAM532nRK/oO3zpoGuuj4Cj5YOCgRDKSVFAeuwOGei+mt0hXc2WH8Ir
        72dni4ofKMCntzDckkcFNAPMGUogEK0=
X-Google-Smtp-Source: ABdhPJxkjdSQQBbod30zDzPDxOx/VEfYl+7oEg7kzZlQtU0WYFp/v3Tk5/KzgICT+xjww0SHApfEdA==
X-Received: by 2002:a17:90a:4402:: with SMTP id s2mr26459778pjg.37.1607967151183;
        Mon, 14 Dec 2020 09:32:31 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 5sm10381687pff.125.2020.12.14.09.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:32:30 -0800 (PST)
Subject: Re: [PATCH 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20201211215942.5726-1-zajec5@gmail.com>
 <20201211215942.5726-3-zajec5@gmail.com>
 <3bc097fa-3bef-396f-a4fd-fa8acbc1b71d@gmail.com>
 <18ebb7ab-2a45-f9fb-a094-0e63d44eadad@milecki.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <55a37742-1f4e-3697-e0e2-e42d67d75e07@gmail.com>
Date:   Mon, 14 Dec 2020 09:32:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18ebb7ab-2a45-f9fb-a094-0e63d44eadad@milecki.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 4:24 AM, Rafał Miłecki wrote:
> On 11.12.2020 23:08, Florian Fainelli wrote:
>> On 12/11/20 1:59 PM, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> PMB can be found on BCM4908 and many other chipsets (e.g. BCM63138).
>>> It's needed to power on and off SoC blocks like PCIe, SATA, USB.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>
>> I will do a more thorough review tonight, however do you mind moving the
>> driver under drives/soc/bcm/bcm63xx? The first SoC that had PMB was
>> 63138 and that one is DSL.
> 
> I now realized that bcm63xx's:
> * Kconfig is wrapper in: if SOC_BCM63XX
> * Makefile is conditional: obj-$(CONFIG_SOC_BCM63XX)
> 
> So it means I've to either:
> 1. Refactor bcm63xx structure
> 2. Make SOC_BCM63XX selectable on ARCH_BCM4908 and select it
> 
> I'm not sure if any of above is a really good idea. Any further thought,
> ideas?

Well, I was thinking about thing along those lines below, it's really
about putting drivers that belong to the same SoC family in the same
basket for easier maintenance while submitting patches/pull requests
from my side.

diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
index 7bc90e0bd773..0f0efa28d92b 100644
--- a/drivers/soc/bcm/Makefile
+++ b/drivers/soc/bcm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BCM2835_POWER)    += bcm2835-power.o
 obj-$(CONFIG_RASPBERRYPI_POWER)        += raspberrypi-power.o
-obj-$(CONFIG_SOC_BCM63XX)      += bcm63xx/
+obj-y                          += bcm63xx/
 obj-$(CONFIG_SOC_BRCMSTB)      += brcmstb/
diff --git a/drivers/soc/bcm/bcm63xx/Kconfig
b/drivers/soc/bcm/bcm63xx/Kconfig
index 16f648a6c70a..76fb61e7377e 100644
--- a/drivers/soc/bcm/bcm63xx/Kconfig
+++ b/drivers/soc/bcm/bcm63xx/Kconfig
@@ -10,3 +10,8 @@ config BCM63XX_POWER
          BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.

 endif # SOC_BCM63XX
+
+config BCM_PMB_POWER
+       tristate "Broadcom PMB bus power domain driver"
+       depends on BMIPS_GENERIC || ARCH_BCM4908 || COMPILE_TEST
+       default ARCH_BCM4908



-- 
Florian
