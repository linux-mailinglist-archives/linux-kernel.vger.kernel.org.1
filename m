Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F482C4DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgKZEWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbgKZEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:22:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52991C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:22:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so1227798ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lXyh67vNMJMfjKfbnDtxJFjlSgopuz07QzIMmNfAPeg=;
        b=L5IGUI+FZGUk7IRBh3HsJdYoxbrewNtuzP7m+REKeCVgqz7N0I0lrS0MsRMyoVpQa7
         rUupJ6W/PyyIfTIZ7qIlWbyVS8w8cbIPMS+oRZCpAWC2iLsciHl5r9WKpslO7SEACbc4
         +cAXXMLHoH+6j2qqnIFzYCljIaTWIEwhG8IrUCxNxmMhVrtzvLXTYXnDgu8B0TmmGBkS
         r5G6DC5RhJF40jPvn9yJGPsJlAmcxvUw2JGJigdXGMvXIRuS1sj8B3ja0qwNI/ra7P8n
         UOCqzTbjdQQ3O7qKaaj2pyWFnLRb5OTo/z1uiRGSroVVw8p2oDJyyhHfUsn7Ns54Le6T
         T4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lXyh67vNMJMfjKfbnDtxJFjlSgopuz07QzIMmNfAPeg=;
        b=ap8+Va/aUVow597JoAgi5ZnkG/a6tZLhVVDARjkyksloS8xfH9cWDfxSl0+P/EHPhi
         PammKs3PnK0oYcx85BoeQnB8hn1SI8u1VBgx38AOL8NucyDuS2+k5x+JHHFj3w0+kK49
         iEuyiJ1Tk0FZ41kas5HAJgB7++EFF93lpm21N+PWofplN5cGyB41rtbhRlSqMUGyXuP0
         JqEoUAKonvn3/AdWQorAh8ZjvTrEYMacAzdNXbv37D4mPKt3TnJbcogpHN58KOgsQJW8
         GBAulQbnSI3wLdRUaaGiSPWI4Tbp1rNT2LIC/02pDqSDDrh/1ijwLrGfHoJj5dCQO1SB
         nxGQ==
X-Gm-Message-State: AOAM533jaYHs66ffJJqyWTorP52XAKoUZo+EjN0A1yg9Ah8mXtwTTSiT
        6Ao5wpxgwyHwaqYeHEJ+OO0AO5Rlxn14XLrKBA==
X-Google-Smtp-Source: ABdhPJxyZQSIfJZ+DnwHrqeAOax2ApANcUZ22vtXQokHYy/tzbO6GP+SVqLbNOIjzllhmQis9p+wdv8Oao5L9x7YkA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:2845:: with SMTP id
 o66mr1678470ybo.260.1606364557582; Wed, 25 Nov 2020 20:22:37 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:22:22 +0800
In-Reply-To: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201126122109.v11.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v11 2/5] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
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
index d6bf1517ddaec..8addb94560013 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1294,8 +1294,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
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
2.29.2.454.gaff20da3a2-goog

