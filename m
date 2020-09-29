Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC527CAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgI2MXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgI2LfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:09 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4068C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:25:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v14so2261670qvq.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/VsBobuTIfoCbFzJ0kQqpf8oU3yDxKHHFbs4g4IK6lE=;
        b=OOkMhc9kd/YE88zM44mAvr9hdQJnhfyFf/+Wf3DKnSyFaxsGd34jTGMKpJXAgB5W6t
         tx17kPa/mRwFvluvQ72yoXRMEvtwgT26e5d4KsHaIZNyrKjA+nNWaxK73+6MEvypnEwx
         TGmbbK7jdvsMUzVXf/NKciW7hZPxPFZKTNAJ96HZFAxBBgS30Rt6EBa0X3MUOCGgdZjM
         fp8kbGxGFCdVRbT/w2439Fow/i2m62XdbjXQtZOJfe59fM29JGgrYof2AFnXE+5tqmbQ
         whozH39NbiWScSh4FZxSVUXOleDMflrFSblR9flbBj0ymSK3cGFcolS0enqYxIBl5d6I
         d1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VsBobuTIfoCbFzJ0kQqpf8oU3yDxKHHFbs4g4IK6lE=;
        b=KoFpmDzXtq3V1bO5K5+YP5WcD77HOrGom0dMTM4ntbzWN18d3kZJ0++5QZGgv1XuEo
         NrYGGkfjA9XEbCwojc6ws4iQffh8LjhUrsmj94+YZv018RI7MpQaTCjdiw/oZ/+MrjcY
         TnJK0B27W3uW7+3x2Vq5AVgtPsemiX7qPju16nKZYTdP+xDlu2hO4sDQUiIfetfNbsMh
         EQl9+hOlh82RJXHrCmJfeUr93f0jvWsMs81rKerPNSVyK3TWIrBXRETdZ+7VrQb5kU8j
         7FRwu3D9Mff16nORE2l8WnIKsORNOzcPN4mcq/hILKKqoUJRcSG7O4LrzU7oGdiDLA2C
         i2Fw==
X-Gm-Message-State: AOAM533pV5e35shB/4c1WLN3DuURBxdxbgSq8G2mkWEnDPEBOs4Mq3h5
        nbtIjy7nu5CDRSi3Bds1phV5me4nVasl6mecdQ==
X-Google-Smtp-Source: ABdhPJzLzPklrSrGkyauOe8xVu8TSVmdlQbBVWjWRiw60PlVaYo2l3XoJjNawqozcNCs75lSLOyxEjtCHPW7SUlaOg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:292:: with SMTP id
 l18mr4013077qvv.11.1601378752727; Tue, 29 Sep 2020 04:25:52 -0700 (PDT)
Date:   Tue, 29 Sep 2020 19:25:24 +0800
In-Reply-To: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200929192508.v7.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v7 2/4] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, alainm@chromium.org, mcchou@chromium.org,
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
index ba3016cc0b573..db44680fbe9c9 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1281,8 +1281,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
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
2.28.0.709.gb0816b6eb0-goog

