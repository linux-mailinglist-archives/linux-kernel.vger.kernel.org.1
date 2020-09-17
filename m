Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA67E26D716
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIQIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIQIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a19so366969pff.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FNIQ4TwzUmm1KHmokSEwCEB+0kpJ2JKM9cy2f0sja/s=;
        b=msz2NcBEHBn4//yvvlA9BvhRf9AbMQ4vFBBmV31mMDu/xsybwVA8JKpGL8YwGWRTkK
         C9dMyGQvzuutz7TlFpLoA/NBVj2arKtETcrRIRgihU50mn/CbHx1GuXnNSXeQZToOvKr
         YfRth3WHQ5gRXi3M9OmExnLIummqxyxMu0WVTQtHleO6IvGYoT/6KrbRB23ajEqNSYlt
         uwvdVtyB7wgxutDSPNaNMOR1uZ9qjBusTRqcHREfQEbW9EdmF75ccCe/O0rTbmVKNA+L
         yyMcvXj3zUc1QNX3ERlxjWJfytcDFCAJAYvEwPhE7O8YXBuY/PGfqTB10LGtUyzhK/r0
         aTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FNIQ4TwzUmm1KHmokSEwCEB+0kpJ2JKM9cy2f0sja/s=;
        b=fkI6+GOpcGCdPbnGX7iJYB4WroGKX6aET0hMFhDBo8czutlA7mHk12X50BCluoZjgA
         t3H3SDC3nWUfaPZjLsUuYHeNO0Gu/PHdxlkgjiZS5ul48lNm/fis8gMtIx1j85urjKIb
         Z7qJPnYmZHoj8K3a2fjHgiTaLwkka33TCXOR91+zR9iTpER7zS94GOcLeqwzb80OPCH+
         HgzN9CdSAHc0XL5zBB93gt4hd/q4+y/QNk4iWokFw/q+oB4pQIjF9+QBHf6zoss2xtPt
         8EuwAmfmzqghyx0VG+hUGzZ3TI172hBfCsKV1SPHRjwyPJiFGbDto8pX0WK2PCGjPFbn
         eqlA==
X-Gm-Message-State: AOAM531TePs3PiFfdOaF1omXdDgnolFwLPajCm5zWNPqUg4Ae350lxje
        fBmElgXKQL3m4Y9cQhOdp1Y0encSCH6D2NP8aw==
X-Google-Smtp-Source: ABdhPJyZ5zr8aCmSNqrsGqhZ7eOqE5l90QCLj+GHKNbZg3/YWweber23RTxxs6jdmYjWgzSEI1Z9EfXTAg39J3fMNw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:941:: with SMTP id
 dw1mr715085pjb.1.1600332452758; Thu, 17 Sep 2020 01:47:32 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:13 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.4.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 4/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
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

(no changes since v1)

 net/bluetooth/hci_request.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 89443b48d90ce..d9082019b6386 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1081,6 +1081,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		filter_policy |= 0x02;
 
 	if (hdev->suspended) {
+		/* Block suspend notifier on response */
+		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+
 		window = hdev->le_scan_window_suspend;
 		interval = hdev->le_scan_int_suspend;
 	} else if (hci_is_le_conn_scanning(hdev)) {
@@ -1167,10 +1170,8 @@ static void hci_req_config_le_suspend_scan(struct hci_request *req)
 		hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
-	hci_req_add_le_passive_scan(req);
+	__hci_update_background_scan(req);
 
-	/* Block suspend notifier on response */
-	set_bit(SUSPEND_SCAN_ENABLE, req->hdev->suspend_tasks);
 }
 
 static void cancel_adv_timeout(struct hci_dev *hdev)
@@ -1282,8 +1283,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
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
2.28.0.618.gf4bc123cb7-goog

