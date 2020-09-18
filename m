Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5126F435
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgIRDM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbgIRDMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g189so4012666ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yq3AQHq0oby0gIEHvauwatHEbFOs+SQiwBq1B7FgTKo=;
        b=FWdnEbfoGFaKXpZHbnLC++79ZWY3a7aRIGxG2mH67sZoVYWZUYC4LcK2SJ2r8mq1IJ
         VN2fUkJ7EQnVl0TGDlhk3EWmIVC8FNtBt131mk65HSsyaCqmFj2XZ3dx837bKYLSTtTp
         KtiAl342ruTWqRQ7YjBWAyaixJN58jS/f+4kUhS9myHZl3p8TUEXUSbz/sbUF+agMq4K
         AAnNYh38Oh55uQbs3TtQ8IPZ8BVtJXVDqpmGk4u/rYTKeSVCH75gVy+RagaTyIrGQjPV
         ZQEzNtygW+Md++DGU88mU1D+gYeda6um7diigCHcmmmMcm3ee2Ge+VsOqtQCdC+PnjvA
         d8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yq3AQHq0oby0gIEHvauwatHEbFOs+SQiwBq1B7FgTKo=;
        b=L9wQ9leQ+/WWB1bGyZXAK0FfX6BzGerFhjOVTSXp3sQA/gYkPJfCmOu0c0j/brWmAy
         H9cIMUMlltOKhDUSpCvIMHANjnnMbsetSL9XJgxU5MnIK9McMWJauOXCxWcQA9vlUIqF
         AXNm+iQYhCLrgKaV+XKNUoayelwsTTfylkuYfPvZLlhRZTWoUVBR3GQfJpearsguBzDj
         YlBDT/op681fGLD0+VrcRYduf3Z0cAoP/ui8HeE72yVHjSrQ1xtdMbXCV20SPCvvGR0o
         oUFXAH1SeeZny/61D+H5J5XIZ8pg75SzxkSxt81Ps1EmBytYhGKRbt7CPXUbDTnXce9R
         UzIA==
X-Gm-Message-State: AOAM530Uj5cqNWf/iCuiKaPfwWV9azY4NOkNg0SAn0X9jYxzA5T1R+Rn
        FwYcdYa1xWP0Z02NW5cTl9/0hIjn1mfNobmsBg==
X-Google-Smtp-Source: ABdhPJxpXqOdPBoIYXkioBEuMajlBbzI5RIYR8yLeXTdm8sYgj7Z8KPEw60I7kFQuiavazH6jfQ/uumb1tiOo/5KnA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a5b:3d2:: with SMTP id
 t18mr42152587ybp.333.1600398751314; Thu, 17 Sep 2020 20:12:31 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:51 +0800
In-Reply-To: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200918111110.v3.4.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 4/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
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
2.28.0.681.g6f77f65b4e-goog

