Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA32E1540
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 03:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgLWCtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 21:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgLWCtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:49:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0673C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 18:48:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v1so2281961pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 18:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxceAbHrG+QCjBzTytmyNX2D15zjk1S0lgoPggdlJc=;
        b=mJOdDEe6UetRm0FbrBpFf2xHVLf9wFF/j4376J4i6So9hVah1v5R4rDg7qUy3j3vD9
         9H9wl12ICipiVBDq+Fft7KzhW9xg56dFK509tgIj38MupYLLquSZoD2030QkWZhl8BpO
         +l8KJ4D+0re54622aMPmL4KHPLK5UoCMOlG34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxceAbHrG+QCjBzTytmyNX2D15zjk1S0lgoPggdlJc=;
        b=hh4tiiqZTGtKhtgsjSttYz4runqnR0lRVdZfW7VwkBlmRKj/kSa1KE+6dpv7339xbd
         r9+V3PG/tzlA/VZVyw23q62nh67++qXRbffvVDpCMLQgs6rve8Kr0wNhqFWMP/jJVK2x
         l2rSYAnfXXFgRq84UkaOHTaN28yq40R9Ou/M036OaBHW0v4sqrv2h4KL5LEZ/Chta+oE
         hTXiDWKVe7+uHdUctfn963lmXooRibmxuRXIyUCtxS9rrHWMVsM31jwBGxpaQ3OLOSYM
         2GbMPMDZUWT83YXszjofEJBw7ofXRKWAM5gCtLxn5ANFq94cOI0aIdplrsy89mWGFJSc
         2oYA==
X-Gm-Message-State: AOAM53259U+XdNTmqpXw/YADgExtmodyu9XhKDXuEgmaf0b8P0m8mjgj
        NTaXJclBJPaZ+s1QL4Edp5ZxLHT8jpCNNQ==
X-Google-Smtp-Source: ABdhPJzF9RZeNCMANXrHlY53rXD4WdbfrHMtZS7GERUgLYC8iaBNClRJod251v2CIVdnaNYa6n6Oxg==
X-Received: by 2002:a17:90a:6604:: with SMTP id l4mr24693719pjj.119.1608691711404;
        Tue, 22 Dec 2020 18:48:31 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id t36sm20149913pfg.55.2020.12.22.18.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 18:48:30 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btrtl: Add null check in setup
Date:   Tue, 22 Dec 2020 18:48:24 -0800
Message-Id: <20201222184753.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrtl_dev->ic_info is only available from the controller on cold boot
(the lmp subversion matches the device model and this is used to look up
the ic_info). On warm boots (firmware already loaded),
btrtl_dev->ic_info is null.

Fixes: 05672a2c14a4 (Bluetooth: btrtl: Enable central-peripheral role)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btrtl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1abf6a4d672734f..978f3c773856b05 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -719,16 +719,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	/* Enable central-peripheral role (able to create new connections with
-	 * an existing connection in slave role).
-	 */
-	switch (btrtl_dev->ic_info->lmp_subver) {
-	case RTL_ROM_LMP_8822B:
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-		break;
-	default:
-		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
-		break;
+	if (btrtl_dev->ic_info) {
+		/* Enable central-peripheral role (able to create new
+		 * connections with an existing connection in slave role).
+		 */
+		switch (btrtl_dev->ic_info->lmp_subver) {
+		case RTL_ROM_LMP_8822B:
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+			break;
+		default:
+			rtl_dev_dbg(hdev,
+				    "Central-peripheral role not enabled.");
+			break;
+		}
 	}
 
 	btrtl_free(btrtl_dev);
-- 
2.29.2.729.g45daf8777d-goog

