Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D4304F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391645AbhA0BkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393820AbhAZSkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:40:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87596C061756;
        Tue, 26 Jan 2021 10:40:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w14so10946822pfi.2;
        Tue, 26 Jan 2021 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc1Y4NMhbCVXiBqEN7io2NrC3w9YKQLRDFoQx1B3ae0=;
        b=BRcBOxwnrhqqL5HPkPKHY2RfFpihmcP3eXkWI3lfIyzbHZMYS/oWxpVQpipvsCbtMS
         06w/N3oueLFZvM+QAR8xalsQk2caRbcQZKP7KNzHsU1R8sdN7scbWiKdt+4TYxxVxbBH
         G574fkdZYOUkqbk/uGcd3WV5dS3ujEwFXyd1puKoy/682V7CFPkygZKwtsii/2dF5poX
         pXFxXOHrNyPmUzh6OkZtuQdFlHlBa2UOvtq5QY1jnXnntdGfD5A8rEOSZk2eTtXy0RLM
         ZuV/Kk+9xJIvzhq5FpR4e/rQ8AplJARbRhxxXJtNCZjeluN45H6ivEFqNI+Fsg/koDAw
         FsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc1Y4NMhbCVXiBqEN7io2NrC3w9YKQLRDFoQx1B3ae0=;
        b=hqSLXSDgtxE0BMOYsoEmfldaiqWS8PplXb/Lfx45DOzSmxadt3OL18sp8hUhZFf74t
         e2B7Fo/2B5N8V8NK3vClPyqThyF3bhEWpxZycVR8oESGmY/ikVFRCgwRRzdD6KCcTzAc
         YuCmM3YqS3bhEsvngig7Q3P1FNWjk9RJSn1w0553owS/L+AebePC8wf0fRHlm7OoAekg
         TjK7lfSJee5bRGF2TYRP1K7+3Badi3r4ZLaO8RgV4voFTcEJ8NogFvKNKy7javH4ma1I
         LPPEHA+pUAPt7W+XhW1bNaT2sRdlc3yJs942nrjs1skpuSqKnILWHsR+bjf+PC8to9wp
         jB+g==
X-Gm-Message-State: AOAM531lYO01ENI4vQr+fuLo1mdZowV43CyMrfiy053QVD9rAykPTgCt
        vf74KDwTgB8EC57AmFnalZw=
X-Google-Smtp-Source: ABdhPJzYLh5KPPyyEPbfFExkULcireYYex7FMizRdkQN0zYFlxx/ENcNe/Br7APfIQY3RX3htU/stQ==
X-Received: by 2002:a63:5004:: with SMTP id e4mr7011098pgb.338.1611686401050;
        Tue, 26 Jan 2021 10:40:01 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id ge16sm2945273pjb.41.2021.01.26.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:40:00 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Evgeny Novikov <novikov@ispras.ru>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] usb: misc: lvstest: update to use the usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 00:09:43 +0530
Message-Id: <20210126183943.914631-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, instances of usb_control_msg() have been replaced with
usb_control_msg_{recv|send}() and the return value checking conditions have
also been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/lvstest.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/misc/lvstest.c b/drivers/usb/misc/lvstest.c
index f8686139d6f3..daa1b2c9139f 100644
--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -85,17 +85,17 @@ static void destroy_lvs_device(struct usb_device *udev)
 static int lvs_rh_clear_port_feature(struct usb_device *hdev,
 		int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	return usb_control_msg_send(hdev, 0,
 		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+		NULL, 0, 1000, GFP_KERNEL);
 }
 
 static int lvs_rh_set_port_feature(struct usb_device *hdev,
 		int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	return usb_control_msg_send(hdev, 0,
 		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+		NULL, 0, 1000, GFP_KERNEL);
 }
 
 static ssize_t u3_entry_store(struct device *dev,
@@ -257,13 +257,9 @@ static ssize_t get_dev_desc_store(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_device *udev;
-	struct usb_device_descriptor *descriptor;
+	struct usb_device_descriptor descriptor;
 	int ret;
 
-	descriptor = kmalloc(sizeof(*descriptor), GFP_KERNEL);
-	if (!descriptor)
-		return -ENOMEM;
-
 	udev = create_lvs_device(intf);
 	if (!udev) {
 		dev_err(dev, "failed to create lvs device\n");
@@ -271,18 +267,16 @@ static ssize_t get_dev_desc_store(struct device *dev,
 		goto free_desc;
 	}
 
-	ret = usb_control_msg(udev, (PIPE_CONTROL << 30) | USB_DIR_IN,
-			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN, USB_DT_DEVICE << 8,
-			0, descriptor, sizeof(*descriptor),
-			USB_CTRL_GET_TIMEOUT);
+	ret = usb_control_msg_recv(udev, 0, USB_REQ_GET_DESCRIPTOR,
+				   USB_DIR_IN, USB_DT_DEVICE << 8,
+				   0, &descriptor, sizeof(descriptor),
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 	if (ret < 0)
 		dev_err(dev, "can't read device descriptor %d\n", ret);
 
 	destroy_lvs_device(udev);
 
 free_desc:
-	kfree(descriptor);
-
 	if (ret < 0)
 		return ret;
 
@@ -336,10 +330,10 @@ static void lvs_rh_work(struct work_struct *work)
 
 	/* Examine each root port */
 	for (i = 1; i <= descriptor->bNbrPorts; i++) {
-		ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+		ret = usb_control_msg_recv(hdev, 0,
 			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, i,
-			port_status, sizeof(*port_status), 1000);
-		if (ret < 4)
+			port_status, sizeof(*port_status), 1000, GFP_KERNEL);
+		if (ret < 0)
 			continue;
 
 		portchange = le16_to_cpu(port_status->wPortChange);
@@ -420,13 +414,13 @@ static int lvs_rh_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, lvs);
 
 	/* how many number of ports this root hub has */
-	ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+	ret = usb_control_msg_recv(hdev, 0,
 			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN | USB_RT_HUB,
 			USB_DT_SS_HUB << 8, 0, &lvs->descriptor,
-			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
-	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
+			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret < 0) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret < 0 ? ret : -EINVAL;
+		return ret;
 	}
 
 	/* submit urb to poll interrupt endpoint */
-- 
2.25.1

