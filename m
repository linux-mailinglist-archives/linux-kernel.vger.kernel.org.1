Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87E126F44C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgIRDNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgIRDMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21088C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x13so2558020plm.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NxYLZaP4aGvAu+/UZ2/LCTJAGtRN+euo/YJvY78SnJI=;
        b=lPnbMx9MR7LP0g8yYqS8XX8PwdhoCbJLqS3Z0Z0JtuxwszJ9u0TKgULzYiNZpjdWBD
         1pFWEgRbhds1BOQrRuitu8mMEDBNDuwU5LUhPPic6Zb0Oe8Cu9IUv4vX3N4HXaUTsqWN
         E3tLAgY5ThRFLx8JC8AtkuxBczzVFBpbeZu2koExJJHkSA5JVsuSRZSxuttC7ewNIl7W
         Yj4EwfyVNTayTJoqCUaNoujn8oMQLgP+QxsxmxT8TnmsrLc3wbbV03nlr+a1oxwen8aE
         Q7X003JemibbmOX6Tn5rBhnHC1uMggGUYmpZwFiCSGp9jwbAzfgo7EOJs9om+YsJ684o
         FBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NxYLZaP4aGvAu+/UZ2/LCTJAGtRN+euo/YJvY78SnJI=;
        b=G4qBxTYnS4sX6FEr6HUiyQm1yatf6sRWDWV0sTF++uAEHr7TQN8Tb6BYNLgf89QQcy
         EQb9nNQT7a0Jgdu2H1UgKRZr9tLkCoKfbtnRVAkPQAwiqWomSNVXKu+oI5xs23Ez26aT
         UY0a9gM1nuhOweSSOsWpF4WU2KgdQq05C/agd+StJz71Boe5YQH3qg1MJg4zAarhxO/h
         BanpdD4IUnyd8D4MvF8Rsgp6aUMfqXwfMBVYWkutyd0bmpRFGLCAIGFE+k9XjmJIuXT0
         eaaE6PJKOifv+ScSoBwt40lrL6C0HcnpPE0rtW6PlJ8U59NNurUxFsYqTx+1UMwmzOXy
         pijQ==
X-Gm-Message-State: AOAM532VLbcKpPP4ypietpLOuFRhm68GylYF5FWQue7BrVqpxQqPsxdb
        YQxUbXzgWZ3iMf7yQTiLu3HgUuamC6qlpWlZag==
X-Google-Smtp-Source: ABdhPJx6kM5DLLFGf2usi1qL12z1S/m8Hsz6v1BbQkAwPJVD0ivhgJmBq+H071e/KejErTX27f7V9MxscFhrpmdfXg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:aa7:8583:0:b029:13f:7096:5eb with SMTP
 id w3-20020aa785830000b029013f709605ebmr30016944pfn.0.1600398739505; Thu, 17
 Sep 2020 20:12:19 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:48 +0800
Message-Id: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 1/6] Bluetooth: Update Adv monitor count upon removal
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This fixes the count of Adv monitor upon monitor removal.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-remove command on one
console and observe a MGMT_EV_ADV_MONITOR_REMOVED event on the other.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
- Remove 'Bluez' prefix

Changes in v2:
- delete 'case 0x001c' in mgmt_config.c

 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a2645a833013..f30a1f5950e15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3061,6 +3061,7 @@ static int free_adv_monitor(int id, void *ptr, void *data)
 
 	idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 	hci_free_adv_monitor(monitor);
+	hdev->adv_monitors_cnt--;
 
 	return 0;
 }
@@ -3077,6 +3078,7 @@ int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
 
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 		hci_free_adv_monitor(monitor);
+		hdev->adv_monitors_cnt--;
 	} else {
 		/* Remove all monitors if handle is 0. */
 		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
-- 
2.28.0.681.g6f77f65b4e-goog

