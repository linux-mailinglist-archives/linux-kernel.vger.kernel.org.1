Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC71F15E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgFHJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgFHJwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:52:42 -0400
Received: from ziggy.de (unknown [213.195.114.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F69E2076A;
        Mon,  8 Jun 2020 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591609962;
        bh=MhdtjOT8vJ8wGIPgzA1MdSHTr2Zgs7Wy2HpBekbvcW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWPp/s5iTdm6L6KOm4utxCkrIPBYP/FLz3Ifj6gektVxSUtN/2Y3UMrmPYhpN52Uw
         stZsuCl0f/k+o7PKOo33jtDlao1WZ0zJg+ew0/gbRE3QvgOIkN2K1ruiyA6Stb/wgP
         WihbBiOaNQsv+9Xb43Z2v60Tx8KbywvBq2kyfY4I=
From:   matthias.bgg@kernel.org
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gene.chen.richtek@gmail.com,
        lee.jones@linaro.org, matthias.bgg@kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 2/2] drivers: base: Convert to printk alias functions
Date:   Mon,  8 Jun 2020 11:52:17 +0200
Message-Id: <20200608095217.21162-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608095217.21162-1-matthias.bgg@kernel.org>
References: <20200608095217.21162-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The file mixes printk calls together with calls to pr_*().
Covert to printk alias functions to unify the code.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/base/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 40fba959c140..aa3b3a226a02 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -164,12 +164,12 @@ int driver_register(struct device_driver *drv)
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
 	    (drv->bus->shutdown && drv->shutdown))
-		printk(KERN_WARNING "Driver '%s' needs updating - please use "
+		pr_warn("Driver '%s' needs updating - please use "
 			"bus_type methods\n", drv->name);
 
 	other = driver_find(drv->name, drv->bus);
 	if (other) {
-		printk(KERN_ERR "Error: Driver '%s' is already registered, "
+		pr_err("Error: Driver '%s' is already registered, "
 			"aborting...\n", drv->name);
 		return -EBUSY;
 	}
-- 
2.26.2

