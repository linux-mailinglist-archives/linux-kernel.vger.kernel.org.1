Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6552A8328
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgKEQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEQMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:12:31 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7FC0613CF;
        Thu,  5 Nov 2020 08:12:31 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g19so1884804otp.13;
        Thu, 05 Nov 2020 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbDOwUuMlo0A1nDQhHyZoOL+DsknOJCCaFJnej8yeRo=;
        b=eqmIKQGuXQ436LrfgfTfJXwXSG8x5Gq52iq8QENzPO4aTImrmq5XJlDFH/PjJImfh2
         X3WD+Aoap5lZYDGl1OPvLUeXuOt1cjhYJJFG9mPbdz5xwHI/rFeiU2awn+e4p4dbReq8
         C4FMiHYnTv4IDcfBR8LPLFRXnvNmV9qQYYy9LsO6jgQs3LiynALZ5eAknxWCtUtoX9ga
         17YoM5KFxutyUAM5DAP33ZDMlmn8oy87qRMCHfhjpV8prAOY7YQcz3dKNIEs434+4kfT
         2Xf4HgBH/aVhsHbP9khrACGClIU4qbfdg+tamw0TmCy/NqJAeCaeDW+QVzMDpaQY04Ml
         kxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WbDOwUuMlo0A1nDQhHyZoOL+DsknOJCCaFJnej8yeRo=;
        b=kfmmKB0+B2EFJaeATmFXQRW7AlGDb8a23eZDq4+H+W3XVUMBjsM9iXnmhJf1Ea2QG6
         8ANhBkX55CsDGst/9RXGSa4n4uUI5IbkYIBlzUQp4lYChB306MW/cAKBLQxgy5U9GmrX
         kVqOkQ6uJvEcAFYsFan9cQ+Z2K1CzLizONO5Aa0/hBKfetgxAPCGQUgiwnwUBl+qphkn
         /CBa9124o9xa97fKuh3wITfnrafv/zWVp87iBILZRTEbw7w58z4j2BNj0FbwRKkaYf+F
         5srIgn5PiTimlkfeiJc7lCu8QFJd7G9f/Dr22n7C6ZlmsV2Qn7iAFuloHEDF30HsZbik
         7ALw==
X-Gm-Message-State: AOAM532cAvg/FfWswiM6dXBwIlXme/nDxyDhRDhit76GsRVWQEyz3aVm
        otn7y88F/pSCZE3Nk8G+xfax2W+439w=
X-Google-Smtp-Source: ABdhPJxQ7IhP1GPuei1ePX9Azt3CzPmncjWP/iyELeqNUFkPtGgtvwm+GF29z2UX4J4OmlF+BeSU2w==
X-Received: by 2002:a9d:62c5:: with SMTP id z5mr2003488otk.351.1604592750335;
        Thu, 05 Nov 2020 08:12:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 72sm409541otd.11.2020.11.05.08.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:12:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Brad Campbell <brad@fnarfbargle.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
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
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e59440cb-72bc-4e48-4ff0-54ceb8e3ae91@roeck-us.net>
Date:   Thu, 5 Nov 2020 08:12:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 11:26 PM, Brad Campbell wrote:
> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()") introduced
> an issue whereby communication with the SMC became unreliable with write
> errors like :
> 
> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.378621] applesmc: LKSB: write data fail
> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.512787] applesmc: LKSB: write data fail
> 
> The original code appeared to be timing sensitive and was not reliable with
> the timing changes in the aforementioned commit.
> 
> This patch re-factors the SMC communication to remove the timing 
> dependencies and restore function with the changes previously committed.
> 

Still a few formatting problems, but I like this version. Id take
care of the formatting myself, but send_command() will need a change.

Subject should be
	[PATCH v<version>] hwmon: (applesmc) ...

> v2 : Address logic and coding style

Change log should be after '---'

> 
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
> 
> ---
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index a18887990f4a..de890f3ec12f 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -42,6 +42,11 @@
>  
>  #define APPLESMC_MAX_DATA_LENGTH 32
>  
> +/* Apple SMC status bits */
> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
> +

Hah, tricked you here ;-). Using "BIT()" requires

#include <linux/bits.h>

>  /* wait up to 128 ms for a status change. */
>  #define APPLESMC_MIN_WAIT	0x0010
>  #define APPLESMC_RETRY_WAIT	0x0100
> @@ -151,65 +156,69 @@ static unsigned int key_at_index;
>  static struct workqueue_struct *applesmc_led_wq;
>  
>  /*
> - * wait_read - Wait for a byte to appear on SMC port. Callers must
> - * hold applesmc_lock.
> + * Wait for specific status bits with a mask on the SMC
> + * Used before and after writes, and before reads
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
> +		if ((status & mask) == val)
>  			return 0;
>  		/* timeout: give up */
>  		if (time_after(jiffies, end))
>  			break;
> -	}
> -
> -	pr_warn("wait_read() fail: 0x%02x\n", status);
> +		usleep_range(us, us * 16);
> +		}

Bad indentation of "}"

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
> +	int ret;
>  
> +	ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED);
> +	if (ret)
> +		return ret;
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
> +	return wait_status(skip ? 0 : SMC_STATUS_BUSY, SMC_STATUS_BUSY);
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
> +	u8 status;
> +	int ret;
> +
> +	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
> +	if (ret)
> +		return ret;
> +
> +	status = inb(APPLESMC_CMD_PORT);
> +

Is this read necessary ? 'status' isn't used subsequently, meaning we'll
probably get static analyzer warnings about a variable which is assigned
but unused. If the read is necessary, just don't assign it to a variable.

> +	outb(cmd, APPLESMC_CMD_PORT);
> +	return wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
>  }
>  
>  static int send_argument(const char *key)
> @@ -239,7 +248,9 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (wait_read()) {
> +		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
> +				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
> +				SMC_STATUS_IB_CLOSED)) {
>  			pr_warn("%.4s: read data[%d] fail\n", key, i);
>  			return -EIO;
>  		}
> @@ -250,7 +261,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  	for (i = 0; i < 16; i++) {
>  		udelay(APPLESMC_MIN_WAIT);
>  		status = inb(APPLESMC_CMD_PORT);
> -		if (!(status & 0x01))
> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>  			break;
>  		data = inb(APPLESMC_DATA_PORT);
>  	}
> @@ -275,7 +286,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
> +		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
>  			pr_warn("%s: write data fail\n", key);
>  			return -EIO;
>  		}
> 

