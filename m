Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D569D2DCCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgLQHTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:19:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B238C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:18:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lb18so3143237pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6D4li/EoV9+RBhAhlhd47010lIB1udrd5aMVBy+LBG0=;
        b=LQKMSNnkir22KpN1Z0gP+35Flb1r2VQnAy78yipBX7LE/zlA1cl3HahIPeD6SyNV+h
         XAPSmIFx/4SkHjBFvjk80ViJf080m1PYDShks/JjkLMyKWeCX65fbIlQOa/Q0jwNxkSA
         uh0OpWOF8LaUh7W9uTAWqq7F5WKWhcPVbFrCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6D4li/EoV9+RBhAhlhd47010lIB1udrd5aMVBy+LBG0=;
        b=QUOZ1NeUjAd3YQWjDlHkKTwwE/j3QYaIlcPfF53mIZPmSDU4KNtrKcsANc5grhHxLp
         8gXjduW29NNkFglzIMNezrzC6XW582sukKwMxPblZqIuo1Gqz1m7Ef87jCugfzBKKcyP
         aJsXLzU4sv8Kt3B4lSIsKsWcdR85F94kFF4v5t1ksgsxvHosE/8+ouTR46nIGmYkLM8E
         dOosnjjAuByichhjXtvcYLshs8jdSBtDKSi2pXtySwoB1Mgb7sqpqpAGBnTE0kR6HdiT
         kOsfKTFT4Mg4y1rtPjNnItbcjnQpmNEe/za1Uwr092+7Ps3ZRX1g3d/oBUvTmCiwnBjJ
         EiRw==
X-Gm-Message-State: AOAM532Y5r0EHQwj6QOcJRv+KmNVWqIwzvtfItyMWppGR9hXRQwpWmEg
        Y1jqcLemhr/yAwc4p1y67EFz/w==
X-Google-Smtp-Source: ABdhPJx4FdO8HNL2nqQo6pdpiTMfzYzzioJPDCoFKkhK9Zu46xCKhqMAe4FYENnsa2pIlHgFIX1S/w==
X-Received: by 2002:a17:902:302:b029:db:fa52:2dd2 with SMTP id 2-20020a1709020302b02900dbfa522dd2mr18603623pld.62.1608189515924;
        Wed, 16 Dec 2020 23:18:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id na6sm3555779pjb.12.2020.12.16.23.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:18:35 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] Bluetooth: btrtl: Enable MSFT extension for RTL8822CE controller
Date:   Wed, 16 Dec 2020 23:17:33 -0800
Message-Id: <20201216231652.v1.4.I369d2fc751e660f78e2930743aa368e0fe1bfd53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL8822CE Bluetooth controller support Microsoft vendor
extension and it uses 0xFCF0 for VsMsftOpCode.

The following test step was performed.
- Boot the test device with RTL8822CE and verify the INFO print in
dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 drivers/bluetooth/btrtl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index a4f7cace66b06..94df4e94999d5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -658,6 +658,12 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
+	/* RTL8822CE supports the Microsoft vendor extension and uses 0xFCF0
+	 * for VsMsftOpCode.
+	 */
+	if (lmp_subver == RTL_ROM_LMP_8822B)
+		hci_set_msft_opcode(hdev, 0xFCF0);
+
 	return btrtl_dev;
 
 err_free:
-- 
2.29.2.684.gfbc64c5ab5-goog

