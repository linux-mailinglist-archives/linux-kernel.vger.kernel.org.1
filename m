Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1A2AE887
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKKF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:56:39 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23673C0613D1;
        Tue, 10 Nov 2020 21:56:39 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j7so905526oie.12;
        Tue, 10 Nov 2020 21:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JxD6Thouiq95EZDoAY6hZ6UHvPjXCHfmUUIXo0p3ig=;
        b=eWG16/ye+r5/Vmh0yHOMQ2c1ObZDyCA2kuX8y9Zcjb0+RyIFjpRBRWNEwLQ4w84LXJ
         IDdyZXsYdzWpVY3cgyQPM6ZyI6mIG6pKVkI3chTn68VCyVyX7cetNFHwxdqTUwm09Mqe
         dbnTJ73Vy0afvY07OMUPOJFXsclsoJIeA/gaJIVvOi03CX8na4+6BRytQuceu1JM6joP
         VdEfCOuJqEYe61YLFENobkPN9d8dHWXgWzF2z3OEkeooeHggCEUpu4bjB0NrCWxniKy9
         deLl4G1DErEEpUUVDDTMKoVkFchZCGP64cVex9kdYOjR2Bc/dO74eYnA7nBovQDIc0qK
         yYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5JxD6Thouiq95EZDoAY6hZ6UHvPjXCHfmUUIXo0p3ig=;
        b=ETHDMcylFbnfJy+YIs2lYj3sLA30knGtDkb4YGeAYxYiGSUqzfHquT33nByFGz10b+
         /+dt13J5yAf3g7BttADh8ljjUCH75a+JuIiYer54gl+6zi74SH0Por6o2Fx27hqMrWlT
         eNKIge5XTB0jPX3GBf2qkFUI7uqFXfGycNTO9F2wTCuKSFqQskY3cNa9HferlokN2ooU
         3Vj23j7oGyuG/7X4STFk+Rkw/H5O4dEr0F0q1AudLHV51IyaPVfSFDdqV9BxkWf5K1/R
         qgOyasD64QmcT80zRLfAInzZjVScagt3EfGTEryspW2ThjnCA5mq3ay+vo8CLwJRdvez
         T1xA==
X-Gm-Message-State: AOAM532G0oLvp7JH17ZqXX2JzkKUeBa8IYjEa7ZbMEIRHoOQnztYAki0
        mxdzDtY7b4p3Hw5v6InGQbFrE+CKPbE=
X-Google-Smtp-Source: ABdhPJwzPLi9JKhKhXH2oiPhKSnD/KK1eNe6vtPRlbjBKzADjafTXEJoSK7ekv0mJGv7WjJnaEJ10Q==
X-Received: by 2002:aca:5710:: with SMTP id l16mr1196170oib.24.1605074198448;
        Tue, 10 Nov 2020 21:56:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm310639otb.24.2020.11.10.21.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 21:56:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 1/1] applesmc: Re-work SMC comms
To:     Brad Campbell <brad@fnarfbargle.com>, linux-hwmon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Henrik Rydberg <rydberg@bitmath.org>
References: <20200930105442.3f642f6c@aktux>
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
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <4eca09dc-7b32-767c-eab0-b9ad8b41efcc@fnarfbargle.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b6345525-c4d0-6949-1231-a47c3053e343@roeck-us.net>
Date:   Tue, 10 Nov 2020 21:56:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4eca09dc-7b32-767c-eab0-b9ad8b41efcc@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 7:38 PM, Brad Campbell wrote:
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
> v1 : Initial attempt
> v2 : Address logic and coding style
> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
> v4 : Re-factored logic based on Apple driver. Simplified wait_status loop
> Index: linux-stable/drivers/hwmon/applesmc.c
> ===================================================================
> --- linux-stable.orig/drivers/hwmon/applesmc.c
> +++ linux-stable/drivers/hwmon/applesmc.c
> @@ -32,6 +32,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/workqueue.h>
>  #include <linux/err.h>
> +#include <linux/bits.h>
>  
>  /* data port used by Apple SMC */
>  #define APPLESMC_DATA_PORT	0x300
> @@ -42,10 +43,14 @@
>  
>  #define APPLESMC_MAX_DATA_LENGTH 32
>  
> -/* wait up to 128 ms for a status change. */
> -#define APPLESMC_MIN_WAIT	0x0010
> -#define APPLESMC_RETRY_WAIT	0x0100
> -#define APPLESMC_MAX_WAIT	0x20000
> +/* Apple SMC status bits */
> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting to be read */
> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
> +
> +/* Exponential delay boundaries */
> +#define APPLESMC_MIN_WAIT	0x0008
> +#define APPLESMC_MAX_WAIT	0x100000

This is a substantial increase in wait time which should be documented.
0x20000 was explained (it translated to 128 ms), but this isn't,
and no reason is provided why it was increased to one second.
Is there any evidence that this is needed ? The only "benefit" I
can see is that a stuck SMC will now hang everything 8 times longer.

There really should be some evidence suggesting that the longer
timeout is really needed, better than "the apple driver does it".
The timeout was increased to 128 ms back in 2012, according to
the commit because timeouts were observed on MacBookPro6,1.
I would expect something similar here. In other words, describe
the circumstances of observed timeouts and the affected system(s).

>  
>  #define APPLESMC_READ_CMD	0x10
>  #define APPLESMC_WRITE_CMD	0x11
> @@ -151,65 +156,73 @@ static unsigned int key_at_index;
>  static struct workqueue_struct *applesmc_led_wq;
>  
>  /*
> - * wait_read - Wait for a byte to appear on SMC port. Callers must
> - * hold applesmc_lock.
> + * Wait for specific status bits with a mask on the SMC
> + * Used before all transactions
>   */
> -static int wait_read(void)
> +
> +static int wait_status(u8 val, u8 mask)
>  {
> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>  	u8 status;
>  	int us;
>  
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		usleep_range(us, us * 16);
> +	for (us = APPLESMC_MIN_WAIT; us <= APPLESMC_MAX_WAIT; us <<= 1) {
>  		status = inb(APPLESMC_CMD_PORT);
> -		/* read: wait for smc to settle */
> -		if (status & 0x01)
> +		if ((status & mask) == val)
>  			return 0;
> -		/* timeout: give up */
> -		if (time_after(jiffies, end))
> -			break;
> +	usleep_range(APPLESMC_MIN_WAIT, us);

Fighting with indentation again... and does that range really make sense ?
Seems to me it makes the whole loop quite unpredictable in its behavior.

>  	}
> -
> -	pr_warn("wait_read() fail: 0x%02x\n", status);
>  	return -EIO;
>  }
>  
> -/*
> - * send_byte - Write to SMC port, retrying when necessary. Callers
> - * must hold applesmc_lock.
> - */
> +/* send_byte - Write to SMC data port. Callers must hold applesmc_lock. */
> +
>  static int send_byte(u8 cmd, u16 port)
>  {
> -	u8 status;
> -	int us;
> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> +	int status;
>  
> +	status = wait_status(0, SMC_STATUS_IB_CLOSED);
> +	if (status)
> +		return status;
> +	status = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
> +	if (status)
> +		return status;

I think this warrants an explanation/comment.

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
> -
> -	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
> -	return -EIO;
> +	return 0;
>  }
>  
> +/* send_command - Write a command to the SMC. Callers must hold applesmc_lock. */
> +
>  static int send_command(u8 cmd)
>  {
> -	return send_byte(cmd, APPLESMC_CMD_PORT);
> +	int ret;
> +
> +	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
> +	if (ret)
> +		return ret;
> +	outb(cmd, APPLESMC_CMD_PORT);
> +	return 0;
> +}
> +
> +/* Based on logic from the Apple driver. This is issued before any interaction
> + * If busy is stuck high, issue a read command to reset the SMC state
> + * machine. If busy is stuck high after the command then the SMC is
> + * jammed.
> + */

This is not the networking subsystem. Please use standard multi-line comments.

> +
> +static int smc_sane(void)
> +{
> +	int ret;
> +
> +	ret = wait_status(0, SMC_STATUS_BUSY);
> +	if (!ret)
> +		return ret;
> +	ret = send_command(APPLESMC_READ_CMD);
> +	if (ret)
> +		return ret;
> +	ret = wait_status(0, SMC_STATUS_BUSY);
> +	if (!ret)
> +		return ret;
> +	return -EIO;

	return wait_status(0, SMC_STATUS_BUSY);

>  }
>  
>  static int send_argument(const char *key)
> @@ -226,6 +239,11 @@ static int read_smc(u8 cmd, const char *
>  {
>  	u8 status, data = 0;
>  	int i;
> +	int ret;
> +
> +	ret = smc_sane();
> +	if (ret)
> +		return ret;
>  
>  	if (send_command(cmd) || send_argument(key)) {
>  		pr_warn("%.4s: read arg fail\n", key);
> @@ -239,7 +257,8 @@ static int read_smc(u8 cmd, const char *
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (wait_read()) {
> +		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
> +				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY) < 0) {
>  			pr_warn("%.4s: read data[%d] fail\n", key, i);
>  			return -EIO;
>  		}
> @@ -250,19 +269,24 @@ static int read_smc(u8 cmd, const char *
>  	for (i = 0; i < 16; i++) {
>  		udelay(APPLESMC_MIN_WAIT);
>  		status = inb(APPLESMC_CMD_PORT);
> -		if (!(status & 0x01))
> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>  			break;
>  		data = inb(APPLESMC_DATA_PORT);
>  	}
>  	if (i)
>  		pr_warn("flushed %d bytes, last value is: %d\n", i, data);
>  
> -	return 0;
> +	return wait_status(0, SMC_STATUS_BUSY);
>  }
>  
>  static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>  {
>  	int i;
> +	int ret;
> +
> +	ret = smc_sane();
> +	if (ret)
> +		return ret;
>  
>  	if (send_command(cmd) || send_argument(key)) {
>  		pr_warn("%s: write arg fail\n", key);
> @@ -281,7 +305,7 @@ static int write_smc(u8 cmd, const char
>  		}
>  	}
>  
> -	return 0;
> +	return wait_status(0, SMC_STATUS_BUSY);
>  }
>  
>  static int read_register_count(unsigned int *count)
> 

