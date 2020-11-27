Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB442C635D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgK0Kql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgK0Kqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:46:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:46:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 3so2359877wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maUAZkkcRtftX+bmS1QJvB6DjaFn1qmyf5on7huUx9k=;
        b=Fhi4gVmJ2TjrJXtKJ9XNpfTeMm3bRo1hVJK8DDgeHMXcOtZRAnfD10NIvjLSdgnS+K
         t7clGd0hsBaXNpMmBSXfFshBZZV+wpVOd29/n4Bkjag79JCqUNqxq32ZUEBq7Tk6jqhd
         QeBU/If/jBUNCPEbfbhmHeutdOCGRpovZFe0cbDBGf5ssE4jdqFY+qzlQbhtvNzbr68C
         MCeIPvKOssW/EX7msuQ+DRt5hIAcJ9i5sWZWigfuOIql412ofKHblI+Pp4SSDhISsAht
         8JovAPxhRQ4vgeZClCIhY73YUx5awFHkztyPIqTF7La3NgODwyulySjxnGNgOV+jBfWa
         SfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maUAZkkcRtftX+bmS1QJvB6DjaFn1qmyf5on7huUx9k=;
        b=j4T1c3QnRyMoUasdeYHXwFZ0kp9Kb8doOP56KvsmkGv5NvY3TozrKF6t8LbdIlvOPL
         SPIqxg8xMqonMcr0Ku3c5Qa1JAzvm6DnNHIV17V85MQe2rHSiulsLKUlvmZcfa1pHyQe
         LId8byLc4Xr01286zw4xarcldKBfFKlS/Mnq5ljmWdj4U9yHhQJEC06wvOdlMrmg2avm
         W627C9+6E0HRxz/SvGV0h2mO6TmspDi7uRz704DqssPOhyN3mBm4afbHT6qFOEkuVXOO
         nkJnFPt248dPtq1mNBACwFE9nJKFD+Outq1QuqFEPVUuaPle0TzBG3E+YKVq7PlLgPU3
         YL+w==
X-Gm-Message-State: AOAM5303xHhuqiUkCvj87oGZ2kF5Y5kl8/JwcYzTsHdEHB+27Q+7Dhh8
        vtAqoZxPvt35LoLq8YojXZo=
X-Google-Smtp-Source: ABdhPJyVMPN9Huy8edhFeYp3Q4Hss9h+uwmhneTfG2Ok6Cuk/ArA6AAM8Fr5hwFBz6e1chrLEKEZgQ==
X-Received: by 2002:a1c:2502:: with SMTP id l2mr1844322wml.40.1606473999084;
        Fri, 27 Nov 2020 02:46:39 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id k81sm23454086wma.2.2020.11.27.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:46:37 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Fix a couple of typos
Date:   Fri, 27 Nov 2020 11:46:30 +0100
Message-Id: <20201127104630.1839171-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

These were just some minor typos that have crept in recently and are
easily fixed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1165a80f8010..5e3600eb3ab2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -468,7 +468,7 @@ postcore_initcall(devlink_class_init);
  * with runtime PM.  First, setting the DL_FLAG_PM_RUNTIME flag will cause the
  * runtime PM framework to take the link into account.  Second, if the
  * DL_FLAG_RPM_ACTIVE flag is set in addition to it, the supplier devices will
- * be forced into the active metastate and reference-counted upon the creation
+ * be forced into the active meta state and reference-counted upon the creation
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
  * ignored.
  *
@@ -491,7 +491,7 @@ postcore_initcall(devlink_class_init);
  * Also, if DL_FLAG_STATELESS, DL_FLAG_AUTOREMOVE_CONSUMER and
  * DL_FLAG_AUTOREMOVE_SUPPLIER are not set in @flags (that is, a persistent
  * managed device link is being added), the DL_FLAG_AUTOPROBE_CONSUMER flag can
- * be used to request the driver core to automaticall probe for a consmer
+ * be used to request the driver core to automatically probe for a consumer
  * driver after successfully binding a driver to the supplier device.
  *
  * The combination of DL_FLAG_STATELESS and one of DL_FLAG_AUTOREMOVE_CONSUMER,
-- 
2.29.2

