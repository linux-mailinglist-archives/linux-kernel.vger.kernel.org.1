Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476981BAFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD0VDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD0VDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:03:05 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93E4C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:03:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q57so22012860qte.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=23GGnMwKYvt3Cgj/lhkkh8PS8CBiboCjGVStVTQoV58=;
        b=uJ3Wv2mn3Q1SH5G5z7pkpeKo+Y1QXqCq3ao34idnjbgsWSe8tTMKo/LZDfBDgSwvJ+
         qKgsWq/UV2BvdfWYtfyu24Cylm6N4eRDHTln1it9IJvuHP1ObRvrToKe/rSJ2+l+alvv
         9XkvWTgmrq0I6aQPz3sDLhld1zpVDIuSof8GyK70zVpvWSrELmm26BzrCygrOJbhaRDM
         Fe8NAjYYDc9VLols4zdTrk+lQtU8GmMBjIifckAuIXoWc9YbRChsliWre51Z6BJ02IG9
         HbzlR3xAR3wg1ypOCeT+s0AGDNR2lOTapxoHwLqXz782WROtbY/WwoXiRhQBmT6Peh4O
         pUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=23GGnMwKYvt3Cgj/lhkkh8PS8CBiboCjGVStVTQoV58=;
        b=SIMw4cUKxucF5kBxDGVRInrRphSsxuPh6m+pFPuPAmbIioEy67go5xPmOPGigM2A7a
         kn0WKCk02yZos5VYOkVAoKL0EJXA0HRr/uDT1XfmOwww44Ku7hWSg6fpvXRbG71uaoBV
         Xw9wa0R1eIJ7weEVRGW6fdt3On7kSVR8wXYqi3eBXD1aGl2u1ixGhrdTAphq/fglbrgR
         sRo3KnBJE3p7Bsj3V62yAfcuMxdSuL9Tnx+lywFj/qZ3nufy2R3yLXXZA741AwV3lyPW
         5+ZrUbS4QG5+rnm6PUmJneeZDjmxY2RsFf84Pxxx20fFVmZ0JnbqYneEsJrGskWAzzjA
         5u0Q==
X-Gm-Message-State: AGi0PuYbzZ27dgb+X0Gh7LDqNk9Y5T6oKnq7awKf1HyzBL4ASGo7YWdf
        WnSqRsU5cKSFJk4+KMneiQidg/xnaWI3
X-Google-Smtp-Source: APiQypKahN7ghxLa5ZMhrrRFTqL+QsRn5U1vupwEhsBNUqZHCzWOu1dqTKRMxgn9lK8zEQi9Upg4I8/GRiNS
X-Received: by 2002:a0c:f8cf:: with SMTP id h15mr23168133qvo.22.1588021382826;
 Mon, 27 Apr 2020 14:03:02 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:02:57 -0700
Message-Id: <20200427210259.91330-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v5 1/3] input/serio/i8042: Attach fwnode to serio i8042 kbd device
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajat Jain <rajatja@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, furquan@google.com,
        dlaurie@google.com, bleung@google.com, zentaro@google.com,
        dbehr@google.com
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attach the firmware node to the serio i8042 kbd device so that device
properties can be passed from the firmware.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Same as v4
v4: Same as v3
v3: same as v2
v2: Remove the Change-Id from the commit log

 drivers/input/serio/i8042-x86ia64io.h | 1 +
 drivers/input/serio/i8042.c           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 08e919dbeb5d1..d0c39426ca2c8 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -938,6 +938,7 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	}
 	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
 			       sizeof(i8042_kbd_firmware_id));
+	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
 
 	/* Keyboard ports are always supposed to be wakeup-enabled */
 	device_set_wakeup_enable(&dev->dev, true);
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 20ff2bed3917a..0dddf273afd94 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -21,6 +21,7 @@
 #include <linux/i8042.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/property.h>
 
 #include <asm/io.h>
 
@@ -124,6 +125,7 @@ MODULE_PARM_DESC(unmask_kbd_data, "Unconditional enable (may reveal sensitive da
 static bool i8042_bypass_aux_irq_test;
 static char i8042_kbd_firmware_id[128];
 static char i8042_aux_firmware_id[128];
+static struct fwnode_handle *i8042_kbd_fwnode;
 
 #include "i8042.h"
 
@@ -1335,6 +1337,7 @@ static int __init i8042_create_kbd_port(void)
 	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
 	strlcpy(serio->firmware_id, i8042_kbd_firmware_id,
 		sizeof(serio->firmware_id));
+	set_primary_fwnode(&serio->dev, i8042_kbd_fwnode);
 
 	port->serio = serio;
 	port->irq = I8042_KBD_IRQ;
-- 
2.26.2.303.gf8c07b1a785-goog

