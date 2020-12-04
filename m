Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B12CE85F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLDHDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLDHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:03:25 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9921C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 23:02:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r18so5439772ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jZ6AFbPDCPLJkjHLTljRKlPcnZORFaH9SH7vtA8afw8=;
        b=hDSTp4cKYkEFGqXlkZxl0e7enLSd91mX6LgTIVbwxTFil4w2/0AzOFhJ7I+jXt6jki
         wA294vQZ/Ql5I4PydeG9zqcHfHD/GfShM2aV1OVcBgEy1giKKUGAHnUBnwQYQoEb7aNl
         zTmLrTqhwP2vldQxMUwGhUEB9XkFUnVVnjHs+7FYvVMpUBeWfgycIlbnYVLJooz93ggx
         ShapoQsABFpeYToeeMehVYCkkr5cpXE7jCUHbO1RmcAGUH0E3lFE1LWSBgvQlCcKh+6X
         mu4KnrcHCtvraht6mqdm8QvSjZQ0yofKuULQpl3TB1iJqPwfI/YftFGFca2pGnRiq8yG
         jT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jZ6AFbPDCPLJkjHLTljRKlPcnZORFaH9SH7vtA8afw8=;
        b=I6lKQtIg6YnmcPhTgL35C0OQhuHJYYvLm57s6Lxh1+SQ2RpA8ApfSG8e9HIz+eYjj5
         5Hjs79Gfm6pln2EItTXtaN0bpn9U5SCcUervAgACLrOOJRRmjhLGELe3R4/Xcg8HKvu8
         qrzYnT94QHJN5bOuVpOXmV85sivQfYiqlySnMZ5q+P0IVDe/p13HE+fTYxkzannOpGb0
         C2Kp16+yQe2GMx+dwdJyVZmf1jnEbhlyFdKa87ILS2nMndSZcM8QzhW45w6iW08eaemh
         DmPjXtENMKcYmFoFSR2xz3gPAx4yL+IoCT94LGO0lygM/Ns3Dq0kvrKVuLU31mMu2WWr
         RjyQ==
X-Gm-Message-State: AOAM530W92EtSTCEL+VY3nxdIBdCpJnoMRJZWwSuMUjKjxIAHLwuCgWI
        4FlnRgPWWoRhDl5OEbF5qZY=
X-Google-Smtp-Source: ABdhPJzt/UsFKrICg452b/He7VElJi/xWVh7UPz++QHFGFD2cWHWT6mVbMWVc81v1AMV+GT6Da7OoQ==
X-Received: by 2002:a2e:b4e4:: with SMTP id s4mr2763327ljm.329.1607065357156;
        Thu, 03 Dec 2020 23:02:37 -0800 (PST)
Received: from spblnx124 ([185.204.20.3])
        by smtp.gmail.com with ESMTPSA id s11sm1370746lfi.256.2020.12.03.23.02.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 23:02:36 -0800 (PST)
Date:   Fri, 4 Dec 2020 10:02:35 +0300
From:   Andrew Klychkov <andrew.a.klychkov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH] (fixed after review) Documentation: fix typos found in
 admin-guide subdirectory
Message-ID: <20201204070235.GA48631@spblnx124.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed twelve typos in cppc_sysfs.rst, binderfs.rst, paride.rst,
zram.rst, bug-hunting.rst, introduction.rst, usage.rst, dm-crypt.rst

Reviewed-by: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
---
 Documentation/admin-guide/acpi/cppc_sysfs.rst        | 4 ++--
 Documentation/admin-guide/binderfs.rst               | 2 +-
 Documentation/admin-guide/blockdev/paride.rst        | 2 +-
 Documentation/admin-guide/blockdev/zram.rst          | 2 +-
 Documentation/admin-guide/bug-hunting.rst            | 2 +-
 Documentation/admin-guide/cifs/introduction.rst      | 2 +-
 Documentation/admin-guide/cifs/usage.rst             | 6 +++---
 Documentation/admin-guide/device-mapper/dm-crypt.rst | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

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
+be invisible to Windows clients and typically will not affect local
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

