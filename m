Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0912CD386
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgLCKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbgLCKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:30:48 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C9C061A53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:29:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id c8so923225plo.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LgFUufeP/6GJIT+/FBOIVfpSa89RyGRkt3hInsL6vv8=;
        b=eq/xwaUjQ+yC41iYj9sWUZ1k+KkznoXg2gfXaN99+GUdDMSNHSwtAq3yhyapLGx7xT
         FYAkzvUmLS3uyff8mQCmRlNDddihzyYvy8UcD+FIfDjda09gubm7I6euR09pOtN+ZEEh
         gZ/KqZD25eu81rhmAyEw9NBJPbISqpU6qNxHVTK3N/DTnG1OssSzevwhT4KV3fjMVbIw
         nTrjEPoBoZurKWT+S7jxmdcifv62CkLSzWL2T2Z6JBqT6YKi8xJcE4UotJsquVLx1fBx
         pxGbe57TgtTR5XBgtsbsosbNmM50UXn9sG8WuA2rnBrc4M+YRxSiePVmlQK/FZlQR1e5
         uL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LgFUufeP/6GJIT+/FBOIVfpSa89RyGRkt3hInsL6vv8=;
        b=oKsjczu/IG/pY10Rri5z2k4TOXQ6Lxj1KY2TldOMNHCyYd1eq3378A8cq0rXhhzQht
         P9PtVwZA+Bn9wG5EsXGCRMbVvIc7NX66A8I9yk/AWlxrx6LdGmSElK68VQQCJLO0vpDG
         k49r9WPwV0v4ghUQmTwX2HvSiQ3TjEu23yIoOuJPxr1Vm00kUB+C+/HYrCprQ0WZV8y7
         9ekZWHIQRnWNUbLmdo0bCnnA12vw0gWfKi0IWoP5sVEovv80L2h2uhd10YjyalB8YWrL
         1+mjhq0pHpT6YePdjCquz6L2e/HK1s0bCAm5zNSyb6PK5qC+Jj02fPDnzChOCwGCLpcy
         9DPg==
X-Gm-Message-State: AOAM533yJ/bw2U/n911dPBsrtOLLUXaodbFX4T9BIX0F2eX9JHle2stp
        o3IEs3RZFDd2S3jgcrJng0N++dDDnuB4
X-Google-Smtp-Source: ABdhPJz1kh8OY2kfEa5qWxyAYd5fj4rgXnXnpj1E6hxkmaWSDTZKCbEpyoyG2efc/XOhnBO2b+XkFj0MmFtC
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90b:4b07:: with SMTP id
 lx7mr2511105pjb.230.1606991390116; Thu, 03 Dec 2020 02:29:50 -0800 (PST)
Date:   Thu,  3 Dec 2020 18:29:31 +0800
In-Reply-To: <20201203102936.4049556-1-apusaka@google.com>
Message-Id: <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
Mime-Version: 1.0
References: <20201203102936.4049556-1-apusaka@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/5] Bluetooth: advmon offload MSFT add rssi support
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

MSFT needs rssi parameter for monitoring advertisement packet,
therefore we should supply them from mgmt.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>

---

 include/net/bluetooth/hci_core.h | 9 +++++++++
 include/net/bluetooth/mgmt.h     | 9 +++++++++
 net/bluetooth/mgmt.c             | 8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd16..42d446417817 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -246,8 +246,17 @@ struct adv_pattern {
 	__u8 value[HCI_MAX_AD_LENGTH];
 };
 
+struct adv_rssi_thresholds {
+	__s8 low_threshold;
+	__s8 high_threshold;
+	__u16 low_threshold_timeout;
+	__u16 high_threshold_timeout;
+	__u8 sampling_period;
+};
+
 struct adv_monitor {
 	struct list_head patterns;
+	struct adv_rssi_thresholds rssi;
 	bool		active;
 	__u16		handle;
 };
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d8367850e8cd..dc534837be0e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -763,9 +763,18 @@ struct mgmt_adv_pattern {
 	__u8 value[31];
 } __packed;
 
+struct mgmt_adv_rssi_thresholds {
+	__s8 high_threshold;
+	__le16 high_threshold_timeout;
+	__s8 low_threshold;
+	__le16 low_threshold_timeout;
+	__u8 sampling_period;
+} __packed;
+
 #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
 struct mgmt_cp_add_adv_patterns_monitor {
 	__u8 pattern_count;
+	struct mgmt_adv_rssi_thresholds rssi;
 	struct mgmt_adv_pattern patterns[];
 } __packed;
 #define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3dfed4efa078..5f0f03dcd81d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4237,6 +4237,14 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	INIT_LIST_HEAD(&m->patterns);
 	m->active = false;
 
+	m->rssi.low_threshold = cp->rssi.low_threshold;
+	m->rssi.low_threshold_timeout =
+	    __le16_to_cpu(cp->rssi.low_threshold_timeout);
+	m->rssi.high_threshold = cp->rssi.high_threshold;
+	m->rssi.high_threshold_timeout =
+	    __le16_to_cpu(cp->rssi.high_threshold_timeout);
+	m->rssi.sampling_period = cp->rssi.sampling_period;
+
 	for (i = 0; i < cp->pattern_count; i++) {
 		if (++mp_cnt > HCI_MAX_ADV_MONITOR_NUM_PATTERNS) {
 			err = mgmt_cmd_status(sk, hdev->id,
-- 
2.29.2.454.gaff20da3a2-goog

