Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8526DB82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIQM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:28:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46018 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgIQM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:27:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HC0X61059792;
        Thu, 17 Sep 2020 07:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600344033;
        bh=cdbe+Y1msYZUZho4J9GT8Lb/U6fSW1HOJKJwJCjY6vI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pIc5siM+52+t8PtNjdlea3M55mMhBi8bY/ZfeVlMx2O+6BHaCdX42OGD1iGik1SxX
         JywogSaSFbB54zOoEI0dlGz/bmKnNv5nsIAzYUsu20ASbglz/WmKPAX7NpNgedekkq
         kbSh0bo+epls6ccKhO+u9ooJU37FwpJLG4ZsUty8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HC0Xxg087303;
        Thu, 17 Sep 2020 07:00:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 07:00:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 07:00:33 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HC0VnM079871;
        Thu, 17 Sep 2020 07:00:31 -0500
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>
CC:     <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
Date:   Thu, 17 Sep 2020 15:00:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916154536.m552ft2jzfsaeokr@akan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter & Nishanth,

On 16/09/2020 18:45, Nishanth Menon wrote:
> On 06:52-20200916, Peter Rosin wrote:
>> Hi,
>>
>> Sorry for the delay.
>>
>> On 2020-09-15 13:20, Roger Quadros wrote:
>>> Each SERDES lane mux can select upto 4 different IPs.
>>> There are 4 lanes in each J7200 SERDES. Define all
>>> the possible functions in this file.
>>>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>   include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>   create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
>>>
>>> diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
>>> new file mode 100644
>>> index 000000000000..b091b1185a36
>>> --- /dev/null
>>> +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
>>> @@ -0,0 +1,29 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * This header provides constants for J7200 WIZ.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_J7200_WIZ
>>> +#define _DT_BINDINGS_J7200_WIZ
>>> +
>>> +#define SERDES0_LANE0_QSGMII_LANE3	0x0
>>> +#define SERDES0_LANE0_PCIE1_LANE0	0x1
>>> +#define SERDES0_LANE0_IP3_UNUSED	0x2
>>> +#define SERDES0_LANE0_IP4_UNUSED	0x3
>>> +
>>> +#define SERDES0_LANE1_QSGMII_LANE4	0x0
>>> +#define SERDES0_LANE1_PCIE1_LANE1	0x1
>>> +#define SERDES0_LANE1_IP3_UNUSED	0x2
>>> +#define SERDES0_LANE1_IP4_UNUSED	0x3
>>> +
>>> +#define SERDES0_LANE2_QSGMII_LANE1	0x0
>>> +#define SERDES0_LANE2_PCIE1_LANE2	0x1
>>> +#define SERDES0_LANE2_IP3_UNUSED	0x2
>>> +#define SERDES0_LANE2_IP4_UNUSED	0x3
>>> +
>>> +#define SERDES0_LANE3_QSGMII_LANE2	0x0
>>> +#define SERDES0_LANE3_PCIE1_LANE3	0x1
>>> +#define SERDES0_LANE3_USB		0x2
>>> +#define SERDES0_LANE3_IP4_UNUSED	0x3
>>> +
>>> +#endif /* _DT_BINDINGS_J7200_WIZ */
>>
>> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
>> generic prefix, at least to me.
> 
> Thanks, good point. I am not sure if WIZ should even be used.. It is
> a TI internal prefix for various serdes solutions, but I agree that
> SERDES0 is too generic a terminology. That said, we should cleanup
> include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> j7200 changes.
> 

I'm planning to put all TI SERDES definitions in one header file "ti-serdes-mux.h"
and add SOC specific prefixes to the macros.

This will mean some churn in the existing DT files. (only 2 so far)

Are you guys OK if I do the change in one patch to avoid a broken build in between.
You guys can then decide whose tree it goes through.

The new SoC addition will be separate of course.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
