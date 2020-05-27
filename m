Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76F1E4CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391882AbgE0SGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 14:06:12 -0400
Received: from out28-99.mail.aliyun.com ([115.124.28.99]:39888 "EHLO
        out28-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbgE0SGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:06:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09056586|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00537309-0.000193602-0.994433;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.HeTMIqm_1590602766;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeTMIqm_1590602766)
          by smtp.aliyun-inc.com(10.147.41.143);
          Thu, 28 May 2020 02:06:07 +0800
Subject: Re: [PATCH v11 4/7] dt-bindings: clock: Add X1830 clock bindings.
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, sernia.zhou@foxmail.com,
        sboyd@kernel.org, zhenwenjin@gmail.com, mturquette@baylibre.com,
        yanfei.li@ingenic.com, aric.pzqi@ingenic.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, rick.tyliu@ingenic.com,
        linux-clk@vger.kernel.org
References: <20200527085449.55573-1-zhouyanjie@wanyeetech.com>
 <20200527085449.55573-5-zhouyanjie@wanyeetech.com>
 <20200527173436.GA2411605@bogus>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <04bae797-0267-ad07-68dc-0bf98d8be59b@wanyeetech.com>
Date:   Thu, 28 May 2020 02:06:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200527173436.GA2411605@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Could you take [3/11] in your tree? Stephen says the file named 
"ingenic,cgu.yaml" is not in clk tree, but it is in your DT tree staged 
for the next release, maybe you pick up the yaml file and he pick up the 
header file is a good idea.

Thanks and best regards!

在 2020/5/28 上午1:34, Rob Herring 写道:
> On Wed, 27 May 2020 16:54:46 +0800, 周琰杰 (Zhou Yanjie) wrote:
>> Add the clock bindings for the X1830 Soc from Ingenic.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>      v11:
>>      New patch, split from [3/6] in v10.
>>
>>   include/dt-bindings/clock/x1830-cgu.h | 55 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/x1830-cgu.h
>>
> Acked-by: Rob Herring <robh@kernel.org>
