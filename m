Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39901A4616
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 07:57:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgDJL5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:57:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 85BE7B3CD520036BAC6B;
        Fri, 10 Apr 2020 19:57:23 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:57:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Date:   Fri, 10 Apr 2020 19:57:08 +0800
Message-ID: <20200410115708.27708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/soundwire/intel_init.c:193:6: warning:
 symbol 'sdw_intel_init' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soundwire/intel_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 4b769409f6f8..ad7053463889 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -190,7 +190,8 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
  * This scans the namespace and creates SoundWire link controller devices
  * based on the info queried.
  */
-void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
+static void *sdw_intel_init(acpi_handle *parent_handle,
+			    struct sdw_intel_res *res)
 {
 	acpi_status status;
 
-- 
2.17.1


