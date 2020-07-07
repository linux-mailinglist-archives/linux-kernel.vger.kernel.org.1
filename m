Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5E217B67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 00:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgGGWwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgGGWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:52:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 15:52:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so10326624pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tg/83hrbdiKC/nqtULfMVzExwdn+D48CNwXlyo8fmO4=;
        b=BUW2C+eLfsuR3+MVx1e1OCy+7uFgx75RJLG1jW550N43OasNBoRqPU9cB8UXYlfNDu
         pcU1SBWMsnh822z3jayvN0pIM00XnDdb8FMJBRAAJGgSeedETZntzbCQ8EbrVjJqGFUR
         g8Z/FkPIapa/KAtXuPv/Xx9z25M1nW9ELxH1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tg/83hrbdiKC/nqtULfMVzExwdn+D48CNwXlyo8fmO4=;
        b=RI8xak+pZyQYvBEzITgw918YJ0PsMIAHAsrK6Wn0610XpPEfFaKNcQo7dF7U2QnUOm
         J3h4HQm/a6MyunR2Rh5pNNzTLyaiZdzik8t24kqNfHbVOeNB7TX678hmjUOiS2TWpcB6
         5e2zDAPLpLr7rakwmzN5xJVXTRqvpnbdyo8kUUev1qG+ARzUA49OHVcGv2ajY81PfWU3
         EsUcaL16Y3qmup0jq72qzpXJ8ws1mD6c4+27c8FvugEE9alidYTM/2IUOOkzLqSOo2Ln
         ftWym8KZh9+aNTSo1XGj+3PyyztEbryd/hjETbGW2ONw4f0r99uX9W0wOBi51S4X4RN2
         DxOg==
X-Gm-Message-State: AOAM532Tmdgt1GcMI7ZR/+QPFBWAKbsse96u/+GpwHGCf/mpk5LjAfDL
        MCM+orhG7YH6d2T/nOaHBXJ9xA==
X-Google-Smtp-Source: ABdhPJwu9V/dqmxBw5pNmoYQaZrQMps5/47kI7zjjDffv70FpI2X7Gle+8miopcdNJQjUzX2lnINDg==
X-Received: by 2002:a62:7bc9:: with SMTP id w192mr49102384pfc.255.1594162353028;
        Tue, 07 Jul 2020 15:52:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 73sm23737551pfy.24.2020.07.07.15.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 15:52:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: Use whitelist for scan policy when suspending
Date:   Tue,  7 Jul 2020 15:52:28 -0700
Message-Id: <20200707155207.1.Id31098b8dbbcf90468fcd7fb07ad0e872b11c36b@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with one advertisement monitor in place, the scan policy should use
the whitelist while the system is going to suspend to prevent waking by
random advertisement.

The following test was performed.
- With a paired device, register one advertisement monitor, suspend
the system and verify that the host was not awaken by random
advertisements.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

 net/bluetooth/hci_request.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6168a3440eff9..e161aabd7bf36 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -799,9 +799,10 @@ static u8 update_white_list(struct hci_request *req)
 
 	/* Once the controller offloading of advertisement monitor is in place,
 	 * the if condition should include the support of MSFT extension
-	 * support.
+	 * support. If suspend is ongoing, whitelist should be the default to
+	 * prevent waking by random advertisements.
 	 */
-	if (!idr_is_empty(&hdev->adv_monitors_idr))
+	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended)
 		return 0x00;
 
 	/* Select filter policy to use white list */
-- 
2.26.2

