Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D42AE7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 05:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKKE4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 23:56:07 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:54788 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKE4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:56:07 -0500
Received: from srv.home ([10.8.0.1] ident=heh21299)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kciAL-00044G-RX; Wed, 11 Nov 2020 12:55:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=uj9dOXaGqSlTaU3pwgaPlMYQQG9P/JCDz5+gitB10gs=;
        b=gsa+3+Xh4gn5QI7kpsST8wGYCx6SQz+PaQYItNr96oMhLw6DaifhukAmvH0voO6Yz1onwbJiG5t5MvudLYRdK5KB4uDzfqG09mUKngai6sI7XvAd9tHtqpRfnGDoxt90DEEQJo1sHjk8fNkPwWKqV+sihzWILYwkt1fsn0w2rIU=;
Subject: [PATCH v1] applesmc: Cleanups on top of re-work comms
From:   Brad Campbell <brad@fnarfbargle.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
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
 <e5c6242a-5207-0f9a-5803-2dc164425b5b@fnarfbargle.com>
Message-ID: <4ed933bd-9bb9-f09f-0e0c-d82893d7ac76@fnarfbargle.com>
Date:   Wed, 11 Nov 2020 15:55:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <e5c6242a-5207-0f9a-5803-2dc164425b5b@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few small cleanups on top of the comms changes for applesmc.c :

send_byte() is always called with APPLESMC_CMD_PORT, so simplify.
Remove redundant check from smc_sane().
Consolidate writing length with other setup parameters.
Consolidate read and write error messages to a single statement each.

Length and error consolidation suggested by Henrik Rydberg <rydberg@bitmath.org>

Signed-off-by: Brad Campbell <brad@fnarfbargle.com>

Index: linux-stable/drivers/hwmon/applesmc.c
===================================================================
--- linux-stable.orig/drivers/hwmon/applesmc.c
+++ linux-stable/drivers/hwmon/applesmc.c
@@ -176,7 +176,7 @@ static int wait_status(u8 val, u8 mask)
 
 /* send_byte - Write to SMC data port. Callers must hold applesmc_lock. */
 
-static int send_byte(u8 cmd, u16 port)
+static int send_byte(u8 cmd)
 {
 	int status;
 
@@ -186,7 +186,7 @@ static int send_byte(u8 cmd, u16 port)
 	status = wait_status(SMC_STATUS_BUSY, SMC_STATUS_BUSY);
 	if (status)
 		return status;
-	outb(cmd, port);
+	outb(cmd, APPLESMC_DATA_PORT);
 	return 0;
 }
 
@@ -219,10 +219,7 @@ static int smc_sane(void)
 	ret = send_command(APPLESMC_READ_CMD);
 	if (ret)
 		return ret;
-	ret = wait_status(0, SMC_STATUS_BUSY);
-	if (!ret)
-		return ret;
-	return -EIO;
+	return wait_status(0, SMC_STATUS_BUSY);
 }
 
 static int send_argument(const char *key)
@@ -230,7 +227,7 @@ static int send_argument(const char *key
 	int i;
 
 	for (i = 0; i < 4; i++)
-		if (send_byte(key[i], APPLESMC_DATA_PORT))
+		if (send_byte(key[i]))
 			return -EIO;
 	return 0;
 }
@@ -245,23 +242,14 @@ static int read_smc(u8 cmd, const char *
 	if (ret)
 		return ret;
 
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
+	if (send_command(cmd) || send_argument(key) || send_byte(len))
+		goto err;
 
 	for (i = 0; i < len; i++) {
 		if (wait_status(SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY,
-				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY) < 0) {
-			pr_warn("%.4s: read data[%d] fail\n", key, i);
-			return -EIO;
-		}
+				SMC_STATUS_AWAITING_DATA | SMC_STATUS_BUSY))
+			goto err;
+
 		buffer[i] = inb(APPLESMC_DATA_PORT);
 	}
 
@@ -277,6 +265,9 @@ static int read_smc(u8 cmd, const char *
 		pr_warn("flushed %d bytes, last value is: %d\n", i, data);
 
 	return wait_status(0, SMC_STATUS_BUSY);
+err:
+	pr_warn("read cmd fail: %x %.4s %d\n", cmd, key, len);
+	return -EIO;
 }
 
 static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
@@ -288,24 +279,17 @@ static int write_smc(u8 cmd, const char
 	if (ret)
 		return ret;
 
-	if (send_command(cmd) || send_argument(key)) {
-		pr_warn("%s: write arg fail\n", key);
-		return -EIO;
-	}
+	if (send_command(cmd) || send_argument(key) || send_byte(len))
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
+		if (send_byte(buffer[i]))
+			goto err;
 
 	return wait_status(0, SMC_STATUS_BUSY);
+err:
+	pr_warn("write cmd fail: %x %.4s %d\n", cmd, key, len);
+	return -EIO;
 }
 
 static int read_register_count(unsigned int *count)
