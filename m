Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF17B281104
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbgJBLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:09:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94DCC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 04:09:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so848496ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzO9r/mm9kn9+8vQnJdM9eXg+PnaAIMWDsQ1sYGBPsQ=;
        b=XKwOAUfLseMj6x2Y3HCLiEV6YHJcdo3MTKuUAWuJUYQNf5t+iX6Umg8ZAmmCSX7pJu
         MaOG4WCvPHxchwYPsPNFQxaFNzbU9qHe0qhFbLDr4j/xbpRG3fMb4u3OFeIsbuwg+paH
         1oGIgH8UK6VqvyBOjuyBmVW+3fi9Hy9tsiUej7HUXnYb3yKhvsAdnMzwtdpy/nILQQzw
         LEZyHCwLLcXHtorRA3WXYHXPQoxm8dLF4FyMJJm2OgNyLC5zVeS8WIDrIKm+oRnumHXY
         tpZ2CNw39d4n8fctnBZUWEhjZXurt93rPviZxOe7BbJevh2uukp+ob2sz7Xh3Vd8ZSkt
         SFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzO9r/mm9kn9+8vQnJdM9eXg+PnaAIMWDsQ1sYGBPsQ=;
        b=KuFH48FdP+5kIxFk8KaexMxJkHMM9uuMEM8eUI0PYP5Tp275VzBOvu//uL5ItB5rsK
         66FuF2l1WuPYnO8VBeYVxkvYLpmkksJTHq9R4DZYVsFe0+a+qaMSDMBDXTipP71CNoYC
         1UI1aeTqGCDl/MlOTIzqAthPe47azZOb+NwJPp+Pn7RElCg0n4AZ+0bsfouPAn4H9xDO
         QyRM/MTo0Pv9ZwC1k+gNbg2sR/l0ANdV8ZuUXufsQIo5c/6tTp2/QLI3fMLC5ig2olDW
         0qOwgqy5Efec+vFpRJWq0KZAeQGmHA/gAKeoOqWzI9l3wlExEFLG4vAD8Qp/x4E7j37p
         V5EQ==
X-Gm-Message-State: AOAM530P+9GAATi7i7fyWwkDUVazJTdpVEpgGX+vr1LleVNyEozbMAbc
        6s3ubTd/PjPzQ6GkglbZ5NI=
X-Google-Smtp-Source: ABdhPJw5fDNozd5g/lD0TKVxOkPdTnVb01sF/xdoUJC4qfmgtMfDktx61pfRVC2gU3JunvKLWoa37Q==
X-Received: by 2002:a2e:3002:: with SMTP id w2mr528037ljw.244.1601636982971;
        Fri, 02 Oct 2020 04:09:42 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m1sm232840lfh.99.2020.10.02.04.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:09:42 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] mm: Optional full ASLR for mmap() and mremap()
Date:   Fri,  2 Oct 2020 14:09:17 +0300
Message-Id: <20201002110917.4227-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
enables full randomization of memory mappings created with mmap(NULL,
...). With 2, the base of the VMA used for such mappings is random,
but the mappings are created in predictable places within the VMA and
in sequential order. With 3, new VMAs are created to fully randomize
the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
even if not necessary.

On 32 bit systems this may cause problems due to increased VM
fragmentation if the address space gets crowded.

In this example, with value of 2, ld.so.cache, libc, an anonymous mmap
and locale-archive are located close to each other:
$ strace /bin/sync
...
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e7f2000
...
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7d9c1e7f0000
mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7d9c1e62b000
...
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7d9c1e0c9000

With 3, they are located in unrelated addresses:
$ echo 3 > /proc/sys/kernel/randomize_va_space
$ /bin/sync
...
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=189096, ...}) = 0
mmap(NULL, 189096, PROT_READ, MAP_PRIVATE, 3, 0) = 0xeda4fbea000
...
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0n\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1839792, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb8fb9c1d000
mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xaabd8598000
...
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5642592, ...}) = 0
mmap(NULL, 5642592, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbe351ab8000

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: also randomize mremap(..., MREMAP_MAYMOVE)
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  6 +++---
 Documentation/admin-guide/sysctl/kernel.rst   | 11 +++++++++++
 init/Kconfig                                  |  2 +-
 mm/mmap.c                                     |  7 ++++++-
 mm/mremap.c                                   | 15 +++++++++++++++
 5 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..9ea250522077 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -254,7 +254,7 @@ Spectre variant 2
    left by the previous process will also be cleared.
 
    User programs should use address space randomization to make attacks
-   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
+   more difficult (Set /proc/sys/kernel/randomize_va_space = 1, 2 or 3).
 
 3. A virtualized guest attacking the host
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -499,8 +499,8 @@ Spectre variant 2
    more overhead and run slower.
 
    User programs should use address space randomization
-   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
-   difficult.
+   (/proc/sys/kernel/randomize_va_space = 1, 2 or 3) to make attacks
+   more difficult.
 
 3. VM mitigation
 ^^^^^^^^^^^^^^^^
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..acd0612155d9 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1060,6 +1060,17 @@ that support this feature.
     Systems with ancient and/or broken binaries should be configured
     with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
     address space randomization.
+
+3   Additionally enable full randomization of memory mappings created
+    with mmap(NULL, ...). With 2, the base of the VMA used for such
+    mappings is random, but the mappings are created in predictable
+    places within the VMA and in sequential order. With 3, new VMAs
+    are created to fully randomize the mappings. Also mremap(...,
+    MREMAP_MAYMOVE) will move the mappings even if not necessary.
+
+    On 32 bit systems this may cause problems due to increased VM
+    fragmentation if the address space gets crowded.
+
 ==  ===========================================================================
 
 
diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..c5ea2e694f6a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1859,7 +1859,7 @@ config COMPAT_BRK
 	  also breaks ancient binaries (including anything libc5 based).
 	  This option changes the bootup default to heap randomization
 	  disabled, and can be overridden at runtime by setting
-	  /proc/sys/kernel/randomize_va_space to 2.
+	  /proc/sys/kernel/randomize_va_space to 2 or 3.
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..489368f43af1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/elf-randomize.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -206,7 +207,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 #ifdef CONFIG_COMPAT_BRK
 	/*
 	 * CONFIG_COMPAT_BRK can still be overridden by setting
-	 * randomize_va_space to 2, which will still cause mm->start_brk
+	 * randomize_va_space to >= 2, which will still cause mm->start_brk
 	 * to be arbitrarily shifted
 	 */
 	if (current->brk_randomized)
@@ -1407,6 +1408,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/* Pick a random address even outside current VMAs? */
+	if (!addr && randomize_va_space >= 3)
+		addr = arch_mmap_rnd();
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..c7fd1ab5fb5f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,6 +24,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm-arch-hooks.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/elf-randomize.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -720,6 +721,20 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
+		/*
+		 * Caller is happy with a different address, so let's
+		 * move even if not necessary!
+		 */
+		new_addr = arch_mmap_rnd();
+
+		ret = mremap_to(addr, old_len, new_addr, new_len,
+				&locked, flags, &uf, &uf_unmap_early,
+				&uf_unmap);
+		goto out;
+	}
+
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.28.0

