Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5442AAA92
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKHKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:30:45 -0500
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:21683
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728267AbgKHKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.se; s=20191106;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=/f+dEr58NAFwA6h2oNnKCEKGGM/QqNypFitbA5g00lI=;
        b=Fga5Zdho6CmA6Vy59eAcUoF0WvQVKh5iLoaeUOWTJOvqTUoTc5CDarNKQ19hdsVuk/xR+CFxtfnNo
         rpmlzxmhz3773y2UPm7npvWs3uEdc5a5mEA2fKEqtS1mLoFE85uHAAzw7vPcLBkEf02amsAiEQ6HEk
         /dUgaDzo+KIcaAD8xTttNrkAVA8FDnu3KydoXqcQNliyGvTHoijTWxvaqaGTjzBhGi9VRZpaTzcsz4
         YniQag1YeWQErTSvHkCXKmtZ7D4DB2t2ykBhn1uS62p1FR/0SMWdfJwXA2+BR0+DROHO06mka/+tXK
         ZqWFc6tFNcPOoNTszTFvvDCPy5Bh7qQ==
X-HalOne-Cookie: 58f6c1504628793ea0f9d8ac43de89593cd4b4e4
X-HalOne-ID: 3497a2ec-21ab-11eb-9658-d0431ea8a283
Received: from localhost (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 3497a2ec-21ab-11eb-9658-d0431ea8a283;
        Sun, 08 Nov 2020 10:14:37 +0000 (UTC)
Date:   Sun, 8 Nov 2020 11:14:29 +0100
From:   Henrik Rydberg <rydberg@bitmath.org>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
Message-ID: <20201108101429.GA28460@mars.bitmath.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
> Hi Brad,
> 
> On 2020-11-08 02:00, Brad Campbell wrote:
> > G'day Henrik,
> > 
> > I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
> > that causes problems on the early Macbook. This is revised on the one sent earlier.
> > If you could test this on your Air1,1 it'd be appreciated.
> 
> No, I managed to screw up the patch; you can see that I carefully added the
> same treatment for the read argument, being unsure if the BUSY state would
> remain during the AVAILABLE data phase. I can check that again, but
> unfortunately the patch in this email shows the same problem.
> 
> I think it may be worthwhile to rethink the behavior of wait_status() here.
> If one machine shows no change after a certain status bit change, then
> perhaps the others share that behavior, and we are waiting in vain. Just
> imagine how many years of cpu that is, combined. ;-)

Here is a modification along that line.

Compared to your latest version, this one has wait_status() return the
actual status on success. Instead of waiting for BUSY, it waits for
the other status bits, and checks BUSY afterwards. So as not to wait
unneccesarily, the udelay() is placed together with the single
outb(). The return value of send_byte_data() is augmented with
-EAGAIN, which is then used in send_command() to create the resend
loop.

I reach 41 reads per second on the MBA1,1 with this version, which is
getting close to the performance prior to the problems.

From b4405457f4ba07cff7b7e4f48c47668bee176a25 Mon Sep 17 00:00:00 2001
From: Brad Campbell <brad@fnarfbargle.com>
Date: Sun, 8 Nov 2020 12:00:03 +1100
Subject: [PATCH] hwmon: (applesmc) Re-work SMC comms

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
v1 : Inital attempt
v2 : Address logic and coding style
v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
v4 : Do not expect busy state to appear without other state changes

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..ea7c66d5788e 100644
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
@@ -151,65 +157,78 @@ static unsigned int key_at_index;
 static struct workqueue_struct *applesmc_led_wq;
 
 /*
- * wait_read - Wait for a byte to appear on SMC port. Callers must
- * hold applesmc_lock.
+ * Wait for specific status bits with a mask on the SMC
+ * Used before and after writes, and before reads
+ * On success, returns the full status
+ * On failure, returns a negative error
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
-			return 0;
+		if ((status & mask) == val)
+			return status;
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
+	int status;
 
+	status = wait_status(0, SMC_STATUS_IB_CLOSED);
+	if (status < 0)
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
+	udelay(APPLESMC_MIN_WAIT);
+	status = wait_status(0, SMC_STATUS_IB_CLOSED);
+	if (status < 0)
+		return status;
+	if (skip || (status & SMC_STATUS_BUSY))
+		return 0;
+	return -EAGAIN;
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
+	for (i = 0; i < 16; i++) {
+		ret = send_byte(cmd, APPLESMC_CMD_PORT);
+		if (!ret)
+			return ret;
+		if (ret != -EAGAIN)
+			break;
+		usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
+	}
+	return -EIO;
 }
 
 static int send_argument(const char *key)
@@ -239,7 +258,8 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	}
 
 	for (i = 0; i < len; i++) {
-		if (wait_read()) {
+		if (wait_status(SMC_STATUS_AWAITING_DATA,
+					SMC_STATUS_AWAITING_DATA | SMC_STATUS_IB_CLOSED) < 0) {
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
@@ -275,7 +295,7 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 	}
 
 	for (i = 0; i < len; i++) {
-		if (send_byte(buffer[i], APPLESMC_DATA_PORT)) {
+		if (send_byte_data(buffer[i], APPLESMC_DATA_PORT, i == len - 1)) {
 			pr_warn("%s: write data fail\n", key);
 			return -EIO;
 		}
-- 
2.29.2

