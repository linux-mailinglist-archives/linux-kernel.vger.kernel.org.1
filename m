Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E08270DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgISMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 08:36:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgISMgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 08:36:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9D94293EF7879526FDE;
        Sat, 19 Sep 2020 20:36:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 20:36:33 +0800
Subject: Re: [PATCH v3 9/9] dt-bindings: sp804: add support for Hisilicon
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
 <20200918132237.3552-10-thunder.leizhen@huawei.com>
 <89edf87e-099a-85c2-6259-de60c0a84608@linaro.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8b44c05a-74b0-afb3-e318-bc96bdb43fed@huawei.com>
Date:   Sat, 19 Sep 2020 20:36:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <89edf87e-099a-85c2-6259-de60c0a84608@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/19 19:43, Daniel Lezcano wrote:
> On 18/09/2020 15:22, Zhen Lei wrote:
>> Some Hisilicon SoCs, such as Hi1212, use the Hisilicon extended sp804
>> timer.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
> 
> I'm not able to apply this patch, the file does not exists.

Hi Rob Herring:
  I will send you a new one, because I didn't notice that there was a
"select" property in arm,sp804.yaml.

> 
> 

