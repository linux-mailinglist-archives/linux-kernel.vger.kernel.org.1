Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04C1B31A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDUVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgDUVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37765C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so361plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1Fvyyf5nczEffjGBcL+8ckFidnOh9Vp/pUQ4gio37U=;
        b=PKvElx00HHdwyyEhNv9HrFEWal6afEqN2MXBKrf15GbVJ1eqTVjzJ6PBhfgwxArQ19
         utaZDQ51WhLVHhZzbl4Ndd3g3CEgTOuSoyzsZq6y/bGCEj9EjYU3rkyWXz+mEGaXN0ri
         A/vxKbYEYsvT+2dcKVPlQPPPY8HZwtQmJYTV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1Fvyyf5nczEffjGBcL+8ckFidnOh9Vp/pUQ4gio37U=;
        b=TxqoeVHdjBsk8SeGsoqPo/GPwzz/7TsSmABz32MvxylrxUTXqKlIIn4VmG/KU8TNsD
         SQHhA5IPh5srVAZOzrjzFZamUHRGJK7WCUhvw0cqU44huyepln9LzgYSm9gQ3b8pD6Ux
         xo5iZD5BMW9dkvyL3ISBdFE7TatQty/zzYhRNmdftlOp63F7kNLLqselngPjBCaE4qST
         mOfYjfafSXIxn6eSjb6jFi+7Au+fgZNU1P6v/4IIraU2YTR5tLoRxUagqPjBGn3QQVZY
         VImrWtqem63zQ2rWbarjXwn9axxuqV5kFM5gXEi1G7EhsaXJPoQZlppMFkpg6NcTPSUU
         r2CQ==
X-Gm-Message-State: AGi0Pub2lZWCvjPUYGtLpOoIfOxWlyahYv1i01Sy7qf1rL1iO/CyHxNk
        0+ZFfQKOiNZTbiNHgGMOI7AsZA==
X-Google-Smtp-Source: APiQypLO8Vq+2uFDtn1QekfYaQkMUKtaot3jc7Cj/gRVKWbD0siljhiALve3Rxk+OpHLYMMkTVAwJA==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr23179231pli.334.1587503720751;
        Tue, 21 Apr 2020 14:15:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] Revert "kgdboc: disable the console lock when in kgdb"
Date:   Tue, 21 Apr 2020 14:14:40 -0700
Message-Id: <20200421141234.v2.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1.

Commit 81eaadcae81b ("kgdboc: disable the console lock when in kgdb")
is no longer needed now that we have the patch ("kgdb: Disable
WARN_CONSOLE_UNLOCKED for all kgdb").  Revert it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Revert "kgdboc: disable the console lock when in kgdb"") new for v2.

 drivers/tty/serial/kgdboc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c9f94fa82be4..8a1a4d1b6768 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -275,14 +275,10 @@ static void kgdboc_pre_exp_handler(void)
 	/* Increment the module count when the debugger is active */
 	if (!kgdb_connected)
 		try_module_get(THIS_MODULE);
-
-	atomic_inc(&ignore_console_lock_warning);
 }
 
 static void kgdboc_post_exp_handler(void)
 {
-	atomic_dec(&ignore_console_lock_warning);
-
 	/* decrement the module count when the debugger detaches */
 	if (!kgdb_connected)
 		module_put(THIS_MODULE);
-- 
2.26.1.301.g55bc3eb7cb9-goog

