Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0609B26D706
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIQIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgIQIr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:26 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m13so1131133qtu.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jbS6cNnfIa6p5stK1Reth2jOjANie62zi7bf38pOt7A=;
        b=VU8ABKyVEn1Vi1rt82lQk6xUqNGfYRWs/LonOCMsKotTAWQFAHyIc3lbKvYZpbOPbG
         MLBq1euoqVyrQDSTl1Hn497WOw8rPdkkXdwAPRWLRoO3izaUQ0UjsEBZy0e7IMHQMQwO
         IRMVs+oBTadkQl6tMo4NjAv7adnZrNFsliwjAXXvdoS3ZjEEyXB5LYnmzQG0ysyMOqa6
         OpiqVFGN9mOfW0wyj9iRsAc6gYLNQC3atiD3JNtZgIht32e/aAOSTI4TTSlxkHc6NTVx
         t4DZGgU30FskG66Z23ockLs4ZBISMfw5G8QRp1cWpKjOSB7/Db0YOb6yROSj2czhoPRG
         iDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jbS6cNnfIa6p5stK1Reth2jOjANie62zi7bf38pOt7A=;
        b=Ne8SxiNyZ5NPPolXTuDqOWX1Hjr4liYMinMFtUVUFxg/TXGK0Ff2b1isEskvhn61Qf
         ghA5vVbRSfzlKZpf1G7DBu4WYnbd1bJ4oBM9NFwWkF8Aht0C2MPUVc5pgctXoZq2GiXN
         FH/HhHHah/6E5ANu5KnGgiadcA1SvQBCsAl5A65KXRtAA2EwctXQ58f6rm3jEykUap+X
         IMdWHmE3nlw6T80JM7qmCx2+hYCVUe4gFR7cAJbC/lCKxUJp2OKgJT+UzrxcWLfUJ+KR
         97Qli+jmp9M4TMwqk8HqQNGLD/8unQRqTHgJSWDgKc4xeblFWnPCUMhbJ4SGtdR+HDij
         uywA==
X-Gm-Message-State: AOAM530YsOSdrypVX7cFlXajqjzqAvqlMsEtQarjY6FGBqev7LKCtz9W
        5r5RoP80CYNl+WGne8c96PHIRoysGBidPBcVJg==
X-Google-Smtp-Source: ABdhPJwTNXeoAZcmFbhFvyRqDwANRZEt20ZmHgLpLRvnL2hVahKmCTmSyY44Xr1VsvT7WQAf5nhMs5ts+tK5asWQow==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:14e8:: with SMTP id
 k8mr17144487qvw.19.1600332445243; Thu, 17 Sep 2020 01:47:25 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:11 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 2/6] Bluetooth: Set scan parameters for ADV Monitor
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

Set scan parameters when there is at least one Advertisement monitor.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 413e3a5aabf54..d2b06f5c93804 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1027,6 +1027,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	} else if (hci_is_le_conn_scanning(hdev)) {
 		window = hdev->le_scan_window_connect;
 		interval = hdev->le_scan_int_connect;
+	} else if (hci_is_adv_monitoring(hdev)) {
+		window = hdev->le_scan_window_adv_monitor;
+		interval = hdev->le_scan_int_adv_monitor;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.28.0.618.gf4bc123cb7-goog

