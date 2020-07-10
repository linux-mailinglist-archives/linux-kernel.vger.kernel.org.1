Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0590921AF96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGJGki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJGkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:40:37 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78306C08C5CE;
        Thu,  9 Jul 2020 23:40:37 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 18B96BC078;
        Fri, 10 Jul 2020 06:40:34 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] LIBATA SUBSYSTEM (Serial and Parallel ATA drivers): Replace HTTP links with HTTPS ones
Date:   Fri, 10 Jul 2020 08:40:28 +0200
Message-Id: <20200710064028.28976-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/ata/acard-ahci.c  |  4 ++--
 drivers/ata/ahci.c        |  4 ++--
 drivers/ata/ahci.h        |  4 ++--
 drivers/ata/libahci.c     |  4 ++--
 drivers/ata/libata-core.c | 10 +++++-----
 drivers/ata/libata-eh.c   |  2 +-
 drivers/ata/libata-scsi.c |  2 +-
 drivers/ata/libata-sff.c  |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 2a04e8abd397..516d2139c7e0 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -13,8 +13,8 @@
  * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
- * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..e806a8547dd8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -12,8 +12,8 @@
  * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
- * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d991dd46e89c..a3b7145632bc 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -12,8 +12,8 @@
  * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
- * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  */
 
 #ifndef _AHCI_H
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f4cbed..1b050d137d80 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -12,8 +12,8 @@
  * as Documentation/driver-api/libata.rst
  *
  * AHCI hardware documentation:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
- * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * https://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b1cd4d97bc2a..d86ce48b01f2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -9,15 +9,15 @@
  *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
- *  http://www.sata-io.org/
+ *  https://www.sata-io.org/
  *
  *  Standards documents from:
  *	http://www.t13.org (ATA standards, PCI DMA IDE spec)
- *	http://www.t10.org (SCSI MMC - for ATAPI MMC)
- *	http://www.sata-io.org (SATA)
+ *	https://www.t10.org (SCSI MMC - for ATAPI MMC)
+ *	https://www.sata-io.org (SATA)
  *	http://www.compactflash.org (CF)
- *	http://www.qic.org (QIC157 - Tape and DSC)
- *	http://www.ce-ata.org (CE-ATA: not supported)
+ *	https://www.qic.org (QIC157 - Tape and DSC)
+ *	https://www.ce-ata.org (CE-ATA: not supported)
  *
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 474c6c34fe02..63a9b893d83a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -8,7 +8,7 @@
  *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
- *  http://www.sata-io.org/
+ *  https://www.sata-io.org/
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 46336084b1a9..854c6dc4c449 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -9,7 +9,7 @@
  *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from
- *  - http://www.t10.org/
+ *  - https://www.t10.org/
  *  - http://www.t13.org/
  */
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ae7189d1a568..18cba8c77a63 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -9,7 +9,7 @@
  *  as Documentation/driver-api/libata.rst
  *
  *  Hardware documentation available from http://www.t13.org/ and
- *  http://www.sata-io.org/
+ *  https://www.sata-io.org/
  */
 
 #include <linux/kernel.h>
-- 
2.27.0

