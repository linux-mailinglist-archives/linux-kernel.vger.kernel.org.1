Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEA2669E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIKVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:07:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58053C061799
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:07:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u9so1452596plk.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wU19sqHhymvGkZ+Wtm/wcCxdG23VTDS4BHk0Ix+WsKo=;
        b=QbdSpYW3TXnEKB1YFeOgVyVcBLHQoeZiyQf7i9l3sXc4VLJHTkYvR7c7H9uYAuWWBj
         UZJ3YN62xrHi+9wyGU6TSokv41guE5JvLIBEBOqay24uPoEsKKAgS56Ih3uB9iClsK2K
         KxrAZ222wjojTh5F5FgRBc4DwX6LdiUJcfQ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wU19sqHhymvGkZ+Wtm/wcCxdG23VTDS4BHk0Ix+WsKo=;
        b=LGJZ8slNsVr948rPG+ZqtSxU5lxV7tVXag2RU29lpojcVutbOK2+/iaknltGNfzDph
         9fSUArYbscQUZf+Bf/qgm3okCMFgO2OhGQF5WQQ46phI41mMY4I2gE1IVwfryh2XvCba
         2ajeZC6xhQHVN13XUZHt33dDcJpD4I0yyOz5OOYUHwAZR3vwqwGicyo49NBECzHkxn/Y
         CS9xRbAja0KRSq4ufcVYN2Z1FAb+z6PR13sXl1agYwSS/e0uK18/GrCj0nCxHjarBO/M
         SlF3ONgnSQzoBUYQBkQtjMrei9cd1lwuA3CtJ8K7pUY7Rfl//zby88EYNULhiQFfYB1+
         eudw==
X-Gm-Message-State: AOAM530dLlIoU/Z9vcCuWsU2GI3u43dfQ/IqZpmtRPhhh3nMedoJ0d2c
        tH50ULQb1JzSnAofYejE7N4AnA==
X-Google-Smtp-Source: ABdhPJzoDtUtsRcEkFhHjmLfW0b3yjW/F9XLj9QgRtZ4xY1h2BESVzUrlq1IfGD9568wpsQcKubqfg==
X-Received: by 2002:a17:90b:2347:: with SMTP id ms7mr3835734pjb.135.1599858444876;
        Fri, 11 Sep 2020 14:07:24 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id c128sm3308764pfb.126.2020.09.11.14.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:07:24 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 2/3] Bluetooth: Add suspend reason for device disconnect
Date:   Fri, 11 Sep 2020 14:07:12 -0700
Message-Id: <20200911140700.v2.2.Ib9bb75b65362d32104df86ffad479761680bb2cb@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911210713.4066465-1-abhishekpandit@chromium.org>
References: <20200911210713.4066465-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device disconnect event with reason 0x5 to indicate that device
disconnected because the controller is suspending.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2: None

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e19e33c7b65c34..a4b8935e0db97a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -842,6 +842,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
 #define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
+#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index db48ee3c213cbd..0b711ad80f6bd1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8270,6 +8270,10 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
 
+	/* Report disconnects due to suspend */
+	if (hdev->suspended)
+		ev.reason = MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND;
+
 	mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
 	if (sk)
-- 
2.28.0.618.gf4bc123cb7-goog

