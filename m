Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BCC2FC1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbhASVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbhASUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d4so11227940plh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsfZjzlNzJXVW++ya1lrDyULLQkDWoVC/E0GTcKu51k=;
        b=ee5dAIFBSCWqkpeMwwe2Q5AQnVcdwExjk+0JJ3ZY+5vKlD4PfmYwhdrvPq/3nzGkjR
         LWEEGlR9t/jobNVnioo1lLPJU0fh4gTUoxxhwIfxlkvGErJrLnnpcNQjkagpKDQ+A9m8
         HMxNfCi+2xn+EHNLyh2/v80Q0KfGHp1adQqA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsfZjzlNzJXVW++ya1lrDyULLQkDWoVC/E0GTcKu51k=;
        b=Jjf9d77S3YSK1Y7QawhZLkIO9qBQcK/kqX9anacgFhLj56ORMtM4v2DD7fL+gHO75/
         G2I7sxlpluZenYDwmaFdTZ8RhFv/U69YHYztLvaAOKuP174LPqLDZ4N89CSozokC13dt
         IrpWtuoM4quyLrBb7V32z7qty2fPPWsR8MojJpjEUxeg/qfhKHEznz3HxSYCYhG0OysK
         Lj2ZxHdsDoiO2oy3L54yApuCI7KAO5T7mWAmaOS+Jd8CvwFPOglZ0I5skngI2UmY2FKf
         ytQVdbPDoKJTN57pYdA2DlZ+aqkQOuFgikwGMqow6/vgRYcoZ0CdlfwcBwUyaAFxqqES
         Dt9g==
X-Gm-Message-State: AOAM533miDkGrn05YRD2ART6AXqJwZKDMcHzVme4ATQQH2lfJdGp4EDs
        7hIgHA7uXbmhKtR+SP8NuaEt6nqxZax1gg==
X-Google-Smtp-Source: ABdhPJydbVhkgkAOI+VFO4e2Os6eSIgJINtaIF/pQjNKUmVP045sHTczGR+2I740dosNO1DABMG8qw==
X-Received: by 2002:a17:902:ec06:b029:de:67a0:989d with SMTP id l6-20020a170902ec06b02900de67a0989dmr6506516pld.53.1611089006265;
        Tue, 19 Jan 2021 12:43:26 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:25 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Expose reset gpio to debugfs
Date:   Tue, 19 Jan 2021 12:43:14 -0800
Message-Id: <20210119124258.3.I7c6ae9b637f9a77f6e6f2e4256c6a0232476be43@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119204315.2611811-1-abhishekpandit@chromium.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If btusb has a reset gpio, expose it to userspace so we can toggle the
reset gpio directly. This is useful for testing and error recovery.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 880e9cd4ee713..702be1871ed88 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -574,6 +575,46 @@ static void btusb_toggle_gpio(struct gpio_desc *desc, unsigned int duration)
 	gpiod_set_value_cansleep(desc, 0);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t btusb_debugfs_has_reset_gpio(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	char buf[3];
+
+	buf[0] = data->reset_gpio ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t btusb_debugfs_reset_gpio(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (!data->reset_gpio)
+		return -EOPNOTSUPP;
+
+	bt_dev_warn(hdev, "Debugfs triggering HW reset via gpio");
+	btusb_toggle_gpio(data->reset_gpio, data->reset_duration_ms);
+
+	return count;
+}
+
+static const struct file_operations reset_gpio_fops = {
+	.open		= simple_open,
+	.read		= btusb_debugfs_has_reset_gpio,
+	.write		= btusb_debugfs_reset_gpio,
+	.llseek		= default_llseek,
+};
+#endif
+
 static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -4625,6 +4666,11 @@ static int btusb_probe(struct usb_interface *intf,
 	if (err < 0)
 		goto out_free_dev;
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_create_file("toggle_hw_reset", 0644, hdev->debugfs, hdev,
+			    &reset_gpio_fops);
+#endif
+
 	usb_set_intfdata(intf, data);
 
 	return 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

