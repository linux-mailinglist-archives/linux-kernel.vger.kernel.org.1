Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7889270DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 08:19:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbgISMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 08:19:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE59280378544E45A87F;
        Sat, 19 Sep 2020 20:19:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 20:19:23 +0800
Subject: Re: [PATCH v3 0/9] clocksource: sp804: add support for Hisilicon
 sp804 timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200918132237.3552-1-thunder.leizhen@huawei.com>
 <f25d4aa6-80f9-0ff6-25f5-f1def38ef824@linaro.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <75ad9d17-3f1d-37bd-1768-5931927658b9@huawei.com>
Date:   Sat, 19 Sep 2020 20:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f25d4aa6-80f9-0ff6-25f5-f1def38ef824@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/19 19:51, Daniel Lezcano wrote:
> On 18/09/2020 15:22, Zhen Lei wrote:
> 
> [ ... ]
> 
>>
>> Zhen Lei (8):
>>   clocksource: sp804: remove unused sp804_timer_disable() and
>>     timer-sp804.h
>>   clocksource: sp804: delete the leading "__" of some functions
>>   clocksource: sp804: remove a mismatched comment
>>   clocksource: sp804: prepare for support non-standard register offset
>>   clocksource: sp804: support non-standard register offset
>>   clocksource: sp804: add support for Hisilicon sp804 timer
>>   clocksource: sp804: enable Hisilicon sp804 timer 64bit mode
>>   dt-bindings: sp804: add support for Hisilicon sp804 timer
> 
> Applied all patches, except 9/9 which should go through Rob's tree as
> the yaml conversion is there.

OK, I will send 9/9 to Rob Herring individually. Thanks.

> 
> 

