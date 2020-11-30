Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390142C7C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgK3BdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgK3BdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:33:24 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB89C0613CF;
        Sun, 29 Nov 2020 17:32:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so9383142pfg.8;
        Sun, 29 Nov 2020 17:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc1Y4NMhbCVXiBqEN7io2NrC3w9YKQLRDFoQx1B3ae0=;
        b=lBWEIheP4d1nXN5YP20R5Oj4Pe/fqJezrOm2IUICE1iQLxmBckKmVCQUWbwiXi3iod
         zI4RZEZB5SK9cuIuflQ07AG7IYXF+6R74d8RQIeHcUr+FRgkD633fbErhLIYw7O1jHYN
         ImqAZsfBqCThNZDRz4iVpgk260K0cWPS/wRi2tbcasl5U3Jm4EzfEn0TFahY/fng5giW
         5fKak+BOiYqbWi4R58Yl6hSrDL+88BOZiMLIV19z1BveL8YtK2lvAzt4EQuQidx95B1x
         9lDVf1MN1rlxELxA+V3IT6uzf8umLLmaNebI1XmKmJtjrc4F3EuHk+ShABG2l/exYg0K
         w5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc1Y4NMhbCVXiBqEN7io2NrC3w9YKQLRDFoQx1B3ae0=;
        b=eusCXUBoY819DTFLTX0+og4QnauDLlUM9xsk/gMmE4jyakmUraS3NV6yUVjVU7orFP
         msaLwdkLAE+ubHDBdueZzewV4ICWtOYwcFodJE+fRzX69djxuwj6oL/jyuGswUcqntmC
         G2EOUqe6qs0NGAnFJr5GUX9jubm5Xn1ag4s6b3XEpHQgSaMIDRS8pGqTdZQ2b3kR7dsZ
         lLfyatFYLfsmJkdT84AHQb3inA1tbZRsemiKgZYxtdxSo0JeKLqkbeLKIn1FYDKsG5hp
         Hy058Fa8uJH3wbIikIF/VnP6DrkuDqb3RvhWKeDPAadQXU4B51xGvaB6awbM/ELxUATY
         HovQ==
X-Gm-Message-State: AOAM533+YUSO0ZmzU4GohVYHT+QkSg+7D+p4dcQw1bzA538gJi2sKniA
        awwGgQWdlpLnaM7nAppjVfU=
X-Google-Smtp-Source: ABdhPJwUlt6J5+lTz3AvhQQHBbxtYuv38EmVGIgU4CBbeADY7C6cZpdtgFyQY7KopPEe8JuaT1ddHg==
X-Received: by 2002:aa7:9087:0:b029:197:daff:a9a8 with SMTP id i7-20020aa790870000b0290197daffa9a8mr16402971pfa.26.1606699963656;
        Sun, 29 Nov 2020 17:32:43 -0800 (PST)
Received: from localhost.localdomain ([49.207.197.72])
        by smtp.gmail.com with ESMTPSA id h32sm14348410pgl.36.2020.11.29.17.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:32:42 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Evgeny Novikov <novikov@ispras.ru>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/15] usb: misc: lvstest: update to use the usb_control_msg_{send|recv}() API
Date:   Mon, 30 Nov 2020 07:02:32 +0530
Message-Id: <20201130013232.2581070-1-anant.thazhemadam@gmail.com>
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

