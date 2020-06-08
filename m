Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAA1F15E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgFHJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgFHJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:52:40 -0400
Received: from ziggy.de (unknown [213.195.114.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2449A206A4;
        Mon,  8 Jun 2020 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591609959;
        bh=hn9vi/4T2g9DMliefSxbxqUpQqK/XzJhcN2tNI0PWH8=;
        h=From:To:Cc:Subject:Date:From;
        b=lPWVeIjS6zZAiJXWqZbWVYx9NWViDjV8FwDHnGonjc0AC7zA9lsKdSnGDInRdDqHt
         KfETrRk+gjJktrvaLnktdcME9yHDKMrTuG6anB7qerNG3WagNn/qXLqy4pjT5Wcl7l
         qBp2YdrjtBIBeDcOZwK2sMbTp9FVjPTrNK2rSAm0=
From:   matthias.bgg@kernel.org
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gene.chen.richtek@gmail.com,
        lee.jones@linaro.org, matthias.bgg@kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] drivers: base: Warn if driver name is not present
Date:   Mon,  8 Jun 2020 11:52:16 +0200
Message-Id: <20200608095217.21162-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

If we pass a driver without a name, we end up in a NULL pointer
derefernce. Check for the name before trying to register the driver.
As we don't have a driver name to point to in the error message, we dump
the call stack to make it easier to detect the buggy driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/base/driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 57c68769e157..40fba959c140 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -149,6 +149,12 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
+	if (!drv->name) {
+		pr_err("Driver has no name.\n");
+		dump_stack();
+		return -EINVAL;
+	}
+
 	if (!drv->bus->p) {
 		pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
 			   drv->name, drv->bus->name);
-- 
2.26.2

