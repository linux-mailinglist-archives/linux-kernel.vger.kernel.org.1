Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243E41F1605
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgFHJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbgFHJ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:59:12 -0400
Received: from ziggy.de (unknown [213.195.114.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC73206A4;
        Mon,  8 Jun 2020 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591610352;
        bh=mpib/uOnrT5XNPMRVyQcZfC0SPaq1PdztMejF8onGS8=;
        h=From:To:Cc:Subject:Date:From;
        b=rZi/A6jCZMIjJfYqktvREvy0XGdUuO1WvzOfmb49shmRBv0ZTWhwxh6rkPHaTcrjJ
         UFQXK3GIpEI1IjsOyW0iFj38TzA4NhA6PlMdKUpFPcDNtv5+AM/VmsGdfUwY+Rp28s
         62Az6rBqrd2VhE+JjiBl3HoYUxvob58ENUjJoHs4=
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, gene.chen.richtek@gmail.com
Cc:     matthias.bgg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mfd: mt6360: Add name field to the driver
Date:   Mon,  8 Jun 2020 11:58:58 +0200
Message-Id: <20200608095859.24393-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The driver does not have a name, this will lead to a NULL pointer
deref when we try to register the driver to a bus.

Fixes: 7edd363421da ("mfd: Add support for PMIC MT6360")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/mfd/mt6360-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index db8cdf5272c1..dc2987dab649 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
 
 static struct i2c_driver mt6360_pmu_driver = {
 	.driver = {
+		.name = "MT6360",
 		.pm = &mt6360_pmu_pm_ops,
 		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
 	},
-- 
2.26.2

