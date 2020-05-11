Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A5C1CD74F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgEKLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:11:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33994 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:11:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BBBLrD037346;
        Mon, 11 May 2020 06:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589195481;
        bh=CISqFCxu5t1PMoQny1CBKpSz9hzWS0lgiIvGz7SxhJg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GpNiWynafDZa99VZDkD2G498YjQqyj2XZFeL+K2CqcbKkoGoCdyJw66FSJKO4jlMe
         PS/nWFHw07WTBhicFjgSdhkR78LLPIqKlmNb39O/ityyVZOF84Vw65Ojytm8ndY71+
         UODRCjBrkLs9/b0VkfvK3y3yb5QXgaVVusQ2WoNk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BBBK0U042948
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 06:11:21 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 06:11:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 06:11:20 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BBBHKd091718;
        Mon, 11 May 2020 06:11:17 -0500
Subject: Re: [PATCH v3 2/2] soc: ti: add k3 platforms chipid module driver
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <20200508100100.20740-1-grygorii.strashko@ti.com>
 <20200508100100.20740-3-grygorii.strashko@ti.com>
 <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <6614f29d-1796-18d9-9b78-214f56964a35@ti.com>
Date:   Mon, 11 May 2020 14:11:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 09/05/2020 01:17, Arnd Bergmann wrote:
> On Fri, May 8, 2020 at 12:01 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> +static int __init k3_chipinfo_init(void)
>> +{
>> +       struct soc_device_attribute *soc_dev_attr;
>> +       struct soc_device *soc_dev;
>> +       struct device_node *node;
>> +       struct regmap *regmap;
>> +       u32 partno_id;
>> +       u32 variant;
>> +       u32 jtag_id;
>> +       u32 mfg;
>> +       int ret;
>> +
>> +       node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
>> +       if (!node)
>> +               return -ENODEV;
> 
> This will fail the initcall and print a warning when the kernel runs on any
> other SoC. Would it be possible to just make this a platform_driver?
> 
> If not, I think you should silently return success when the device
> node is absent.

Thank you for your report.
Can' make it platform drv., as te SoC info need to be accessible by divers early.
I'll fix it to return success.

-- 
Best regards,
grygorii
