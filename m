Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FCC2AA885
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgKHAL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:11:57 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:44192 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKHAL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:11:57 -0500
Received: from srv.home ([10.8.0.1] ident=heh3199)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kbYGv-0001dS-L3; Sun, 08 Nov 2020 08:09:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=W11utpUc9JqwXMy6WRNFpPy4tcbCcr4lnQf/725rYWc=;
        b=EwNO2PgqSX96XKcIHsxk+s7s5u+6HSRnGsUFryeJfCmPt4p5E0keYdboSu777HT6uQN6qjOiSEsIq4W6IhWXhJhHco/lFcJOVZf4YZcQGBJdTrjHgqsZ4/i1DmHSOpADGMObcxa/pYd7K+ZGAWEwlPWVGcXoFbwZUobl8ezGYKA=;
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux> <20201002002251.28462e64@aktux>
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
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <26d3f4f5-2e9a-cd20-1531-74cf44ef738c@fnarfbargle.com>
Date:   Sun, 8 Nov 2020 11:09:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 5:31 am, Henrik Rydberg wrote:
> On 2020-11-06 21:02, Henrik Rydberg wrote:
>>> So as it stands, it does not work at all. I will continue to check another machine, and see if I can get something working.
>>
>> On the MacBookAir3,1 the situation is somewhat better.
>>
>> The first three tree positions result in zero failures and 10 reads per second. The fourth yields zero failues and 11 reads per second, within the margin of similarity.
>>
>> So, the patch appears to have no apparent effect on the 3,1 series.
>>
>> Now onto fixing the 1,1 behavior.
> 
> Hi again,
> 
> This patch, v3, works for me, on both MBA1,1 and MBA3,1. Both machines yields 25 reads per second.
> 
> It turns out that the origin code has a case that was not carried over to the v2 patch; the command byte needs to be resent upon the wrong status code. I added that back. Also, there seems to be a basic response time that needs to be respected, so I added back a small fixed delay after each write operation. I also took the liberty to reduce the number of status reads, and clean up error handling. Checkpatch is happy with this version.
> 
> The code obviously needs to be retested on the other machines, but the logic still follows what you wrote, Brad, and I have also checked it against the VirtualSMC code. It appears to make sense, so hopefully there wont be additional issues.
> 
> Thanks,
> Henrik
> 

G'day Henrik,

Which kernel was this based on? It won't apply to my 5.9 tree.

I assume the sprinkling of udelay(APPLESMC_MIN_WAIT) means the SMC is
slow in getting its status register set up. Could we instead just put
a single one of those up-front in wait_status?

Any chance you could try this one? I've added a retry to send_command and 
added a single global APPLESMC_MIN_WAIT before each status read.

From looking at your modified send_command, it appears the trigger for a 
retry is sending a command and the SMC doing absolutely nothing. This
should do the same thing.

Interestingly enough, by adding the udelay to wait_status on my machine I've
gone from 24 reads/s to 50 reads/s.

I've left out the remainder of the cleanups. Once we get a minimally working
patch I was going to look at a few cleanups, and I have some patches pending
to allow writing to the SMC from userspace (for setting BCLM and BFCL mainly)


diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..2190de78b5f5 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -32,6 +32,7 @@
 #include <linux/hwmon.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
+#include <linux/bits.h>
 
 /* data port used by Apple SMC */
 #define APPLESMC_DATA_PORT	0x300
@@ -42,6 +43,11 @@
 
 #define APPLESMC_MAX_DATA_LENGTH 32
 
+/* Apple SMC status bits */
+#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting */
+#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
+#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
+
 /* wait up to 128 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
@@ -151,65 +157,73 @@ static unsigned int key_at_index;
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
 
+	udelay(APPLESMC_MIN_WAIT);
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
-
-	pr_warn("wait_read() fail: 0x%02x\n", status);
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
 {
-	u8 status;
-	int us;
-	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
+	int ret;
 
+	ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED);
+	if (ret)
+		return ret;
 	outb(cmd, port);
-	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		usleep_range(us, us * 16);
-		status = inb(APPLESMC_CMD_PORT);
-		/* write: wait for smc to settle */
-		if (status & 0x02)
-			continue;
-		/* ready: cmd accepted, return */
-		if (status & 0x04)
-			return 0;
-		/* timeout: give up */
-		if (time_after(jiffies, end))
-			break;
-		/* busy: long wait and resend */
-		udelay(APPLESMC_RETRY_WAIT);
-		outb(cmd, port);
-	}
+	return wait_status(skip ? 0 : SMC_STATUS_BUSY, SMC_STATUS_BUSY);
+}
 
-	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
-	return -EIO;
+static int send_byte(u8 cmd, u16 port)
+{
+	return send_byte_data(cmd, port, false);
 }
 
+/*
+ * send_command - Write a command to the SMC. Callers must hold applesmc_lock.
+ * If SMC is in undefined state, any new command write resets the state machine.
+ */
+
 static int send_command(u8 cmd)
 {
-	return send_byte(cmd, APPLESMC_CMD_PORT);
+	int ret;
+	int i;
+		
+	for (i=0; i < 16; i++) {
+		ret = wait_status(0, SMC_STATUS_IB_CLOSED);
+		if (ret)
+			return ret;
+	
+		outb(cmd, APPLESMC_CMD_PORT);
+		ret = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
+		if (!ret)
+			return ret;
+	}
+	return -EIO;
 }
 
 static int send_argument(const char *key)
@@ -239,7 +253,9 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	}
 
 	for (i = 0; i < len; i++) {
-		if (wait_read()) {
+		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
+				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
+				SMC_STATUS_IB_CLOSED)) {
 			pr_warn("%.4s: read data[%d] fail\n", key, i);
 			return -EIO;
 		}
@@ -250,7 +266,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	for (i = 0; i < 16; i++) {
 		udelay(APPLESMC_MIN_WAIT);
 		status = inb(APPLESMC_CMD_PORT);
-		if (!(status & 0x01))
+		if (!(status & SMC_STATUS_AWAITING_DATA))
 			break;
 		data = inb(APPLESMC_DATA_PORT);
 	}
@@ -275,7 +291,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 	}
 
 	for (i = 0; i < len; i++) {
-		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
+		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
 			pr_warn("%s: write data fail\n", key);
 			return -EIO;
 		}


