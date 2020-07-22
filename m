Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE078229DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgGVRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 13:03:20 -0400
Received: from out28-74.mail.aliyun.com ([115.124.28.74]:40806 "EHLO
        out28-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGVRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:03:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0809535|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0192437-0.000249335-0.980507;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07381;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I6.6HMv_1595437393;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6.6HMv_1595437393)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 23 Jul 2020 01:03:14 +0800
Subject: Re: [PATCH v10 0/2] Add support for the OST in Ingenic X1000.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200720173134.22826-1-zhouyanjie@wanyeetech.com>
 <6aca88ad-1e20-97da-effe-fa5a4cec789c@linaro.org>
 <0ace68b6-9d75-8b8f-c108-89863cb6d03d@wanyeetech.com>
 <8129fbbf-652d-5429-4b8a-63038cd42ccb@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <35e3e3f9-8348-cb09-8809-5e93be03744d@wanyeetech.com>
Date:   Thu, 23 Jul 2020 01:03:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8129fbbf-652d-5429-4b8a-63038cd42ccb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/23 上午12:49, Daniel Lezcano 写道:
> On 22/07/2020 18:47, Zhou Yanjie wrote:
>> Hello Daniel,
>>
>> 在 2020/7/21 下午8:53, Daniel Lezcano 写道:
>>> On 20/07/2020 19:31, 周琰杰 (Zhou Yanjie) wrote:
>>>> v9->v10:
>>>> Fix errors which case "make dt_binding_check" failed.
>>>>
>>>> 周琰杰 (Zhou Yanjie) (2):
>>>>     dt-bindings: timer: Add Ingenic X1000 OST bindings.
>>>>     clocksource: Ingenic: Add support for the Ingenic X1000 OST.
>>>>
>>>>    .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
>>>>    drivers/clocksource/Kconfig                        |  12 +-
>>>>    drivers/clocksource/Makefile                       |   1 +
>>>>    drivers/clocksource/ingenic-sysost.c               | 539
>>>> +++++++++++++++++++++
>>>>    include/dt-bindings/clock/ingenic,sysost.h         |  12 +
>>>>    5 files changed, 626 insertions(+), 1 deletion(-)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>>>>    create mode 100644 drivers/clocksource/ingenic-sysost.c
>>>>    create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
>>> Applied, thanks
>>
>> I'm very sorry, I found some typos in this series, do I need to send a
>> v11 to fix these typos?
> As your convenience, V11 or patches on top of V10. But please do it
> quickly as I'm preparing the PR.


Okay, thank you very much, I will finish v11 in half an hour.

Thanks and best regards!


> Thanks
>
>    -- Daniel
>
>
