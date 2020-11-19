Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060F2B9070
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKSKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:53:50 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52073 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKSKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:53:49 -0500
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4292D240010;
        Thu, 19 Nov 2020 10:53:44 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id B801872214948; Thu, 19 Nov 2020 11:53:44 +0100 (CET)
Date:   Thu, 19 Nov 2020 11:53:44 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] x86/msr: Filter MSR writes
Message-ID: <20201119105344.GA434279@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
References: <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
 <20201118090929.GC189743@weirdfishes>
 <20201118115027.GF7472@zn.tnic>
 <20201118140427.GA213447@weirdfishes>
 <20201118175048.GK7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175048.GK7472@zn.tnic>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:50:48PM +0100, Borislav Petkov wrote:
> Please fix the text in Documentation/admin-guide/sysctl/kernel.rst also.

Done.

> People might wonder what "out of specifications" means. I'd say
> something along the lines of "the CPU has been put into a not supported
> configuration, therefore proper execution cannot be guaranteed". Grep
> the tree for TAINT_CPU_OUT_OF_SPEC to see when this gets set, might give
> you a better idea of what to say.

Did the grep thing and it showed it's not just a CPU thing as drivers
can also set that flag hence why I use "system" instead of CPU now.

> And here you can expand on the examples by saying that poking at random
> MSRs from userspace is one possible way to mis-configure it.

I added almost all examples I found to the documentation.

> Yeah, can you think of a better formulation than "out of spec
> processor"?
> 
> The CPU is fine, only its current configuration is not.

Given it can be something else than just a CPU thing which tainted the
kernel, I use out of spec system as there are too many cases to have a
clear simple short definition. I mean I've yet to find a better explanation...

So what about that patch?

---
TAINT_CPU_OUT_OF_SPEC now means what a bit more than what it implies as
the flag isn't set just because of a CPU misconfiguration or mismatch.
Historically it was for SMP kernel oops on an officially SMP incapable
processor but now it also covers CPUs whose MSRs have been incorrectly
poked at from userspace, drivers being used on non supported
architectures, broken firmware, mismatched CPUs, ...

Update documentation and script to reflect that.

Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
---
 Documentation/admin-guide/sysctl/kernel.rst   |  2 +-
 Documentation/admin-guide/tainted-kernels.rst | 22 +++++++++++++++++-----
 tools/debugging/kernel-chktaint               |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)


diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..edd89e2d3af7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1336,7 +1336,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
 ======  =====  ==============================================================
      1  `(P)`  proprietary module was loaded
      2  `(F)`  module was force loaded
-     4  `(S)`  SMP kernel oops on an officially SMP incapable processor
+     4  `(S)`  kernel running on an out of specification system
      8  `(R)`  module was force unloaded
     16  `(M)`  processor reported a Machine Check Exception (MCE)
     32  `(B)`  bad page referenced or some unexpected page flags
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f718a2eaf1f6..5737dfa17cd1 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -84,7 +84,7 @@ Bit  Log  Number  Reason that got the kernel tainted
 ===  ===  ======  ========================================================
   0  G/P       1  proprietary module was loaded
   1  _/F       2  module was force loaded
-  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
+  2  _/S       4  kernel running on an out of specification system
   3  _/R       8  module was force unloaded
   4  _/M      16  processor reported a Machine Check Exception (MCE)
   5  _/B      32  bad page referenced or some unexpected page flags
@@ -116,10 +116,22 @@ More detailed explanation for tainting
  1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
      modules were loaded normally.
 
- 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
-     hasn't been certified as safe to run multiprocessor.
-     Currently this occurs only on various Athlons that are not
-     SMP capable.
+ 2)  ``S`` if the kernel is running on a processor or system that is out of
+     specification: hardware has been put into an unsupported configuration,
+     therefore proper execution cannot be guaranteed.
+     Kernel will be tainted for example if:
+
+     - on x86: you force PAE on intel CPUs, you run a SMP kernel on non
+       officially capable SMP Athlon CPUs, you poke at random MSRs from
+       userspace.
+     - on arm: you run a kernel on certain CPUs (such as Keystone 2) without
+       having certain kernel features enabled.
+     - on arm64: you have mismatched hardware features between CPUs, the
+       bootloader has booted CPUs in different modes.
+     - you use certain drivers on non supported architectures (such as
+       scsi/snic on something else than x86_64, scsi/ips on non
+       x86/x86_64/itanium, have broken firmware settings for the
+       irqchip/irq-gic on arm64 ...).
 
  3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..607b2b280945 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -72,7 +72,7 @@ if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
 else
 	addout "S"
-	echo " * SMP kernel oops on an officially SMP incapable processor (#2)"
+	echo " * kernel running on an out of specification system (#2)"
 fi
 
 T=`expr $T / 2`
