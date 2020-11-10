Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31BA2AD379
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgKJKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgKJKSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:18:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:18:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so14318451ybq.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=fN+dlOttk59kV4mLEiOPuNPqRVO5JnVN+aLCHgK4Ide9SzT2SQ3I1Yp3N5t72yFdir
         34VUGkP4Cvs7PgQaYEmHpmbygeZ3AOQw1Pcu5X64sVf/KYR3/Zvp+Jtqmky9LNAMiyK9
         yHgzL0q3RFCeESLtPDPRlS44QRMGM03aVf5L8qeRpxeY5wq2LY2FbBI5YCagY3N/ML8h
         7alq99rz5kLQbnA2mlTGvhGpeRazuasVf4ZJpuJ1N3j4IJGh2yI0rCnyhq2a0ybp/N67
         JJaJ8aXsthHSK58MdaYjLmplXIPzz9REb/KjTV4SQfWagMuVv38m6r4oJ1Y95ua6bjPa
         Kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=oJb12qZWxSdgRdd5vBwVljxceSMedn5eASO8NH/HtAZbbBmP3NuOkjzr8MGICdfN0v
         2xze8Kp8e9T5wbWteQFQJMUS+4U7Q399iz2ZCeLbMdaj9G5brK8ESTSTb3L47/6qoSKu
         n+o64+FvBxU+DGi1+/+CImmh+6Wru7vsGI5zMVl98fcan6xNr48vrgus4dg9c1YRqxIN
         LlUJQQ2pdePZy4d0A6l76H+w6wtv/gkRH1DvSHktJfs0XPWr+jeakJatT2ljes8qO9Ph
         aUMz9fB0ERt1iMEzyv1D8FLdIMF7HYNRL/zanu1TOqSG2kWbVtH//Aww23K8rpAwTBvv
         YiIQ==
X-Gm-Message-State: AOAM531GNjGADhBDYUWXXdZG6ol96GP1neMZjShWMeJNv5dsssmFf9Jn
        TyaYp1iN1obnura22N5lvcvIL7tF/cRZHPK26A==
X-Google-Smtp-Source: ABdhPJx69PbWxwCICMrL7Wj6VOTH3H80JJyY09ctMYN6Hw9Hg3URXQvI6M3r7B32IDzklPSaZONPScF2und96eg5ZQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:ac23:: with SMTP id
 w35mr26697654ybi.171.1605003531984; Tue, 10 Nov 2020 02:18:51 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:17:53 +0800
In-Reply-To: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201110181740.v8.4.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v8 4/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
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
index d943ad2885aa0..172ccbf4f0cd2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3099,8 +3099,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
2.29.2.222.g5d2a92d10f8-goog

