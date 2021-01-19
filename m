Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0732FC1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392097AbhASVGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbhASUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:22 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 30so13709948pgr.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNZtkCbUa8hD8i5c8Z88wPPZUgfGlIac4Ln9H9P6rjQ=;
        b=DCm3qDCVSKAJdzglfBL+yhBYAk1i5rGUUfC2003rmZQBQo2iL9R5tkkge5C82iidfg
         ZYbUimvLxJV/InGQxnigu2TB/MENW+sCh/v4Za5KYZW0WaRBf+1qjlpg/RCi359WlMBP
         iu6n7b55NdIG+vi9FhIzv9Zj57GOjAo3CD9GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNZtkCbUa8hD8i5c8Z88wPPZUgfGlIac4Ln9H9P6rjQ=;
        b=m/++Yk6s7HKlBC4kkkIn/ag8aMGWRULcijI3S0aPxRsKsKpDoHk+WttnIEsaLeWVD+
         rx1y3I3hFsaDjm80Z9gu+SPC4Tx/bw+NiJInvY64cxj6jRQShBsrjSsv0t2hqeZX6uC+
         fy8aAIXUhcUjqj+5wJT2OJXJDlO1O0L0N4vsyxow6pI6NGw9V1EjXwfBuvVPGR2r1mPp
         VGNOjF+zFCRMibInaiBMn3b2VRdpId6M8HAZmQZtyQNJ3Dh6jnShxA9LhKR6zJABJNGG
         wck6i1m307+VGT9Lhtq816E45TrDhkyLg3gzHJilIT7CCUMl1/pxCc04/y9wbNQJvGk7
         G0IA==
X-Gm-Message-State: AOAM532c0P2hD9TfYS60zW7uZIpCFGpdkQLBCK8evKLXjZoSPvaE2l3g
        9fOsYBZhbwmGQUyGw8MEf4BI/Q==
X-Google-Smtp-Source: ABdhPJyDDGGUQhc5IeVLwoRYLYcF75sBQMwTBofM+cMEtxjL5hJ2Vczkyh9F39LursT9eYuZzfZoWw==
X-Received: by 2002:a63:1865:: with SMTP id 37mr6142729pgy.206.1611089001995;
        Tue, 19 Jan 2021 12:43:21 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:21 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: btusb: Expose hw reset to debugfs
Date:   Tue, 19 Jan 2021 12:43:11 -0800
Message-Id: <20210119204315.2611811-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

This series updates the reset gpio based recovery from command
timeouts with the following changes:
  * Refactor duplicate code to use a single btusb_gpio_cmd_timeout
  * Reduce the number of command timeouts needed for reset to 3
  * Expose the gpio based hardware reset to debugfs for testing

The last one is important to us so that we can confirm new chips support
hardware based reset (which is part of our requirements for BT chips).

We will probably also add the 'toggle_hw_reset' debugfs entry to other
drivers that support hardware based reset (i.e. hci_qca, hci_h5, etc) in
subsequent changes.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: btusb: Refactor gpio reset
  Bluetooth: btusb: Trigger gpio reset quicker
  Bluetooth: btusb: Expose reset gpio to debugfs

 drivers/bluetooth/btusb.c | 107 +++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 41 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

