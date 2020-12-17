Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7329B2DDBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgLQWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLQWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:54:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9BC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:53:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e2so108226pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fRqpnsxfl7qHr4VGqHrEfBZUN2xnW4XoVy0GlNX3IEw=;
        b=M7tyJ75ZEoEHtHRFHXWzjAukeGU6uZWu4hbrVNbxb4pviOUrB3bQahQtCfSC+9p2m0
         YDbKmXSabg6qZDYR7dqyDdhad3kdv7qLeVSxCaRhSh8fTvXp8w00pJZo8oMSmq2YxgXl
         fNBAwH8sxrhgbeSxvMpB24u/EOf+k1SOiNXGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fRqpnsxfl7qHr4VGqHrEfBZUN2xnW4XoVy0GlNX3IEw=;
        b=uT+kNxRyaKBTZ5M8RSANKajUbeYHtbuIl3CwJNJMrtQqWaWX09B5aP3YfoUmZSZnne
         iCuaWjF80W6IMweziG1w38QMmH9K4Rb9/PZRdHxr+mlC7J2v9tE6X2y8Da1OaP4SFaCd
         iKCaoJPXo4ZZcGVNVsJ3jMFjVpNLDnqTgnTMKcYWMUc2jcleLZrzII028FfqFjX5nMdn
         S51+uoXRnO8EwBEL21Wa7uQUXMxjtIvVJT7w+DUBSIRF/G4Hgz6OLLMe2MeSwpnb9H8J
         aT5qqSE97xkuDLC2tPNJ30P0IOya7qZCZFojd3uYDrri55CU9NKAI+wZ7v4L8hgmsypC
         9qDg==
X-Gm-Message-State: AOAM5328lOBXS6wkNLkDIUJnDviWRWN+RCqxW3YB1AuIuNbStyHxXBu9
        NTmAakMMJIkoOwNAY45hC4ykTg==
X-Google-Smtp-Source: ABdhPJyOQPClQLF1y6Xhcm5nUIsJcSrkwCk6ErtPzkEBtpkBszZYYYcHnTdPbU3QjM4VER8TSicGxw==
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id b1-20020aa787010000b029019e0561d476mr1477814pfo.2.1608245617759;
        Thu, 17 Dec 2020 14:53:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id c14sm6559544pfd.37.2020.12.17.14.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:53:37 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle
Date:   Thu, 17 Dec 2020 14:53:15 -0800
Message-Id: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves msft_do_close() from hci_dev_do_close() to
hci_unregister_dev() to avoid clearing MSFT extension info. This also
avoids retrieving MSFT info upon every msft_do_open() if MSFT extension
has been initialized.

The following test steps were performed.
(1) boot the test device and verify the MSFT support debug log in syslog
(2) restart bluetoothd and verify msft_do_close() doesn't get invoked

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_core.c | 4 ++--
 net/bluetooth/msft.c     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d2c9a1c552fd..8471be105a2ac 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1780,8 +1780,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
-	msft_do_close(hdev);
-
 	if (hdev->flush)
 		hdev->flush(hdev);
 
@@ -3869,6 +3867,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	unregister_pm_notifier(&hdev->suspend_notifier);
 	cancel_work_sync(&hdev->suspend_prepare);
 
+	msft_do_close(hdev);
+
 	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 4b39534a14a18..d9d2269bc93ef 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -76,7 +76,8 @@ void msft_do_open(struct hci_dev *hdev)
 {
 	struct msft_data *msft;
 
-	if (hdev->msft_opcode == HCI_OP_NOP)
+	/* Skip if opcode is not supported or MSFT has been initiatlized */
+	if (hdev->msft_opcode == HCI_OP_NOP || hdev->msft_data)
 		return;
 
 	bt_dev_dbg(hdev, "Initialize MSFT extension");
-- 
2.29.2.684.gfbc64c5ab5-goog

