Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EB2A00C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3JIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJ3JIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:08:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D0C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s5so3423834qkj.21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d0ULAdnRkpP0tiJ9/bir4TO+qpr79/0IK0rveQZPnt0=;
        b=tyXPfxubkKIRGg/KIZF9G5IRxo7TciRnhlKJPHOrHk1Cp9Y68QDQqneATMSHTq0gyi
         S+QCQc8RTvIudCaw2/UUbd7r/3AntfelNY9TVZr2IWTp5nfAE130BYPLMCmlj/vUV3IV
         Ki/fWMMBnv04KzC/R7VUXYzGtqrsnilkpUNgDLkA+UFnU9t9xL3EJI1TreQGaCDcevIL
         JvNahGyYMCegBP3W99HX8+mVWI405Ion/TuoGLVmULNK+5+ooCXCT4+QgimRdoD9oAcM
         MpdKi5uIDcxTqE4DAHQxc5us2j6Evxz42dS0bpzu8mwaMiY8zEeS3lYJKiYdpHo1ZCQs
         oDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d0ULAdnRkpP0tiJ9/bir4TO+qpr79/0IK0rveQZPnt0=;
        b=dMQIa/1I2H2Uva0vYNzMW2NZuOQ3GPXyYYWHUCHlO/uzOC8SJKtZhsDB+0QJB9arlf
         68XdO2MuaWjkCVx0T29fpQ1ae4R/myJUIwysptHLS2St2n/yXEExDBTP3T6CFo5phmlF
         +5eVml7PWuGWW8pHwGQXwaKxRX41No+z3oZpzX+ScF23v/D4eepuzPluonUAIY3g1xcc
         JtpCC8ZjlySNASiWhEXzpsRg7X/QBn9R8ZruKBKg4AptHgBQHmeezXIkTDsPt1neuiBQ
         H+LwaIu6g7CCJoUF0uyQHke6hs5Ft8C3RhRSBYlfwMYaEnEcOEdycus9Y3rBL65uk2Hc
         0WDA==
X-Gm-Message-State: AOAM532WtV75UrqSGBg91lXx5/hp3F9vGY+uVFgGc6mMHs9Ick8LYul6
        Z9w7/j5BizvSR+WhoaQY2b1Fe9CR8C8KI6cxIA==
X-Google-Smtp-Source: ABdhPJwDUShIiCm4ZQ7Be3llx0aPNgpneRGMjPv+gtzuLViB9OtGsiBHu6o1MxIO2GaexnkAgctAPH+ZsNmWAZXjzQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:db13:: with SMTP id
 d19mr7898374qvk.23.1604048925295; Fri, 30 Oct 2020 02:08:45 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:08:25 +0800
In-Reply-To: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201030163529.v6.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 3/5] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.orgi, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
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
index b615b981be9d6..396960ef54a13 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3092,8 +3092,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
2.29.1.341.ge80a0c044ae-goog

