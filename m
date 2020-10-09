Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA872899C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbgJIUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733207AbgJIUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:32:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B02C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 13:32:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g10so7812657pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+2n+NyZ2VneHzUu3O2ZFqbFaH2GXP/g85/cyhLlDKI=;
        b=A8XYNUW8Xe/wp8Aw5xuggIjNpSnLeh7BCaGlsN1cdwkCDjJ+bm3AodNUNMj4u7j+qC
         Fw80OE29KjLbplTmCSepVJeFZrlKkr5wnjlULWeLMim0M4QlOaJ1Lv+qnsNa8Rw0ZGyo
         v4AORhGBFeS2Bhvi5tEi9mS8B0/n6+tb1m5jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+2n+NyZ2VneHzUu3O2ZFqbFaH2GXP/g85/cyhLlDKI=;
        b=hQTlWNTqTxkzFLUwKAaf4hwDyPO73vdZfG/aOrbOzr42MH/8T+drHU9rt3ubgHiZTH
         sgFLXE2/koDYl7PK1Qw7ZAzo2c5ksAm4MTebgbL6yeHwa3Dw5/39Og4RN1V3AdfQvqnK
         yKxkNff10dG5AjaLxuMIsh3Ie/zT6yhv6TPnauINyzQK9xlYMeA9HHVpu1Zw8V37xQvA
         A8cQGIVQmIgb/ScyIpvPAHg4oeBeNX0gh5iCXrXjxAn3x+uW+F+hXbO7hPzEBidjUzU/
         HDe2Qx0ud1WozTK/HuKSnagGOj4Ne72TBnWrbt+Gn+utPYiuaR8j0QFf2jeetmlFVDlM
         L2/A==
X-Gm-Message-State: AOAM531yRMKAW98GZqrSdjxoN+GD5pqh4jFtIIfzED7g5HZMBJTR45w7
        mqkl6jqn1XAdCGBbEMu72+i1Sg==
X-Google-Smtp-Source: ABdhPJw6NQLrfDn2TZOVRhHaE/4OISnGsGiedt9Nbd2aFZ9b1GT5NT1UMOuE55luWmrtXwFD8Y2D8Q==
X-Received: by 2002:a62:2546:0:b029:153:753e:68e3 with SMTP id l67-20020a6225460000b0290153753e68e3mr13234994pfl.61.1602275542760;
        Fri, 09 Oct 2020 13:32:22 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id m22sm10952251pfk.214.2020.10.09.13.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:32:22 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, drinkcat@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: Add driver capabilities for RTL8822CS
Date:   Fri,  9 Oct 2020 13:32:09 -0700
Message-Id: <20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain controller capabilities must be exposed by the driver because it
can't be queried from HCI (wideband speech support, for example). Update
the match data structure to set the supported capabilities and set the
proper quirks on hdev after registering the device.

Also update the 8822CS capabilities to show it supports wideband speech
and has valid le states (allows central peripheral role).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/hci_h5.c | 53 +++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index a10d710fc3f13e..3833a2d276665f 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -97,6 +97,11 @@ struct h5 {
 	struct gpio_desc *device_wake_gpio;
 };
 
+enum h5_capabilities {
+	H5_CAP_WIDEBAND_SPEECH = BIT(0),
+	H5_CAP_VALID_LE_STATES = BIT(1),
+};
+
 struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
@@ -106,6 +111,11 @@ struct h5_vnd {
 	const struct acpi_gpio_mapping *acpi_gpio_map;
 };
 
+struct h5_device_data {
+	uint32_t capabilities;
+	struct h5_vnd *vnd;
+};
+
 static void h5_reset_rx(struct h5 *h5);
 
 static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
@@ -791,7 +801,10 @@ static const struct hci_uart_proto h5p = {
 static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
+	struct hci_dev *hdev;
 	struct h5 *h5;
+	const struct h5_device_data *data;
+	int err;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
 	if (!h5)
@@ -808,23 +821,21 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (!match)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)match->driver_data;
+		data = (const struct h5_device_data *)match->driver_data;
+		h5->vnd = data->vnd;
 		h5->id  = (char *)match->id;
 
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
 	} else {
-		const void *data;
-
 		data = of_device_get_match_data(dev);
 		if (!data)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)data;
+		h5->vnd = data->vnd;
 	}
 
-
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(h5->enable_gpio))
 		return PTR_ERR(h5->enable_gpio);
@@ -834,7 +845,20 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	err = hci_uart_register_device(&h5->serdev_hu, &h5p);
+	if (err)
+		return err;
+
+	hdev = h5->serdev_hu.hdev;
+
+	/* Set match specific quirks */
+	if (data->capabilities & H5_CAP_WIDEBAND_SPEECH)
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+	if (data->capabilities & H5_CAP_VALID_LE_STATES)
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
+	return 0;
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
@@ -1000,12 +1024,21 @@ static struct h5_vnd rtl_vnd = {
 	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
+
+static const struct h5_device_data h5_data_rtl8822cs = {
+	.capabilities = H5_CAP_WIDEBAND_SPEECH | H5_CAP_VALID_LE_STATES,
+	.vnd = &rtl_vnd,
+};
+
+static const struct h5_device_data h5_data_rtl8723bs = {
+	.vnd = &rtl_vnd,
+};
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
+	{ "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs},
 #endif
 	{ },
 };
@@ -1019,9 +1052,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 static const struct of_device_id rtl_bluetooth_of_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
 	{ .compatible = "realtek,rtl8822cs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = &h5_data_rtl8822cs,
+	},
 	{ .compatible = "realtek,rtl8723bs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = &h5_data_rtl8723bs,
+	},
 #endif
 	{ },
 };
-- 
2.28.0.1011.ga647a8990f-goog

