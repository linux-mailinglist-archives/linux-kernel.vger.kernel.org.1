Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245362DDBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgLQWz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbgLQWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:55:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275BC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l23so249138pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pX4/p0ajAVR2V3H5po7317NWmJXfT5ZtsIuTWx4ykXE=;
        b=UW3JZDeAgJB94y8VYny9htsdJS/3QwO6xIlcMTtpJTsXxc79KPHZnxu2NTdc+7SdwW
         bTKMwyLvgZUMCdMT8M6dbZFg3RCqyWA33UuXdhVgLQ8Gvu9fWLHBw6Ssj1ntU78tCEvZ
         MoGZtq+EU1cOnKI5KA1J9e3VO+5rp9G4M4owA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pX4/p0ajAVR2V3H5po7317NWmJXfT5ZtsIuTWx4ykXE=;
        b=Oy0zniw4lMfEwzkju5hE0e3tvQMY8IHBSLFWREsWgHWau88ZlU4v0TMPiGBtVyoBis
         8ca+wvy8moa2qvXbasBgiRbD9KhbVCnPxrFLWOuQZUmtHU3BN1aeDoKXKUWcMbx4837G
         q1e4PU37U+EFmlY5nN43WGWtqxzVvXH29AKic5lkiAcARoUo4l6gXBKa8eAsryDBpVSU
         GD+SIe8+8hiKAPVEVCplyoh1L6Q4EoCMIaV3Iv0ERo2GwFCurSVy86xbXtmjtH0JSWE9
         1Rqt2+a3RFbX5BHH636HlyZuJxHqctuBcP53G2pidNABGrcLyP0Hy8OBOKMd4aMWWS4g
         nmjQ==
X-Gm-Message-State: AOAM533zSVP/zCy/ty8Fc81Zb22huBTEN8GRME5M0jUt12jLIFSzr/6T
        aDyxz8jEnaZ4dsBPoXxVxfwtFQ==
X-Google-Smtp-Source: ABdhPJzvKmNeRUa70WCUPTD0GN+SfqGb+b30Uoxnskq565xw5R6HRynaT3Q8A4bGT+DlFjP8XFG+DQ==
X-Received: by 2002:a17:902:7489:b029:da:5aed:8ebf with SMTP id h9-20020a1709027489b02900da5aed8ebfmr1382008pll.35.1608245685742;
        Thu, 17 Dec 2020 14:54:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id q11sm7167639pgh.16.2020.12.17.14.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:54:45 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: btrtl: Enable MSFT extension for RTL8822CE controller
Date:   Thu, 17 Dec 2020 14:53:21 -0800
Message-Id: <20201217145149.v2.4.I369d2fc751e660f78e2930743aa368e0fe1bfd53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
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

(no changes since v1)

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

