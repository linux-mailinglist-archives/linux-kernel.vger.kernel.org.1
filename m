Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E76217D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 04:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgGHCuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 22:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgGHCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:50:23 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18234C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 19:50:23 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 15294BC0C1;
        Wed,  8 Jul 2020 02:50:18 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Intel mic drivers
Date:   Wed,  8 Jul 2020 04:50:13 +0200
Message-Id: <20200708025013.57804-1-grandmaster@al2klimov.de>
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
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.
 Rationale:
 I'd like not to submit patches much faster than you maintainers apply them.

 drivers/misc/mic/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 8f201d019f5a..a20202df8ce2 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -14,7 +14,7 @@ config INTEL_MIC_BUS
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config SCIF_BUS
 	tristate "SCIF Bus Driver"
@@ -29,7 +29,7 @@ config SCIF_BUS
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config VOP_BUS
 	tristate "VOP Bus Driver"
@@ -43,7 +43,7 @@ config VOP_BUS
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config INTEL_MIC_HOST
 	tristate "Intel MIC Host Driver"
@@ -61,7 +61,7 @@ config INTEL_MIC_HOST
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config INTEL_MIC_CARD
 	tristate "Intel MIC Card Driver"
@@ -78,7 +78,7 @@ config INTEL_MIC_CARD
 	  say M (recommended) or Y, else say N. If unsure say N.
 
 	  For more information see
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config SCIF
 	tristate "SCIF Driver"
@@ -96,7 +96,7 @@ config SCIF
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config MIC_COSM
 	tristate "Intel MIC Coprocessor State Management (COSM) Drivers"
@@ -112,7 +112,7 @@ config MIC_COSM
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 config VOP
 	tristate "VOP Driver"
@@ -131,6 +131,6 @@ config VOP
 
 	  More information about the Intel MIC family as well as the Linux
 	  OS and tools for MIC to use with this driver are available from
-	  <http://software.intel.com/en-us/mic-developer>.
+	  <https://software.intel.com/en-us/mic-developer>.
 
 endmenu
-- 
2.27.0

