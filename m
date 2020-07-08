Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81144217D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 05:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGHDeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 23:34:11 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:43878 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgGHDeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:34:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1F637200033F;
        Wed,  8 Jul 2020 11:34:08 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dLIQy9gPlcW1; Wed,  8 Jul 2020 11:34:08 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 025082000306;
        Wed,  8 Jul 2020 11:34:08 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.79])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 51F56C01B68;
        Wed,  8 Jul 2020 11:34:07 +0800 (HKT)
Subject: Re: [PATCH v3 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200707133503.GA217263@roeck-us.net>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <40330886-9943-d3ae-3c28-f2baa9c73ade@gtsys.com.hk>
Date:   Wed, 8 Jul 2020 11:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707133503.GA217263@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 7/7/2020 9:35 pm, Guenter Roeck wrote:
> On Tue, Jul 07, 2020 at 04:01:03PM +0800, Chris Ruehl wrote:
>> Add documentation for the newly added DTS support in the shtc1 driver.
>> To align with the drivers logic to have high precision by default
>> a boolean sensirion,low_precision is used to switch to low precision.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>> new file mode 100644
>> index 000000000000..bcccdcadd86b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
>> +
>> +maintainers:
>> +  - jdelvare@suse.com
> 
> Did Jean agree to maintain this file ?

I thought its OK to set the maintainer from the list shown with
get_maintainer.pl here. I don't mind take care of this file - there will be 
small changes only in case the dt-schema change and requires updates.

I put me here, if that is acceptable.

Chris

> 
>> +
>> +description: |
>> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
>> +  designed especially for battery-driven high-volume consumer electronics
>> +  applications.
>> +  For further information refere to Documentation/hwmon/shtc1.rst
>> +
>> +  This binding document describes the binding for the hardware monitor
>> +  portion of the driver.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sensirion,shtc1
>> +      - sensirion,shtw1
>> +      - sensirion,shtc3
>> +
>> +  reg: I2C address 0x70
>> +
>> +Optional properties:
>> +  sensirion,blocking_io: |
>> +    bool, if set the i2c bus hold until measure finished
>> +  sensirion,low_precision: |
>> +    bool, if set aquire data with low precision (not recommend)
> 
> recommended
> 
> It might make sense to mention that the default is expected to be high precision
> if not specified.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +Example:
>> +  &i2c1 {
>> +    status = "okay";
>> +    clock-frequency = <400000>;
>> +
>> +    shtc3@70 {
>> +      compatible = "sensirion,shtc3";
>> +      reg = <0x70>
>> +      sensirion,blocking_io;
>> +      status = "okay";
>> +    };
>> +  };
>> -- 
>> 2.20.1
>>

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
