Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD752E0E28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgLVSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgLVSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:17:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:16:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c79so8922392pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0bpRNUW0sMX67i76nSxzJVA0UXv2Ge/HrRVpArz6Og=;
        b=lKRfKAiPlfWevqIDZpQSTkPSL/bZXtYdbMRQIw4G8nvyx8Vn5G4bekPGEX1q/WUrY/
         Lo+2s1XFmkvboKIQ7jQGoWz2ZktBkV72EuStOBXiebt7ZtJndehOLBpY6DPSn4/vs1dX
         p1iD6aGW57yuLqmVW6CQ36mgpNOjIohIXgPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0bpRNUW0sMX67i76nSxzJVA0UXv2Ge/HrRVpArz6Og=;
        b=WZYjM9N6ZYJ7j0mJiVdlydpk23r6cIyQbC9RAi4OHRnVuViAH1BIQmD9dDXIDcRLed
         my2y74aA4mDG7hTWQqdCkMMusQq9O77d2aw1qwVNPK5lBFQJ3YvHGuUc0RlDXJNF1J7q
         YCG3W/oKjCLpluyVo0RE5ZyvbiYRpHoZCqRrvUrj67lzfLWb/Czgv36Oo+8O7tbyqBPD
         LtcJe33hOE7EhNFrX8eQ42aVtlPXIrCijCSwgXeWPPU5tTKXJDEwnRLt1r1ZiGo5ocrS
         2V7D1O2VmicWBEspSM18QpgED4A8iLtY0b75/61aZs13wwBWg5M8L1wKaH7MSCYFzcRj
         VABw==
X-Gm-Message-State: AOAM531MTvNqLX2mxBsi0aYZ9lgGYBGKq6Dt6Mk7/r5qllxxfyJsa9Aj
        FLUvp9SmEfcD1022+k//BccUYg==
X-Google-Smtp-Source: ABdhPJykTpZupV+No5FAvI4pY9PaCiMKPvgnZy9HVOOI83xtRywNlB9mZlTohp4nNs0m55RsxRn/Rg==
X-Received: by 2002:a62:184e:0:b029:19e:c636:17f9 with SMTP id 75-20020a62184e0000b029019ec63617f9mr20599968pfy.23.1608660994487;
        Tue, 22 Dec 2020 10:16:34 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 193sm21107111pfz.36.2020.12.22.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:16:33 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Enable central-peripheral role
Date:   Tue, 22 Dec 2020 10:16:27 -0800
Message-Id: <20201222101603.1.I94935e7936550207ae745d3670890541c792c35e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the central-peripheral role on RTL8822CE. This enables creating
connections while there is an existing connection in the slave role.

This change can be confirmed in userspace via `bluetoothctl show` which
will now show "Roles: central-peripheral".

Reviewed-by: Daniel Winkler <danielwinkler@google.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btrtl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 94df4e94999d5c8..1abf6a4d672734f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -714,13 +714,24 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
 
-	btrtl_free(btrtl_dev);
-
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
+	/* Enable central-peripheral role (able to create new connections with
+	 * an existing connection in slave role).
+	 */
+	switch (btrtl_dev->ic_info->lmp_subver) {
+	case RTL_ROM_LMP_8822B:
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		break;
+	default:
+		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
+		break;
+	}
+
+	btrtl_free(btrtl_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
-- 
2.29.2.729.g45daf8777d-goog

