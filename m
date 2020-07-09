Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10AC21A3CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGIPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 11:32:02 -0400
Received: from foss.arm.com ([217.140.110.172]:36798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgGIPcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:32:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4348531B;
        Thu,  9 Jul 2020 08:32:01 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A48D93F792;
        Thu,  9 Jul 2020 08:32:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Provide a missing function param description
Date:   Thu,  9 Jul 2020 16:31:55 +0100
Message-Id: <20200709153155.22573-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc as well as clang now produce warnings for missing kerneldoc function
parameter.

Fix the following W=1 kernel build warning:

drivers/firmware/arm_scmi/smc.c:32:
 warning: Function parameter or member 'shmem_lock' not described in 'scmi_smc'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 49bc4b0e8428..a1537d123e38 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -21,6 +21,7 @@
  *
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
  * @func_id: smc/hvc call function id
  */
 
-- 
2.17.1

