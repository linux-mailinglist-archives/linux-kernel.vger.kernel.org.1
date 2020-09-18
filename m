Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4053426F42E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgIRDMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIRDMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED0C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:23 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a20so2873052qvk.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2XmRDQUdgiUCXLjgBSHndxfu/U3AL11i4Ub5lRoe7R0=;
        b=tzX8w74Fl69bkT1fuRekk3Yej9sz1p+sVINXDr737cRNWeMl+XLBVOK2a2H0/gbs18
         Uteg1+HYcXiSdUfhbnQicvFRotx4pj43Yc4fW36tr8Heiz4fRD8sQpYKYSvllygVcd0A
         xkuT05qTA+JmIK5f05enmUZ28D5g3H9MHYFzxpZpBaDdUSpx7BYg+gM4Yw3d88FLJ1ms
         +Vx9hoczHxmCaA1IKAcuAWej+DHGVqZm/4w+QsYhlF6k3BQ5dr8m3Yfy+IR0h4u/6xkd
         dq4v9k/P82oknrNxUTpZMex+uiAB60T391HA8RB0MOdr02Im6N06aKG0sZmsi2N5CYBz
         9SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2XmRDQUdgiUCXLjgBSHndxfu/U3AL11i4Ub5lRoe7R0=;
        b=CDGs2eYuufz6rgxBGheg07WaKfeZZHf0jWgXb9XxDMmvMr9AtdM3uMKS1s8OeASV6B
         1r6jUVEufO76HRtJYcuXBCzyvoAhWOYzgnDLcK7zEcC6dRPK1jOo5Rfcwu0pXcodQvo4
         +6qnVl0mnitkK+SGUOK7DNasfJoyr5yZf8nd0MxmU3lzvv6INhUEaSXG1bSGC2PRdMZi
         i5GdLKg3bN5lFPGNA9AYYV1CxQTWB9KBSUE4GjurqO9Cdiu8I1okJ+AeMFJuYudbnHwv
         E8EpF48CWUqOsjUmOQ5PJO4KeJQn/K7P/HbmfLXn02xQ303PDy7exXyX3XJV6JkY53iR
         kjIA==
X-Gm-Message-State: AOAM532G8ME57myIUq3tlsB0H4b6lzn/EpkZgP8uncrmxrymKro120ii
        mtJ50XB0OAs703DKiTPKtpKShFz9DL0zg+FOcw==
X-Google-Smtp-Source: ABdhPJwmWJFJNTTBFBXGPrIZyuSqnx1dWqO6oAbGMDrw5KopjYBA2KwiHRZ355u4CWsVx/4UV2f90s26M6BxkZjhrg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:458f:: with SMTP id
 x15mr15602557qvu.33.1600398742980; Thu, 17 Sep 2020 20:12:22 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:49 +0800
In-Reply-To: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200918111110.v3.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 2/6] Bluetooth: Set scan parameters for ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set scan parameters when there is at least one Advertisement monitor.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 413e3a5aabf54..d2b06f5c93804 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1027,6 +1027,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	} else if (hci_is_le_conn_scanning(hdev)) {
 		window = hdev->le_scan_window_connect;
 		interval = hdev->le_scan_int_connect;
+	} else if (hci_is_adv_monitoring(hdev)) {
+		window = hdev->le_scan_window_adv_monitor;
+		interval = hdev->le_scan_int_adv_monitor;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.28.0.681.g6f77f65b4e-goog

