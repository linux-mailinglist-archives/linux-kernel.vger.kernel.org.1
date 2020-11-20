Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E404B2B9F88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKTBDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKTBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:03:37 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D1C0613CF;
        Thu, 19 Nov 2020 17:03:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so6249717pfn.0;
        Thu, 19 Nov 2020 17:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiK50gZFRvZf6hl7npXpnNvDrQlEKrxGEmTIg/yKDkI=;
        b=TKLjMstgNn6hZHEN80pmev0XaV77aX7Ox9/KlCscuge+05zoLOfZhK+QbL/6jjXj68
         /x6AQy3IrPgvtkg2D6KgfBgyUwi6fASU7DvPApatLyOgz2vy2NmE/u5h9ttOK/9hrrsx
         NPEXf4KMjEpjxgKgbTdeEh72h0g+BUNWJmxhOCJgQSrkxZfzkERJxh5WBAYWJ+2yPJNU
         +lfA4yP9uemk+Y9PcP6SFUT9c49+un8p28+Zxn4LQw9Z0dsNaiD/WRQByvURNVmwPGaW
         OSdS9zUjjJTGpKmEEA92QLV58POPo4PvqJAr9srlFr3IFve0cPbZsnXmYRxgUUgrtgVs
         gghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EiK50gZFRvZf6hl7npXpnNvDrQlEKrxGEmTIg/yKDkI=;
        b=DyQb7rYKm3YQNAM2eOASWEJmP2FF8Jg0UqnqCEtWGa3olX+wLpjpBY1wlK1AUY/5ab
         H9+pPZzygyFP9DOrlu/haPb0krsAUlYcVSIGEzFjkFFs3P8xHF+PZHIuntOuA/JUbFBg
         L6DptDUbNE/tSJLdErk6eaQ4IybpgLADDYPw92s1AuveK+1oNUUDeImoP04MyBdrTQLL
         QUxwFfvGXi6gQ/wKJiXxO47XNjUqbVzBO7Y+kH9W1mL/9JTNDXhhy5ES3ePoLm1PmzTG
         ITNSLrc6XPTNVAdtQXw7HgfXqTh3M3SDN7RxpG/qvpbmi4ZJiJDCvPvPRBfcKDe03O6R
         13ag==
X-Gm-Message-State: AOAM530UnYmrELWSjsFJgaY8LMRLzECxm4QwAQIdw7+yVdzYirRfEqgK
        fbQ/85gDrwvFZOMvoLan270=
X-Google-Smtp-Source: ABdhPJwD55ENFXC6dqQbgkN884KrwMVQ0iYZvxTRleYt2tRqaibT6aRf+KAi9+dFsnmz54nAsBmeZg==
X-Received: by 2002:a17:90a:bd0d:: with SMTP id y13mr7055267pjr.236.1605834217035;
        Thu, 19 Nov 2020 17:03:37 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id q14sm1205273pfl.163.2020.11.19.17.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 17:03:35 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 2/3] fsi: occ: Add support for P10
Date:   Fri, 20 Nov 2020 11:33:14 +1030
Message-Id: <20201120010315.190737-3-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120010315.190737-1-joel@jms.id.au>
References: <20201120010315.190737-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

The P10 OCC has a different SRAM address for the command and response
buffers. In addition, the SBE commands to access the SRAM have changed
format. Add versioning to the driver to handle these differences.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix sparse warning with a cast as Guneter suggested
---
 drivers/fsi/fsi-occ.c | 125 ++++++++++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 9eeb856c8905..10ca2e290655 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/fsi-occ.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -24,8 +25,13 @@
 #define OCC_CMD_DATA_BYTES	4090
 #define OCC_RESP_DATA_BYTES	4089
 
-#define OCC_SRAM_CMD_ADDR	0xFFFBE000
-#define OCC_SRAM_RSP_ADDR	0xFFFBF000
+#define OCC_P9_SRAM_CMD_ADDR	0xFFFBE000
+#define OCC_P9_SRAM_RSP_ADDR	0xFFFBF000
+
+#define OCC_P10_SRAM_CMD_ADDR	0xFFFFD000
+#define OCC_P10_SRAM_RSP_ADDR	0xFFFFE000
+
+#define OCC_P10_SRAM_MODE	0x58	/* Normal mode, OCB channel 2 */
 
 /*
  * Assume we don't have much FFDC, if we do we'll overflow and
@@ -37,11 +43,14 @@
 #define OCC_TIMEOUT_MS		1000
 #define OCC_CMD_IN_PRG_WAIT_MS	50
 
+enum versions { occ_p9, occ_p10 };
+
 struct occ {
 	struct device *dev;
 	struct device *sbefifo;
 	char name[32];
 	int idx;
+	enum versions version;
 	struct miscdevice mdev;
 	struct mutex occ_lock;
 };
@@ -235,29 +244,43 @@ static int occ_verify_checksum(struct occ_response *resp, u16 data_length)
 	return 0;
 }
 
-static int occ_getsram(struct occ *occ, u32 address, void *data, ssize_t len)
+static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t resp_len, resp_data_len;
-	__be32 *resp, cmd[5];
-	int rc;
+	size_t cmd_len, resp_len, resp_data_len;
+	__be32 *resp, cmd[6];
+	int idx = 0, rc;
 
 	/*
 	 * Magic sequence to do SBE getsram command. SBE will fetch data from
 	 * specified SRAM address.
 	 */
-	cmd[0] = cpu_to_be32(0x5);
+	switch (occ->version) {
+	default:
+	case occ_p9:
+		cmd_len = 5;
+		cmd[2] = cpu_to_be32(1);	/* Normal mode */
+		cmd[3] = cpu_to_be32(OCC_P9_SRAM_RSP_ADDR + offset);
+		break;
+	case occ_p10:
+		idx = 1;
+		cmd_len = 6;
+		cmd[2] = cpu_to_be32(OCC_P10_SRAM_MODE);
+		cmd[3] = 0;
+		cmd[4] = cpu_to_be32(OCC_P10_SRAM_RSP_ADDR + offset);
+		break;
+	}
+
+	cmd[0] = cpu_to_be32(cmd_len);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
-	cmd[2] = cpu_to_be32(1);
-	cmd[3] = cpu_to_be32(address);
-	cmd[4] = cpu_to_be32(data_len);
+	cmd[4 + idx] = cpu_to_be32(data_len);
 
 	resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
 	resp = kzalloc(resp_len << 2, GFP_KERNEL);
 	if (!resp)
 		return -ENOMEM;
 
-	rc = sbefifo_submit(occ->sbefifo, cmd, 5, resp, &resp_len);
+	rc = sbefifo_submit(occ->sbefifo, cmd, cmd_len, resp, &resp_len);
 	if (rc)
 		goto free;
 
@@ -287,20 +310,21 @@ static int occ_getsram(struct occ *occ, u32 address, void *data, ssize_t len)
 	return rc;
 }
 
-static int occ_putsram(struct occ *occ, u32 address, const void *data,
-		       ssize_t len)
+static int occ_putsram(struct occ *occ, const void *data, ssize_t len)
 {
 	size_t cmd_len, buf_len, resp_len, resp_data_len;
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
 	__be32 *buf;
-	int rc;
+	int idx = 0, rc;
+
+	cmd_len = (occ->version == occ_p10) ? 6 : 5;
 
 	/*
 	 * We use the same buffer for command and response, make
 	 * sure it's big enough
 	 */
 	resp_len = OCC_SBE_STATUS_WORDS;
-	cmd_len = (data_len >> 2) + 5;
+	cmd_len += data_len >> 2;
 	buf_len = max(cmd_len, resp_len);
 	buf = kzalloc(buf_len << 2, GFP_KERNEL);
 	if (!buf)
@@ -312,11 +336,23 @@ static int occ_putsram(struct occ *occ, u32 address, const void *data,
 	 */
 	buf[0] = cpu_to_be32(cmd_len);
 	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
-	buf[2] = cpu_to_be32(1);
-	buf[3] = cpu_to_be32(address);
-	buf[4] = cpu_to_be32(data_len);
 
-	memcpy(&buf[5], data, len);
+	switch (occ->version) {
+	default:
+	case occ_p9:
+		buf[2] = cpu_to_be32(1);	/* Normal mode */
+		buf[3] = cpu_to_be32(OCC_P9_SRAM_CMD_ADDR);
+		break;
+	case occ_p10:
+		idx = 1;
+		buf[2] = cpu_to_be32(OCC_P10_SRAM_MODE);
+		buf[3] = 0;
+		buf[4] = cpu_to_be32(OCC_P10_SRAM_CMD_ADDR);
+		break;
+	}
+
+	buf[4 + idx] = cpu_to_be32(data_len);
+	memcpy(&buf[5 + idx], data, len);
 
 	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
 	if (rc)
@@ -356,21 +392,35 @@ static int occ_putsram(struct occ *occ, u32 address, const void *data,
 static int occ_trigger_attn(struct occ *occ)
 {
 	__be32 buf[OCC_SBE_STATUS_WORDS];
-	size_t resp_len, resp_data_len;
-	int rc;
+	size_t cmd_len, resp_len, resp_data_len;
+	int idx = 0, rc;
 
-	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 7);
+	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 8);
 	resp_len = OCC_SBE_STATUS_WORDS;
 
-	buf[0] = cpu_to_be32(0x5 + 0x2);        /* Chip-op length in words */
+	switch (occ->version) {
+	default:
+	case occ_p9:
+		cmd_len = 7;
+		buf[2] = cpu_to_be32(3); /* Circular mode */
+		buf[3] = 0;
+		break;
+	case occ_p10:
+		idx = 1;
+		cmd_len = 8;
+		buf[2] = cpu_to_be32(0xd0); /* Circular mode, OCB Channel 1 */
+		buf[3] = 0;
+		buf[4] = 0;
+		break;
+	}
+
+	buf[0] = cpu_to_be32(cmd_len);		/* Chip-op length in words */
 	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
-	buf[2] = cpu_to_be32(0x3);              /* Mode: Circular */
-	buf[3] = cpu_to_be32(0x0);              /* Address: ignore in mode 3 */
-	buf[4] = cpu_to_be32(0x8);              /* Data length in bytes */
-	buf[5] = cpu_to_be32(0x20010000);       /* Trigger OCC attention */
-	buf[6] = 0;
+	buf[4 + idx] = cpu_to_be32(8);		/* Data length in bytes */
+	buf[5 + idx] = cpu_to_be32(0x20010000);	/* Trigger OCC attention */
+	buf[6 + idx] = 0;
 
-	rc = sbefifo_submit(occ->sbefifo, buf, 7, buf, &resp_len);
+	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
 	if (rc)
 		goto error;
 
@@ -429,7 +479,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 
 	/* Extract the seq_no from the command (first byte) */
 	seq_no = *(const u8 *)request;
-	rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
+	rc = occ_putsram(occ, request, req_len);
 	if (rc)
 		goto done;
 
@@ -440,7 +490,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	/* Read occ response header */
 	start = jiffies;
 	do {
-		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR, resp, 8);
+		rc = occ_getsram(occ, 0, resp, 8);
 		if (rc)
 			goto done;
 
@@ -476,8 +526,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	/* Grab the rest */
 	if (resp_data_length > 1) {
 		/* already got 3 bytes resp, also need 2 bytes checksum */
-		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR + 8,
-				 &resp->data[3], resp_data_length - 1);
+		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
 		if (rc)
 			goto done;
 	}
@@ -517,6 +566,7 @@ static int occ_probe(struct platform_device *pdev)
 	if (!occ)
 		return -ENOMEM;
 
+	occ->version = (uintptr_t)of_device_get_match_data(dev);
 	occ->dev = dev;
 	occ->sbefifo = dev->parent;
 	mutex_init(&occ->occ_lock);
@@ -575,7 +625,14 @@ static int occ_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id occ_match[] = {
-	{ .compatible = "ibm,p9-occ" },
+	{
+		.compatible = "ibm,p9-occ",
+		.data = (void *)occ_p9
+	},
+	{
+		.compatible = "ibm,p10-occ",
+		.data = (void *)occ_p10
+	},
 	{ },
 };
 
-- 
2.29.2

