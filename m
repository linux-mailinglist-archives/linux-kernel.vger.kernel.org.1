Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF522D6CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgLKAvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394682AbgLKAuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:50:52 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7832E23DB4;
        Fri, 11 Dec 2020 00:50:11 +0000 (UTC)
Date:   Thu, 10 Dec 2020 19:50:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Libo Chen <libo.chen@oracle.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [GIT PULL] ktest.pl: Fix incorrect reboot for grub2bls
Message-ID: <20201210195009.2a06b3ef@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Fix issues with grub2bls in ktest.pl

ktest.pl does not know about grub2bls that was introduced in Fedora 30,
and now it does.


Please pull the latest ktest-v5.10-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.10-rc6

Tag SHA1: 5df55c97b33392ad11775afce8d327736de49fba
Head SHA1: 271e0c9dce1b02a825b3cc1a7aa1fab7c381d44b


Libo Chen (1):
      ktest.pl: Fix incorrect reboot for grub2bls

----
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 271e0c9dce1b02a825b3cc1a7aa1fab7c381d44b
Author: Libo Chen <libo.chen@oracle.com>
Date:   Fri Nov 20 18:12:43 2020 -0800

    ktest.pl: Fix incorrect reboot for grub2bls
    
    This issue was first noticed when I was testing different kernels on
    Oracle Linux 8 which as Fedora 30+ adopts BLS as default. Even though a
    kernel entry was added successfully and the index of that kernel entry was
    retrieved correctly, ktest still wouldn't reboot the system into
    user-specified kernel.
    
    The bug was spotted in subroutine reboot_to where the if-statement never
    checks for REBOOT_TYPE "grub2bls", therefore the desired entry will not be
    set for the next boot.
    
    Add a check for "grub2bls" so that $grub_reboot $grub_number can
    be run before a reboot if REBOOT_TYPE is "grub2bls" then we can boot to
    the correct kernel.
    
    Link: https://lkml.kernel.org/r/20201121021243.1532477-1-libo.chen@oracle.com
    
    Cc: stable@vger.kernel.org
    Fixes: ac2466456eaa ("ktest: introduce grub2bls REBOOT_TYPE option")
    Signed-off-by: Libo Chen <libo.chen@oracle.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index cb16d2aac51c..54188ee16c48 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2040,7 +2040,7 @@ sub reboot_to {
 
     if ($reboot_type eq "grub") {
 	run_ssh "'(echo \"savedefault --default=$grub_number --once\" | grub --batch)'";
-    } elsif ($reboot_type eq "grub2") {
+    } elsif (($reboot_type eq "grub2") or ($reboot_type eq "grub2bls")) {
 	run_ssh "$grub_reboot $grub_number";
     } elsif ($reboot_type eq "syslinux") {
 	run_ssh "$syslinux --once \\\"$syslinux_label\\\" $syslinux_path";
