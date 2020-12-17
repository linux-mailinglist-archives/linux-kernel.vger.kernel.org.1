Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0712DDBBA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgLQXE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgLQXE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:04:56 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A43C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:04:16 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n7so134794pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuN3s87sgv5dYv1RWZnvVr37IV4kzzDZbC355KoF86s=;
        b=gNYVoiuPmDtcwNGgz1b29ap/WFF1trap8wB+8F3/ztzMefmOEU7saVMs3StoaqtlAH
         9Q8N3sf1nJNiAhPl30mLWT9rNWcMRL/4jESUIXbVfkLi8FQUqfpdgxGE7cbX+EuWkw4P
         1zxaKNqHwd03cw5UeRIIdyo4kxBqKz2+CUimc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuN3s87sgv5dYv1RWZnvVr37IV4kzzDZbC355KoF86s=;
        b=W4PudPy2J4McU6MjctU7TNKb5/Pz5ugq9+isBHBnUcvZA5TjCOwdAFW4TpJnC4El1u
         QeBOtwsMNF3lX8pHtrp350t1YdeqwRDqdL2zal/FS11y7e6XP2Ylkbmlw194aM8NRPOL
         4FhRW7UlFipHakv32T4z3/S1ITDOdTS3vfmcpHM8uG59+/JII09mfTzM+7opjXOnDXIC
         z+E7Xme1XrTlIYgQYXvZF/N3d0Nhmu1/P5e9OMp8delhe9PDDpaVaAXzJYmxswCHjWpc
         3uIytcDifJ6ABdhLYVpGWSMQ4Lt1BBZfc1yAP+YMMI+YFlUHxWzoaUkhSDT+OV90jdFR
         RzDg==
X-Gm-Message-State: AOAM530zSdM19dKOABK7vmkZxwaHzi4truKRQztCP6nKTLkzWAj7wfz2
        L2RoOYlcuhgIVYxwujkN+fhKEQ==
X-Google-Smtp-Source: ABdhPJyY7LcYcKznwl8cdcSmFXO7wsiD2aQSfSQOfEtl4hhRILKgwPonDiZBJATkFfNdYx2HSVXcDg==
X-Received: by 2002:a63:eb4b:: with SMTP id b11mr1435362pgk.351.1608246255566;
        Thu, 17 Dec 2020 15:04:15 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id q23sm6001004pgm.89.2020.12.17.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:04:15 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: Pause service discovery for suspend
Date:   Thu, 17 Dec 2020 15:04:08 -0800
Message-Id: <20201217150346.1.If6feff48e17a881af9cb55526db7f53bf0db40f1@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like MGMT_OP_START_DISCOVERY, we should reject
MGMT_OP_START_SERVICE_DISCOVERY with MGMT_STATUS_BUSY when we are paused
for suspend.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
On ChromeOS, we started getting reports of scanning failing after
resuming from suspend. The root cause was that Start Service Discovery
was being called while discovery was supposed to be paused for suspend
and it was screwing up some internal state. Adding this check
immediately fixed it.

The fix was tested by doing the following:
* Set Discovery Filter ({'transport': 'auto'})
* Start Discovery
* Suspend
* Resume
* Check the Discovering property

Without the fix, this test failed when checking the Discovering
property above.

 net/bluetooth/mgmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa0f7a4a1d2fc8a..608dda5403b7327 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4798,6 +4798,14 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (hdev->discovery_paused) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_BUSY, &cp->type,
+					sizeof(cp->type));
+		goto failed;
+	}
+
 	uuid_count = __le16_to_cpu(cp->uuid_count);
 	if (uuid_count > max_uuid_count) {
 		bt_dev_err(hdev, "service_discovery: too big uuid_count value %u",
-- 
2.29.2.729.g45daf8777d-goog

