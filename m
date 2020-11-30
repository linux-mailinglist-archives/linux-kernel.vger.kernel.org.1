Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225CD2C7C63
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgK3BaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgK3BaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:30:13 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960CC0613CF;
        Sun, 29 Nov 2020 17:29:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so9368616pfb.9;
        Sun, 29 Nov 2020 17:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ib7I1SBzR+I2y31YawRWflg5fgYPXjDvqt2aJ7OH+U=;
        b=cecYIi5FdVJnecc8OYQz5g8ZzZj9yof8HUpow1OIVGK4S3ezZcRt27keh5z1crNFJY
         BgTzGwtYe6GjXN5Le7w5oGJvAAe+QvsG2N+grDBksFbWIE9vjEwxcVQj4AYIMaazyYoC
         fVUm2oCW9NVeoMvwnR+nwQXcnXtiEXfryPdBjoZIApNy0I/6vyAXemYKkWUFbKY02gL2
         KnU4hq/qsnmEGPzbdQnrd0f/R7xaRxDh7uKoAxYwCJ65fGbDZB7Mnj21/e+TsiXqIsyA
         cqMOMUNEi4oHeRN0iCCMg/VT/E6FrwzdOrEcAdQQ1Q9IvXOsB0NDZCoOTTvxbCgpYTO+
         4+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ib7I1SBzR+I2y31YawRWflg5fgYPXjDvqt2aJ7OH+U=;
        b=Y4H6LqABKhMz5MoBr6+DAH9H62roSM11/LmINcpLidqJbda+qxyxS82xwY/GU7UmZN
         4wkz3Dfqp4BSAZG9MgqR9G3HuLjlXbsILOCwI2a2iKIEhkkjps127b7L+69IKsPVX0N2
         5TMxrvweo9+yKmdwFtj7mkxtQJmKmPTUBVIbAODmR5YFI7YgzPjMk4teYTeSYK5b8d0b
         qndU6exfvcoQQg431+QzbB9+BcB0O0kxjthv4BfsVUY8s8Qk2IWoFsg1OTmJMmpl8fQ8
         m/JtpQcxFMOp/Sm9ZmoCF8lC974fcp2RMHWe5Gy6X0X/pXM9rvHBaD22AaJeHkdfsHRh
         q1+Q==
X-Gm-Message-State: AOAM530Uk71OCYiDQ4uYO9JtpOd1CfH9WsQr+ndBggcvJQOvsiiUJGA6
        Lda15PEul7xyTtccPEhRsx8=
X-Google-Smtp-Source: ABdhPJyquQazRocFDtBMZM5qU7dDWxxxNHNwIB0txUPxRL9WQqQfpF0YT3pGUCaSbpIHAmNGBjHAPw==
X-Received: by 2002:a62:84d2:0:b029:18a:f574:fded with SMTP id k201-20020a6284d20000b029018af574fdedmr16612845pfd.31.1606699772878;
        Sun, 29 Nov 2020 17:29:32 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id y15sm3256550pju.13.2020.11.29.17.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:29:32 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] usb: misc: emi62: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 06:59:25 +0530
Message-Id: <20201130012925.2579632-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/emi62.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/misc/emi62.c b/drivers/usb/misc/emi62.c
index 3eea60437f56..6ac4e72d53e0 100644
--- a/drivers/usb/misc/emi62.c
+++ b/drivers/usb/misc/emi62.c
@@ -36,7 +36,7 @@
 #define INTERNAL_RAM(address)   (address <= MAX_INTERNAL_ADDRESS)
 
 static int emi62_writememory(struct usb_device *dev, int address,
-			     const unsigned char *data, int length,
+			     const void *data, int length,
 			     __u8 bRequest);
 static int emi62_set_reset(struct usb_device *dev, unsigned char reset_bit);
 static int emi62_load_firmware (struct usb_device *dev);
@@ -45,21 +45,11 @@ static void emi62_disconnect(struct usb_interface *intf);
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
 static int emi62_writememory(struct usb_device *dev, int address,
-			     const unsigned char *data, int length,
+			     const void *data, int length,
 			     __u8 request)
 {
-	int result;
-	unsigned char *buffer =  kmemdup(data, length, GFP_KERNEL);
-
-	if (!buffer) {
-		dev_err(&dev->dev, "kmalloc(%d) failed.\n", length);
-		return -ENOMEM;
-	}
-	/* Note: usb_control_msg returns negative value on error or length of the
-	 * 		 data that was written! */
-	result = usb_control_msg (dev, usb_sndctrlpipe(dev, 0), request, 0x40, address, 0, buffer, length, 300);
-	kfree (buffer);
-	return result;
+	return usb_control_msg_send(dev, 0, request, 0x40, address,
+				    0, data, length, 300, GFP_KERNEL);
 }
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
@@ -85,12 +75,9 @@ static int emi62_load_firmware (struct usb_device *dev)
 	int err = -ENOMEM;
 	int i;
 	__u32 addr;	/* Address to write */
-	__u8 *buf;
+	__u8 buf[FW_LOAD_SIZE];
 
 	dev_dbg(&dev->dev, "load_firmware\n");
-	buf = kmalloc(FW_LOAD_SIZE, GFP_KERNEL);
-	if (!buf)
-		goto wraperr;
 
 	err = request_ihex_firmware(&loader_fw, "emi62/loader.fw", &dev->dev);
 	if (err)
@@ -140,11 +127,11 @@ static int emi62_load_firmware (struct usb_device *dev)
 
 		/* intel hex records are terminated with type 0 element */
 		while (rec && (i + be16_to_cpu(rec->len) < FW_LOAD_SIZE)) {
-			memcpy(buf + i, rec->data, be16_to_cpu(rec->len));
+			memcpy(&buf[i], rec->data, be16_to_cpu(rec->len));
 			i += be16_to_cpu(rec->len);
 			rec = ihex_next_binrec(rec);
 		}
-		err = emi62_writememory(dev, addr, buf, i, ANCHOR_LOAD_FPGA);
+		err = emi62_writememory(dev, addr, &buf, i, ANCHOR_LOAD_FPGA);
 		if (err < 0)
 			goto wraperr;
 	} while (rec);
@@ -209,8 +196,6 @@ static int emi62_load_firmware (struct usb_device *dev)
 	release_firmware(bitstream_fw);
 	release_firmware(firmware_fw);
 
-	kfree(buf);
-
 	/* return 1 to fail the driver inialization
 	 * and give real driver change to load */
 	return 1;
@@ -223,7 +208,6 @@ static int emi62_load_firmware (struct usb_device *dev)
 	release_firmware(bitstream_fw);
 	release_firmware(firmware_fw);
 
-	kfree(buf);
 	dev_err(&dev->dev, "Error\n");
 	return err;
 }
-- 
2.25.1

