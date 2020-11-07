Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7032AA76B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgKGSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 13:31:12 -0500
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:31750
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgKGSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 13:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:cc:to:from:subject:from;
        bh=p3PbTb+Cq5DBv6T/N0pHjzdGEMwCxu84V9BqU/mJRgQ=;
        b=bx+f1G+HZ4Ae74L/MITHrYiF143QVKEe/GlBzWYTtmOcG2DkLld3/LADDtnZIO65qTu5iYCNRTPPX
         MbRnwFMfKBArH8ZOVaKEfafD24HPYAHhx7bgu/HgMVR1jnMxJhWeUuy5UcQzp//hTYChB0W9uN/8DV
         bqaa7WlGQkVgJwzbgnWlGlQC65UVz4CYw4bnuftsrmco1/EpMt0LuziOTYhJjFJ+VJXG7oYH+SS13w
         o0znhy0UxvMTQIhW4fw19I73uX+G6cklz9Ff04wrPk51tkmMBtnw0ARHvqNS3VHjGvrA0jNQyEWNmq
         0pU50TjzdRNNk0dbVfElHUaX/RnPoMA==
X-HalOne-Cookie: f80572ca68637df08d6fef21497c3d34cbfcdfb5
X-HalOne-ID: 63bd4e96-2127-11eb-bb7e-d0431ea8bb10
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 63bd4e96-2127-11eb-bb7e-d0431ea8bb10;
        Sat, 07 Nov 2020 18:31:02 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
From:   Henrik Rydberg <rydberg@bitmath.org>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux>
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
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
Message-ID: <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
Date:   Sat, 7 Nov 2020 19:31:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 21:02, Henrik Rydberg wrote:
>> So as it stands, it does not work at all. I will continue to check 
>> another machine, and see if I can get something working.
> 
> On the MacBookAir3,1 the situation is somewhat better.
> 
> The first three tree positions result in zero failures and 10 reads per 
> second. The fourth yields zero failues and 11 reads per second, within 
> the margin of similarity.
> 
> So, the patch appears to have no apparent effect on the 3,1 series.
> 
> Now onto fixing the 1,1 behavior.

Hi again,

This patch, v3, works for me, on both MBA1,1 and MBA3,1. Both machines 
yields 25 reads per second.

It turns out that the origin code has a case that was not carried over 
to the v2 patch; the command byte needs to be resent upon the wrong 
status code. I added that back. Also, there seems to be a basic response 
time that needs to be respected, so I added back a small fixed delay 
after each write operation. I also took the liberty to reduce the number 
of status reads, and clean up error handling. Checkpatch is happy with 
this version.

The code obviously needs to be retested on the other machines, but the 
logic still follows what you wrote, Brad, and I have also checked it 
against the VirtualSMC code. It appears to make sense, so hopefully 
there wont be additional issues.

Thanks,
Henrik

 From be4a32620b2b611472af3e35f9b50004e678efd5 Mon Sep 17 00:00:00 2001
From: Brad Campbell <brad@fnarfbargle.com>
Date: Thu, 5 Nov 2020 18:26:24 +1100
Subject: [PATCH] applesmc: Re-work SMC comms v3

Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
introduced an issue whereby communication with the SMC became
unreliable with write errors like:

[  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[  120.378621] applesmc: LKSB: write data fail
[  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[  120.512787] applesmc: LKSB: write data fail

The original code appeared to be timing sensitive and was not reliable with
the timing changes in the aforementioned commit.

This patch re-factors the SMC communication to remove the timing
dependencies and restore function with the changes previously committed.

v2 : Address logic and coding style
v3 : Modifications for MacBookAir1,1

Reported-by: Andreas Kemnade <andreas@kemnade.info>
Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
---
  drivers/hwmon/applesmc.c | 132 +++++++++++++++++++++------------------
  1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..08289827da1e 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -42,6 +42,11 @@

  #define APPLESMC_MAX_DATA_LENGTH 32

+/* Apple SMC status bits */
+#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
+#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
+#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
+
  /* wait up to 128 ms for a status change. */
  #define APPLESMC_MIN_WAIT	0x0010
  #define APPLESMC_RETRY_WAIT	0x0100
@@ -151,65 +156,76 @@ static unsigned int key_at_index;
  static struct workqueue_struct *applesmc_led_wq;

  /*
- * wait_read - Wait for a byte to appear on SMC port. Callers must
- * hold applesmc_lock.
+ * Wait for specific status bits with a mask on the SMC
+ * Used before and after writes, and before reads
   */
-static int wait_read(void)
+
+static int wait_status(u8 val, u8 mask)
  {
  	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
  	u8 status;
  	int us;

  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		usleep_range(us, us * 16);
  		status = inb(APPLESMC_CMD_PORT);
-		/* read: wait for smc to settle */
-		if (status & 0x01)
+		if ((status & mask) == val)
  			return 0;
  		/* timeout: give up */
  		if (time_after(jiffies, end))
  			break;
+		usleep_range(us, us * 16);
  	}

-	pr_warn("wait_read() fail: 0x%02x\n", status);
+	if (debug)
+		pr_warn("%s fail: 0x%02x 0x%02x 0x%02x\n", __func__, val, mask, status);
  	return -EIO;
  }

  /*
- * send_byte - Write to SMC port, retrying when necessary. Callers
+ * send_byte_data - Write to SMC data port. Callers
   * must hold applesmc_lock.
+ * Parameter skip must be true on the last write of any
+ * command or it'll time out.
   */
-static int send_byte(u8 cmd, u16 port)
+
+static int send_byte_data(u8 cmd, u16 port, bool skip)
+{
+	outb(cmd, port);
+	udelay(APPLESMC_MIN_WAIT);
+	return wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | 
SMC_STATUS_IB_CLOSED);
+}
+
+/*
+ * send_command - Write a command to the SMC. Callers must hold 
applesmc_lock.
+ * If SMC is in undefined state, any new command write resets the state 
machine.
+ */
+
+static int send_command(u8 cmd)
  {
+	int ret;
+	int i;
  	u8 status;
-	int us;
-	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;

-	outb(cmd, port);
-	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		usleep_range(us, us * 16);
+	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 16; i++) {
+		outb(cmd, APPLESMC_CMD_PORT);
+		udelay(APPLESMC_MIN_WAIT);
+		ret = wait_status(0, SMC_STATUS_IB_CLOSED);
+		if (ret)
+			return ret;
  		status = inb(APPLESMC_CMD_PORT);
-		/* write: wait for smc to settle */
-		if (status & 0x02)
-			continue;
-		/* ready: cmd accepted, return */
-		if (status & 0x04)
+		if (status & SMC_STATUS_BUSY)
  			return 0;
-		/* timeout: give up */
-		if (time_after(jiffies, end))
-			break;
-		/* busy: long wait and resend */
-		udelay(APPLESMC_RETRY_WAIT);
-		outb(cmd, port);
+		usleep_range(APPLESMC_RETRY_WAIT, APPLESMC_RETRY_WAIT * 16);
  	}

-	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
-	return -EIO;
-}
+	if (debug)
+		pr_warn("%s fail: 0x%02x\n", __func__, status);

-static int send_command(u8 cmd)
-{
-	return send_byte(cmd, APPLESMC_CMD_PORT);
+	return -EIO;
  }

  static int send_argument(const char *key)
@@ -217,32 +233,28 @@ static int send_argument(const char *key)
  	int i;

  	for (i = 0; i < 4; i++)
-		if (send_byte(key[i], APPLESMC_DATA_PORT))
+		if (send_byte_data(key[i], APPLESMC_DATA_PORT, false))
  			return -EIO;
  	return 0;
  }

+static int send_length(u8 len, bool skip)
+{
+	return send_byte_data(len, APPLESMC_DATA_PORT, skip);
+}
+
  static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
  {
  	u8 status, data = 0;
  	int i;

-	if (send_command(cmd) || send_argument(key)) {
-		pr_warn("%.4s: read arg fail\n", key);
-		return -EIO;
-	}
-
-	/* This has no effect on newer (2012) SMCs */
-	if (send_byte(len, APPLESMC_DATA_PORT)) {
-		pr_warn("%.4s: read len fail\n", key);
-		return -EIO;
-	}
+	if (send_command(cmd) || send_argument(key) || send_length(len, 1))
+		goto err;

  	for (i = 0; i < len; i++) {
-		if (wait_read()) {
-			pr_warn("%.4s: read data[%d] fail\n", key, i);
-			return -EIO;
-		}
+		if (wait_status(SMC_STATUS_AWAITING_DATA,
+						SMC_STATUS_AWAITING_DATA | SMC_STATUS_IB_CLOSED))
+			goto err;
  		buffer[i] = inb(APPLESMC_DATA_PORT);
  	}

@@ -250,7 +262,7 @@ static int read_smc(u8 cmd, const char *key, u8 
*buffer, u8 len)
  	for (i = 0; i < 16; i++) {
  		udelay(APPLESMC_MIN_WAIT);
  		status = inb(APPLESMC_CMD_PORT);
-		if (!(status & 0x01))
+		if (!(status & SMC_STATUS_AWAITING_DATA))
  			break;
  		data = inb(APPLESMC_DATA_PORT);
  	}
@@ -258,30 +270,26 @@ static int read_smc(u8 cmd, const char *key, u8 
*buffer, u8 len)
  		pr_warn("flushed %d bytes, last value is: %d\n", i, data);

  	return 0;
+err:
+	pr_warn("read cmd fail: %x %.4s %d\n", cmd, key, len);
+	return -EIO;
  }

  static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
  {
  	int i;

-	if (send_command(cmd) || send_argument(key)) {
-		pr_warn("%s: write arg fail\n", key);
-		return -EIO;
-	}
+	if (send_command(cmd) || send_argument(key) || send_length(len, 0))
+		goto err;

-	if (send_byte(len, APPLESMC_DATA_PORT)) {
-		pr_warn("%.4s: write len fail\n", key);
-		return -EIO;
-	}
-
-	for (i = 0; i < len; i++) {
-		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
-			pr_warn("%s: write data fail\n", key);
-			return -EIO;
-		}
-	}
+	for (i = 0; i < len; i++)
+		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1))
+			goto err;

  	return 0;
+err:
+	pr_warn("write cmd fail: %x %.4s %d\n", cmd, key, len);
+	return -EIO;
  }

  static int read_register_count(unsigned int *count)
-- 
2.29.2

