Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C398B2AD35A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgKJKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgKJKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:18:48 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:18:48 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z130so8832380pgz.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/ezy6lAqc7MUpQhd7aVdTsjzC/c2bjGSDjWe3QgakvQ=;
        b=Yybuizz6Mc33yHPec9FElLcYFRiTkf1aiM2CvR0ktL7KzOSRcV1EUd13NWQYKcgjth
         k/z9RoC4BvYZnVprvkFJnxbcC7jPYLSKr5o9x8JTiqOVDN/XbxinyH/QFjWPBLxRJUiq
         pdIK/Pf+WRRKrh4C7aQv9oIssB+aI+qiGK3f4e6TgCwpm62QQtogpDPx+XXbFJcgHBOk
         ABxC8JtX8UODMqGw1L4b1X7iyGFHjKfTIaIjxtmjT+YVNny8S8Kr9clHEQ2jJiJ6yq9I
         Ltas9d24vQ5N/dfDcnuUIZp6VyJm4BHX6mscE6cAo8ha+e2/ycACkuyIEhBSIcN6n8HI
         QOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ezy6lAqc7MUpQhd7aVdTsjzC/c2bjGSDjWe3QgakvQ=;
        b=S7od9C/90j2DVzEf0oCBmYui9T2UCEF/QB1rmOI0NZzPR/E6X6YdePBIdgm+TMZ6y8
         vwZwL5SF+VIgDADGdmpQ6ncwoSfWIxQuki44yvudiac1+mLogHDCtMSJ8xO7TT669W58
         TxlZagrGVxYaG1tEjVrRpqxD2gsgLje9grfgAWrhCPo7glK3RlQgEymOEya5ZA/dtgl2
         XqA77yumdcDYC3ZCD+QEHQCWID4kWxyjbjQecJ0MaQW4+ZmTb+xS1RFiUzfLoR4g5lOd
         DjLCnpjUCA4DAtYoPzCBwfxkXzO4n3E0Ns8xZz84k98grM/klu3kLJhZGMSl8RgWEMvl
         E2sA==
X-Gm-Message-State: AOAM531Zj5YnvvIhTj/gG81XUDO0igouftDSMPA61wxHQvH39RAxKPnX
        eptOb3LwVp/3gSpyiUtADoYyLhOJYZOQx0ZWnw==
X-Google-Smtp-Source: ABdhPJwHkpKNrKFUFMOYgnQsqYxdKy56iUBJN/YTKnaGpMPdfnI8Y8AqTrIkm02d8C1B5pRTr8rM/OLutcE/QTwGeA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:16c7:b029:163:ce86:1d5d with
 SMTP id l7-20020a056a0016c7b0290163ce861d5dmr17262650pfc.80.1605003528100;
 Tue, 10 Nov 2020 02:18:48 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:17:52 +0800
In-Reply-To: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201110181740.v8.3.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v8 3/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to handle the system suspension during interleave
scan. The interleave scan will be canceled when the system is going to
sleep, and will be restarted after waking up.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v5)

Changes in v5:
- Remove the change in hci_req_config_le_suspend_scan

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2fd56ee21d31f..d943ad2885aa0 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1293,8 +1293,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan if enabled */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_interleave_scan(hdev);
 			hci_req_add_le_scan_disable(&req, false);
+		}
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.29.2.222.g5d2a92d10f8-goog

