Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11662A7EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgKEMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:44:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:44:12 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kaecb-0001QT-Ht; Thu, 05 Nov 2020 12:44:09 +0000
Subject: Re: [PATCH][next] hwmon: corsair-psu: fix unintentional sign
 extension issue
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201105115019.41735-1-colin.king@canonical.com>
 <20201105133233.10edda5b@monster.powergraphx.local>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <0ad7f7e1-564c-1644-8e11-c2eacc1ba667@canonical.com>
Date:   Thu, 5 Nov 2020 12:44:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105133233.10edda5b@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 12:32, Wilken Gottwalt wrote:
> On Thu,  5 Nov 2020 11:50:19 +0000
> Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The shifting of the u8 integer data[3] by 24 bits to the left will
>> be promoted to a 32 bit signed int and then sign-extended to a
>> long. In the event that the top bit of data[3] is set then all
>> then all the upper 32 bits of a 64 bit long end up as also being
>> set because of the sign-extension. Fix this by casting data[3] to
>> a long before the shift.
>>
>> Addresses-Coverity: ("Unintended sign extension")
>> Fixes: ce15cd2cee8b ("hwmon: add Corsair PSU HID controller driver")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/hwmon/corsair-psu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
>> index e92d0376e7ac..5d19a888231a 100644
>> --- a/drivers/hwmon/corsair-psu.c
>> +++ b/drivers/hwmon/corsair-psu.c
>> @@ -241,7 +241,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8
>> rail, l
>>  	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest
>> psu
>>  	 * supported (HX1200i)
>>  	 */
>> -	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>> +	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>>  	switch (cmd) {
>>  	case PSU_CMD_IN_VOLTS:
>>  	case PSU_CMD_IN_AMPS:
> 
> Yeah, this could happen if the uptime value in the micro-controller gets bigger
> than 68 years (in seconds), and it is the only value which actually uses more
> than 2 bytes for the representation. So what about architectures which are 32 bit
> wide and where a long has 32 bits? I guess this simple cast is not enough.

For 32 bits (unsigned) the 4 u8 values in data represents ~136 years no
matter if we use a 32 or 64 bit long for tmp. The cast to long is
signed, so yes, that's ~68 years in seconds. So perhaps
corsairpsu_get_value() should be passing a unsigned long for the *val
arg and tmp should be unsigned long too?

> 
> greetings,
> Wilken
> 

