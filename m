Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E922AC3A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgKISW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgKISWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:24 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so433194wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kN+nLzLc6b7cOpaWz6eZ4gZDLXqa51d6pByGdFZOfqY=;
        b=F+ZvdTVfnmjMXGSx8RoJArP9mYgb6L0mURGvhy8zo5keNvI2erU5GFgmqjFjC1EBnr
         oYJKjRClMhVseA4yWoa+zele2IZaHfRfpdW7TCR6W/c+wsKQ/RwjMHcol69anMrdXVem
         egxPWz9OSnO46hy3I0k3b41lurIRC6St9SJep8l+cRKoVsJBzvszVtKHYZber7rRh3Pz
         SpWHFdgn41nzJsiqZA7TWG1f6TPQa6CvmajSDYkrRxjGm+ScUYSQHXWxf4L8jb0oNM7b
         hXKAlwJ9AWT5GstvOuq8Rh7cV/CbkyzaldLohyd1+ykzfpUgkW+Q4jFcSl8kgtdP539O
         HLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kN+nLzLc6b7cOpaWz6eZ4gZDLXqa51d6pByGdFZOfqY=;
        b=JS5qi4S4oQH/rsNfKbhSFecf8iEOsuhkuYQlrcws4N6ESWz2o6qxjiKVQXQJHgXUub
         PQLsJpJgJXBCzv6/VnSU/LgKiD2IS9130HbUsWJrYKyGdrtrgiQMbIr6gmtV/OWg6o8a
         Wx6vnHWi2a7GXCMJvzLkJXKo6x/WWUT8LUdKwjY8FKji3H9hZToQDJNsV4oSqkhKZIij
         iRStCsOR4j/6VLFIzTfIxQ3LV/pU/icNrrqCoVR1mEMHI/LjivhLrq3nue+PByV3oZys
         lfTY7vK6QslF6HBMee5mkOQXHn8Y1v+Vemqw4vLPWggWEvpxxAOsaLrtHZKus6XCqgsS
         SKQg==
X-Gm-Message-State: AOAM532U02PqtF2dwa0MgJ5smCnam1J0/z8lbOEEjIklA6Gy0fEum7Lh
        +Bwr597zs6gZ69JG/qWYlbyjTg==
X-Google-Smtp-Source: ABdhPJx2cRCR5MumYHhSe9bOuIXvuy0M70QEB8hG/wCQFrg/vjCkg9pVmz/SovG4i36C/5ecIpSMOQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr438554wmd.147.1604946143007;
        Mon, 09 Nov 2020 10:22:23 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 04/23] mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc' issues
Date:   Mon,  9 Nov 2020 18:21:47 +0000
Message-Id: <20201109182206.3037326-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch also places the descriptions in the correct order.

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/docg3.c:819: warning: bad line:
 drivers/mtd/devices/docg3.c:1799: warning: Excess function parameter 'base' description in 'doc_probe_device'

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/docg3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index a030792115bc2..5b0ae5ddad745 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -816,7 +816,7 @@ static void doc_read_page_finish(struct docg3 *docg3)
 
 /**
  * calc_block_sector - Calculate blocks, pages and ofs.
-
+ *
  * @from: offset in flash
  * @block0: first plane block index calculated
  * @block1: second plane block index calculated
@@ -1783,10 +1783,9 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 
 /**
  * doc_probe_device - Check if a device is available
- * @base: the io space where the device is probed
+ * @cascade: the cascade of chips this devices will belong to
  * @floor: the floor of the probed device
  * @dev: the device
- * @cascade: the cascade of chips this devices will belong to
  *
  * Checks whether a device at the specified IO range, and floor is available.
  *
-- 
2.25.1

