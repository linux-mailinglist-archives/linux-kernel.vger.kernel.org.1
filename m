Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176EB26D70A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIQIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIQIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA0C061797
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so1089282qky.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UhuK6+MhkgaxqFHbZntBmCr9unC/T/VqbfwHczdbfRY=;
        b=qXt5f0VOk1NuPgsYlWvkIK0xsQnwgp2Ib9s9qNNRYd2jjziI2ZkbqiZEZBy98FogDJ
         VkQH+qcfsU34O/22zMmtsfltxbnOCDtMgwsX5Lc/8k2R7cjQi1onQqjZ851o8nTg/Dv8
         oZeMwO8/vKRK61+eC+t0c1rnhq1va2f3hQ2nYCo+jNWzFQ8GtCX7sZLpwf5M7C8vhWZA
         pqk86IdYJNlRUkB6lyzfodAMn0NZvW7zupX/Q2VOt2ig2Jxt5lVTT9aUjoEfUj49um6v
         Zbl2j7AfHKhKAPRyRigq2h7vqLeyDTWtGAJwyewpwVbDjlj8KD16Dh7BRY9T3yxWXmd9
         uLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhuK6+MhkgaxqFHbZntBmCr9unC/T/VqbfwHczdbfRY=;
        b=eCZu5BYHoI+B/3vKIcn+ULLwgfLzJL86Jjf3/+7mvNk8kiwnKR3XFrPFbFl+6/VKnK
         vcYsFW5HOHCItJ4+BPLY8urG+HF0WMS668bOStOEa+c6Pt5sMmnE34VP3x1eNz9a0Llj
         NUs7wEcw78Sv62SkNeI5V9M+2j2CH85RYFJZvAh1fZad84cpz/G52Ofaj8SlX05I/BK0
         6a9IsphCLzlomMoyno5qP1Bn32yt8KH9i/y1pWojC8nomu7MzCShJ04BhO8C/MMvb3ZU
         ylwfy2jG0ilRQlROf9DZdOYGr+HFYEjtPb5989yd5QzDlP+y7qY5WheR1cMxqXtS9PGM
         ySkg==
X-Gm-Message-State: AOAM533s5kpFBX+spGrtW9B8wqXQfvwmwRQdIi7F9edVX+FP8v7hvLev
        YWEdQfDeF3naAuRME6ntUhZjl4AhQwVT/l+YrA==
X-Google-Smtp-Source: ABdhPJzmrOX6EdMHFDJQGtaf1jHPst8t8hO4cIyNRCqT0Rc+SxpDoI51AMdKKtlEiFVuWa5OuFK9wrM0HWg3g2dx/g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr11174814qvb.54.1600332456529; Thu, 17 Sep 2020 01:47:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:14 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.5.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 5/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to handle the active scan during interleave
scan. The interleave scan will be canceled when users start active scan,
and it will be restarted after active scan stopped.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d9082019b6386..1fcf6736811e4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3085,8 +3085,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * running. Thus, we should temporarily stop it in order to set the
 	 * discovery scanning parameters.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(req, false);
+		cancel_interleave_scan(hdev);
+	}
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
-- 
2.28.0.618.gf4bc123cb7-goog

