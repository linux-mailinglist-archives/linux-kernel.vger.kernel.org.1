Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318332CB790
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgLBIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgLBIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:44:44 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:44:03 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so2960021lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e4esWlqPfsUi8TgFUtImaHunhN+ShXo2n7GzFvpxIiU=;
        b=Y4tqQvgITwA0PMHAX/9keLwkdkZ44qjKhBT+8C7ZLvSv5QZYDuLIGZYXZWYYp+tAlB
         my5D7Exms3SPrcdGuIoz3lZgtqN1XApPY1F3s5jizC73nHizjawGIORUAZHskAx5/SEC
         Q+p5mRtJQSdlt4aq1kay/ih9atWqoy0tCryGCSYHyvj19PdAlMyEBbFWWEdvw5gh/3Zm
         U6rMb6buUquWku81clQVKdtVGR/k+rxSRRaCxKn26q7IpL4eweII4YBYfh3aTcjEcMTk
         IuDa99TSmmefpZM+KV02xSGN7373d3QBOsCk5G6IQOico60d+4iK8MsiZ5uzM0BNbvk7
         rFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e4esWlqPfsUi8TgFUtImaHunhN+ShXo2n7GzFvpxIiU=;
        b=aRzEapafDKLMtINF+NcJQKbTAnDqGos2nCkWU8lrJw0G38CtD28ZpWJK5EY5VNdDCa
         tZD507rxi1eUT9vyJuH1rsLiB/SoHw7lr0bqiGccKkq4jt8hOa4kl/Jr+P+9DVz/7nNi
         pIOJK33x0WQ3k3CXilXgsGLubn8C92+jshgQ62yhYj1eJl1UrR1wUHyZvfER7HO8FR6O
         fFZkyblUJs5kv8xTmLgvYfyi1WCvveGqtKd7MUX7HB5o8PExiOItwEuZiMEb1L7DZ+oM
         r96WOPyqWfMOEEtjqrla3Mp+whN13Kw06nFrVdcOIdG1PN4lPHakJ6QmW0nTYX9HjT6+
         VRpA==
X-Gm-Message-State: AOAM532FMeO9+ijBdl5cpCvTXzqcchNXddU6n+50Yf0+IkEyccbMigWV
        DfSDYG+ULr8o+CGr6ZCmEr95JN0CZtU=
X-Google-Smtp-Source: ABdhPJxxZGfePIgPQ8ount6jv1Jr95jNn3c24lsIbi5MrKlD5scT4RqDOz7KMREuZWIopHq6iF2Apg==
X-Received: by 2002:a19:4a55:: with SMTP id x82mr782188lfa.241.1606898641658;
        Wed, 02 Dec 2020 00:44:01 -0800 (PST)
Received: from spblnx124 ([185.204.20.3])
        by smtp.gmail.com with ESMTPSA id u11sm276955lfq.142.2020.12.02.00.44.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2020 00:44:01 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:44:00 +0300
From:   Andrew Klychkov <andrew.a.klychkov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix typos found in admin-guide subdirectory
Message-ID: <20201202084400.GA38345@spblnx124.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix thirteen typos in cppc_sysfs.rst, binderfs.rst, binfmt-misc.rst,
paride.rst, zram.rst, bug-hunting.rst, introduction.rst, usage.rst,
dm-crypt.rst

Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
---
 Documentation/admin-guide/acpi/cppc_sysfs.rst        | 4 ++--
 Documentation/admin-guide/binderfs.rst               | 2 +-
 Documentation/admin-guide/binfmt-misc.rst            | 2 +-
 Documentation/admin-guide/blockdev/paride.rst        | 2 +-
 Documentation/admin-guide/blockdev/zram.rst          | 2 +-
 Documentation/admin-guide/bug-hunting.rst            | 2 +-
 Documentation/admin-guide/cifs/introduction.rst      | 2 +-
 Documentation/admin-guide/cifs/usage.rst             | 6 +++---
 Documentation/admin-guide/device-mapper/dm-crypt.rst | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentation/admin-guide/acpi/cppc_sysfs.rst
index a4b99af..fccf221 100644
--- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -8,7 +8,7 @@ CPPC
 ====
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
-performance of a logical processor on a contigious and abstract performance
+performance of a logical processor on a contiguous and abstract performance
 scale. CPPC exposes a set of registers to describe abstract performance scale,
 to request performance levels and to measure per-cpu delivered performance.
 
@@ -45,7 +45,7 @@ for each cpu X::
 * lowest_freq : CPU frequency corresponding to lowest_perf (in MHz).
 * nominal_freq : CPU frequency corresponding to nominal_perf (in MHz).
   The above frequencies should only be used to report processor performance in
-  freqency instead of abstract scale. These values should not be used for any
+  frequency instead of abstract scale. These values should not be used for any
   functional decisions.
 
 * feedback_ctrs : Includes both Reference and delivered performance counter.
diff --git a/Documentation/admin-guide/binderfs.rst b/Documentation/admin-guide/binderfs.rst
index 8243af9..199d843 100644
--- a/Documentation/admin-guide/binderfs.rst
+++ b/Documentation/admin-guide/binderfs.rst
@@ -70,5 +70,5 @@ Deleting binder Devices
 Binderfs binder devices can be deleted via `unlink() <unlink_>`_.  This means
 that the `rm() <rm_>`_ tool can be used to delete them. Note that the
 ``binder-control`` device cannot be deleted since this would make the binderfs
-instance unuseable.  The ``binder-control`` device will be deleted when the
+instance unusable.  The ``binder-control`` device will be deleted when the
 binderfs instance is unmounted and all references to it have been dropped.
diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 7a86413..287d54c 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -43,7 +43,7 @@ Here is what the fields mean:
 - ``mask``
    is an (optional, defaults to all 0xff) mask. You can mask out some
    bits from matching by supplying a string like magic and as long as magic.
-   The mask is anded with the byte sequence of the file. Note that you must
+   The mask is ended with the byte sequence of the file. Note that you must
    escape any NUL bytes; parsing halts at the first one. Ignored when using
    filename extension matching.
 - ``interpreter``
diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
index 87b4278..e1ce90a 100644
--- a/Documentation/admin-guide/blockdev/paride.rst
+++ b/Documentation/admin-guide/blockdev/paride.rst
@@ -220,7 +220,7 @@ example::
 Finally, you can load high-level drivers for each kind of device that
 you have connected.  By default, each driver will autoprobe for a single
 device, but you can support up to four similar devices by giving their
-individual co-ordinates when you load the driver.
+individual coordinates when you load the driver.
 
 For example, if you had two no-name CD-ROM drives both using the
 KingByte KBIC-951A adapter, one on port 0x378 and the other on 0x3bc
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index a6fd1f9..9093228 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -360,7 +360,7 @@ like below::
 		/sys/block/zram0/writeback_limit.
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
-If admins want to allow further write again once the bugdet is exhausted,
+If admins want to allow further write again once the budget is exhausted,
 he could do it like below::
 
 	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admin-guide/bug-hunting.rst
index f7c80f4..95299b0 100644
--- a/Documentation/admin-guide/bug-hunting.rst
+++ b/Documentation/admin-guide/bug-hunting.rst
@@ -263,7 +263,7 @@ Please notice that it will point to:
 
 - The last developers that touched the source code (if this is done inside
   a git tree). On the above example, Tejun and Bhaktipriya (in this
-  specific case, none really envolved on the development of this file);
+  specific case, none really involved on the development of this file);
 - The driver maintainer (Hans Verkuil);
 - The subsystem maintainer (Mauro Carvalho Chehab);
 - The driver and/or subsystem mailing list (linux-media@vger.kernel.org);
diff --git a/Documentation/admin-guide/cifs/introduction.rst b/Documentation/admin-guide/cifs/introduction.rst
index 0b98f67..cc2851d 100644
--- a/Documentation/admin-guide/cifs/introduction.rst
+++ b/Documentation/admin-guide/cifs/introduction.rst
@@ -9,7 +9,7 @@ Introduction
   PC operating systems. New and improved versions of CIFS are now
   called SMB2 and SMB3. Use of SMB3 (and later, including SMB3.1.1)
   is strongly preferred over using older dialects like CIFS due to
-  security reaasons. All modern dialects, including the most recent,
+  security reasons. All modern dialects, including the most recent,
   SMB3.1.1 are supported by the CIFS VFS module. The SMB3 protocol
   is implemented and supported by all major file servers
   such as all modern versions of Windows (including Windows 2016
diff --git a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
index 7b32d50..baeb5c8 100644
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/cifs/usage.rst
@@ -115,7 +115,7 @@ later source tree in docs/manpages/mount.cifs.8
 Allowing User Unmounts
 ======================
 
-To permit users to ummount directories that they have user mounted (see above),
+To permit users to unmount directories that they have user mounted (see above),
 the utility umount.cifs may be used.  It may be invoked directly, or if
 umount.cifs is placed in /sbin, umount can invoke the cifs umount helper
 (at least for most versions of the umount utility) for umount of cifs
@@ -197,7 +197,7 @@ that is ignored by local server applications and non-cifs clients and that will
 not be traversed by the Samba server).  This is opaque to the Linux client
 application using the cifs vfs. Absolute symlinks will work to Samba 3.0.5 or
 later, but only for remote clients using the CIFS Unix extensions, and will
-be invisbile to Windows clients and typically will not affect local
+be invisibile to Windows clients and typically will not affect local
 applications running on the same server as Samba.
 
 Use instructions
@@ -267,7 +267,7 @@ would be forbidden for Windows/CIFS semantics) as long as the server is
 configured for Unix Extensions (and the client has not disabled
 /proc/fs/cifs/LinuxExtensionsEnabled). In addition the mount option
 ``mapposix`` can be used on CIFS (vers=1.0) to force the mapping of
-illegal Windows/NTFS/SMB characters to a remap range (this mount parm
+illegal Windows/NTFS/SMB characters to a remap range (this mount parameter
 is the default for SMB3). This remap (``mapposix``) range is also
 compatible with Mac (and "Services for Mac" on some older Windows).
 
diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index bc28a95..1a6753b 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -46,7 +46,7 @@ Parameters::
         capi:authenc(hmac(sha256),xts(aes))-random
         capi:rfc7539(chacha20,poly1305)-random
 
-    The /proc/crypto contains a list of curently loaded crypto modes.
+    The /proc/crypto contains a list of currently loaded crypto modes.
 
 <key>
     Key used for encryption. It is encoded either as a hexadecimal number
@@ -92,7 +92,7 @@ Parameters::
 
 <#opt_params>
     Number of optional parameters. If there are no optional parameters,
-    the optional paramaters section can be skipped or #opt_params can be zero.
+    the optional parameters section can be skipped or #opt_params can be zero.
     Otherwise #opt_params is the number of following arguments.
 
     Example of optional parameters section:
-- 
1.8.3.1

