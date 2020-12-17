Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC12DD2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgLQOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgLQOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:21:08 -0500
Date:   Thu, 17 Dec 2020 15:20:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608214827;
        bh=m2pqAub9e3jm+t7rOT5d+cVkmAc4UUU8rn/uGWbiZVI=;
        h=From:To:Cc:Subject:From;
        b=Rto5tdOSaelgG9X4QSfEqOo0/LIYdRpE8fXUO1IkUrDmyLyG3vPnHbCHEz+Au3Igf
         mtDeRaFmpl1iqK3K6eRptN+PCY8Zge9BaYTF/KxNoZLv7TH2eEVp1BmP1J13E2x5gj
         JOVer9v81ScDUR2drq7qYIQcieyjeiSDnnc9Ub36vgU2cIHLs7Cs/OqGC/NNoEVM3X
         kwMktDBbVK1j8oU8GPqQRDvrZJ919/8FbkbwDcb+/pjJrUp0aedxVOiXTMCy0osCnr
         hgOeaJ34vU9A5bH7q/kfOye8QNFI0ujrtBzfvx1KKwD7efg475aWU+5oLveaJV/v+0
         kJ6mOF48V4hEw==
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.11
Message-ID: <20201217142020.GA19116@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.11 merge window.
A summary can be found in the signed tag.

Thank you,

Jessica

---
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/ tags/modules-for-v5.11

for you to fetch changes up to 38dc717e97153e46375ee21797aa54777e5498f3:

  module: delay kobject uevent until after module init call (2020-12-09 09:42:47 +0100)

----------------------------------------------------------------
Modules updates for v5.11

Summary of modules changes for the 5.11 merge window:

- Fix a race condition between systemd/udev and the module loader.
  The module loader was sending a uevent before the module was fully
  initialized (i.e., before its init function has been called). This means
  udev can start processing the module uevent before the module has
  finished initializing, and some udev rules expect that the module has
  initialized already upon receiving the uevent. This resulted in some
  systemd mount units failing if udev processes the event faster than the
  module can finish init. This is fixed by delaying the uevent until after
  the module has called its init routine.

- Make the linker array sections for kernel params and module version
  attributes more robust by switching to use the alignment of the type in
  question. Namely, linker section arrays will be constructed using the
  alignment required by the struct (using __alignof__()) as opposed to a
  specific value such as sizeof(void *) or sizeof(long). This is less
  likely to cause breakages should the size of the type ever change (from
  Johan Hovold)

- Fix module state inconsistency by setting it back to GOING when a module
  fails to load and is on its way out (from Miroslav Benes)

- Some comment and code cleanups (from Sergey Shtylyov)

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
      module: delay kobject uevent until after module init call

Johan Hovold (7):
      module: drop version-attribute alignment
      module: simplify version-attribute handling
      params: drop redundant "unused" attributes
      params: use type alignment for kernel parameters
      params: clean up module-param macros
      init: use type alignment for kernel parameters
      module: drop semicolon from version macro

Miroslav Benes (1):
      module: set MODULE_STATE_GOING state when a module fails to load

Sergey Shtylyov (6):
      module: merge repetitive strings in module_sig_check()
      module: avoid *goto*s in module_sig_check()
      module: only handle errors with the *switch* statement in module_sig_check()
      module: fix up 'kernel-doc' comments
      module: add more 'kernel-doc' comments
      module: fix comment style

 include/linux/init.h        |   2 +-
 include/linux/module.h      |  28 +++----
 include/linux/moduleparam.h |  12 +--
 kernel/module.c             | 200 ++++++++++++++++++++++++++------------------
 kernel/params.c             |  10 +--
 5 files changed, 142 insertions(+), 110 deletions(-)
