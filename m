Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF202AE725
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgKKDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:40:04 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:42376 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgKKDkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:40:02 -0500
Received: from srv.home ([10.8.0.1] ident=heh29331)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kcgxd-000437-EU; Wed, 11 Nov 2020 11:38:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=1odn6iaRI4gALQJHByjERPVNF4/8V2emPjealNHoiIM=;
        b=qyk35c8Ak2FdsS32UV5+Qn6CdeHAHquld+iqsMV1Jm33j6BXvTpcpjgfuKpmiWU0DYla+zNW3agaoiVmeEzKQehEI+/MrvrXe++jmG8P+UYSbGYQVmYSAePsF6vFaDYBIvq5siqz3hqeRMbaURLg0wFjykp03GKi3MLN8gzck7w=;
Subject: [PATCH v4 1/1] applesmc: Re-work SMC comms
From:   Brad Campbell <brad@fnarfbargle.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Henrik Rydberg <rydberg@bitmath.org>
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
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
Message-ID: <4eca09dc-7b32-767c-eab0-b9ad8b41efcc@fnarfbargle.com>
Date:   Wed, 11 Nov 2020 14:38:18 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
introduced an issue whereby communication with the SMC became
unreliable with write errors like :

[  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[  120.378621] applesmc: LKSB: write data fail
[  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[  120.512787] applesmc: LKSB: write data fail

The original code appeared to be timing sensitive and was not reliable
with the timing changes in the aforementioned commit.

This patch re-factors the SMC communication to remove the timing
dependencies and restore function with the changes previously
committed.

Tested on : MacbookAir6,2 MacBookPro11,1 iMac12,2, MacBookAir1,1,
MacBookAir3,1

Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
Reported-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>

---
Changelog : 
v1 : Initial attempt
v2 : Address logic and coding style
v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
v4 : Re-factored logic based on Apple driver. Simplified wait_status loop
Index: linux-stable/drivers/hwmon/applesmc.c
===================================================================
--- linux-stable.orig/drivers/hwmon/applesmc.c
+++ linux-stable/drivers/hwmon/applesmc.c
@@ -32,6 +32,7 @@
 #include <linux/hwmon.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
+#include <linux/bits.h>
 
 /* data port used by Apple SMC */
 #define APPLESMC_DATA_PORT	0x300
@@ -42,10 +43,14 @@
 
 #define APPLESMC_MAX_DATA_LENGTH 32
 
-/* wait up to 128 ms for a status change. */
-#define APPLESMC_MIN_WAIT	0x0010
-#define APPLESMC_RETRY_WAIT	0x0100
-#define APPLESMC_MAX_WAIT	0x20000
+/* Apple SMC status bits */
+#define SMC_STATUS_AWAITING_DATA  BIT(0) /* SMC has data waiting to be read */
+#define SMC_STATUS_IB_CLOSED      BIT(1) /* Will ignore any input */
+#define SMC_STATUS_BUSY           BIT(2) /* Command in progress */
+
+/* Exponential delay boundaries */
+#define APPLESMC_MIN_WAIT	0x0008
+#define APPLESMC_MAX_WAIT	0x100000
 
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
@@ -151,65 +156,73 @@ static unsigned int key_at_index;
 static struct workqueue_struct *applesmc_led_wq;
 
 /*
- * wait_read - Wait for a byte to appear on SMC port. Callers must
- * hold applesmc_lock.
+ * Wait for specific status bits with a mask on the SMC
+ * Used before all transactions
  */
-static int wait_read(void)
+
+static int wait_status(u8 val, u8 mask)
 {
-	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
 	u8 status;
 	int us;
 
-	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		usleep_range(us, us * 16);
+	for (us = APPLESMC_MIN_WAIT; us <= APPLESMC_MAX_WAIT; us <<= 1) {
 		status = inb(APPLESMC_CMD_PORT);
-		/* read: wait for smc to settle */
-		if (status & 0x01)
+		if ((status & mask) == val)
 			return 0;
-		/* timeout: give up */
-		if (time_after(jiffies, end))
-			break;
+	usleep_range(APPLESMC_MIN_WAIT, us);
 	}
-
-	pr_warn("wait_read() fail: 0x%02x\n", status);
 	return -EIO;
 }
 
-/*
- * send_byte - Write to SMC port, retrying when necessary. Callers
- * must hold applesmc_lock.
- */
+/* send_byte - Write to SMC data port. Callers must hold applesmc_lock. */
+
 static int send_byte(u8 cmd, u16 port)
 {
-	u8 status;
-	int us;
-	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
+	int status;
 
+	status = wait_status(0, SMC_STATUS_IB_CLOSED);
+	if (status)
+		return status;
+	status = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
+	if (status)
+		return status;
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
-	return -EIO;
+	return 0;
 }
 
+/* send_command - Write a command to the SMC. Callers must hold applesmc_lock. */
+
 static int send_command(u8 cmd)
 {
-	return send_byte(cmd, APPLESMC_CMD_PORT);
+	int ret;
+
+	ret = wait_status(0, SMC_STATUS_IB_CLOSED);
+	if (ret)
+		return ret;
+	outb(cmd, APPLESMC_CMD_PORT);
+	return 0;
+}
+
+/* Based on logic from the Apple driver. This is issued before any interaction
+ * If busy is stuck high, issue a read command to reset the SMC state
+ * machine. If busy is stuck high after the command then the SMC is
+ * jammed.
+ */
+
+static int smc_sane(void)
+{
+	int ret;
+
+	ret = wait_status(0, SMC_STATUS_BUSY);
+	if (!ret)
+		return ret;
+	ret = send_command(APPLESMC_READ_CMD);
+	if (ret)
+		return ret;
+	ret = wait_status(0, SMC_STATUS_BUSY);
+	if (!ret)
+		return ret;
+	return -EIO;
 }
 
 static int send_argument(const char *key)
@@ -226,6 +239,11 @@ static int read_smc(u8 cmd, const char *
 {
 	u8 status, data = 0;
 	int i;
+	int ret;
+
+	ret = smc_sane();
+	if (ret)
+		return ret;
 
 	if (send_command(cmd) || send_argument(key)) {
 		pr_warn("%.4s: read arg fail\n", key);
@@ -239,7 +257,8 @@ static int read_smc(u8 cmd, const char *
 	}
 
 	for (i = 0; i < len; i++) {
-		if (wait_read()) {
+		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
+				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY) < 0) {
 			pr_warn("%.4s: read data[%d] fail\n", key, i);
 			return -EIO;
 		}
@@ -250,19 +269,24 @@ static int read_smc(u8 cmd, const char *
 	for (i = 0; i < 16; i++) {
 		udelay(APPLESMC_MIN_WAIT);
 		status = inb(APPLESMC_CMD_PORT);
-		if (!(status & 0x01))
+		if (!(status & SMC_STATUS_AWAITING_DATA))
 			break;
 		data = inb(APPLESMC_DATA_PORT);
 	}
 	if (i)
 		pr_warn("flushed %d bytes, last value is: %d\n", i, data);
 
-	return 0;
+	return wait_status(0, SMC_STATUS_BUSY);
 }
 
 static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 {
 	int i;
+	int ret;
+
+	ret = smc_sane();
+	if (ret)
+		return ret;
 
 	if (send_command(cmd) || send_argument(key)) {
 		pr_warn("%s: write arg fail\n", key);
@@ -281,7 +305,7 @@ static int write_smc(u8 cmd, const char
 		}
 	}
 
-	return 0;
+	return wait_status(0, SMC_STATUS_BUSY);
 }
 
 static int read_register_count(unsigned int *count)
