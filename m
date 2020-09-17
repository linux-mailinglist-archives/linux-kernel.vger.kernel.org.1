Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3483B26DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIQLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:36:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35824 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgIQL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:29:10 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:29:03 EDT
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HAI0qe010583;
        Thu, 17 Sep 2020 05:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600337880;
        bh=nF94rj5wLkPLwYnqYDJZW1Y0SHQFeOaaaswY3EiKhnc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U4hsB4GEEz0ISKqJEzygwcJ6aG1Qwr0mQtol8Sc1gN3bvW51sUnpsQgT3hDzFe193
         YzAFiA/36TbMGOslABZw8HTU2POqsPgonKBCIiXj1z2Bsdg6CqdX87HpQvqMa6pivJ
         VZEUtjrLwhKNYIaWXmEthcLkXlpYbSZ8qiwCikBM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HAI0WH073785;
        Thu, 17 Sep 2020 05:18:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 05:18:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 05:18:00 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HAHuAd120951;
        Thu, 17 Sep 2020 05:17:57 -0500
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>
CC:     Roger Quadros <rogerq@ti.com>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8a27f8f3-20c4-f72c-b683-81153107d867@ti.com>
Date:   Thu, 17 Sep 2020 15:47:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916154536.m552ft2jzfsaeokr@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 16/09/20 9:15 pm, Nishanth Menon wrote:
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
>>>  include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>  create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
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

WIZ is defined in public TRM (https://www.ti.com/lit/pdf/spruiu1).
"
The SERDES mux (WIZ) module supports the following features:
*) Multiplexes device interfaces onto a single SERDES lane (Tx and Rx)
*) Provides registers to implement SERDES control and status functions
and alignment delays
.
.
"

Thanks
Kishon
