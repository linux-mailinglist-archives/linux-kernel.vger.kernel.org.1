Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE122EB920
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 06:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFE73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFE72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:59:28 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361FC06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 20:59:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f14so948712pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 20:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9pp+81pD9V5ZO1oudtV3NEzkiSbh9CAEsR5KS2cLrU=;
        b=eecW6ub0INs2zUQFbDtOijjrADBxTQ3+KIkXXktPtIhMY4WJDpJmz0G5PKyEtAnAOG
         F6w7KCIFkmpvy4e/XxRw5OcTQBFEY/ab7e80X2jhXlOP8PGphYT4txY9uInjvz5ap7zF
         P2wEo7r5E9ROHFOBRSe7i3t7ORS80205tjCUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9pp+81pD9V5ZO1oudtV3NEzkiSbh9CAEsR5KS2cLrU=;
        b=ubUrELbzGHpVQ6GXdlkn2fJx9tzy0b3B/ca0ySaLKtmJuB8czCcr/8UFYFt+xKAaXa
         FacodR+7MQLvufisXLEAH9aXszR2c3QlXWc2bTFq55LifkYYfC9VVGXCvnLaigLhoau0
         gQKvd8lWYO+6cnjzLrbSv4GoESyyA2zuWU9EJ2y0DcnbnKNaqGpeAJ/4RRjNwzK//HIk
         FQkZCR155BXkHTYqQbOMTjOSWXeg5yzWO3x5i/izTj5iZA5cZqEXBt72Jl5NpISj9uFr
         S0bFUndx0hh/Ru/KOQoFY0Iv77STxPTYyC2k6PKnqXfnBptuxSw1asQfr2wGCCFBfe0F
         syZw==
X-Gm-Message-State: AOAM530Fi7HKBAH3bBjp19/dM+e/zGqYcWFBDAA+gDk8g4kvk3R+8q72
        cXMMreIQ+44XiAAxhBWllpUQRA==
X-Google-Smtp-Source: ABdhPJwW59FjnNZUcdiKcpwcD/EYzFYWrPrpARJWVZMP+JxOv4bVf7mNf2em3OdX4BWmsvOZRXSSVQ==
X-Received: by 2002:a17:90b:68d:: with SMTP id m13mr2468477pjz.164.1609909145953;
        Tue, 05 Jan 2021 20:59:05 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 22sm743287pjw.19.2021.01.05.20.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 20:59:05 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: btrtl: Add null check in setup
Date:   Tue,  5 Jan 2021 20:58:58 -0800
Message-Id: <20210105205855.v2.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrtl_dev->ic_info is only available from the controller on cold boot
(the lmp subversion matches the device model and this is used to look up
the ic_info). On warm boots (firmware already loaded),
btrtl_dev->ic_info is null.

Fixes: 05672a2c14a4 (Bluetooth: btrtl: Enable central-peripheral role)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Added nullcheck with goto done

 drivers/bluetooth/btrtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1abf6a4d6727..24f03a1f8d57 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -719,6 +719,9 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
+	if (!btrtl_dev->ic_info)
+		goto done;
+
 	/* Enable central-peripheral role (able to create new connections with
 	 * an existing connection in slave role).
 	 */
@@ -731,6 +734,7 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		break;
 	}
 
+done:
 	btrtl_free(btrtl_dev);
 	return ret;
 }
-- 
2.29.2.729.g45daf8777d-goog

