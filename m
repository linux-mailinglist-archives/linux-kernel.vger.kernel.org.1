Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA62D8A29
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 22:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407973AbgLLVjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 16:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 16:39:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CCC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 13:38:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so20549003lfd.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 13:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q21k+DxDlCUv8pvFxZ+s0QheebFP/RNF4267huWVLGc=;
        b=o5bB3LrJbgjJcLG4iAYsY/+flT0PbdirGD96gVC7V00syNBdQ94qXhYdonKvNahFCJ
         vrG4L2Hif+KN6RYmMlKtBcfdXDw7RKweuOavdFIoQ/eFY5xpM2ZVe4o9fzIgRofPpvx/
         5AE8mX5jLRHbG18uNUfuRk96z+MPxpuqBTyuG/RJkHXVe4/wLGmP3r5EP7Cg7+s+4UKD
         ml2mtxHHhMEaIorAZATTXmNjsQIiKTJtRpdGkRyAkFy8zEoBj0r7tG5golPP8oNUybTb
         3Huk3zYWxHvD7HdNYA0C/ZhCkO9EXUDWlA47upZexcFnYwNLCcw9jvechkqQGK2mugPV
         myog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q21k+DxDlCUv8pvFxZ+s0QheebFP/RNF4267huWVLGc=;
        b=fyBZk4gCCCUSW/VTVQdysW4KF0A+oN/7pusAFhxJOHMdOdGpMYcH9A3TLgx+zUoKhw
         s1WZ5j+S2KxcZHE2lgMPC6khBx/0cwNlI22abmkNLeVqIxFR7ru8xCduYI1jpnyB8wfP
         jC0m6KaKjnjL8kS7EkVlEjF+3Ez64ynvYlftZxmRYQnnmhCe9TRuTWar0K3b1JP9DQuz
         A99WT1uR5OKT0OQmqlgS5jhZcyjD1VLCKDFA40Q8k/pPjSnau6PKnYefWZCAyvMVt5sL
         0WfTJiIyHMwLKRR4Bf466fOj6h/wH0rHrvq3GlNiozQv9rBOGlq8Z7deI+3RawAKUgLt
         sBOQ==
X-Gm-Message-State: AOAM532UpdRb+jI9nXUfGwwnd90MioxK4judmgRWAH/sMtoNSP9QhLtM
        Db3rhHHveC7ztV7wPPrEtUAoXw==
X-Google-Smtp-Source: ABdhPJzRBI9jHX/lU38qP3Uh3Snh8b7CV5ew91i5mbEFF+QdKKeySErwSceweUIvi5xOzpVRv4kPrA==
X-Received: by 2002:a19:23d8:: with SMTP id j207mr7566676lfj.144.1607809114838;
        Sat, 12 Dec 2020 13:38:34 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.97])
        by smtp.gmail.com with ESMTPSA id p7sm1493303lfc.222.2020.12.12.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 13:38:34 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] driver core: platform: don't oops in platform_shutdown() on unbound devices
Date:   Sun, 13 Dec 2020 00:38:32 +0300
Message-Id: <20201212213832.237027-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform code stopped checking if the device is bound to the actual
platform driver, thus calling non-existing drv->shutdown(). Verify that
_dev->driver is not NULL before calling shutdown callback.

[   57.832972] platform 3d6a000.gmu: shutdown
[   57.837778] Unable to handle kernel paging request at virtual address ffffffffffffffe8
[   57.846391] Mem abort info:
[   57.849704]   ESR = 0x96000004
[   57.853286]   EC = 0x25: DABT (current EL), IL = 32 bits
[   57.859177]   SET = 0, FnV = 0
[   57.862751]   EA = 0, S1PTW = 0
[   57.866415] Data abort info:
[   57.869801]   ISV = 0, ISS = 0x00000004
[   57.874171]   CM = 0, WnR = 0
[   57.877634] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000a1646000
[   57.884937] [ffffffffffffffe8] pgd=0000000000000000, p4d=0000000000000000
[   57.892323] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   57.898471] Modules linked in:
[   57.902022] CPU: 7 PID: 387 Comm: reboot Tainted: G        W  5.10.0-rc7-next-20201211-13328-gb9e15b9c1940-dirty #1270
[   57.914043] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[   57.921340] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[   57.927930] pc : platform_shutdown+0x8/0x34
[   57.932661] lr : device_shutdown+0x158/0x32c
[   57.937483] sp : ffff800010773c70
[   57.941319] x29: ffff800010773c70 x28: ffff14f80c41c600
[   57.947208] x27: 0000000000000000 x26: ffff14f80129c490
[   57.953100] x25: ffffaa6264ece398 x24: 0000000000000008
[   57.958990] x23: ffffaa62655be030 x22: ffffaa6265671600
[   57.964875] x21: ffff14f80122b010 x20: ffff14f80129c410
[   57.970765] x19: ffff14f80129c418 x18: 0000000000000030
[   57.976665] x17: 0000000000000000 x16: 0000000000000001
[   57.982590] x15: 0000000000000004 x14: 000000000000019f
[   57.988478] x13: 0000000000000000 x12: 0000000000000000
[   57.994394] x11: 0000000000000000 x10: 00000000000009b0
[   58.000297] x9 : ffff800010773920 x8 : ffff14f80c41d010
[   58.006205] x7 : ffff14f976ff59c0 x6 : 0000000000000192
[   58.012112] x5 : 0000000000000000 x4 : ffff14f976feb920
[   58.018023] x3 : ffff14f976ff2878 x2 : 0000000000000000
[   58.023940] x1 : 0000000000000000 x0 : ffff14f80129c410
[   58.029871] Call trace:
[   58.032849]  platform_shutdown+0x8/0x34
[   58.037256]  kernel_restart+0x40/0xa0
[   58.041485]  __do_sys_reboot+0x228/0x250
[   58.045975]  __arm64_sys_reboot+0x28/0x34
[   58.050571]  el0_svc_common+0x7c/0x1a0
[   58.054886]  do_el0_svc+0x28/0x94
[   58.058754]  el0_svc+0x14/0x20
[   58.062371]  el0_sync_handler+0x1a4/0x1b0
[   58.066951]  el0_sync+0x174/0x180
[   58.070822] Code: d503201f d503201f d503245f f9403401 (f85e8021)
[   58.077532] ---[ end trace 26b521c0dca4c8d0 ]---

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
---
 drivers/base/platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0358dc3ea3ad..e9477e0bbca5 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1351,9 +1351,13 @@ static int platform_remove(struct device *_dev)
 
 static void platform_shutdown(struct device *_dev)
 {
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
+	struct platform_driver *drv;
+
+	if (!_dev->driver)
+		return;
 
+	drv = to_platform_driver(_dev->driver);
 	if (drv->shutdown)
 		drv->shutdown(dev);
 }
-- 
2.29.2

