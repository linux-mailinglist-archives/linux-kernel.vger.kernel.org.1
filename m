Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD52C2FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404242AbgKXSH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404221AbgKXSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:07:54 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B976C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:07:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id n95so1227885qte.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ugBjHs8qLQMChRHRG7+A3K4v2J2RLx38B7emQOjbJo8=;
        b=kAk7zpejlXea9eHTXlou0iTVDqjH1/CCr1DU06i0EEuuCGqlb4qgAtTzGo/amDke1c
         raRfU4kKXPcIgwinghEc1v0zIdEW1dgH4O2S8op6//kEJuVy+PVfcrQ0PxStQv3HilaM
         U7DmacelpbBpbexeeIsE2R53F3AIQEw9s7H6jkyMv8pcJaM80oflSGLweRdIMgwo/LNM
         gPiwVGMFWGK0n5fG2qlfJqmK4K33uSXRq3H5ihCyKlPmo4eNBY93XAPc5txrzT1DPSVe
         wJgYkgehdRHPjrubjyzWBLzWW6CMg/P1jep/2Dq/sNf1KFhbwkat9UZ4AoTyhvP5D/Lv
         WPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ugBjHs8qLQMChRHRG7+A3K4v2J2RLx38B7emQOjbJo8=;
        b=cEz1nhQlyWhk4OfwYgmCyvrAN06vJGEhngP2j2zAzciK4Lq83LaX/4deTuJXwBidXY
         R08WZV68Cwlk2/Y1fd1hu/JLqLMuwDxNYMgkc1zpFrLMToeLb+wKCmyS3+vT92HUb3pp
         Y5gm/O3fEvZ7rJ+rIZzh+vt5AZxB8FQsx1Q9S7LT3HUv7g6eBafHISFt8yBvwMJMrFXq
         6Iw6pFY9ZswYw9c/ZwW0on2okXeZCHFSFfwe07ZWkCF6pyAZ5LID3fist3cdcd26EdWT
         eAHLaFIt58pgsdjzSUXpA7WjBImDfGNGtXw9oZZfaI6F2pNqyY7tNOF6nZ+6Mf8p3Hnc
         3oaQ==
X-Gm-Message-State: AOAM531Cf3y0fHMgkqyf1vn9C8HcY8jXhXd5fPr3pb587aMcxUv+VrRH
        egMa/G4tNpm6Iro/EZsMto7UkMlmHs34wm1c7Omm
X-Google-Smtp-Source: ABdhPJzD0QDXO0+1CEVK+AXfBOJH93TC7KtgOs4WwMcRM7CKWmyYYLEYoUW/+g9V/oxHG9m3IY8Qx+nz73idpqmEk7L0
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:7711:: with SMTP id
 s17mr9337263ybc.240.1606241272796; Tue, 24 Nov 2020 10:07:52 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:07:42 -0800
In-Reply-To: <20201124180746.1773091-1-danielwinkler@google.com>
Message-Id: <20201124100610.v5.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20201124180746.1773091-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 1/5] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We wish to handle advertising data separately from advertising
parameters in our new MGMT requests. This change adds a helper that
allows the advertising data and scan response to be updated for an
existing advertising instance.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd163b..300b3572d479e1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1291,6 +1291,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
 			 u16 timeout, u16 duration);
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 502552d6e9aff3..35afb63514f38b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3005,6 +3005,37 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	return 0;
 }
 
+/* This function requires the caller holds hdev->lock */
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			      u16 adv_data_len, u8 *adv_data,
+			      u16 scan_rsp_len, u8 *scan_rsp_data)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+
+	/* If advertisement doesn't exist, we can't modify its data */
+	if (!adv_instance)
+		return -ENOENT;
+
+	if (adv_data_len) {
+		memset(adv_instance->adv_data, 0,
+		       sizeof(adv_instance->adv_data));
+		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
+		adv_instance->adv_data_len = adv_data_len;
+	}
+
+	if (scan_rsp_len) {
+		memset(adv_instance->scan_rsp_data, 0,
+		       sizeof(adv_instance->scan_rsp_data));
+		memcpy(adv_instance->scan_rsp_data,
+		       scan_rsp_data, scan_rsp_len);
+		adv_instance->scan_rsp_len = scan_rsp_len;
+	}
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_adv_monitors_clear(struct hci_dev *hdev)
 {
-- 
2.29.2.454.gaff20da3a2-goog

