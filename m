Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7212FB7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391572AbhASLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:36:17 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55327 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405637AbhASL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:28:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UMEykKZ_1611055592;
Received: from 30.225.36.0(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UMEykKZ_1611055592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jan 2021 19:26:32 +0800
Subject: Re: [PATCH] arm64/cpuinfo: Show right CPU architecture information
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, gustavoars@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210119105510.27836-1-zhangliguang@linux.alibaba.com>
 <20210119110131.GA18433@willie-the-truck>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <ff3a2f25-083c-2363-5e09-4d6acf5291e7@linux.alibaba.com>
Date:   Tue, 19 Jan 2021 19:26:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119110131.GA18433@willie-the-truck>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/1/19 19:01, Will Deacon Ð´µÀ:
> On Tue, Jan 19, 2021 at 06:55:10PM +0800, Liguang Zhang wrote:
>> CPU architecture is assigned to be a fixed value, it should be obtained
>> from midr register.
>>
>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>> ---
>>   arch/arm64/kernel/cpuinfo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 77605aec25fe..0bd11e0fe9f2 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -191,7 +191,7 @@ static int c_show(struct seq_file *m, void *v)
>>   
>>   		seq_printf(m, "CPU implementer\t: 0x%02x\n",
>>   			   MIDR_IMPLEMENTOR(midr));
>> -		seq_printf(m, "CPU architecture: 8\n");
>> +		seq_printf(m, "CPU architecture: %d\n", MIDR_ARCHITECTURE(midr));
> Huh? Won't this always return 0xf?

Hi Will,

I'm not sure. My platform return 0xf, but /proc/cpuinfo show 8. Why we 
assign a fixed

value to cpu architecture?

Regards

Liguang Zhang

>
> Will
