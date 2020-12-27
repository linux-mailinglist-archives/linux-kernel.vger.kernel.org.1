Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6D2E3150
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgL0N14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 08:27:56 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60453 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbgL0N14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 08:27:56 -0500
Received: from [192.168.1.11] (dynamic-077-013-243-215.77.13.pool.telefonica.de [77.13.243.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D2B0120225BD3;
        Sun, 27 Dec 2020 14:27:12 +0100 (CET)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: 120 s delay during boot with smaller initrd
Message-ID: <96184c8e-6ea3-caa7-ba2b-b5644b70b2a9@molgen.mpg.de>
Date:   Sun, 27 Dec 2020 14:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Using an initrd created by tiny-initramfs [1], the boot stalls for two 
minutes *after* the initrd has run and systemd has already started. An 
F2FS root partition is used.

```
[    0.000000] microcode: microcode updated early to revision 0xa0b, 
date = 2010-09-28
[    0.000000] Linux version 5.9.0-5-amd64 
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-1) 10.2.1 
20201207, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian 
5.9.15-1 (2020-12-17)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-5-amd64 
root=/dev/sda2 ro quiet noisapnp cryptomgr.notests random.trust_cpu=on 
tsc=unstable debug log_buf_len=2M initcall_debug
[…]
[    0.650168] Trying to unpack rootfs image as initramfs...
[    0.661343] Freeing initrd memory: 1024K
[…]
[    6.033044] systemd[1]: systemd 247.2-3 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD 
+IDN2 -IDN +PCRE2 default-hierarchy=unified)
[…]
[    9.372134] fuse: init (API version 7.31)
[    9.396990] calling  pkcs8_key_init+0x0/0x1000 [pkcs8_key_parser] @ 114
[    9.413956] Asymmetric key parser 'pkcs8' registered
[    9.421378] initcall pkcs8_key_init+0x0/0x1000 [pkcs8_key_parser] 
returned 0 after 15912 usecs
[    9.433989] initcall fuse_init+0x0/0x142 [fuse] returned 0 after 
28206 usecs
[    9.443229] calling  drm_core_init+0x0/0x1000 [drm] @ 110
[    9.480740] initcall drm_core_init+0x0/0x1000 [drm] returned 0 after 
28888 usecs
[   12.057456] random: crng init done
[   12.060811] random: 7 urandom warning(s) missed due to ratelimiting
[  135.871988] perf: interrupt took too long (2509 > 2500), lowering 
kernel.perf_event_max_sample_rate to 79500
[  140.286157] audit: type=1400 audit(1609064788.012:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe" pid=142 comm="apparmor_parser"
[  140.315152] audit: type=1400 audit(1609064788.012:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe//kmod" pid=142 comm="apparmor_parser"
[  140.348623] audit: type=1400 audit(1609064788.072:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=155 comm="apparmor_parser"
[  140.382744] audit: type=1400 audit(1609064788.072:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_filter" pid=155 comm="apparmor_parser"
[  140.408791] audit: type=1400 audit(1609064788.072:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_groff" pid=155 comm="apparmor_parser"
[  140.439860] audit: type=1400 audit(1609064788.072:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/cups/backend/cups-pdf" pid=141 comm="apparmor_parser" 

[  140.481521] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 154
[…]
```

The userspace log during that time could be:

```
Dez 27 11:24:17 sitopanaki systemd[1]: Finished Coldplug All udev Devices.
Dez 27 11:24:17 sitopanaki systemd[1]: systemd-udev-trigger.service: 
Control group is empty.
Dez 27 11:24:17 sitopanaki systemd[1]: sysinit.target: starting held 
back, waiting for: systemd-hwdb-update.service
Dez 27 11:26:02 sitopanaki systemd[1]: systemd-journald.service: Got 
notification message from PID 113 (WATCHDOG=1)
Dez 27 11:26:27 sitopanaki systemd-fsck[119]: Info: Fix the reported 
corruption.
Dez 27 11:26:27 sitopanaki systemd-fsck[119]: Info: Mounted device!
Dez 27 11:26:27 sitopanaki systemd-fsck[119]: Info: Check FS only due to RO
```

As it does not happen with the initrd created by initramfs-tools, but 
the initrd was successfully run, I am quite confused. Could it be F2FS 
related? Please find the full logs of both starts attached to bug 
#210917 [2].


Kind regards,

Paul


[1]: https://github.com/chris-se/tiny-initramfs/
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=210917
