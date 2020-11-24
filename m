Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D732C0B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgKWNX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:23:29 -0500
Received: from in-mybox ([77.221.147.26]:59638 "EHLO mail.maxverevkin.tk"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730646AbgKWNXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:23:25 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 08:23:23 EST
Received: from localhost.localdomain (93-142-28.internethome.cytanet.com.cy [93.109.142.28])
        by mail.maxverevkin.tk (Postfix) with ESMTPSA id 19FF360FD9;
        Mon, 23 Nov 2020 16:18:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maxverevkin.tk;
        s=mail; t=1606137485;
        bh=iJMW+N6SGA/9loTgraFaj02i7KR+pNuG/X3h06ydbIU=;
        h=From:To:Cc:Subject:Date:From;
        b=Qkk1n5R+9p2+6BvZyvrP9T+qQ5R1eohPc1eZDfr2zbLi6RWJsg0AZRUNyhEEd0JWW
         4iFPxedeq2V5X6NIxehlvJ/0PVWYePZ645/aa1HIPv+2XHE6XLS6w7OP1BM98cMF2H
         ujrEDyh+2IACire9mOWD4ieIEC3a3VmqpXmZvCI8GDhu9nDAozCn2W0EH4oiY0chp6
         GcfgcKU9q6u+KuKamIfapHF1mHfKD1vDn8wbpiSSZ3MIQ6nDMWqSIuIIjnSqDTG9Eh
         PEWRWZ8q7FyuKbXtZRaypxNMHj7VcKbGk3lFqDztJhRprPKllQ5nwSnlVOofp0evUw
         YJaNw0R7M5+FA==
From:   Max Verevkin <me@maxverevkin.tk>
Cc:     Max Verevkin <me@maxverevkin.tk>,
        AceLan Kao <acelan.kao@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion 13 x360 PC
Date:   Tue, 24 Nov 2020 15:16:52 +0200
Message-Id: <20201124131652.11165-1-me@maxverevkin.tk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Max Verevkin <me@maxverevkin.tk>
---
 drivers/platform/x86/intel-vbtn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index f5901b0b07cd..0419c8001fe3 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -206,6 +206,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Stream x360 Convertible PC 11"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion 13 x360 PC"),
+		},
+	},
 	{} /* Array terminator */
 };
 
-- 
2.29.2

