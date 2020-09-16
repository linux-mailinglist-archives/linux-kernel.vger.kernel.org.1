Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656B26CAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgIPUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgIPUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BEC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:16:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b54so7075198qtk.17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ouJiHCy9pxH2T5sj1WvYnJy8YM/MOUySnAX+tlwL2Gg=;
        b=UH8BwLtkHWhbvtlrnOx6o/E+DHvd5pUr9rXriuBNxKQ8cgR4HYRcjlG+1Uhz8PsJmJ
         iszKYxgls1Lm7qMJE++pD96lGlHyUh6T0EQt7h+KYlbxQNyRF/225JVRS1z1M+f2ktnv
         am1k7dS8Ju9FsCpWZDUHpgA7ZyF8ETcqT5BSEwwzq33wM3QmAAsObTZHr7aAmTnsrdX5
         ePRCv3rBzh64mrTm/pMOgQ8mi7T/yuxblGUjCdKoGi1ZXR6paZ3NSB+GlzlHa5GUrs2l
         df5UN0cmCy7Wd7NDRDmV/WikaCe3inVRL2MehUEmzlsWoAxkHQ7m7YNdNN65NsAGLy/E
         qb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ouJiHCy9pxH2T5sj1WvYnJy8YM/MOUySnAX+tlwL2Gg=;
        b=tOw39Iu+Ftp58d7H0d4vgLrG66hm//yiM0+wi8zmFoL1HWSRjd6nmztHHXUmPEfpiG
         qtTJDpkbdscBi9jl+aS8aw/vkvcHPtTq4lMJPx2z4mQPj2OGUNGRW/0c61HwvwWr0dLw
         yW1rY2snkkHDGILseafLZhufytv7ZiYSutUF5EAgwbWZdA36RTEzJ1L+uNfLbpbwiKdR
         rutc4GWLQVUqBL1Wc6Wmmch3ujGuiqINwGRaUYKqABveFRlPwje25EolL5p0k/Qr0gwk
         NMQR64BsID4KZuP0pGKve/nukUiKBbRLtDgLBbt+pqv4Hoocc8bOn9lem0luyqn1FSRq
         J8MQ==
X-Gm-Message-State: AOAM533lGPPIF9FaUEED/ec3FxcgyCg7T2UUUE6P+tJjNqZl7jPuV0Gz
        UdY3O58tp6vg/R4PZtUHEpw6Hwhmd6TZSFD6YJbd
X-Google-Smtp-Source: ABdhPJyOpQ4N29pZDC8hPDv7B7QRLfS+4nlHD81FOSX8Yz1lGNTqb8jjD+/PxRtpoZl1uLpN42r/+zYEa3sofnMw/bLj
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr8902976qvx.48.1600287371193; Wed, 16 Sep 2020 13:16:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:15:57 -0700
In-Reply-To: <20200916201602.1223002-1-danielwinkler@google.com>
Message-Id: <20200916131430.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20200916201602.1223002-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 1/6] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
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
index 8a2645a8330137..3f73f147826409 100644
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
2.28.0.618.gf4bc123cb7-goog

