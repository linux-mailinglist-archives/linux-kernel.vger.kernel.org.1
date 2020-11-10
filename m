Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAA2ACE93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgKJEip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgKJEip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:38:45 -0500
X-Greylist: delayed 3672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Nov 2020 20:38:45 PST
Received: from elastic.org (elastic.org [IPv6:2600:3c03::f03c:91ff:fe50:73f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elastic.org
        ; s=default2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fXOYkOMo4y/NtxCAzrvn6mJQrwSi0IlwJJUDchbfqe4=; b=HbQbE0ZdVJtYbvJRtoGXq0QRyf
        aFAWJc33pgamTICovlVhcZwXnETvXLdBIvmjijhx2LdMgVzeEadGLN016kI+M6x3lKlTi/W1acr0J
        IX3gWkuRUMDk/tcCua8TJSOAhbzChjpfMOt9KLdZNQ2ukk4AkRfgz9BRcSYKlOyIKyFcg/FDrM2VC
        YSxpEw7WkO6UKSSPNFdkB/spDFlcjDXemwruxJj9gbJOqTGY5W4144SyWIdBxIXGK9uGqjQA/LQJX
        4TdXsmf5IuaNY9yVmOC1nuqzN0Djk/nuXx8Sm52WB/Tq6C1XuBi8pDfo08Ls2Bz+IvDllG8VK56rS
        YfUEFTeQ==;
Received: from vpn-home.elastic.org ([10.0.0.2] helo=elastic.org)
        by elastic.org with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <fche@elastic.org>)
        id 1kcKTL-0000Wq-Fc; Tue, 10 Nov 2020 03:37:31 +0000
Received: from fche by elastic.org with local (Exim 4.94)
        (envelope-from <fche@elastic.org>)
        id 1kcKTK-0000gM-QH; Mon, 09 Nov 2020 22:37:30 -0500
Date:   Mon, 9 Nov 2020 22:37:30 -0500
From:   "Frank Ch. Eigler" <fche@elastic.org>
To:     systemtap@sourceware.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap release 4.4
Message-ID: <20201110033730.GB87630@elastic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Sender-Verification: ""
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.4

Enhancements to this release include: significant performance and
stability improvements to user-space probing, implicit thread-local
storage variables can now be accessed on x86_64, ppc and s390, support
for processing floating point values, significantly improved
concurrency for scripts using global variables via shortened critical
sections, new syntax for defining aliases with both a prologue and
epilogue, new @probewrite predicate and syscall arguments are writable
again

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.4 (commit 988f439af39a)

  There have been over 135 commits since the last release.
  There have been 25+ bugs fixed / features added since the last release.

= SystemTap frontend (stap) changes

- New syntax for defining aliases with both a prologue and an epilogue:
  'probe ALIAS = PROBE { <prologue> }, { <epilogue> }' 

- New @probewrite predicate. @probewrite(var) returns 1 if var has been 
  written to in the probe handler body and 0 otherwise. The check can
  only be used with probes that have an epilogue or prologue.

- Implicit thread local storage variables can now be accessed on
  x86_64, ppc, and s390.

= SystemTap backend changes

- Various performance and stability improvements to user-space probing.
  This includes replacing spinlocks with RCU locks in vma map and utrace
  task's hash table lookups which reduces CPU time a lot when there are
  a lot of target processes and vma tracker or task finder is enabled.
  Also increased the default hash table sizes to reduce hash conflicts.
  Special thanks to Yichun Zhang and Sultan Alsawaf for these contributions.

- The locks required to protect concurrent access to global variables
  has been optimized with a "pushdown" algorithm, so that they span 
  the smallest possible critical region.  Formerly, and with 
  --compatible=4.3, locks always spanned the entire probe handler.
  Lock pushdown means much greater potential concurrency between
  probes running on different CPUs.
                                     
- Systemtap now supports kernel-lockdown configurations that disable
  debugfs, by instead using procfs to carry relayfs transport files.

= SystemTap tapset changes

- Systemtap now supports extracting 64-bit floating point and stored
  in long type.  Also basic floating point arithmetic and comparison
  functions are provided in a tapset.  More automated syntax coming
  soon.  e.g.:
    probe process.function("foo") {
        fp = user_long(& $fp_variable)
        println (fp_to_string (fp_add (string_to_fp("3.14"), fp)))
    }

- Make syscall arguments writable again in non-DWARF probes on kernels
  that use syscall wrappers to pass arguments via pt_regs (currently
  x86_64 4.17+ and aarch64 4.19+). For example, the following probe
  adds rwx user permissions to any directory made by the process
  specified by stap -c:
  
    probe nd_syscall.mkdir {
      if (pid() == target())
        mode |= 0700
    }

= SystemTap sample scripts

- All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- New sample scripts:

  floatingpoint.stp	Extract a floating point value from a process and
			print the results of various simple floating point
			operations

- The following sample scripts have been enabled to run on the stapbpf backend:

  general/sizeof.stp
  memory/overcommit.stp

= Examples of tested kernel versions 

  2.6.32 (RHEL6 x86_64)
  3.10.0 (RHEL7 x86_64)
  4.15.0 (Ubuntu 18.04 x86_64)
  4.18.0 (RHEL8 x86_64, aarch64, ppc64le, s390x)
  5.3.8  (Fedora 30 i686)
  5.8.16 (Fedora 32 x86_64)
  5.8.18 (Fedora 33 x86_64)
  5.9.0-rc7   (Fedora rawhide x86_64)
  5.10.0-rc1  (Fedora rawhide x86_64)

= Known issues with this release

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT (see PR26811).

- An sdt probe cannot parse a parameter that uses a segment register.
  (PR13429)

- The presence of a line such as
      *CFLAGS += $(call cc-option, -fno-var-tracking-assignments)
  in the linux kernel Makefile unnecessarily reduces debuginfo quality,
  consider removing that line if you build kernels.

= Contributors for this release

Aaron Merey, Alice Zhang, Craig Ringer, Frank Ch. Eigler, Martin Cermak,
Sagar Patel, Sergei Trofimovich*, Serhei Makarov, Stan Cox, Sultan Alsawaf*,
Thorsten Glaser*, William Cohen, Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.
Special thanks to Aaron Merey for drafting these notes.

= Bugs fixed for this release <https://sourceware.org/PR#####>

10013 Support ENABLED sdt probe macro
12663 statement probes on inlined-function-call sites: search .debug_line PLUS .debug_info
13838 floating point $var support
14013 Access to user space thread local variables (errno)
14765 jvm crashes when specifying --runtime=dyninst
24954 stapdyn on ppc/aarch64 do not support full register set
25549 Systemtap unable to find many probe points available in code compiled with LTO enable
26015 make syscall arguments symbol-writeable again
26123 Use of VMA tracker would leak kernel slab memory for modern kernels without CONFIG_UTRACE
26131 Relay flushing results in garbled output data being read by staprun
26142 Kernel module compilation fails for the latest Fedora Rawhide x64
26181 tapset/linux/nfs_proc.stp needs update
26249 uconversions format error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘void *’ 
26296 delay script-global locking until required
26307 kernel commit ed66f991bb19 breaks module initialization
26379 stap -p4 systemtap.examples/network/nfsd-trace.stp fails
26392 The optimizer would generate inefficient code which always evaluate dwarf ops eagerly
26511 PR18115 + PR11353 + PR26296 = build error
26567 systemtap-mode uses obsolete common lisp emulation
26658 restore onboot capability via /usr/bin/kernel-install
26660 probe kernel.statement(HEX).absolute incorrectly requires kernel debuginfo
26665 secureboot stap-server matching breaks if non-stap MOK is already enrolled
26673 The kernel backtrace dumper should not use stack array which may lead to compilation errors
26697 NULL pointer dereference might happen in get_utrace_lock()
26846 task_finder2: kernel panics by due to unreliable in_atomic() usage
