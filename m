Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482B4268F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgINPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:11:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgINPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:10:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF34B1FB;
        Mon, 14 Sep 2020 08:10:34 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC77D3F718;
        Mon, 14 Sep 2020 08:10:33 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.indradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/14] Optimise and update memcpy, user copy and string routines 
Date:   Mon, 14 Sep 2020 15:09:44 +0000
Message-Id: <20200914150958.2200-1-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In this version the backtracking fixups are replaced with a two-stage
approach that maintains the accuracy in v4 and still uses the fault address,
but provides a copy-routine-independent mechanism for determining the fault
address.

The same constraints on the fixup routine (the available information being
src,dst,count,faddr) are used here, but in a more straightforward way that
could allow the copy template to be re-used with the new optimized copy
routines, and for the fixups to also apply to future copy routines.

There is a secondary in-order copy invoked which is expected to fault, and
this is byte-wise to provide the second fixup with the exact fault address,
which helps to avoid the need to special-case fixups for unprivileged
load/store accesses.

This alternative came about shortly after posting v4 and builds on a
discussion between Robin and I regarding a new idea for a cleaner approach
to the fixup routines, and I found some time to prototype it a couple of
weeks ago (previously been busy with moving teams internally and also wanted
to wait for further feedback before re-submitting to avoid excessive
revisions). A solution akin to this was incidentally one of my initial
thoughts but took a different direction as had previously assumed there
would be problems faulting from within a fixup routine (please point out
any issues with this that I may be unaware of - so far it has only been
tested internally on a couple of machines under basic workloads).

In order to provide additional information to the fixup that could reduce
the overhead of the secondary copy for large copy sizes, we also discussed
a potential magnitude N to jump back by from the first fault rather than
initiate from the beginning, on the basis that this is a basic property to
identify in the algorithm and one that could apply to future copy routines
simply by increasing this value. It holds for long copies due to the
cortex-strings implementation effectively copying in an in-order manner in
chunks of 64B (but out-of-order within each chunk). However, I have included
this as a standalone patch as this is based on an assumption about the
algorithm.

I thought that you might consequently like to have a look at v5 in deciding
whether or not to use separate algorithms for in-kernel/uaccess copy routines
(re feedback from v4).

Comments welcome,

Many thanks,
Oli

Changes since v4:
* Replaces the fixup routines in v4, which would require an understanding of
and be subject to change with newer optimizations, with another approach that
provides the same level of accuracy;
* Introduces an intermediate fixup routine that initiates an in-order copy;
* Configures a value to jump back from the fault address by before starting
the copy;
* Adds the additional macros to the copy template to account for the second
fixup, and reduces the total number of new macros initially added;
* Removes the special-case for UAO in the fixup (please see patch 14 in v4)
as this is now handled by the copy template substituting in the unprivileged
variants for the in-order copy, so the same fixups should apply to those
systems without modification;
* Repurpose commit 11 to exclusively check for overlapping buffers in
copy_in_user() calls and return the full width for these cases as it may result
in unusual behaviour, due implementations invoking memmov routines for which the
fixup wouldn't be applicable;
* In the process of rebasing to v5.9-rc4, moves Sam's fixup-offset
implementation in eatable.h to occur after bpf-related checks
* Rephrases commit messages in patches 9-14 for clarity and to reflect the
new changes.

This revision was tested on two machines (UAO & non-UAO) internally using a
custom test module (planning on posting this shortly).

v4: https://lore.kernel.org/linux-arm-kernel/f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com/

Oliver Swede (5):
  arm64: usercopy: Store the arguments on stack
  arm64: usercopy: Check for overlapping buffers in fixup
  arm64: usercopy: Add intermediate fixup routine
  arm64: usercopy: Add conclusive fixup routine
  arm64: usercopy: Reduce overhead in fixup

Robin Murphy (2):
  arm64: kprobes: Drop open-coded exception fixup
  arm64: Tidy up _asm_extable_faultaddr usage

Sam Tebbs (7):
  arm64: Allow passing fault address to fixup handlers
  arm64: Import latest version of Cortex Strings' memcmp
  arm64: Import latest version of Cortex Strings' memmove
  arm64: Import latest version of Cortex Strings' strcmp
  arm64: Import latest version of Cortex Strings' strlen
  arm64: Import latest version of Cortex Strings' strncmp
  arm64: Import latest optimization of memcpy

 arch/arm64/include/asm/alternative.h |  36 ---
 arch/arm64/include/asm/assembler.h   |  13 +
 arch/arm64/include/asm/extable.h     |  11 +-
 arch/arm64/kernel/probes/kprobes.c   |   7 -
 arch/arm64/lib/copy_from_user.S      | 117 +++++++--
 arch/arm64/lib/copy_in_user.S        | 122 +++++++--
 arch/arm64/lib/copy_template.S       | 375 +++++++++++++++------------
 arch/arm64/lib/copy_template_user.S  |  32 +++
 arch/arm64/lib/copy_to_user.S        | 118 +++++++--
 arch/arm64/lib/copy_user_fixup.S     |  94 +++++++
 arch/arm64/lib/memcmp.S              | 333 +++++++++---------------
 arch/arm64/lib/memcpy.S              |  47 ++--
 arch/arm64/lib/memmove.S             | 232 ++++++-----------
 arch/arm64/lib/strcmp.S              | 272 ++++++++-----------
 arch/arm64/lib/strlen.S              | 247 ++++++++++++------
 arch/arm64/lib/strncmp.S             | 363 ++++++++++++--------------
 arch/arm64/mm/extable.c              |  27 +-
 arch/arm64/mm/fault.c                |   2 +-
 18 files changed, 1323 insertions(+), 1125 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template_user.S
 create mode 100644 arch/arm64/lib/copy_user_fixup.S

-- 
2.17.1

