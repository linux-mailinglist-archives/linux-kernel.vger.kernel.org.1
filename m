Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463DB2AD8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgKJOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:40:37 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:40:37 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id qegb230024C55Sk01egbZc; Tue, 10 Nov 2020 15:40:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUp0-001CPj-Pk; Tue, 10 Nov 2020 15:40:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUp0-00Dktn-8a; Tue, 10 Nov 2020 15:40:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Justin P . Mattock" <justinmattock@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: ABI: Drop trailing whitespace
Date:   Tue, 10 Nov 2020 15:40:33 +0100
Message-Id: <20201110144033.3278499-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all trailing whitespace from the ABI documentation.
Most of it was introduced during recent updates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fixes: 0ea6e61122196509 ("Documentation: update broken web addresses.")
Fixes: 54a19b4d3fe0fa0a ("docs: ABI: cleanup several ABI documents")
Fixes: 3197ebdb130473a9 ("ext4: Add sysfs support")
---
 Documentation/ABI/testing/configfs-usb-gadget-ecm     | 2 +-
 Documentation/ABI/testing/sysfs-devices-memory        | 2 +-
 Documentation/ABI/testing/sysfs-fs-ext4               | 2 +-
 Documentation/ABI/testing/sysfs-module                | 2 +-
 Documentation/ABI/testing/sysfs-platform-renesas_usb3 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-ecm b/Documentation/ABI/testing/configfs-usb-gadget-ecm
index 272bc1e4ce2e6257..732101ca9d0bb5a3 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-ecm
+++ b/Documentation/ABI/testing/configfs-usb-gadget-ecm
@@ -7,7 +7,7 @@ Description:
 		ifname
 			      - network device interface name associated with
 				this function instance
-		qmult	
+		qmult
 			      - queue length multiplier for high and
 				super speed
 		host_addr
diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index 2da2b1fba2c1cd10..246a45b96d22a921 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -19,7 +19,7 @@ Description:
 		identify removable sections of the memory before attempting
 		potentially expensive hot-remove memory operation
 Users:		hotplug memory remove tools
-		http://www.ibm.com/developerworks/wikis/display/LinuxP/powerpc-utils	
+		http://www.ibm.com/developerworks/wikis/display/LinuxP/powerpc-utils
 
 What:		/sys/devices/system/memory/memoryX/phys_device
 Date:		September 2008
diff --git a/Documentation/ABI/testing/sysfs-fs-ext4 b/Documentation/ABI/testing/sysfs-fs-ext4
index 99e3d92f8299c9a2..2edd0a6672d3a75b 100644
--- a/Documentation/ABI/testing/sysfs-fs-ext4
+++ b/Documentation/ABI/testing/sysfs-fs-ext4
@@ -33,7 +33,7 @@ What:		/sys/fs/ext4/<disk>/mb_order2_req
 Date:		March 2008
 Contact:	"Theodore Ts'o" <tytso@mit.edu>
 Description:
-		Tuning parameter which controls the minimum size for 
+		Tuning parameter which controls the minimum size for
 		requests (as a power of 2) where the buddy cache is
 		used
 
diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 353c0db5bc1f584a..a485434d2a0fb975 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -25,7 +25,7 @@ Description:	Maximum time allowed for periodic transfers per microframe (μs)
 		  However there are cases, when 80% max isochronous bandwidth is
 		  too limiting. For example two video streams could require 110
 		  microseconds of isochronous bandwidth per microframe to work
-		  together. 
+		  together.
 
 		Through this setting it is possible to raise the limit so that
 		the host controller would allow allocating more than 100
diff --git a/Documentation/ABI/testing/sysfs-platform-renesas_usb3 b/Documentation/ABI/testing/sysfs-platform-renesas_usb3
index 8af5b9c3fabbf07b..b08379e7fe37092e 100644
--- a/Documentation/ABI/testing/sysfs-platform-renesas_usb3
+++ b/Documentation/ABI/testing/sysfs-platform-renesas_usb3
@@ -12,6 +12,6 @@ Description:
 		- "peripheral" - switching mode from host to peripheral.
 
 		Read the file, then it shows the following strings:
-		
+
 		- "host" - The mode is host now.
 		- "peripheral" - The mode is peripheral now.
-- 
2.25.1

