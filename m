Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245152C7C61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgK3B3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgK3B3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:29:41 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3998C0613D2;
        Sun, 29 Nov 2020 17:28:55 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e5so287651pjt.0;
        Sun, 29 Nov 2020 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odz+kb1KpmjaBlSIsSkY7pj1XNUUsPWvStEjf4gxHdU=;
        b=k30vK/uVBS2ysUeIkpG/T9aRQUWMbgTX2kJ3obZ7BuPcx6jgJX+k9zQ2/plmrF+P+q
         uSMc7zlVOVx6gRjHHBQ87dEe2O6/9No6FeStiwfzQj8tcQCbog+mMF42ma1dPAmADb8Y
         Pg//cWEapNPrWUWgHN9MYaX8EFZHHnecSiG6LJ25sb3H+WZYQJTVBTTH4PhUSx9qtQHi
         CkDzVByFtcVSG1w4e1ZCLyWqUJwTJZW/yPrtbtyxGo6D5RhYZrzi1JI56Jx+njla70PJ
         maN6I3rti4/pmscav+oKAG/Ytly5wNuQdxaUCTX51eMjwaq33cmSRKBLGwwVzPrZEZKG
         7s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odz+kb1KpmjaBlSIsSkY7pj1XNUUsPWvStEjf4gxHdU=;
        b=N8Lxf0URa0RPLzDDDsy+afGg4prPKDt/JTc5LUJyWrlZoWKMtQG0YYE8hCq9xJqRQN
         NFakIrVryt7Fdg2JaPWhTH/dGa31OWP3XxZmCk0J80F9NkU3br9eZe4ggCXIcECmjrMg
         kM8dR5LE0WmqcnHgfsJSVnPg0uokqrlv94FBIqWLmNoJXp9PJR+sqGBfuj7294d6Bqkz
         dzmkAYtRklFzQjIaMh+m2ES8lsHZOOg56T2T2kHt/JZGxxCYQzeu77WzzAhf2C/+Y7ix
         Kbffk94DghlzzUFjio0/2rM5Zq8nLMdXcXBtMkv9dXnft7jcBvERUgCt7Y5OALQfpbZ4
         ODng==
X-Gm-Message-State: AOAM5306sj+5E+/uxPSvmW0S47jkRiHgQ98tCHeiV7FLVndU8QESM+UC
        qDJb3txdCPxuTcb7zfu5Ub2O+219cxrrVLi0TzY=
X-Google-Smtp-Source: ABdhPJz5OT92OWKkSRuxaohuF6Hwaatl+3XGDi4LGFv61H2jpVNcA1DprkT9mbRb9Ke6riy26rcs6A==
X-Received: by 2002:a17:90b:1886:: with SMTP id mn6mr14823892pjb.31.1606699735236;
        Sun, 29 Nov 2020 17:28:55 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id l7sm3214644pgi.44.2020.11.29.17.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:28:54 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] usb: misc: emi26: update to use usb_control_msg_send()
Date:   Mon, 30 Nov 2020 06:58:47 +0530
Message-Id: <20201130012847.2579463-1-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/emi26.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/misc/emi26.c b/drivers/usb/misc/emi26.c
index 24d841850e05..1dd024507f40 100644
--- a/drivers/usb/misc/emi26.c
+++ b/drivers/usb/misc/emi26.c
@@ -27,7 +27,7 @@
 #define INTERNAL_RAM(address)   (address <= MAX_INTERNAL_ADDRESS)
 
 static int emi26_writememory( struct usb_device *dev, int address,
-			      const unsigned char *data, int length,
+			      const void *data, int length,
 			      __u8 bRequest);
 static int emi26_set_reset(struct usb_device *dev, unsigned char reset_bit);
 static int emi26_load_firmware (struct usb_device *dev);
@@ -35,22 +35,12 @@ static int emi26_probe(struct usb_interface *intf, const struct usb_device_id *i
 static void emi26_disconnect(struct usb_interface *intf);
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
-static int emi26_writememory (struct usb_device *dev, int address,
-			      const unsigned char *data, int length,
+static int emi26_writememory(struct usb_device *dev, int address,
+			      const void *data, int length,
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
+	return usb_control_msg_send(dev, 0, request, 0x40, address, 0,
+				    data, length, 300, GFP_KERNEL);
 }
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
@@ -77,11 +67,7 @@ static int emi26_load_firmware (struct usb_device *dev)
 	int err = -ENOMEM;
 	int i;
 	__u32 addr;	/* Address to write */
-	__u8 *buf;
-
-	buf = kmalloc(FW_LOAD_SIZE, GFP_KERNEL);
-	if (!buf)
-		goto wraperr;
+	__u8 buf[FW_LOAD_SIZE];
 
 	err = request_ihex_firmware(&loader_fw, "emi26/loader.fw", &dev->dev);
 	if (err)
@@ -133,11 +119,11 @@ static int emi26_load_firmware (struct usb_device *dev)
 
 		/* intel hex records are terminated with type 0 element */
 		while (rec && (i + be16_to_cpu(rec->len) < FW_LOAD_SIZE)) {
-			memcpy(buf + i, rec->data, be16_to_cpu(rec->len));
+			memcpy(&buf[i], rec->data, be16_to_cpu(rec->len));
 			i += be16_to_cpu(rec->len);
 			rec = ihex_next_binrec(rec);
 		}
-		err = emi26_writememory(dev, addr, buf, i, ANCHOR_LOAD_FPGA);
+		err = emi26_writememory(dev, addr, &buf, i, ANCHOR_LOAD_FPGA);
 		if (err < 0)
 			goto wraperr;
 	} while (rec);
@@ -211,7 +197,6 @@ static int emi26_load_firmware (struct usb_device *dev)
 	release_firmware(bitstream_fw);
 	release_firmware(firmware_fw);
 
-	kfree(buf);
 	return err;
 }
 
-- 
2.25.1

