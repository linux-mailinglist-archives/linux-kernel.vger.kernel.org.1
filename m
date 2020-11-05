Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064572A7778
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgKEGcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgKEGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:32:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E97C0613CF;
        Wed,  4 Nov 2020 22:32:15 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 32so462895otm.3;
        Wed, 04 Nov 2020 22:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=03T6gJ6dS40kdzfq7FR4zWQJ8oo9/pW0kZ6DQu+oINs=;
        b=M9O6kcWPdCcJ3ab2Qf1kKva74D7AvlvmhWxIA5u2oKe7am0VB99pN2/gRbMI+38HEI
         REPSC73TQhqU1KrFsocJctNdwSWaANkcKuLKVzezC4ZfTHKivHn+CTqQgLq5G8V+3ol7
         47XG6XrDZbMCxEi4a/rzUboX3B7GP88koGQxPOg/iXo4GGU1/u2jrSMcQ0h/vjp4d+na
         84tnAhD/1Mo7yLV1mywYudz1MDXgKfBmjBnsCVNDtAfNHLGrj1tT+eyf92ovxm8c7Use
         +VrTwDvnuhI/DG7Mwjz5PBhMzA0p3BkIi4vjYXBKTtf5S4Zucj8bAuwmV0LcP8rr0ZgF
         JDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=03T6gJ6dS40kdzfq7FR4zWQJ8oo9/pW0kZ6DQu+oINs=;
        b=ib9Lg3ZufZYM5MsAF3yBokvNEmWBkCVr3roXoLgvky1yovsVuzK1O5BR/oKG3DQwNg
         tDdEfCZ/jUb5ncsXDwlTmTyIp0N6HZe0lHVD4XbyTLXTYKitWDcAWyQzu4DavgNRBcdV
         oNlgUxGvwb2f06t4QS2uk2HhlioJkEyYSNrDRapSY6jSHhZfz+DL5ybUztQaLccAG0KU
         XPTZq3wsm+OuygK3ZPceSAJw/XRqgkr2F6TLa0vCoF3z+HWaBVNij0gny8rUDLEaL9yT
         qAap9QID9DkNAa+Cwv+lMCw+hnUBQsy09+F8KIC9FoNlPfd4n9AEFyGtMxea7RUt2BNV
         fyHQ==
X-Gm-Message-State: AOAM530/iRGEwm76ljGBwdp6lV/2wMhGoxGXe4NDPaPM25IxktWNbj1u
        jl3C1I5c2APyDwCsRvoQs2I/FAa7IMU=
X-Google-Smtp-Source: ABdhPJwqeg0ZK4vb4YEyxdc6/2QfPxl+JYw0ucH/L1S1UsIDfZZfY9F7OMKTs42YaO9qObsTbeV0/Q==
X-Received: by 2002:a05:6830:154d:: with SMTP id l13mr739203otp.61.1604557934952;
        Wed, 04 Nov 2020 22:32:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q10sm183073oih.56.2020.11.04.22.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 22:32:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 4 Nov 2020 22:32:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
Subject: Re: [PATCH] applesmc: Re-work SMC comms v1
Message-ID: <20201105063212.GA89225@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:47:25PM +1100, Brad Campbell wrote:
> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()") introduced
> an issue whereby communication with the SMC became unreliable with write
> errors :
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
> Reported-by: Andreas Kemnade <andreas@kemnade.info>

Add

Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")

> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
> 
> ---
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index a18887990f4a..22cc5122ce9a 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -42,6 +42,11 @@
>  
>  #define APPLESMC_MAX_DATA_LENGTH 32
>  
> +/* Apple SMC status bits from VirtualSMC */
> +#define SMC_STATUS_AWAITING_DATA  0x01  ///< Data waiting to be read
> +#define SMC_STATUS_IB_CLOSED      0x02  /// A write is pending / will ignore input
> +#define SMC_STATUS_BUSY           0x04  ///< Busy in the middle of a command.
> +

Maybe consider using BIT() while at it.

/* Please use standard comments */

Also, what does the "<" mean ? Is that supposed to be negated 
(ie bit set means not busy) ? If so, that isn't a standard notation
that I am aware of. Maybe "not set if busy in the middle of a command"
would be better in this case.

>  /* wait up to 128 ms for a status change. */
>  #define APPLESMC_MIN_WAIT	0x0010
>  #define APPLESMC_RETRY_WAIT	0x0100
> @@ -151,65 +156,77 @@ static unsigned int key_at_index;
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
> +	pr_warn("wait_status timeout: 0x%02x, 0x%02x, 0x%02x\n", status, val, mask);
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

I would suggest to keep send_byte() and change it to the following.

static int send_byte(u8 cmd, u16 port)
{
	return send_byte_data(cmd, port, false);
}

That would limit the number of changes needed later in the code
(it is never called with a hard 'true' as parameter).

> +
> +static int send_byte_data(u8 cmd, u16 port, bool skip)
>  {
> -	u8 status;
> -	int us;
> -	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> +	u8 wstat = SMC_STATUS_BUSY;
>  
> +	if (skip)
> +		wstat = 0;

	u8 wstat = skip ? 0 : SMC_STATUS_BUSY;

> +	if (wait_status(SMC_STATUS_BUSY,
> +	SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED))

This fits one line, and the error code
should really not be overwritten.

	ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED);
	if (ret)
		return ret;

> +		goto fail;
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
> +	if (!wait_status(wstat,
> +	SMC_STATUS_BUSY))

That really fits into one line.

> +		return 0;
> +fail:
> +	pr_warn("send_byte_data(0x%02x, 0x%04x) fail\n", cmd, APPLESMC_CMD_PORT);

Can you drop this message ? wait_status() already displays a message,
after all. Also, please reverse error handling, and don't overwrite
error codes.

	ret = wait_status(wstat, SMC_STATUS_BUSY)
	if (ret)
		return ret;

Actually, this can be simplified to
	return wait_status(wstat, SMC_STATUS_BUSY);
or, since wstat is only used once,
	return wait_status(skip ? 0 : SMC_STATUS_BUSY, SMC_STATUS_BUSY);

>  	return -EIO;
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
> +
> +	if (wait_status(0,
> +	SMC_STATUS_IB_CLOSED)) {

Another one of those odd continuation lines.

> +		pr_warn("send_command SMC was busy\n");

and logging noise. As for error handling, same as above, please

	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
	if (ret)
		return ret;

> +		goto fail; }
> +
> +	status = inb(APPLESMC_CMD_PORT);
> +
> +	outb(cmd, APPLESMC_CMD_PORT);
> +	if (!wait_status(SMC_STATUS_BUSY,
> +	SMC_STATUS_BUSY))

Odd/unnecessary continuation line again.

> +		return 0;
> +fail:
> +	pr_warn("send_cmd(0x%02x, 0x%04x) fail\n", cmd, APPLESMC_CMD_PORT);

Wow, up to three messages on failure. Please, don't do that.
One message per failure is really enough. Please simplify to

	return wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);

Actually, I notice that the callers of send_command()
log yet again. Maybe it is time to drop all the messages
from here and from send_argument() and only log in the
calling code.

> +	return -EIO;
>  }
>  
>  static int send_argument(const char *key)
> @@ -217,7 +234,8 @@ static int send_argument(const char *key)
>  	int i;
>  
>  	for (i = 0; i < 4; i++)
> -		if (send_byte(key[i], APPLESMC_DATA_PORT))
> +	/* Parameter skip is false as we always send data after an argument */

Please align comments with code. Maybe move the comment ahead
of the for statement. Or drop it entirely - it doesn't add that
much value. Actually, this blob would go away if you keep
send_byte().

> +		if (send_byte_data(key[i], APPLESMC_DATA_PORT, false))
>  			return -EIO;
>  	return 0;
>  }
> @@ -233,13 +251,15 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  	}
>  
>  	/* This has no effect on newer (2012) SMCs */
> -	if (send_byte(len, APPLESMC_DATA_PORT)) {
> +	if (send_byte_data(len, APPLESMC_DATA_PORT, false)) {
>  		pr_warn("%.4s: read len fail\n", key);
>  		return -EIO;
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (wait_read()) {
> +		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
> +		SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
> +		SMC_STATUS_IB_CLOSED)) {

Align continuatiuon lines with preceding '('. "checkpatch --strict"
reports all those alignment issues.

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
> @@ -263,20 +283,21 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
>  static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
>  {
>  	int i;
> +	u8 end = len-1;

space before and after '-', please. checkpatch --strict will tell.

>  
>  	if (send_command(cmd) || send_argument(key)) {
>  		pr_warn("%s: write arg fail\n", key);
>  		return -EIO;

I notice the driver keeps overwriting error codes. Oh well.
I can't expect you to fix that, and it should not be fixed as part
of this patch, but please don't make it worse (not here, but above
where calls are changed).

>  	}
>  
> -	if (send_byte(len, APPLESMC_DATA_PORT)) {
> +	if (send_byte_data(len, APPLESMC_DATA_PORT, false)) {
>  		pr_warn("%.4s: write len fail\n", key);
>  		return -EIO;
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
> -			pr_warn("%s: write data fail\n", key);
> +		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, (i == end))) {

Unnecessary ( ) around i == end. Not sure if the 'end' variable
is worth it. Might as well make it "i == len - 1" and let the compiler
optimize it at will.

> +			pr_warn("%s: write data fail at %i\n", key, i);
>  			return -EIO;
>  		}
>  	}
