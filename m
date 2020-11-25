Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151932C3F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgKYLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:41:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgKYLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:35 -0500
X-UUID: ead93c3836594f58a09cb9a758abbbd9-20201125
X-UUID: ead93c3836594f58a09cb9a758abbbd9-20201125
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1462991004; Wed, 25 Nov 2020 19:41:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Nov 2020 19:41:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 19:41:27 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Date:   Wed, 25 Nov 2020 19:41:30 +0800
Message-ID: <20201125114130.507-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201125103637.GC70906@C02TD0UTHF1T.local>
References: <20201125103637.GC70906@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: "Lecopzer Chen" <lecopzer.chen@mediatek.com>
>> 
>> Although most of modern devices use ACPI, there still has combination
>> of APM + ARM64.
>> 
>> In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
>> default is y if ACPI isn't configured.
>
>I'm a bit confused why this should be enabled for !ACPI. Which DT
>platforms need this, and how do they use it? Why should this only be
>enabled for kernels without ACPI support, and not for kernels that
>support both ACPI and DT?
>
>Thanks,
>Mark.

Hi Mark,

In our internal patch has no !ACPI here,
the reason I add here is that in kernel document[1] it mention:
> No, sorry, you cannot have both ACPI and APM enabled and running at once.
Thus, I try to limit the scope for who don't use the ACPI because I'm not sure
they could exist at the same time or not.

But I think it should be fine without !ACPI if APM and APCI
config won't conflict with each other.

So if it's better to remove !ACPI I'll send v2 for this.


BTW, The platform is for our internal kernel drivers, they utilize APM interface,
/dev/apm_bios to do their works in arm64.





[1] APM or ACPI?:
https://www.kernel.org/doc/html/latest/power/apm-acpi.html


Thanks,
Lecopzer


>> 
>> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
>> Suggested-by: YJ Chiang <yj.chiang@mediatek.com>
>> ---
>>  arch/arm64/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1515f6f153a0..5e9e3694015a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -260,6 +260,9 @@ config NO_IOPORT_MAP
>>  config STACKTRACE_SUPPORT
>>  	def_bool y
>>  
>> +config SYS_SUPPORTS_APM_EMULATION
>> +	def_bool y if !ACPI
>> +
>>  config ILLEGAL_POINTER_VALUE
>>  	hex
>>  	default 0xdead000000000000
>> -- 
>> 2.18.0
>> 
