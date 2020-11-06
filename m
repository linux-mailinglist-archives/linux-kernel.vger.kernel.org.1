Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6ED2AA0BE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgKFXNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:13:43 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:39972 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgKFXNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:13:43 -0500
Received: from srv.home ([10.8.0.1] ident=heh14179)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kbAsu-0001PN-QL; Sat, 07 Nov 2020 07:11:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=IJg9I3sWXQAFqOIxVldrvYtfCazCCY50HuwEBx1IZOw=;
        b=FIJcEwpHR4v/SdQD18zDk6T91eoRBXOpEOGvhb6MMTiNEYOHmj8C2odeDdMGQDPXdaNVHFRzXUH8OvEZV+pt+wH3cDv3WMbnxvrVyN4y9UlM7WLwjwTLiGIchU2WG4wR6GbbBLDPTeesuJRZmWDtlO5rphyAb/MG3Ybkbl6LdOk=;
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
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
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <4405a9f5-49d2-b162-8b70-8479a4d9705c@fnarfbargle.com>
Date:   Sat, 7 Nov 2020 10:11:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/20 3:26 am, Henrik Rydberg wrote:
>>> I can't guarantee it won't break older machines which is why I've asked for help testing it. I only have a MacbookPro 11,1 and an iMac 12,2. It fixes both of those.
>>>
>>> Help testing would be much appreciated.
>>
>> I see, this makes much more sense. I may be able to run some tests tonight. Meanwhile, looking at the patch, the status variable in send_command looks superfluous now that there is a wait_status() before it.
> 
> Ok, it took some time to get the machines up to speed, but so far I have managed to run some tests on an MacBookAir1,1. I only managed to upgrade up to 4.15, so I had to revert the inputdev polling patch, but the rest applied without problems. I recovered an old test program I used to use (attached), and checked for failures and reads per second
> 
> *** hwmon: (applesmc) switch to using input device polling mode
> 
> At this point in the tree, with this reverted, I see 0 failures and 55 reads per second.
> 
> *** hwmon: (applesmc) avoid overlong udelay()
> 
> With this applied, I see 0 failures and 16 reads per second.
> 
> *** hwmon: (applesmc) check status earlier.
> 
> With this applied, I see 0 failures and 16 reads per second.
> 
> *** (HEAD -> stable) applesmc: Re-work SMC comms v2
> 
> With this applied, the kernel hangs in module probe, and the kernel log is flooded with read failures.
> 
> So as it stands, it does not work at all. I will continue to check another machine, and see if I can get something working.
> 
> Henrik


G'day Heinrik,

If you could try this earlier version which still had all the failure logging it in we might be able to get a handle on the failure.

Regards,
Brad

---
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..22cc5122ce9a 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -42,6 +42,11 @@
 
 #define APPLESMC_MAX_DATA_LENGTH 32
 
+/* Apple SMC status bits from VirtualSMC */
+#define SMC_STATUS_AWAITING_DATA  0x01  ///< Data waiting to be read
+#define SMC_STATUS_IB_CLOSED      0x02  /// A write is pending / will ignore input
+#define SMC_STATUS_BUSY           0x04  ///< Busy in the middle of a command.
+
 /* wait up to 128 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
@@ -151,65 +156,77 @@ static unsigned int key_at_index;
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
-	}
-
-	pr_warn("wait_read() fail: 0x%02x\n", status);
+		usleep_range(us, us * 16);
+		}
+	pr_warn("wait_status timeout: 0x%02x, 0x%02x, 0x%02x\n", status, val, mask);
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
+	u8 wstat = SMC_STATUS_BUSY;
 
+	if (skip)
+		wstat = 0;
+	if (wait_status(SMC_STATUS_BUSY,
+	SMC_STATUS_BUSY | SMC_STATUS_IB_CLOSED))
+		goto fail;
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
-
-	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
+	if (!wait_status(wstat,
+	SMC_STATUS_BUSY))
+		return 0;
+fail:
+	pr_warn("send_byte_data(0x%02x, 0x%04x) fail\n", cmd, APPLESMC_CMD_PORT);
 	return -EIO;
 }
 
+/*
+ * send_command - Write a command to the SMC. Callers must hold applesmc_lock.
+ * If SMC is in undefined state, any new command write resets the state machine.
+ */
+
 static int send_command(u8 cmd)
 {
-	return send_byte(cmd, APPLESMC_CMD_PORT);
+	u8 status;
+
+	if (wait_status(0,
+	SMC_STATUS_IB_CLOSED)) {
+		pr_warn("send_command SMC was busy\n");
+		goto fail; }
+
+	status = inb(APPLESMC_CMD_PORT);
+
+	outb(cmd, APPLESMC_CMD_PORT);
+	if (!wait_status(SMC_STATUS_BUSY,
+	SMC_STATUS_BUSY))
+		return 0;
+fail:
+	pr_warn("send_cmd(0x%02x, 0x%04x) fail\n", cmd, APPLESMC_CMD_PORT);
+	return -EIO;
 }
 
 static int send_argument(const char *key)
@@ -217,7 +234,8 @@ static int send_argument(const char *key)
 	int i;
 
 	for (i = 0; i < 4; i++)
-		if (send_byte(key[i], APPLESMC_DATA_PORT))
+	/* Parameter skip is false as we always send data after an argument */
+		if (send_byte_data(key[i], APPLESMC_DATA_PORT, false))
 			return -EIO;
 	return 0;
 }
@@ -233,13 +251,15 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	}
 
 	/* This has no effect on newer (2012) SMCs */
-	if (send_byte(len, APPLESMC_DATA_PORT)) {
+	if (send_byte_data(len, APPLESMC_DATA_PORT, false)) {
 		pr_warn("%.4s: read len fail\n", key);
 		return -EIO;
 	}
 
 	for (i = 0; i < len; i++) {
-		if (wait_read()) {
+		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
+		SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY |
+		SMC_STATUS_IB_CLOSED)) {
 			pr_warn("%.4s: read data[%d] fail\n", key, i);
 			return -EIO;
 		}
@@ -250,7 +270,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	for (i = 0; i < 16; i++) {
 		udelay(APPLESMC_MIN_WAIT);
 		status = inb(APPLESMC_CMD_PORT);
-		if (!(status & 0x01))
+		if (!(status & SMC_STATUS_AWAITING_DATA))
 			break;
 		data = inb(APPLESMC_DATA_PORT);
 	}
@@ -263,20 +283,21 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 {
 	int i;
+	u8 end = len-1;
 
 	if (send_command(cmd) || send_argument(key)) {
 		pr_warn("%s: write arg fail\n", key);
 		return -EIO;
 	}
 
-	if (send_byte(len, APPLESMC_DATA_PORT)) {
+	if (send_byte_data(len, APPLESMC_DATA_PORT, false)) {
 		pr_warn("%.4s: write len fail\n", key);
 		return -EIO;
 	}
 
 	for (i = 0; i < len; i++) {
-		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
-			pr_warn("%s: write data fail\n", key);
+		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, (i == end))) {
+			pr_warn("%s: write data fail at %i\n", key, i);
 			return -EIO;
 		}
 	}

