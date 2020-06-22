Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E512040C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgFVUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgFVUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:02:15 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCBAC0617BA;
        Mon, 22 Jun 2020 12:47:08 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4A5443EECF;
        Mon, 22 Jun 2020 19:46:59 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     corbet@lwn.net, masahiroy@kernel.org, grandmaster@al2klimov.de,
        rostedt@goodmis.org, changbin.du@intel.com, j.neuschaefer@gmx.net,
        mchehab+samsung@kernel.org, cohuck@redhat.com,
        colin.king@canonical.com, mgreer@animalcreek.com,
        davem@davemloft.net, jacob.e.keller@intel.com, abbotti@mev.co.uk,
        tytso@mit.edu, ebiggers@google.com, jack@suse.cz,
        tglx@linutronix.de, akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com,
        andy.shevchenko@gmail.com, logang@deltatee.com,
        jacek.anaszewski@gmail.com, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/admin-guide
Date:   Mon, 22 Jun 2020 21:46:48 +0200
Message-Id: <20200622194648.51802-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
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
Difference in v2:
Fixed missing = in changed .rst header. (README.rst)

 Documentation/admin-guide/README.rst                        | 4 ++--
 Documentation/admin-guide/dell_rbu.rst                      | 2 +-
 Documentation/admin-guide/devices.txt                       | 6 +++---
 Documentation/admin-guide/ext4.rst                          | 4 ++--
 Documentation/admin-guide/kernel-parameters.txt             | 2 +-
 Documentation/admin-guide/laptops/disk-shock-protection.rst | 2 +-
 Documentation/admin-guide/laptops/sonypi.rst                | 2 +-
 Documentation/admin-guide/laptops/thinkpad-acpi.rst         | 6 +++---
 Documentation/admin-guide/mm/ksm.rst                        | 2 +-
 Documentation/admin-guide/nfs/nfs-client.rst                | 4 ++--
 Documentation/admin-guide/nfs/nfs-rdma.rst                  | 2 +-
 Documentation/admin-guide/nfs/nfsroot.rst                   | 6 +++---
 Documentation/admin-guide/sysctl/fs.rst                     | 2 +-
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 5fb526900023..d9e7f7117850 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,7 +1,7 @@
 .. _readme:
 
-Linux kernel release 5.x <http://kernel.org/>
-=============================================
+Linux kernel release 5.x <https://kernel.org/>
+==============================================
 
 These are the release notes for Linux version 5.  Read them carefully,
 as they tell you what this is all about, explain how to install the
diff --git a/Documentation/admin-guide/dell_rbu.rst b/Documentation/admin-guide/dell_rbu.rst
index 8d70e1fc9f9d..2196caf1b939 100644
--- a/Documentation/admin-guide/dell_rbu.rst
+++ b/Documentation/admin-guide/dell_rbu.rst
@@ -26,7 +26,7 @@ Please go to  http://support.dell.com register and you can find info on
 OpenManage and Dell Update packages (DUP).
 
 Libsmbios can also be used to update BIOS on Dell systems go to
-http://linux.dell.com/libsmbios/ for details.
+https://linux.dell.com/libsmbios/ for details.
 
 Dell_RBU driver supports BIOS update using the monolithic image and packetized
 image methods. In case of monolithic the driver allocates a contiguous chunk
diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 2a97aaec8b12..a622dfec92a4 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -1442,7 +1442,7 @@
 		    ...
 
 		The driver and documentation may be obtained from
-		http://www.winradio.com/
+		https://www.winradio.com/
 
   82 block	I2O hard disk
 		  0 = /dev/i2o/hdag	33rd I2O hard disk, whole disk
@@ -1656,7 +1656,7 @@
 		dynamically, so there is no fixed mapping from subdevice
 		pathnames to minor numbers.
 
-		See http://www.comedi.org/ for information about the Comedi
+		See https://www.comedi.org/ for information about the Comedi
 		project.
 
   98 block	User-mode virtual block device
@@ -1723,7 +1723,7 @@
 		implementations a kernel presence for caching and easy
 		mounting.  For more information about the project,
 		write to <arla-drinkers@stacken.kth.se> or see
-		http://www.stacken.kth.se/project/arla/
+		https://www.stacken.kth.se/project/arla/
 
  103 block	Audit device
 		  0 = /dev/audit	Audit device
diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fcef1876..bc3abfb33476 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -611,7 +611,7 @@ kernel source:	<file:fs/ext4/>
 
 programs:	http://e2fsprogs.sourceforge.net/
 
-useful links:	http://fedoraproject.org/wiki/ext3-devel
+useful links:	https://fedoraproject.org/wiki/ext3-devel
 		http://www.bullopensource.org/ext4/
 		http://ext4.wiki.kernel.org/index.php/Main_Page
-		http://fedoraproject.org/wiki/Features/Ext4
+		https://fedoraproject.org/wiki/Features/Ext4
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..b333ba5cb144 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2786,7 +2786,7 @@
 			touchscreen support is not enabled in the mainstream
 			kernel as of 2.6.30, a preliminary port can be found
 			in the "bleeding edge" mini2440 support kernel at
-			http://repo.or.cz/w/linux-2.6/mini2440.git
+			https://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
 			[X86,PPC,S390,ARM64] Control optional mitigations for
diff --git a/Documentation/admin-guide/laptops/disk-shock-protection.rst b/Documentation/admin-guide/laptops/disk-shock-protection.rst
index e97c5f78d8c3..22c7ec3e84cf 100644
--- a/Documentation/admin-guide/laptops/disk-shock-protection.rst
+++ b/Documentation/admin-guide/laptops/disk-shock-protection.rst
@@ -135,7 +135,7 @@ single project which, although still considered experimental, is fit
 for use. Please feel free to add projects that have been the victims
 of my ignorance.
 
-- http://www.thinkwiki.org/wiki/HDAPS
+- https://www.thinkwiki.org/wiki/HDAPS
 
   See this page for information about Linux support of the hard disk
   active protection system as implemented in IBM/Lenovo Thinkpads.
diff --git a/Documentation/admin-guide/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
index c6eaaf48f7c1..190da1234314 100644
--- a/Documentation/admin-guide/laptops/sonypi.rst
+++ b/Documentation/admin-guide/laptops/sonypi.rst
@@ -151,7 +151,7 @@ Bugs:
 	  different way to adjust the backlighting of the screen. There
 	  is a userspace utility to adjust the brightness on those models,
 	  which can be downloaded from
-	  http://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
+	  https://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
 
 	- since all development was done by reverse engineering, there is
 	  *absolutely no guarantee* that this driver will not crash your
diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 822907dcc845..69b7ce905cba 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -904,7 +904,7 @@ temperatures:
 The mapping of thermal sensors to physical locations varies depending on
 system-board model (and thus, on ThinkPad model).
 
-http://thinkwiki.org/wiki/Thermal_Sensors is a public wiki page that
+https://thinkwiki.org/wiki/Thermal_Sensors is a public wiki page that
 tries to track down these locations for various models.
 
 Most (newer?) models seem to follow this pattern:
@@ -925,7 +925,7 @@ For the R51 (source: Thomas Gruber):
 - 3:  Internal HDD
 
 For the T43, T43/p (source: Shmidoax/Thinkwiki.org)
-http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
+https://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
 
 - 2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
 - 3:  PCMCIA slot
@@ -935,7 +935,7 @@ http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
 - 11: Power regulator, underside of system board, below F2 key
 
 The A31 has a very atypical layout for the thermal sensors
-(source: Milos Popovic, http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_A31)
+(source: Milos Popovic, https://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_A31)
 
 - 1:  CPU
 - 2:  Main Battery: main sensor
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 874eb0c77d34..e87bf0135edf 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -9,7 +9,7 @@ Overview
 
 KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
 added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
-and http://lwn.net/Articles/306704/ and http://lwn.net/Articles/330589/
+and http://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/
 
 KSM was originally developed for use with KVM (where it was known as
 Kernel Shared Memory), to fit more virtual machines into physical memory,
diff --git a/Documentation/admin-guide/nfs/nfs-client.rst b/Documentation/admin-guide/nfs/nfs-client.rst
index c4b777c7584b..6adb6457bc69 100644
--- a/Documentation/admin-guide/nfs/nfs-client.rst
+++ b/Documentation/admin-guide/nfs/nfs-client.rst
@@ -65,8 +65,8 @@ migrated onto another server by means of the special "fs_locations"
 attribute. See `RFC3530 Section 6: Filesystem Migration and Replication`_ and
 `Implementation Guide for Referrals in NFSv4`_.
 
-.. _RFC3530 Section 6\: Filesystem Migration and Replication: http://tools.ietf.org/html/rfc3530#section-6
-.. _Implementation Guide for Referrals in NFSv4: http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
+.. _RFC3530 Section 6\: Filesystem Migration and Replication: https://tools.ietf.org/html/rfc3530#section-6
+.. _Implementation Guide for Referrals in NFSv4: https://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
 
 The fs_locations information can take the form of either an ip address and
 a path, or a DNS hostname and a path. The latter requires the NFS client to
diff --git a/Documentation/admin-guide/nfs/nfs-rdma.rst b/Documentation/admin-guide/nfs/nfs-rdma.rst
index ef0f3678b1fb..f137485f8bde 100644
--- a/Documentation/admin-guide/nfs/nfs-rdma.rst
+++ b/Documentation/admin-guide/nfs/nfs-rdma.rst
@@ -65,7 +65,7 @@ use with NFS/RDMA.
   If the version is less than 1.1.2 or the command does not exist,
   you should install the latest version of nfs-utils.
 
-  Download the latest package from: http://www.kernel.org/pub/linux/utils/nfs
+  Download the latest package from: https://www.kernel.org/pub/linux/utils/nfs
 
   Uncompress the package and follow the installation instructions.
 
diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index c6772075c80c..135218f33394 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -264,7 +264,7 @@ They depend on various facilities being available:
      	access to the floppy drive device, /dev/fd0
 
      	For more information on syslinux, including how to create bootdisks
-     	for prebuilt kernels, see http://syslinux.zytor.com/
+     	for prebuilt kernels, see https://syslinux.zytor.com/
 
 	.. note::
 		Previously it was possible to write a kernel directly to
@@ -292,7 +292,7 @@ They depend on various facilities being available:
 	  cdrecord dev=ATAPI:1,0,0 arch/x86/boot/image.iso
 
      	For more information on isolinux, including how to create bootdisks
-     	for prebuilt kernels, see http://syslinux.zytor.com/
+     	for prebuilt kernels, see https://syslinux.zytor.com/
 
 - Using LILO
 
@@ -346,7 +346,7 @@ They depend on various facilities being available:
 	see Documentation/admin-guide/serial-console.rst for more information.
 
 	For more information on isolinux, including how to create bootdisks
-	for prebuilt kernels, see http://syslinux.zytor.com/
+	for prebuilt kernels, see https://syslinux.zytor.com/
 
 
 
diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..f48277a0a850 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -261,7 +261,7 @@ directories like /tmp. The common method of exploitation of this flaw
 is to cross privilege boundaries when following a given symlink (i.e. a
 root process follows a symlink belonging to another user). For a likely
 incomplete list of hundreds of examples across the years, please see:
-http://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
+https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
 
 When set to "0", symlink following behavior is unrestricted.
 
-- 
2.27.0

