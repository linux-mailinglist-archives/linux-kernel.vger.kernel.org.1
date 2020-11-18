Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775B92B7F03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgKROEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:04:33 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59385 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKROEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:04:32 -0500
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 80CD0200004;
        Wed, 18 Nov 2020 14:04:27 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 271D772214948; Wed, 18 Nov 2020 15:04:27 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:04:27 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: [PATCH] x86/msr: Filter MSR writes
Message-ID: <20201118140427.GA213447@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
 <20201118090929.GC189743@weirdfishes>
 <20201118115027.GF7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118115027.GF7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:50:27PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 10:09:29AM +0100, Mathieu Chouquet-Stringer wrote:
> > Speaking of doc, looking at the patches you submitted, I didn't see any
> > update to the documentation. Would you like me to create a patch for
> > that?
> 
> Sure, that would be appreciated.

Here you go, let me know if I got that right...

---
TAINT_CPU_OUT_OF_SPEC now means what it says. Historically it was for
SMP kernel oops on an officially SMP incapable processor but now it also
covers CPUs whose MSRs have been incorrectly poked at. Update
documentation and script to reflect that.

Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
---
 Documentation/admin-guide/tainted-kernels.rst | 11 ++++++-----
 tools/debugging/kernel-chktaint               |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f718a2eaf1f6..95f432c43ba0 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -84,7 +84,7 @@ Bit  Log  Number  Reason that got the kernel tainted
 ===  ===  ======  ========================================================
   0  G/P       1  proprietary module was loaded
   1  _/F       2  module was force loaded
-  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
+  2  _/S       4  kernel running on out of spec processor
   3  _/R       8  module was force unloaded
   4  _/M      16  processor reported a Machine Check Exception (MCE)
   5  _/B      32  bad page referenced or some unexpected page flags
@@ -116,10 +116,11 @@ More detailed explanation for tainting
  1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
      modules were loaded normally.
 
- 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
-     hasn't been certified as safe to run multiprocessor.
-     Currently this occurs only on various Athlons that are not
-     SMP capable.
+ 2)  ``S`` if the kernel is running on any processor that is out of
+     specifications (writing to MSRs will trigger this behavior).
+     Historically, it could also be if an oops occured on a kernel running on
+     hardware that hasn't been certified as safe to run multiprocessor, such
+     as various Athlons that are not SMP capable.
 
  3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..0b9d93e27910 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -72,7 +72,7 @@ if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
 else
 	addout "S"
-	echo " * SMP kernel oops on an officially SMP incapable processor (#2)"
+	echo " * kernel running on out of spec processor (#2)"
 fi
 
 T=`expr $T / 2`
