Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FEC2F8F23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 21:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAPUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 15:18:35 -0500
Received: from vern.gendns.com ([98.142.107.122]:45478 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbhAPUSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 15:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m08zOXqNQtpcD4gKaTDISoVY1ErE89DNHarinAmmR2g=; b=fgKDZdoxgug+ACCGAz7N0ieQG8
        w9qCykFUop+Sq+SxBXsHtIAMoSfzRag6MK84PtqyDWfSiAujX6okuOW2lInl3L/D0Vm7m9qiq+JYb
        vMH6ICaljqhMQGl0XoW46WzgLbRBGJQS9Y0Ji0YTbTp77FYn9556POs/qvMYDlljtHDsq/O5/xmOR
        Z8U3BAUHkSO5sqoTRrmUyLDiz1yLqajUgZrvRgVKSZW0Tib/koaAwQ9hzj3RJ2EDmKxio2hTXNSs2
        wFl8+amWxxms0tzo4wvRbslba0zcrAULOVPKfVJy2R7cGOqtKviGUtoVFLcZQitn5gLxWFmHvzmkY
        pnPveggA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52410 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1l0rz2-000369-5r; Sat, 16 Jan 2021 15:15:40 -0500
Subject: Re: [PATCH 2/2] soc: ti: pruss: add support for AM18XX/OMAP-L138
 PRUSS
To:     Suman Anna <s-anna@ti.com>, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-3-david@lechnology.com>
 <4b60b60b-7e59-28fb-dc3a-f3f097e4cc8a@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <2ae31c89-fe5c-bc80-f7cc-a24f55616d9a@lechnology.com>
Date:   Sat, 16 Jan 2021 14:15:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b60b60b-7e59-28fb-dc3a-f3f097e4cc8a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 6:52 PM, Suman Anna wrote:
> Hi David,
> 
> On 1/4/21 12:30 PM, David Lechner wrote:
>> This adds support for the PRUSS found in AM18XX/OMAP-L138. This PRUSS
>> doesn't have a CFG register, so that is made optional as selected by
>> the device tree compatible string.
>>
>> ARCH_DAVINCI is added in the Kconfig so that the driver can be selected
>> on that platform.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/soc/ti/Kconfig |  2 +-
>>   drivers/soc/ti/pruss.c | 76 ++++++++++++++++++++++++------------------
>>   2 files changed, 45 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>> index 7e2fb1c16af1..7a692a21480a 100644
>> --- a/drivers/soc/ti/Kconfig
>> +++ b/drivers/soc/ti/Kconfig
>> @@ -85,7 +85,7 @@ config TI_K3_SOCINFO
>>   
>>   config TI_PRUSS
>>   	tristate "TI PRU-ICSS Subsystem Platform drivers"
>> -	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
>> +	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
>>   	select MFD_SYSCON
>>   	help
>>   	  TI PRU-ICSS Subsystem platform specific support.
>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>> index 5d6e7132a5c4..bfaf3ff74b01 100644
>> --- a/drivers/soc/ti/pruss.c
>> +++ b/drivers/soc/ti/pruss.c
>> @@ -24,10 +24,12 @@
>>    * struct pruss_private_data - PRUSS driver private data
>>    * @has_no_sharedram: flag to indicate the absence of PRUSS Shared Data RAM
>>    * @has_core_mux_clock: flag to indicate the presence of PRUSS core clock
>> + * @has_cfg: flag to indicate the presence of PRUSS CFG registers
> 
> I recommend to change this to a negative flag as the Davinci platforms are the
> only ones that don't have CFG (being the very first SoCs with a PRUSS IP)
> sub-module.

Negative flags hurt my brain. :-)

I was actually thinking about submitting a patch to convert
has_no_sharedram to a positive flag as well. But I understand
the sentiment of only setting the flag true for the odd case
rather than the usual case.

> 
>>    */
>>   struct pruss_private_data {
>>   	bool has_no_sharedram;
>>   	bool has_core_mux_clock;
>> +	bool has_cfg;
>>   };
>>   
>>   static void pruss_of_free_clk_provider(void *data)
>> @@ -239,42 +241,44 @@ static int pruss_probe(struct platform_device *pdev)
>>   		goto rpm_disable;
>>   	}
>>   
> 
> And use it here to skip all the cfg code parsing. All the below delta is just
> for the additional indentation for the flag. If you don't like goto's in
> non-error paths, then we can refactor the CFG parse code into a separate function.
> 

Refactoring to a separate function sounds good to me.
