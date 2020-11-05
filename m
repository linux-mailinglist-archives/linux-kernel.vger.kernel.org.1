Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA32A7899
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKEIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:12:02 -0500
Received: from mailrelay1-2.pub.mailoutpod1-cph3.one.com ([46.30.212.0]:27882
        "EHLO mailrelay1-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKEIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:12:02 -0500
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 03:11:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=D3MU3tRUSu7s03Tlyh6y0ZtSkXnT8UyY9MPAt4sFHAQ=;
        b=S6YYHr0je4NUbXCS4PYTN3Af0Vq94ChhZtdhdBca5S4oIpkNqG0InSyXlb4v/iEsQuIQOLZKIUsLx
         SWS6JKkmIRcjEaXTqr3aC6lrwpIid4mKWHeSmmzCyZJdyrHLJ+4Ye7C+guBKGT0a86s9mqPhQuQmFB
         6REjh0CnVsnF+XKWNl3xrcgw6zp799Mou1fOMNzipPkfC42BRY18dTj9CpnmH1CZFChwWa1b6qwtcu
         1KX+zus7nLeR4N+oTIXryzkCj5+9PppnI+Jus5e0FO/N+SOpRMX+n8El2gEpw4CDxScVa7S9Bl5wAS
         RIABLCHW5GPuX7hrkeCcyOXkCUoUVlA==
X-HalOne-Cookie: f2c9b26ba623b8435f905a5fb37f3adfadb69ed0
X-HalOne-ID: 53c0083f-1f3c-11eb-9653-d0431ea8a283
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 53c0083f-1f3c-11eb-9653-d0431ea8a283;
        Thu, 05 Nov 2020 07:55:53 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Brad Campbell <brad@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
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
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
Date:   Thu, 5 Nov 2020 08:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

Great to see this effort, it is certainly an area which could be 
improved. After having seen several generations of Macbooks while 
modifying much of that code, it became clear that the SMC communication 
got refreshed a few times over the years. Every tiny change had to be 
tested on all machines, or kept separate for a particular generation, or 
something would break.

I have not followed the back story here, but I imagine the need has 
arisen because of a new refresh, and so this patch only needs to 
strictly apply to a new generation. I would therefore advice that you 
write the patch in that way, reducing the actual change to zero for 
earlier generations. It also makes it easier to test the effect of the 
new approach on older systems. I should be able to help testing on a 
2008 and 2011 model once we get to that stage.

Thanks,
Henrik

On 2020-11-05 08:26, Brad Campbell wrote:
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
> v2 : Address logic and coding style
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
>   #define APPLESMC_MAX_DATA_LENGTH 32
>   
> +/* Apple SMC status bits */
> +#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
> +#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
> +#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
> +
>   /* wait up to 128 ms for a status change. */
>   #define APPLESMC_MIN_WAIT	0x0010
>   #define APPLESMC_RETRY_WAIT	0x0100
> @@ -151,65 +156,69 @@ static unsigned int key_at_index;
>   static struct workqueue_struct *applesmc_led_wq;
>   
>   /*
> - * wait_read - Wait for a byte to appear on SMC port. Callers must
> - * hold applesmc_lock.
> + * Wait for specific status bits with a mask on the SMC
> + * Used before and after writes, and before reads
>    */
> -static int wait_read(void)
> +
> +static int wait_status(u8 val, u8 mask)
>   {
>   	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>   	u8 status;
>   	int us;
>   
>   	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		usleep_range(us, us * 16);
>   		status = inb(APPLESMC_CMD_PORT);
> -		/* read: wait for smc to settle */
> -		if (status & 0x01)
> +		if ((status & mask) == val)
>   			return 0;
>   		/* timeout: give up */
>   		if (time_after(jiffies, end))
>   			break;
> -	}
> -
> -	pr_warn("wait_read() fail: 0x%02x\n", status);
> +		usleep_range(us, us * 16);
> +		}
>   	return -EIO;
>   }
>   
>   /*
> - * send_byte - Write to SMC port, retrying when necessary. Callers
> + * send_byte_data - Write to SMC data port. Callers
>    * must hold applesmc_lock.
> + * Parameter skip must be true on the last write of any
> + * command or it'll time out.
>    */
> -static int send_byte(u8 cmd, u16 port)
> +
> +static int send_byte_data(u8 cmd, u16 port, bool skip)
>   {
> -	u8 status;
> -	int us;
> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> +	int ret;
>   
> +	ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED);
> +	if (ret)
> +		return ret;
>   	outb(cmd, port);
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
>   }
>   
> +/*
> + * send_command - Write a command to the SMC. Callers must hold applesmc_lock.
> + * If SMC is in undefined state, any new command write resets the state machine.
> + */
> +
>   static int send_command(u8 cmd)
>   {
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
> +	outb(cmd, APPLESMC_CMD_PORT);
> +	return wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
>   }
>   
>   static int send_argument(const char *key)
> @@ -239,7 +248,9 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>   	}
>   
>   	for (i = 0; i < len; i++) {
> -		if (wait_read()) {
> +		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
> +				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
> +				SMC_STATUS_IB_CLOSED)) {
>   			pr_warn("%.4s: read data[%d] fail\n", key, i);
>   			return -EIO;
>   		}
> @@ -250,7 +261,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>   	for (i = 0; i < 16; i++) {
>   		udelay(APPLESMC_MIN_WAIT);
>   		status = inb(APPLESMC_CMD_PORT);
> -		if (!(status & 0x01))
> +		if (!(status & SMC_STATUS_AWAITING_DATA))
>   			break;
>   		data = inb(APPLESMC_DATA_PORT);
>   	}
> @@ -275,7 +286,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>   	}
>   
>   	for (i = 0; i < len; i++) {
> -		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
> +		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
>   			pr_warn("%s: write data fail\n", key);
>   			return -EIO;
>   		}
> 

