Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1CF2B4910
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgKPPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:22:28 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2307 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbgKPPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:22:28 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CZXqW6bQgz13TJm;
        Mon, 16 Nov 2020 23:21:59 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 16 Nov 2020 23:22:23 +0800
Subject: Re: [PATCH v3 1/2] dt-bindings: Document the hi3559a clock bindings
To:     Rob Herring <robh@kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20201114002237.35962-1-gengdongjiu@huawei.com>
 <20201114002237.35962-2-gengdongjiu@huawei.com>
 <20201116150223.GA1645329@bogus>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <8071c22d-1a9f-6353-7dd0-026de6e465de@huawei.com>
Date:   Mon, 16 Nov 2020 23:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20201116150223.GA1645329@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/16 23:02, Rob Herring wrote:
> On Sat, 14 Nov 2020 00:22:36 +0000, Dongjiu Geng wrote:
>> Add DT bindings documentation for hi3559a SoC clock.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  .../clock/hisilicon,hi3559av100-clock.yaml    |  65 +++++++
>>  include/dt-bindings/clock/hi3559av100-clock.h | 165 ++++++++++++++++++
>>  2 files changed, 230 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dts:20.23-27.11: Warning (unit_address_vs_reg): /example-0/clock0: node has a reg or ranges property, but no unit name
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: compatible: ['hisilicon,hi3559av100-clock', 'syscon'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: compatible: Additional items are not allowed ('syscon' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: #reset-cells:0:0: 1 was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1399891
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
ok， thanks a lot for the reminder.

> 
> .
> 
