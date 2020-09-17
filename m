Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160A26D314
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIQFaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgIQF3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:29:53 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BEC061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:29:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z27so898735qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iN2CxHeMNgWaifXzqNK0PvVkokPY17tdMHt/mMLio+0=;
        b=nrIqOSlka6gtQA/RNk0dOAyWdFk1JRuotnAsgOi4qPsbqcEhwnvkcHDzjNXMTHchAW
         sXhWyBjoCzGM7UibTywYYwkI62nicmbZaWCAUya0veldw469JT5qps31uB1GnE4+YsJa
         DOFulqEQ8dT5ZWZKc3yRNn1NOq74s7naWuJ4aPOLwf3U3BzhzPIAooWHhCOOrQbZCKRT
         3j3HRkslX5TI4xaHyEh1m7oH+kNkkfB4DApDmjBPY50Uu4cCaskv6LUilb/XAcMOsryw
         Snv+OqzXw9bLaiykWU1qA5fSPqtexYAGSd+FAm/fS1bmjWIxt3mdnhQvVlQKMHu7RdvI
         9wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iN2CxHeMNgWaifXzqNK0PvVkokPY17tdMHt/mMLio+0=;
        b=NzOldKdjlhcTPq5kIxhOqWzPks3I7Ce7La8k47saiZzSo1OmG4tV0v+WPh6waYPOq8
         smezY3slCNtU+uEv68SJ8kNPMMakCE4lb9OeTwxV7DlCk3u8dWJ55A5BYHZY/Wn9pEMi
         rQIpNIZBtYb3Oc79ycRPx0ZWcID6o+8/Df67kSEnV1eD+zcD0h0h54xriqc+Jo4xeo7r
         Jqcvu0TSjGB2InsVyd86sRfTMSSE/SA7HreQ5dh0SPHj1DGVNxJBE6tTkVuEL5lmkv3d
         gRUCnusrw4HxXwpgsbFlN+cNRh/vOlvX8VvW0WSJlEgglMPCg+WHaa8GbiEQh8xbA4Wb
         oy2Q==
X-Gm-Message-State: AOAM531I48qmIWkuVuFmv1CoTdkcAv/Xj+tqxsS9ManTo5BuLjRtr52F
        5mZP6QLiQEyWzL2H4y7rJ/+s37hp9OBihoOZSA==
X-Google-Smtp-Source: ABdhPJxh6ZM7nWp+f56ZHzsBJQta1PXhiAYtNC+IKmQct9nghl9r42M5HOw/4ZPapXC7Rh/zWov0/Z9I9u+dwlWNEQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5006:: with SMTP id
 s6mr10447990qvo.51.1600320591974; Wed, 16 Sep 2020 22:29:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:39 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 2/6] Bluetooth: Set scan parameters for ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
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

