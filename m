Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F395B2CD127
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbgLCIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:21:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519BC061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 00:20:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d20so1433465lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VdnIYr9YeJub2mP2w3Tk7xWX5tJWa5LVTnny6kAVJ6U=;
        b=p6xnvE8Gbo+5SKXhvH1Lsay+0/8r+Jdhhgks9Mb/1WFB879WVJrRMyxKE3qQk9oEpf
         WZJzpK02mIxL0OrdAgktHPqtCT1B27cuxePA/WAQ7pZ1Z3q1B7QCVNZ6M/11DaJNe52t
         Yc80NXmLfgpPqfBJRQDUK3QfpSc+QLiqDi1M0gIopHV25SETYGXJjfLyTgXBW+E7xSPZ
         D97Ltx//Ic6rbqhg0Imgo8GIWTy+jMCd8XC27CVe1pUMd1RT9b0thVSynisLSC00txay
         StVcHcBor0PvmJhwWn2DdnUrReu0zIZw+Gmstpslur5WuKaXdyzRczoS7xCS/sQy0sEB
         ku9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VdnIYr9YeJub2mP2w3Tk7xWX5tJWa5LVTnny6kAVJ6U=;
        b=XeKPfp3pfIrLjecd6dMNEvjASWsytFtOM195xzreY23jSU4tMxX2LzXpe5pGn8J1SX
         EpMh/s7Exe5eslZDkM7EnKCWq8z+zeXVvqa2vvuvmLLbT/kUl/Mv+pgFh2k+Pa3szw7E
         16w/F3vDPTJ3bianqgnXFo81XNDTkgOt26vn2Gx584X9ecQFhZRRipD7K++HxbO6YX1H
         tx5xlnwyQIumAm8+Z4cFyMD27LEr4VpCN4f0aRrqRk2dQd0FB4XdRakAuov3YtE+UCiS
         /vqdxLG8vsn4O9C0rxRhGE5AnUrq2MDF1cE2zyJhuqa8/Cx5ykzpKunmOzR0hu41aZRJ
         k5VA==
X-Gm-Message-State: AOAM532WsESkqCsB6rFjqfKT0FTHvL73OUsLCHFbyv2QropUYrSUXEN1
        5hPn+yuIJ1AHmYy3kD8UCADTcuLdsqb0DA==
X-Google-Smtp-Source: ABdhPJyrE0ow+GyV52WK7R3rbckrR/AKGZBJnHDfH5BkyeZ1h3eecqFQ8BkpEqeTRcNxOHk49E4cIg==
X-Received: by 2002:ac2:5619:: with SMTP id v25mr846338lfd.102.1606983631037;
        Thu, 03 Dec 2020 00:20:31 -0800 (PST)
Received: from spblnx124 ([185.204.20.3])
        by smtp.gmail.com with ESMTPSA id p132sm248164lfa.149.2020.12.03.00.20.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 00:20:30 -0800 (PST)
Date:   Thu, 3 Dec 2020 11:20:29 +0300
From:   Andrew Klychkov <andrew.a.klychkov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix multiple typos found in the admin-guide
 subdirectory
Message-ID: <20201203082029.GA44830@spblnx124.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix thirty seven typos in dm-integrity.rst, dm-raid.rst, dm-zoned.rst,
verity.rst, writecache.rst, tsx_async_abort.rst, ldm.rst, md.rst,
bttv.rst, dvb_references.rst, frontend-cardlist.rst, gspca-cardlist.rst,
ipu3.rst, remote-controller.rst, mm/index.rst, numaperf.rst,
userfaultfd.rst, module-signing.rst, imx-ddr.rst,
intel-speed-select.rst, intel_pstate.rst, ramoops.rst, abi.rst,
kernel.rst, vm.rst

Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-integrity.rst | 4 ++--
 Documentation/admin-guide/device-mapper/dm-raid.rst      | 2 +-
 Documentation/admin-guide/device-mapper/dm-zoned.rst     | 6 +++---
 Documentation/admin-guide/device-mapper/verity.rst       | 2 +-
 Documentation/admin-guide/device-mapper/writecache.rst   | 4 ++--
 Documentation/admin-guide/hw-vuln/tsx_async_abort.rst    | 2 +-
 Documentation/admin-guide/ldm.rst                        | 2 +-
 Documentation/admin-guide/md.rst                         | 2 +-
 Documentation/admin-guide/media/bttv.rst                 | 2 +-
 Documentation/admin-guide/media/dvb_references.rst       | 2 +-
 Documentation/admin-guide/media/frontend-cardlist.rst    | 4 ++--
 Documentation/admin-guide/media/gspca-cardlist.rst       | 2 +-
 Documentation/admin-guide/media/ipu3.rst                 | 6 +++---
 Documentation/admin-guide/media/remote-controller.rst    | 2 +-
 Documentation/admin-guide/mm/index.rst                   | 4 ++--
 Documentation/admin-guide/mm/numaperf.rst                | 2 +-
 Documentation/admin-guide/mm/userfaultfd.rst             | 2 +-
 Documentation/admin-guide/module-signing.rst             | 4 ++--
 Documentation/admin-guide/perf/imx-ddr.rst               | 2 +-
 Documentation/admin-guide/pm/intel-speed-select.rst      | 4 ++--
 Documentation/admin-guide/pm/intel_pstate.rst            | 6 +++---
 Documentation/admin-guide/ramoops.rst                    | 2 +-
 Documentation/admin-guide/sysctl/abi.rst                 | 2 +-
 Documentation/admin-guide/sysctl/kernel.rst              | 2 +-
 Documentation/admin-guide/sysctl/vm.rst                  | 2 +-
 25 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-integrity.rst b/Documentation/admin-guide/device-mapper/dm-integrity.rst
index 3ab4f77..4e6f504 100644
--- a/Documentation/admin-guide/device-mapper/dm-integrity.rst
+++ b/Documentation/admin-guide/device-mapper/dm-integrity.rst
@@ -117,7 +117,7 @@ journal_watermark:number
 
 commit_time:number
 	Commit time in milliseconds. When this time passes, the journal is
-	written. The journal is also written immediatelly if the FLUSH
+	written. The journal is also written immediately if the FLUSH
 	request is received.
 
 internal_hash:algorithm(:key)	(the key is optional)
@@ -147,7 +147,7 @@ journal_crypt:algorithm(:key)	(the key is optional)
 	"salsa20" or "ctr(aes)").
 
 	The journal contains history of last writes to the block device,
-	an attacker reading the journal could see the last sector nubmers
+	an attacker reading the journal could see the last sector numbers
 	that were written. From the sector numbers, the attacker can infer
 	the size of files that were written. To protect against this
 	situation, you can encrypt the journal.
diff --git a/Documentation/admin-guide/device-mapper/dm-raid.rst b/Documentation/admin-guide/device-mapper/dm-raid.rst
index 7ef9fe6..bb17e26 100644
--- a/Documentation/admin-guide/device-mapper/dm-raid.rst
+++ b/Documentation/admin-guide/device-mapper/dm-raid.rst
@@ -418,6 +418,6 @@ Version History
 	specific devices are requested via rebuild.  Fix RAID leg
 	rebuild errors.
  1.15.0 Fix size extensions not being synchronized in case of new MD bitmap
-        pages allocated;  also fix those not occuring after previous reductions
+        pages allocated;  also fix those not occurring after previous reductions
  1.15.1 Fix argument count and arguments for rebuild/write_mostly/journal_(dev|mode)
         on the status line.
diff --git a/Documentation/admin-guide/device-mapper/dm-zoned.rst b/Documentation/admin-guide/device-mapper/dm-zoned.rst
index e6350413..0fac051 100644
--- a/Documentation/admin-guide/device-mapper/dm-zoned.rst
+++ b/Documentation/admin-guide/device-mapper/dm-zoned.rst
@@ -24,7 +24,7 @@ The dm-zoned implementation is simple and minimizes system overhead (CPU
 and memory usage as well as storage capacity loss). For a 10TB
 host-managed disk with 256 MB zones, dm-zoned memory usage per disk
 instance is at most 4.5 MB and as little as 5 zones will be used
-internally for storing metadata and performaing reclaim operations.
+internally for storing metadata and performing reclaim operations.
 
 dm-zoned target devices are formatted and checked using the dmzadm
 utility available at:
@@ -102,7 +102,7 @@ the buffer zone assigned. If the accessed chunk has no mapping, or the
 accessed blocks are invalid, the read buffer is zeroed and the read
 operation terminated.
 
-After some time, the limited number of convnetional zones available may
+After some time, the limited number of conventional zones available may
 be exhausted (all used to map chunks or buffer sequential zones) and
 unaligned writes to unbuffered chunks become impossible. To avoid this
 situation, a reclaim process regularly scans used conventional zones and
@@ -158,7 +158,7 @@ Ex::
 	dmzadm --format /dev/sdxx /dev/sdyy
 
 
-Fomatted device(s) can be started with the dmzadm utility, too.:
+Formatted device(s) can be started with the dmzadm utility, too.:
 
 Ex::
 
diff --git a/Documentation/admin-guide/device-mapper/verity.rst b/Documentation/admin-guide/device-mapper/verity.rst
index 66f71f0..8c50e5c 100644
--- a/Documentation/admin-guide/device-mapper/verity.rst
+++ b/Documentation/admin-guide/device-mapper/verity.rst
@@ -69,7 +69,7 @@ Construction Parameters
 
 <#opt_params>
     Number of optional parameters. If there are no optional parameters,
-    the optional paramaters section can be skipped or #opt_params can be zero.
+    the optional parameters section can be skipped or #opt_params can be zero.
     Otherwise #opt_params is the number of following arguments.
 
     Example of optional parameters section:
diff --git a/Documentation/admin-guide/device-mapper/writecache.rst b/Documentation/admin-guide/device-mapper/writecache.rst
index d3d7690..dce0184 100644
--- a/Documentation/admin-guide/device-mapper/writecache.rst
+++ b/Documentation/admin-guide/device-mapper/writecache.rst
@@ -37,10 +37,10 @@ Constructor parameters:
 	autocommit_blocks n	(default: 64 for pmem, 65536 for ssd)
 		when the application writes this amount of blocks without
 		issuing the FLUSH request, the blocks are automatically
-		commited
+		committed
 	autocommit_time ms	(default: 1000)
 		autocommit time in milliseconds. The data is automatically
-		commited if this time passes and no FLUSH request is
+		committed if this time passes and no FLUSH request is
 		received
 	fua			(by default on)
 		applicable only to persistent memory - use the FUA flag
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
index 68d96f0..76673af 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -60,7 +60,7 @@ Hyper-Thread attacks are possible.
 
 The victim of a malicious actor does not need to make use of TSX. Only the
 attacker needs to begin a TSX transaction and raise an asynchronous abort
-which in turn potenitally leaks data stored in the buffers.
+which in turn potentially leaks data stored in the buffers.
 
 More detailed technical information is available in the TAA specific x86
 architecture section: :ref:`Documentation/x86/tsx_async_abort.rst <tsx_async_abort>`.
diff --git a/Documentation/admin-guide/ldm.rst b/Documentation/admin-guide/ldm.rst
index 12c5713..2cb4146 100644
--- a/Documentation/admin-guide/ldm.rst
+++ b/Documentation/admin-guide/ldm.rst
@@ -19,7 +19,7 @@ longer any primary or extended partitions.  Normal MSDOS style partitions are
 now known as Basic Disks.
 
 If you wish to use Spanned, Striped, Mirrored or RAID 5 Volumes, you must use
-Dynamic Disks.  The journalling allows Windows to make changes to these
+Dynamic Disks.  The journaling allows Windows to make changes to these
 partitions and filesystems without the need to reboot.
 
 Once the LDM driver has divided up the disk, you can use the MD driver to
diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index cc8781b..d8fc9a5 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -221,7 +221,7 @@ All md devices contain:
 
   layout
      The ``layout`` for the array for the particular level.  This is
-     simply a number that is interpretted differently by different
+     simply a number that is interpreted differently by different
      levels.  It can be written while assembling an array.
 
   array_size
diff --git a/Documentation/admin-guide/media/bttv.rst b/Documentation/admin-guide/media/bttv.rst
index 4938237..0ef1f20 100644
--- a/Documentation/admin-guide/media/bttv.rst
+++ b/Documentation/admin-guide/media/bttv.rst
@@ -77,7 +77,7 @@ the Subsystem ID in the second line, looks like this:
 only bt878-based cards can have a subsystem ID (which does not mean
 that every card really has one).  bt848 cards can't have a Subsystem
 ID and therefore can't be autodetected.  There is a list with the ID's
-at :doc:`bttv-cardlist` (in case you are intrested or want to mail
+at :doc:`bttv-cardlist` (in case you are interested or want to mail
 patches with updates).
 
 
diff --git a/Documentation/admin-guide/media/dvb_references.rst b/Documentation/admin-guide/media/dvb_references.rst
index 48445ac..4f0fd42 100644
--- a/Documentation/admin-guide/media/dvb_references.rst
+++ b/Documentation/admin-guide/media/dvb_references.rst
@@ -10,7 +10,7 @@ The DVB mailing list linux-dvb is hosted at vger. Please see
 http://vger.kernel.org/vger-lists.html#linux-media for details.
 
 There are also some other old lists hosted at:
-https://linuxtv.org/lists.php. If you're insterested on that for historic
+https://linuxtv.org/lists.php. If you're interested on that for historic
 reasons, please check the archive at https://linuxtv.org/pipermail/linux-dvb/.
 
 The media subsystem Wiki is hosted at https://linuxtv.org/wiki/.
diff --git a/Documentation/admin-guide/media/frontend-cardlist.rst b/Documentation/admin-guide/media/frontend-cardlist.rst
index 73a248c..ba5b7c6 100644
--- a/Documentation/admin-guide/media/frontend-cardlist.rst
+++ b/Documentation/admin-guide/media/frontend-cardlist.rst
@@ -68,7 +68,7 @@ cx24116         Conexant CX24116 based
 cx24117         Conexant CX24117 based
 cx24120         Conexant CX24120 based
 cx24123         Conexant CX24123 based
-ds3000          Montage Tehnology DS3000 based
+ds3000          Montage Technology DS3000 based
 mb86a16         Fujitsu MB86A16 based
 mt312           Zarlink VP310/MT312/ZL10313 based
 s5h1420         Samsung S5H1420 based
@@ -83,7 +83,7 @@ tda10086        Philips TDA10086 based
 tda8083         Philips TDA8083 based
 tda8261         Philips TDA8261 based
 tda826x         Philips TDA826X silicon tuner
-ts2020          Montage Tehnology TS2020 based tuners
+ts2020          Montage Technology TS2020 based tuners
 tua6100         Infineon TUA6100 PLL
 cx24113         Conexant CX24113/CX24128 tuner for DVB-S/DSS
 itd1000         Integrant ITD1000 Zero IF tuner for DVB-S/DSS
diff --git a/Documentation/admin-guide/media/gspca-cardlist.rst b/Documentation/admin-guide/media/gspca-cardlist.rst
index adda933..e3404d1 100644
--- a/Documentation/admin-guide/media/gspca-cardlist.rst
+++ b/Documentation/admin-guide/media/gspca-cardlist.rst
@@ -305,7 +305,7 @@ pac7302         093a:2625	Genius iSlim 310
 pac7302         093a:2626	Labtec 2200
 pac7302         093a:2627	Genius FaceCam 300
 pac7302         093a:2628	Genius iLook 300
-pac7302         093a:2629	Genious iSlim 300
+pac7302         093a:2629	Genius iSlim 300
 pac7302         093a:262a	Webcam 300k
 pac7302         093a:262c	Philips SPC 230 NC
 jl2005bcd       0979:0227	Various brands, 19 known cameras supported
diff --git a/Documentation/admin-guide/media/ipu3.rst b/Documentation/admin-guide/media/ipu3.rst
index 07d139b..f59697c 100644
--- a/Documentation/admin-guide/media/ipu3.rst
+++ b/Documentation/admin-guide/media/ipu3.rst
@@ -86,7 +86,7 @@ raw Bayer format that is specific to IPU3.
 Let us take the example of ov5670 sensor connected to CSI2 port 0, for a
 2592x1944 image capture.
 
-Using the media contorller APIs, the ov5670 sensor is configured to send
+Using the media controller APIs, the ov5670 sensor is configured to send
 frames in packed raw Bayer format to IPU3 CSI2 receiver.
 
 .. code-block:: none
@@ -313,8 +313,8 @@ configuration steps of 0.03125 (1/32).
 
 **Geometric Distortion Correction**
 
-Geometric Distortion Correction is used to performe correction of distortions
-and image filtering. It needs some extra filter and envelop padding pixels to
+Geometric Distortion Correction is used to perform correction of distortions
+and image filtering. It needs some extra filter and envelope padding pixels to
 work, so the input resolution of GDC should be larger than the output
 resolution.
 
diff --git a/Documentation/admin-guide/media/remote-controller.rst b/Documentation/admin-guide/media/remote-controller.rst
index fa05410..188944b 100644
--- a/Documentation/admin-guide/media/remote-controller.rst
+++ b/Documentation/admin-guide/media/remote-controller.rst
@@ -68,7 +68,7 @@ Using without lircd
 
 Xorg recognizes several IR keycodes that have its numerical value lower
 than 247. With the advent of Wayland, the input driver got updated too,
-and should now accept all keycodes. Yet, you may want to just reasign
+and should now accept all keycodes. Yet, you may want to just reassign
 the keycodes to something that your favorite media application likes.
 
 This can be done by setting
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index cd727cf..4b14d8b 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -3,9 +3,9 @@ Memory Management
 =================
 
 Linux memory management subsystem is responsible, as the name implies,
-for managing the memory in the system. This includes implemnetation of
+for managing the memory in the system. This includes implementation of
 virtual memory and demand paging, memory allocation both for kernel
-internal structures and user space programms, mapping of files into
+internal structures and user space programs, mapping of files into
 processes address space and many other cool things.
 
 Linux memory management is a complex system with many configurable
diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index 86f2a3c..c2f8264 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -74,7 +74,7 @@ memory node's access class 0 initiators as follows::
 	/sys/devices/system/node/nodeY/access0/initiators/
 
 These attributes apply only when accessed from nodes that have the
-are linked under the this access's inititiators.
+are linked under the this access's initiators.
 
 The performance characteristics the kernel provides for the local initiators
 are exported are as follows::
diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 1dc2d5f..65eefa6 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -114,7 +114,7 @@ Notes:
   you must provide some kind of page in your thread after reading from
   the uffd.  You must provide either ``UFFDIO_COPY`` or ``UFFDIO_ZEROPAGE``.
   The normal behavior of the OS automatically providing a zero page on
-  an annonymous mmaping is not in place.
+  an anonymous mmaping is not in place.
 
 - None of the page-delivering ioctls default to the range that you
   registered with.  You must fill in all fields for the appropriate
diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index f8b5841..219e286 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -106,7 +106,7 @@ This has a number of options available:
      certificate and a private key.
 
      If the PEM file containing the private key is encrypted, or if the
-     PKCS#11 token requries a PIN, this can be provided at build time by
+     PKCS#11 token requires a PIN, this can be provided at build time by
      means of the ``KBUILD_SIGN_PIN`` variable.
 
 
@@ -185,7 +185,7 @@ in a keyring called ".builtin_trusted_keys" that can be seen by::
 	[root@deneb ~]# cat /proc/keys
 	...
 	223c7853 I------     1 perm 1f030000     0     0 keyring   .builtin_trusted_keys: 1
-	302d2d52 I------     1 perm 1f010000     0     0 asymmetri Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []
+	302d2d52 I------     1 perm 1f010000     0     0 asymmetric Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []
 	...
 
 Beyond the public key generated specifically for module signing, additional
diff --git a/Documentation/admin-guide/perf/imx-ddr.rst b/Documentation/admin-guide/perf/imx-ddr.rst
index f05f56c..90926d0 100644
--- a/Documentation/admin-guide/perf/imx-ddr.rst
+++ b/Documentation/admin-guide/perf/imx-ddr.rst
@@ -4,7 +4,7 @@ Freescale i.MX8 DDR Performance Monitoring Unit (PMU)
 
 There are no performance counters inside the DRAM controller, so performance
 signals are brought out to the edge of the controller where a set of 4 x 32 bit
-counters is implemented. This is controlled by the CSV modes programed in counter
+counters is implemented. This is controlled by the CSV modes programmed in counter
 control register which causes a large number of PERF signals to be generated.
 
 Selection of the value for each counter is done via the config registers. There
diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
index 219f135..0a1fbdb 100644
--- a/Documentation/admin-guide/pm/intel-speed-select.rst
+++ b/Documentation/admin-guide/pm/intel-speed-select.rst
@@ -57,7 +57,7 @@ To get help on a command, another level of help is provided. For example for the
 
 Summary of platform capability
 ------------------------------
-To check the current platform and driver capaibilities, execute::
+To check the current platform and driver capabilities, execute::
 
 #intel-speed-select --info
 
@@ -658,7 +658,7 @@ If -a option is not used, then the following steps are required before enabling
 Intel(R) SST-BF:
 
 - Discover Intel(R) SST-BF and note low and high priority base frequency
-- Note the high prioity CPU list
+- Note the high priority CPU list
 - Enable CLOS using core-power feature set
 - Configure CLOS parameters. Use CLOS.min to set to minimum performance
 - Subscribe desired CPUs to CLOS groups
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 5072e70..df29b4f 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -56,7 +56,7 @@ Operation Modes
 
 ``intel_pstate`` can operate in two different modes, active or passive.  In the
 active mode, it uses its own internal performance scaling governor algorithm or
-allows the hardware to do preformance scaling by itself, while in the passive
+allows the hardware to do performance scaling by itself, while in the passive
 mode it responds to requests made by a generic ``CPUFreq`` governor implementing
 a certain performance scaling algorithm.  Which of them will be in effect
 depends on what kernel command line options are used and on the capabilities of
@@ -380,13 +380,13 @@ argument is passed to the kernel in the command line.
 
 ``no_turbo``
 	If set (equal to 1), the driver is not allowed to set any turbo P-states
-	(see `Turbo P-states Support`_).  If unset (equalt to 0, which is the
+	(see `Turbo P-states Support`_).  If unset (equal to 0, which is the
 	default), turbo P-states can be set by the driver.
 	[Note that ``intel_pstate`` does not support the general ``boost``
 	attribute (supported by some other scaling drivers) which is replaced
 	by this one.]
 
-	This attrubute does not affect the maximum supported frequency value
+	This attribute does not affect the maximum supported frequency value
 	supplied to the ``CPUFreq`` core and exposed via the policy interface,
 	but it affects the maximum possible value of per-policy P-state	limits
 	(see `Interpretation of Policy Attributes`_ below for details).
diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index a60a962..b0a1ae7 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -22,7 +22,7 @@ and type of the memory area are set using three variables:
   * ``mem_address`` for the start
   * ``mem_size`` for the size. The memory size will be rounded down to a
     power of two.
-  * ``mem_type`` to specifiy if the memory type (default is pgprot_writecombine).
+  * ``mem_type`` to specify if the memory type (default is pgprot_writecombine).
 
 Typically the default value of ``mem_type=0`` should be used as that sets the pstore
 mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
diff --git a/Documentation/admin-guide/sysctl/abi.rst b/Documentation/admin-guide/sysctl/abi.rst
index ac87eaf..77b1d1b 100644
--- a/Documentation/admin-guide/sysctl/abi.rst
+++ b/Documentation/admin-guide/sysctl/abi.rst
@@ -28,7 +28,7 @@ vsyscall32 (x86)
 
 Determines whether the kernels maps a vDSO page into 32-bit processes;
 can be set to 1 to enable, or 0 to disable. Defaults to enabled if
-``CONFIG_COMPAT_VDSO`` is set, disabled otherwide.
+``CONFIG_COMPAT_VDSO`` is set, disabled otherwise.
 
 This controls the same setting as the ``vdso32`` kernel boot
 parameter.
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc..b3bc8a5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -879,7 +879,7 @@ The default value is 127.
 perf_event_mlock_kb
 ===================
 
-Control size of per-cpu ring buffer not counted agains mlock limit.
+Control size of per-cpu ring buffer not counted against mlock limit.
 
 The default value is 512 + 1 page
 
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f455fa0..e0cf17a 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -146,7 +146,7 @@ This should be used on systems where stalls for minor page faults are an
 acceptable trade for large contiguous free memory.  Set to 0 to prevent
 compaction from moving pages that are unevictable.  Default value is 1.
 On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
-to compaction, which would block the task from becomming active until the fault
+to compaction, which would block the task from becoming active until the fault
 is resolved.
 
 
-- 
1.8.3.1

