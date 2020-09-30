Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B127F2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgI3UBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgI3UBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1796C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:01:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so1926836pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yd6l4FulTeamGjzLY1tF0TQenwZuapAs4XC6TJqnsI=;
        b=m4W9sJpp/0kJj76A36B+GEkq0kcB6lzObEAEWV9HgmqYP5Z4FSXlp//IVN6jAsyni3
         yX3uCp7Xr+AvTwLF1NwXvQULbnanZ1ehU82eBky0+babTwllriyZ/QjJbDoj85LNvQOc
         R26G+QOyY5sDEaG9uqsQExuJ//Iw4vQBHAL6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yd6l4FulTeamGjzLY1tF0TQenwZuapAs4XC6TJqnsI=;
        b=orCPIUJ1By5Ag3dLLE538hqKSxP8xmZjILEX0a6MsdSaw9q9izwDKf/R/KUv+RBI1g
         SgigDR1GnuxQmSAXeVS0QKNsNUk7VL/5oHxf/AICV9PXf7xeYgkkjjA5s7dAFueA7WjU
         eab0BLZxmIzDADpRBJk8x4hq3r/fr00BDsGsDLmXznXUbNimaLyBEENc+Sv2KdITsjvN
         HfWYXByH50gkw2EcmFI0ZETI89ELnIL7HVV65f0VU/OTkABMXaltDCXJXN71qG2ErsOQ
         sydqq8rX2ifNVZbCegV3nKejJQPDkVP9PanxOnlM3YbBW37vK4LV3aONbjyM+QFW4+Gp
         RFGg==
X-Gm-Message-State: AOAM532/UCpPQ3wL0Q82qePeOYB/DrQKM2poJ8qCXTeNjjGhnlJbehl9
        3eKhvhSrsvGMrNegfDvCQOrKgKsulfnMFw==
X-Google-Smtp-Source: ABdhPJzAUKYXF1dekvreSmIR1ZdIcd3TMlw2eUoM1hHVFsTCtHW2Jrsu0mXZBjl40aJa0CFSqCWMLg==
X-Received: by 2002:a63:1657:: with SMTP id 23mr3522143pgw.168.1601496105262;
        Wed, 30 Sep 2020 13:01:45 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 75sm2998874pgg.22.2020.09.30.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:44 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btqca: Add valid le states quirk
Date:   Wed, 30 Sep 2020 13:01:38 -0700
Message-Id: <20200930130108.1.Iaa2fcfb9b4fbfe4b4887464a6b4f12ac4b831c84@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCN3991 supports connectable advertisements so we need to add the valid
le states quirk so the 'central-peripheral' role is exposed in
userspace.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Example result showing the central-peripheral role correctly.

localhost # bluetoothctl show
Controller 3C:28:6D:4F:A0:1F (public)
        Name: BlueZ 5.54
        Alias: Chromebook_63FC
        Class: 0x00480000
        Powered: yes
        Discoverable: no
        DiscoverableTimeout: 0x000000b4
        Pairable: yes
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        Modalias: bluetooth:v00E0pC405d0057
        Discovering: no
        Roles: central
        Roles: peripheral
        Roles: central-peripheral

 drivers/bluetooth/hci_qca.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 244b8feba52327..2d3f1f179a1e3d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,6 +78,7 @@ enum qca_flags {
 
 enum qca_capabilities {
 	QCA_CAP_WIDEBAND_SPEECH = BIT(0),
+	QCA_CAP_VALID_LE_STATES = BIT(1),
 };
 
 /* HCI_IBS transmit side sleep protocol states */
@@ -1780,7 +1781,7 @@ static const struct qca_device_data qca_soc_data_wcn3991 = {
 		{ "vddch0", 450000 },
 	},
 	.num_vregs = 4,
-	.capabilities = QCA_CAP_WIDEBAND_SPEECH,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn3998 = {
@@ -2017,11 +2018,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		hdev->shutdown = qca_power_off;
 	}
 
-	/* Wideband speech support must be set per driver since it can't be
-	 * queried via hci.
-	 */
-	if (data && (data->capabilities & QCA_CAP_WIDEBAND_SPEECH))
-		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+	if (data) {
+		/* Wideband speech support must be set per driver since it can't
+		 * be queried via hci. Same with the valid le states quirk.
+		 */
+		if (data->capabilities & QCA_CAP_WIDEBAND_SPEECH)
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+				&hdev->quirks);
+
+		if (data->capabilities & QCA_CAP_VALID_LE_STATES)
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+	}
 
 	return 0;
 }
-- 
2.28.0.709.gb0816b6eb0-goog

