Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155DD2AAE83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 01:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgKIA0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 19:26:11 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:59364 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKIA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 19:26:10 -0500
Received: from srv.home ([10.8.0.1] ident=heh9363)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kbuzl-0001vH-Mx; Mon, 09 Nov 2020 08:25:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=RIYcfOeKtFvzWTaNbBcRqZb/hFknofybHPd06UXh8aM=;
        b=k3xWNIuv59GZL5PeQhBg3cJaun4jEH/bOaFPk8bEIW+EUxi+TsrCwc0HKZwLTSvR2BIPTrNV+YJ0k1wRUYhzNuDBHUONRbNgTZV2mosr/pWEJ+HeEhEcEI6M4/sSWu3ek1IBPp5om2BdmyW5av/hcZesDoNaTuAsyZFUzIgPbNc=;
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Guenter Roeck <linux@roeck-us.net>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
 <20201108101429.GA28460@mars.bitmath.org>
 <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <b00cffd1-96ed-775f-cc18-a16e1fff3ca2@fnarfbargle.com>
Date:   Mon, 9 Nov 2020 11:25:15 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 3:06 am, Guenter Roeck wrote:
> On 11/8/20 2:14 AM, Henrik Rydberg wrote:
>> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
>>> Hi Brad,
>>>
>>> On 2020-11-08 02:00, Brad Campbell wrote:
>>>> G'day Henrik,
>>>>
>>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
>>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
>>>> If you could test this on your Air1,1 it'd be appreciated.
>>>
>>> No, I managed to screw up the patch; you can see that I carefully added the
>>> same treatment for the read argument, being unsure if the BUSY state would
>>> remain during the AVAILABLE data phase. I can check that again, but
>>> unfortunately the patch in this email shows the same problem.
>>>
>>> I think it may be worthwhile to rethink the behavior of wait_status() here.
>>> If one machine shows no change after a certain status bit change, then
>>> perhaps the others share that behavior, and we are waiting in vain. Just
>>> imagine how many years of cpu that is, combined. ;-)
>>
>> Here is a modification along that line.
>>
> 
> Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
> it doesn't make it into patchwork, and is thus not only difficult to apply but
> may get lost, and it is all but impossible to find and apply all tags.
> Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
> of the changes made.

G'day Guenter,

Yes, I'll do that. I still have some more testing to do before it's pushed forwards.

Regards,
Brad
> 
>> Compared to your latest version, this one has wait_status() return the
>> actual status on success. Instead of waiting for BUSY, it waits for
>> the other status bits, and checks BUSY afterwards. So as not to wait
>> unneccesarily, the udelay() is placed together with the single
>> outb(). The return value of send_byte_data() is augmented with
>> -EAGAIN, which is then used in send_command() to create the resend
>> loop.
>>
>> I reach 41 reads per second on the MBA1,1 with this version, which is
>> getting close to the performance prior to the problems.
>>
>> >From b4405457f4ba07cff7b7e4f48c47668bee176a25 Mon Sep 17 00:00:00 2001
>> From: Brad Campbell <brad@fnarfbargle.com>
>> Date: Sun, 8 Nov 2020 12:00:03 +1100
>> Subject: [PATCH] hwmon: (applesmc) Re-work SMC comms
>>
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
>> v1 : Inital attempt
>> v2 : Address logic and coding style
>> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
>> v4 : Do not expect busy state to appear without other state changes
>>
>> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
>> index a18887990f4a..ea7c66d5788e 100644
>> --- a/drivers/hwmon/applesmc.c
>> +++ b/drivers/hwmon/applesmc.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/hwmon.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/err.h>
>> +#include <linux/bits.h>
>>  
>>  /* data port used by Apple SMC */
>>  #define APPLESMC_DATA_PORT	0x300
>> @@ -42,6 +43,11 @@
>>  
>>  #define APPLESMC_MAX_DATA_LENGTH 32
>>  
>> +/* Apple SMC status bits */
>> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
>> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
>> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
>> +
>>  /* wait up to 128 ms for a status change. */
>>  #define APPLESMC_MIN_WAIT	0x0010
>>  #define APPLESMC_RETRY_WAIT	0x0100
>> @@ -151,65 +157,78 @@ static unsigned int key_at_index;
>>  static struct workqueue_struct *applesmc_led_wq;
>>  
>>  /*
>> - * wait_read - Wait for a byte to appear on SMC port. Callers must
>> - * hold applesmc_lock.
>> + * Wait for specific status bits with a mask on the SMC
>> + * Used before and after writes, and before reads
>> + * On success, returns the full status
>> + * On failure, returns a negative error
>>   */
>> -static int wait_read(void)
>> +
>> +static int wait_status(u8 val, u8 mask)
>>  {
>>  	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>>  	u8 status;
>>  	int us;
>>  
>>  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
>> -		usleep_range(us, us * 16);
>>  		status = inb(APPLESMC_CMD_PORT);
>> -		/* read: wait for smc to settle */
>> -		if (status & 0x01)
>> -			return 0;
>> +		if ((status & mask) == val)
>> +			return status;
>>  		/* timeout: give up */
>>  		if (time_after(jiffies, end))
>>  			break;
>> +		usleep_range(us, us * 16);
>>  	}
>> -
>> -	pr_warn("wait_read() fail: 0x%02x\n", status);
>>  	return -EIO;
>>  }
>>  
>>  /*
>> - * send_byte - Write to SMC port, retrying when necessary. Callers
>> + * send_byte_data - Write to SMC data port. Callers
>>   * must hold applesmc_lock.
>> + * Parameter skip must be true on the last write of any
>> + * command or it'll time out.
>>   */
>> -static int send_byte(u8 cmd, u16 port)
>> +
>> +static int send_byte_data(u8 cmd, u16 port, bool skip)
>>  {
>> -	u8 status;
>> -	int us;
>> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>> +	int status;
>>  
>> +	status = wait_status(0, SMC_STATUS_IB_CLOSED);
>> +	if (status < 0)
>> +		return status;
>>  	outb(cmd, port);
>> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
>> -		usleep_range(us, us * 16);
>> -		status = inb(APPLESMC_CMD_PORT);
>> -		/* write: wait for smc to settle */
>> -		if (status & 0x02)
>> -			continue;
>> -		/* ready: cmd accepted, return */
>> -		if (status & 0x04)
>> -			return 0;
>> -		/* timeout: give up */
>> -		if (time_after(jiffies, end))
>> -			break;
>> -		/* busy: long wait and resend */
>> -		udelay(APPLESMC_RETRY_WAIT);
>> -		outb(cmd, port);
>> -	}
>> +	udelay(APPLESMC_MIN_WAIT);
>> +	status = wait_status(0, SMC_STATUS_IB_CLOSED);
>> +	if (status < 0)
>> +		return status;
>> +	if (skip || (status & SMC_STATUS_BUSY))
>> +		return 0;
>> +	return -EAGAIN;
>> +}
>>  
>> -	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
>> -	return -EIO;
>> +static int send_byte(u8 cmd, u16 port)
>> +{
>> +	return send_byte_data(cmd, port, false);
>>  }
>>  
>> +/*
>> + * send_command - Write a command to the SMC. Callers must hold applesmc_lock.
>> + * If SMC is in undefined state, any new command write resets the state machine.
>> + */
>> +
>>  static int send_command(u8 cmd)
>>  {
>> -	return send_byte(cmd, APPLESMC_CMD_PORT);
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < 16; i++) {
>> +		ret = send_byte(cmd, APPLESMC_CMD_PORT);
>> +		if (!ret)
>> +			return ret;
>> +		if (ret != -EAGAIN)
>> +			break;
>> +		usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
>> +	}
>> +	return -EIO;
>>  }
>>  
>>  static int send_argument(const char *key)
>> @@ -239,7 +258,8 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>>  	}
>>  
>>  	for (i = 0; i < len; i++) {
>> -		if (wait_read()) {
>> +		if (wait_status(SMC_STATUS_AWAITING_DATA,
>> +					SMC_STATUS_AWAITING_DATA | SMC_STATUS_IB_CLOSED) < 0) {
>>  			pr_warn("%.4s: read data[%d] fail\n", key, i);
>>  			return -EIO;
>>  		}
>> @@ -250,7 +270,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>>  	for (i = 0; i < 16; i++) {
>>  		udelay(APPLESMC_MIN_WAIT);
>>  		status = inb(APPLESMC_CMD_PORT);
>> -		if (!(status & 0x01))
>> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>>  			break;
>>  		data = inb(APPLESMC_DATA_PORT);
>>  	}
>> @@ -275,7 +295,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>>  	}
>>  
>>  	for (i = 0; i < len; i++) {
>> -		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
>> +		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
>>  			pr_warn("%s: write data fail\n", key);
>>  			return -EIO;
>>  		}
>>
> 
> 

