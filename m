Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1552AFEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKLFhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgKLEGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:06:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FCC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:06:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n186so4512277ybg.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fSfxB4VA6HWJos6j00jhYEtfQGFYYqHBRAAgqZtHTuo=;
        b=KmuFB6APf5Q8jpuDG0OjasxiMRYANtOvA6fQMbWgycwdNqx6l5CQomfIsdAyoo2YTC
         TMJBFgZqHwLaf3GL8tc6mcsP4FjnFRstgWYAg8ICx0zopBkuxyqKZao3sRk2ZsfBOpMw
         PpX1nP0DhWbdSBBJ+drZhz91JO4rJSN/cHcrlPxsLvNWOANn1WEaFvNwPA5II10NDvYo
         BEO8NOQVQqaDip0l69/D8ZQvD1qcB+tDMhPBqTW3ibEvEyjeRBNyOOhoklcPaBE/y2UI
         u0fVbPUza7AznR+yufgkIHHCW1daDuLfhpeQsMmTWcd/wt67ZbQsl+gVVzYJDzm3AfiV
         u9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fSfxB4VA6HWJos6j00jhYEtfQGFYYqHBRAAgqZtHTuo=;
        b=rPKx/xp9Ea0MpyF2/EYVyr6z43Z4TStGAsr9R44yT5sIgZKl3aEsqviU3iLOE5p/s3
         leyYl3aR523k9c80deCzDKal512cuIj5R7De06SyAuCXvQIwKUsnehwtpLFfWdbLP2fa
         GWy0nEdR2tNbdg/zKTRtM2MuwnZpnDEjjo7GbkYzYwEZ7z5I2My1mjMvQdQshPjgMBt1
         jAswQwMxPtkVU0XwAdPqFxD2cU/BILyl7YGTlWVC5QnupZZIZos8U+NIJhTsJTLkQjf8
         XlheV3TrT24igM4bZfyAR9uqJhwo2phx2V1wm1GtGMYnEtO86c3/PuxfHhgaYM+a7wGB
         1fsw==
X-Gm-Message-State: AOAM530kBwcqYAICaRsJQaDG5Fl3c5onaYj0t10VIsDtIENnN8maAr+z
        FhO+i1RLbgjT22/Z4TTdNemTrwWBnR/ELuPCCg==
X-Google-Smtp-Source: ABdhPJwDBsebnMZaBf+gS4Vi/3zrgCQdRPpxtRYipbkkr1QIjAIx7MUBnnzRzXH7s8RvjqT1o4+VuhvlCb7oytWA7A==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:61c5:: with SMTP id
 v188mr33521370ybb.422.1605154011633; Wed, 11 Nov 2020 20:06:51 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:06:37 +0800
In-Reply-To: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201112120532.v10.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v10 2/5] Bluetooth: Handle system suspend resume case
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
index 51cc237b7ce60..3bb0d2a98e82c 100644
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

