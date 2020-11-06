Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403F82A8B17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgKFADq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:03:46 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:55424 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgKFADp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:03:45 -0500
Received: from srv.home ([10.8.0.1] ident=heh11857)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kapCc-0000gA-Iq; Fri, 06 Nov 2020 08:02:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=mrnTQlx4URaoQZqylMNRHrV1WLBTM2LXvxwuxfk7iBE=;
        b=nZabsBfnWrO6boX58eIQCS1Rl7kpr2TjCDMDq7y59O7S89dzXKX1YFhLHlKQpN697YdFzHWPo2++RgYLP0QkmewHd67/gmmktlF8PsrLyXcPrVRU/u3I0wQMutLbplzcrltGVoBTPMslLa1vS/vuO7uWeAEyIJBeQToH2CKQSic=;
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Henrik Rydberg <rydberg@bitmath.org>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <e59440cb-72bc-4e48-4ff0-54ceb8e3ae91@roeck-us.net>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <34ff244b-fe98-fcf5-eb61-95a529a52c45@fnarfbargle.com>
Date:   Fri, 6 Nov 2020 11:02:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <e59440cb-72bc-4e48-4ff0-54ceb8e3ae91@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 3:12 am, Guenter Roeck wrote:
> On 11/4/20 11:26 PM, Brad Campbell wrote:
>> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()") introduced
>> an issue whereby communication with the SMC became unreliable with write
>> errors like :
>>
>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.378621] applesmc: LKSB: write data fail
>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.512787] applesmc: LKSB: write data fail
>>
>> The original code appeared to be timing sensitive and was not reliable with
>> the timing changes in the aforementioned commit.
>>
>> This patch re-factors the SMC communication to remove the timing 
>> dependencies and restore function with the changes previously committed.
>>
> 
> Still a few formatting problems, but I like this version. Id take
> care of the formatting myself, but send_command() will need a change.

Nope, I'm more than happy to sort it all out. It's a learning process.

I'd still like this to get some wider testing before I consider it ready to go
so extra revisions don't worry me.

> Subject should be
> 	[PATCH v<version>] hwmon: (applesmc) ...

Thanks.
 
>> v2 : Address logic and coding style
> 
> Change log should be after '---'

No worries, can do.

> 
>>
>> Reported-by: Andreas Kemnade <andreas@kemnade.info>
>> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
>> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
>>
>> ---
>> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
>> index a18887990f4a..de890f3ec12f 100644
>> --- a/drivers/hwmon/applesmc.c
>> +++ b/drivers/hwmon/applesmc.c
>> @@ -42,6 +42,11 @@
>>  
>>  #define APPLESMC_MAX_DATA_LENGTH 32
>>  
>> +/* Apple SMC status bits */
>> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
>> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
>> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
>> +
> 
> Hah, tricked you here ;-). Using "BIT()" requires
> 
> #include <linux/bits.h>

"requires" ?? 
It compiles and tests without warning, but I'll certainly add it in.


>>  /* wait up to 128 ms for a status change. */
>>  #define APPLESMC_MIN_WAIT	0x0010
>>  #define APPLESMC_RETRY_WAIT	0x0100
>> @@ -151,65 +156,69 @@ static unsigned int key_at_index;
>>  static struct workqueue_struct *applesmc_led_wq;
>>  
>>  /*
>> - * wait_read - Wait for a byte to appear on SMC port. Callers must
>> - * hold applesmc_lock.
>> + * Wait for specific status bits with a mask on the SMC
>> + * Used before and after writes, and before reads
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
>> +		if ((status & mask) == val)
>>  			return 0;
>>  		/* timeout: give up */
>>  		if (time_after(jiffies, end))
>>  			break;
>> -	}
>> -
>> -	pr_warn("wait_read() fail: 0x%02x\n", status);
>> +		usleep_range(us, us * 16);
>> +		}
> 
> Bad indentation of "}"

Yeah, I've found my editor "less than optimal" and I've had to correct a few
tab related indent problems manually. Thanks.
 
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
>> +	int ret;
>>  
>> +	ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED);
>> +	if (ret)
>> +		return ret;
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
>> +	return wait_status(skip ? 0 : SMC_STATUS_BUSY, SMC_STATUS_BUSY);
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
>> +	u8 status;
>> +	int ret;
>> +
>> +	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
>> +	if (ret)
>> +		return ret;
>> +
>> +	status = inb(APPLESMC_CMD_PORT);
>> +
> 
> Is this read necessary ? 'status' isn't used subsequently, meaning we'll
> probably get static analyzer warnings about a variable which is assigned
> but unused. If the read is necessary, just don't assign it to a variable.

No it's not. It's hangover from incompletely remove debug statements.
Henrik Rydberg picked that one up yesterday.

>> +	outb(cmd, APPLESMC_CMD_PORT);
>> +	return wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
>>  }
>>  
>>  static int send_argument(const char *key)
>> @@ -239,7 +248,9 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>>  	}
>>  
>>  	for (i = 0; i < len; i++) {
>> -		if (wait_read()) {
>> +		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
>> +				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
>> +				SMC_STATUS_IB_CLOSED)) {
>>  			pr_warn("%.4s: read data[%d] fail\n", key, i);
>>  			return -EIO;
>>  		}
>> @@ -250,7 +261,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>>  	for (i = 0; i < 16; i++) {
>>  		udelay(APPLESMC_MIN_WAIT);
>>  		status = inb(APPLESMC_CMD_PORT);
>> -		if (!(status & 0x01))
>> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>>  			break;
>>  		data = inb(APPLESMC_DATA_PORT);
>>  	}
>> @@ -275,7 +286,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
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

I'll get a v3 in when I get some more test results.

Much appreciated.
Regards,
Brad
