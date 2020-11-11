Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCD2AE95C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKKHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:06:32 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:47356 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:06:32 -0500
Received: from srv.home ([10.8.0.1] ident=heh32733)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kckCL-0004ED-Fw; Wed, 11 Nov 2020 15:05:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gCy+cez+T1kyiig5SozaCSgBHWDf0Nv1yRJwi/tf86Y=;
        b=ex0/yuJuvhPzPYT61UJzOJYwlCKHxupsapTwh2FTn4TIPNUPwe6y+3pwaLMLoho1dQiWd6Qm8jUkDHaEXurZrP3ojo0m0E8eDj5LDpECvQx0uoheoVLpxW8BPNYBCIqLqawNxJthdxjtZVYllEYMcyWXrzVYhUL6A+ozbzG3aIE=;
Subject: Re: [PATCH v4 1/1] applesmc: Re-work SMC comms
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Henrik Rydberg <rydberg@bitmath.org>
References: <20200930105442.3f642f6c@aktux>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <4eca09dc-7b32-767c-eab0-b9ad8b41efcc@fnarfbargle.com>
 <b6345525-c4d0-6949-1231-a47c3053e343@roeck-us.net>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <49d025e1-779a-6829-bf24-8b0fd5e2586b@fnarfbargle.com>
Date:   Wed, 11 Nov 2020 18:05:42 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b6345525-c4d0-6949-1231-a47c3053e343@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 4:56 pm, Guenter Roeck wrote:
> On 11/10/20 7:38 PM, Brad Campbell wrote:
>> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
>> introduced an issue whereby communication with the SMC became
>> unreliable with write errors like :
>>
>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.378621] applesmc: LKSB: write data fail
>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.512787] applesmc: LKSB: write data fail
>>
>> The original code appeared to be timing sensitive and was not reliable
>> with the timing changes in the aforementioned commit.
>>
>> This patch re-factors the SMC communication to remove the timing
>> dependencies and restore function with the changes previously
>> committed.
>>
>> Tested on : MacbookAir6,2 MacBookPro11,1 iMac12,2, MacBookAir1,1,
>> MacBookAir3,1
>>
>> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
>> Reported-by: Andreas Kemnade <andreas@kemnade.info>
>> Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
>> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
>>
>> ---
>> Changelog : 
>> v1 : Initial attempt
>> v2 : Address logic and coding style
>> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
>> v4 : Re-factored logic based on Apple driver. Simplified wait_status loop
>> Index: linux-stable/drivers/hwmon/applesmc.c
>> ===================================================================
>> --- linux-stable.orig/drivers/hwmon/applesmc.c
>> +++ linux-stable/drivers/hwmon/applesmc.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/hwmon.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/err.h>
>> +#include <linux/bits.h>
>>  
>>  /* data port used by Apple SMC */
>>  #define APPLESMC_DATA_PORT	0x300
>> @@ -42,10 +43,14 @@
>>  
>>  #define APPLESMC_MAX_DATA_LENGTH 32
>>  
>> -/* wait up to 128 ms for a status change. */
>> -#define APPLESMC_MIN_WAIT	0x0010
>> -#define APPLESMC_RETRY_WAIT	0x0100
>> -#define APPLESMC_MAX_WAIT	0x20000
>> +/* Apple SMC status bits */
>> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting to be read */
>> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
>> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
>> +
>> +/* Exponential delay boundaries */
>> +#define APPLESMC_MIN_WAIT	0x0008
>> +#define APPLESMC_MAX_WAIT	0x100000
> 
> This is a substantial increase in wait time which should be documented.
> 0x20000 was explained (it translated to 128 ms), but this isn't,
> and no reason is provided why it was increased to one second.
> Is there any evidence that this is needed ? The only "benefit" I
> can see is that a stuck SMC will now hang everything 8 times longer.
> 
> There really should be some evidence suggesting that the longer
> timeout is really needed, better than "the apple driver does it".
> The timeout was increased to 128 ms back in 2012, according to
> the commit because timeouts were observed on MacBookPro6,1.
> I would expect something similar here. In other words, describe
> the circumstances of observed timeouts and the affected system(s).
> 
G'day Guenter,

The wait timer turns out to be the most contentious part of the whole patch.

That particular algorithm was put forward off list, and in testing it was as
fast as {while true ; do stuff; udelay(10)}. The reason for the larger max value
isn't actually for timing purposes. It was to allow a minimum of 16 times around the hedge.

I've probably had 10 chops at this timeout trying to balance performance with a sane
algorithm. 

How does this look? This performs pretty well.

/* Minimum sleep time is 8uS */
#define APPLESMC_MIN_WAIT      0x0008

/*
 * Wait for specific status bits with a mask on the SMC.
 * Used before all transactions.
 * This does 10 fast loops of 8us then exponentially backs off for a 
 * minimum total wait of 262ms. Depending on usleep_range this could
 * run out past 500ms. 
 */

static int wait_status(u8 val, u8 mask)
{
	u8 status;
	int us;
	int i;
	
	us=APPLESMC_MIN_WAIT;
	for (i = 0; i < 24 ; i++) {
		status = inb(APPLESMC_CMD_PORT);
		if ((status & mask) == val)
			return 0;
		usleep_range(us, us * 2);
		if (i > 9)
			us <<= 1;
	}
	return -EIO;
}

Regards,
Brad
