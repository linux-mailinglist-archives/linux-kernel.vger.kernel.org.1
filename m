Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA92AAC11
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgKHQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:06:27 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE5C0613CF;
        Sun,  8 Nov 2020 08:06:27 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so7354141oih.8;
        Sun, 08 Nov 2020 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CK1K20zW2fW9FYhtQWPpYueh/+Gw0rewTkHug9Xlgo=;
        b=LtznmZ9tnvyFlinxs81ltyLnDxxB6K5XfM2r9MY9dTp7JkFONVTVoRXrwSsNkxL7on
         gjzVulD3pnDwLN/bYJALIB935FRxLtfXX7n2qvU80JjjcI4j12Yx0MK+Jb9OD+wswlpN
         VckrZk2sqW0Pr1dZTDDy4nd7rTQ74Mva0BA/7gyJNFqemUMoB9flhRr01AWkNe2f20TD
         1JsObYRWtkZzTICemHpfl3HNBHWOawF34z1s477iqvSKQGCvLwO69bSA2XQ24zzUfZTY
         BBrI31PTD3xe/O36cViKtwSdmdep3wv5Pv7tkGzfRiQ0bvC9eLtse46CJt9UVex9qaDM
         6KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2CK1K20zW2fW9FYhtQWPpYueh/+Gw0rewTkHug9Xlgo=;
        b=qd0/na2iGGWAiLaZf6iMCFnnKpaPVrgUrF4NgpeBnQZRYTHb4/MDK9SZvgLLMsLMIy
         FPRuvp+HrKoqfgHWLLPRL8zSIhfxd743HS68eK97EykYbY+TVT8bYioMq8t9SEwweeHE
         XvNl2e56l9GVo36xPz1XCjhbTU7dJhYejeeMMi9ivFD2ylooTsANhxQrwhf5UbL6srBd
         ED8R50e3B0od1r7bGQiA+sogzsNQC0yQjwhe5nuXk5cO+AqNre+gBCM326nY1N0AKoxt
         eCAtipw5FlP2epghKyrZVQE2jDEFYagOJNpSp4EgNcrHiGOWaXl3cFQ+qe2MTMa/Cu4O
         HBxg==
X-Gm-Message-State: AOAM530mT6cs0PmU5757tiCcqCtkUm027peZVbXX/awpONLeWdl4nba0
        nVdmZxBAFcobuNap5lI3lXbVFXmiRJI=
X-Google-Smtp-Source: ABdhPJyuIHVd+5kMyR5bM4sS6Yo6LDisEH0NgKeibFZGfYLRB1rrq4hLec1AIZ8cCNj7PvwdP9hTfA==
X-Received: by 2002:aca:cd17:: with SMTP id d23mr6424145oig.171.1604851585702;
        Sun, 08 Nov 2020 08:06:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4sm1850161otd.66.2020.11.08.08.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 08:06:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Henrik Rydberg <rydberg@bitmath.org>,
        Brad Campbell <brad@fnarfbargle.com>
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
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
Date:   Sun, 8 Nov 2020 08:06:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201108101429.GA28460@mars.bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 2:14 AM, Henrik Rydberg wrote:
> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
>> Hi Brad,
>>
>> On 2020-11-08 02:00, Brad Campbell wrote:
>>> G'day Henrik,
>>>
>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
>>> If you could test this on your Air1,1 it'd be appreciated.
>>
>> No, I managed to screw up the patch; you can see that I carefully added the
>> same treatment for the read argument, being unsure if the BUSY state would
>> remain during the AVAILABLE data phase. I can check that again, but
>> unfortunately the patch in this email shows the same problem.
>>
>> I think it may be worthwhile to rethink the behavior of wait_status() here.
>> If one machine shows no change after a certain status bit change, then
>> perhaps the others share that behavior, and we are waiting in vain. Just
>> imagine how many years of cpu that is, combined. ;-)
> 
> Here is a modification along that line.
> 

Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
it doesn't make it into patchwork, and is thus not only difficult to apply but
may get lost, and it is all but impossible to find and apply all tags.
Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
of the changes made.

Thanks,
Guenter

> Compared to your latest version, this one has wait_status() return the
> actual status on success. Instead of waiting for BUSY, it waits for
> the other status bits, and checks BUSY afterwards. So as not to wait
> unneccesarily, the udelay() is placed together with the single
> outb(). The return value of send_byte_data() is augmented with
> -EAGAIN, which is then used in send_command() to create the resend
> loop.
> 
> I reach 41 reads per second on the MBA1,1 with this version, which is
> getting close to the performance prior to the problems.
> 
>>From b4405457f4ba07cff7b7e4f48c47668bee176a25 Mon Sep 17 00:00:00 2001
> From: Brad Campbell <brad@fnarfbargle.com>
> Date: Sun, 8 Nov 2020 12:00:03 +1100
> Subject: [PATCH] hwmon: (applesmc) Re-work SMC comms
> 
> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> introduced an issue whereby communication with the SMC became
> unreliable with write errors like :
> 
> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.378621] applesmc: LKSB: write data fail
> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.512787] applesmc: LKSB: write data fail
> 
> The original code appeared to be timing sensitive and was not reliable
> with the timing changes in the aforementioned commit.
> 
> This patch re-factors the SMC communication to remove the timing
> dependencies and restore function with the changes previously
> committed.
> 
> Tested on : MacbookAir6,2 MacBookPro11,1 iMac12,2, MacBookAir1,1,
> MacBookAir3,1
> 
> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
> 
> ---
> Changelog : 
> v1 : Inital attempt
> v2 : Address logic and coding style
> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
> v4 : Do not expect busy state to appear without other state changes
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index a18887990f4a..ea7c66d5788e 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -32,6 +32,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/workqueue.h>
>  #include <linux/err.h>
> +#include <linux/bits.h>
>  
>  /* data port used by Apple SMC */
>  #define APPLESMC_DATA_PORT	0x300
> @@ -42,6 +43,11 @@
>  
>  #define APPLESMC_MAX_DATA_LENGTH 32
>  
> +/* Apple SMC status bits */
> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
> +
>  /* wait up to 128 ms for a status change. */
>  #define APPLESMC_MIN_WAIT	0x0010
>  #define APPLESMC_RETRY_WAIT	0x0100
> @@ -151,65 +157,78 @@ static unsigned int key_at_index;
>  static struct workqueue_struct *applesmc_led_wq;
>  
>  /*
> - * wait_read - Wait for a byte to appear on SMC port. Callers must
> - * hold applesmc_lock.
> + * Wait for specific status bits with a mask on the SMC
> + * Used before and after writes, and before reads
> + * On success, returns the full status
> + * On failure, returns a negative error
>   */
> -static int wait_read(void)
> +
> +static int wait_status(u8 val, u8 mask)
>  {
>  	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>  	u8 status;
>  	int us;
>  
>  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		usleep_range(us, us * 16);
>  		status = inb(APPLESMC_CMD_PORT);
> -		/* read: wait for smc to settle */
> -		if (status & 0x01)
> -			return 0;
> +		if ((status & mask) == val)
> +			return status;
>  		/* timeout: give up */
>  		if (time_after(jiffies, end))
>  			break;
> +		usleep_range(us, us * 16);
>  	}
> -
> -	pr_warn("wait_read() fail: 0x%02x\n", status);
>  	return -EIO;
>  }
>  
>  /*
> - * send_byte - Write to SMC port, retrying when necessary. Callers
> + * send_byte_data - Write to SMC data port. Callers
>   * must hold applesmc_lock.
> + * Parameter skip must be true on the last write of any
> + * command or it'll time out.
>   */
> -static int send_byte(u8 cmd, u16 port)
> +
> +static int send_byte_data(u8 cmd, u16 port, bool skip)
>  {
> -	u8 status;
> -	int us;
> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> +	int status;
>  
> +	status = wait_status(0, SMC_STATUS_IB_CLOSED);
> +	if (status < 0)
> +		return status;
>  	outb(cmd, port);
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		usleep_range(us, us * 16);
> -		status = inb(APPLESMC_CMD_PORT);
> -		/* write: wait for smc to settle */
> -		if (status & 0x02)
> -			continue;
> -		/* ready: cmd accepted, return */
> -		if (status & 0x04)
> -			return 0;
> -		/* timeout: give up */
> -		if (time_after(jiffies, end))
> -			break;
> -		/* busy: long wait and resend */
> -		udelay(APPLESMC_RETRY_WAIT);
> -		outb(cmd, port);
> -	}
> +	udelay(APPLESMC_MIN_WAIT);
> +	status = wait_status(0, SMC_STATUS_IB_CLOSED);
> +	if (status < 0)
> +		return status;
> +	if (skip || (status & SMC_STATUS_BUSY))
> +		return 0;
> +	return -EAGAIN;
> +}
>  
> -	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
> -	return -EIO;
> +static int send_byte(u8 cmd, u16 port)
> +{
> +	return send_byte_data(cmd, port, false);
>  }
>  
> +/*
> + * send_command - Write a command to the SMC. Callers must hold applesmc_lock.
> + * If SMC is in undefined state, any new command write resets the state machine.
> + */
> +
>  static int send_command(u8 cmd)
>  {
> -	return send_byte(cmd, APPLESMC_CMD_PORT);
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < 16; i++) {
> +		ret = send_byte(cmd, APPLESMC_CMD_PORT);
> +		if (!ret)
> +			return ret;
> +		if (ret != -EAGAIN)
> +			break;
> +		usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
> +	}
> +	return -EIO;
>  }
>  
>  static int send_argument(const char *key)
> @@ -239,7 +258,8 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (wait_read()) {
> +		if (wait_status(SMC_STATUS_AWAITING_DATA,
> +					SMC_STATUS_AWAITING_DATA | SMC_STATUS_IB_CLOSED) < 0) {
>  			pr_warn("%.4s: read data[%d] fail\n", key, i);
>  			return -EIO;
>  		}
> @@ -250,7 +270,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  	for (i = 0; i < 16; i++) {
>  		udelay(APPLESMC_MIN_WAIT);
>  		status = inb(APPLESMC_CMD_PORT);
> -		if (!(status & 0x01))
> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>  			break;
>  		data = inb(APPLESMC_DATA_PORT);
>  	}
> @@ -275,7 +295,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
> +		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
>  			pr_warn("%s: write data fail\n", key);
>  			return -EIO;
>  		}
> 

