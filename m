Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AA297BF4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761070AbgJXKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 06:50:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758400AbgJXKuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 06:50:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CJHtk2PFBz9sV0;
        Sat, 24 Oct 2020 21:50:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603536623;
        bh=futRN9+C9/VUFQoIxDl1M1NHrkygM2MfKid/iDdusPM=;
        h=From:To:Cc:Subject:Date:From;
        b=h1bbSPWlgE9sfQnrTURDeWhd4Hpc6xe2uSYYMVjKBreNFyFIZtgMVifk/jWlmJMOW
         rkmau2+wp/85KWciIbnUDJ58nRNGsKmAz83b9EgX2b6GzzwK8zSKSpRU0ybH1O1pjn
         XcFenP3nnhoz/gq1piCOWkbdG0L2owEOxDqiOT3aGEk74Xg/irbNnl9oJOS5jwgOPt
         9g21JQwejXpvAVwvOJln0GIRYii31jeu6QWdYkvMHNUCvu1L1oNwdgVbCscBV6BHrZ
         SW6x6LP1jJ8FDbf/cKGbVto5Qej0X1B21yy1aYS7rYdhsfMfuQHUzLx26jva9bQEWm
         o3LZbJHXJoXwA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        ganeshgr@linux.ibm.com, hegdevasant@linux.vnet.ibm.com,
        jniethe5@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, oohall@gmail.com,
        segher@kernel.crashing.org, srikar@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-2 tag
Date:   Sat, 24 Oct 2020 21:50:21 +1100
Message-ID: <871rhnyk2a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 5.10:

The following changes since commit ffd0b25ca049a477cb757e5bcf2d5e1664d12e5d:

  Revert "powerpc/pci: unmap legacy INTx interrupts when a PHB is removed" (2020-10-15 13:42:49 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-2

for you to fetch changes up to 4ff753feab021242144818b9a3ba011238218145:

  powerpc/pseries: Avoid using addr_to_pfn in real mode (2020-10-22 14:34:45 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.10 #2

A fix for undetected data corruption on Power9 Nimbus <= DD2.1 in the emulation
of VSX loads. The affected CPUs were not widely available.

Two fixes for machine check handling in guests under PowerVM.

A fix for our recent changes to SMP setup, when CONFIG_CPUMASK_OFFSTACK=y.

Three fixes for races in the handling of some of our powernv sysfs attributes.

One change to remove TM from the set of Power10 CPU features.

A couple of other minor fixes.

Thanks to:
  Aneesh Kumar K.V, Christophe Leroy, Ganesh Goudar, Jordan Niethe, Mahesh
  Salgaonkar, Michael Neuling, Oliver O'Halloran, Qian Cai, Srikar Dronamraju,
  Vasant Hegde.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/opal_elog: Handle multiple writes to ack attribute

Christophe Leroy (1):
      powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9

Ganesh Goudar (2):
      powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash
      powerpc/pseries: Avoid using addr_to_pfn in real mode

Jordan Niethe (1):
      powerpc/64s: Remove TM from Power10 features

Michael Neuling (2):
      powerpc: Fix undetected data corruption with P9N DD2.1 VSX CI load emulation
      selftests/powerpc: Make alignment handler test P9N DD2.1 vector CI load workaround

Oliver O'Halloran (1):
      powerpc/eeh: Fix eeh_dev_check_failure() for PE#0

Srikar Dronamraju (2):
      powerpc/smp: Remove unnecessary variable
      powerpc/smp: Use GFP_ATOMIC while allocating tmp mask

Vasant Hegde (2):
      powerpc/powernv/dump: Fix race while processing OPAL dump
      powerpc/powernv/dump: Handle multiple writes to ack attribute


 arch/powerpc/include/asm/asm-const.h                          |  13 +++
 arch/powerpc/include/asm/cputable.h                           |   2 +-
 arch/powerpc/include/asm/uaccess.h                            |   4 +-
 arch/powerpc/kernel/cputable.c                                |  13 ++-
 arch/powerpc/kernel/eeh.c                                     |   5 -
 arch/powerpc/kernel/mce.c                                     |   7 +-
 arch/powerpc/kernel/smp.c                                     |  70 ++++++------
 arch/powerpc/kernel/traps.c                                   |   2 +-
 arch/powerpc/platforms/powernv/opal-dump.c                    |  52 ++++++---
 arch/powerpc/platforms/powernv/opal-elog.c                    |  11 +-
 arch/powerpc/platforms/pseries/ras.c                          | 118 ++++++++++++--------
 tools/testing/selftests/powerpc/alignment/alignment_handler.c |   8 +-
 12 files changed, 185 insertions(+), 120 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl+UBeUACgkQUevqPMjh
pYBHUA//THLt6DJlSPPqn8LQZQGT76Gx82cKyy9DQ7/Elcl13xcuq3XbhHD5asi0
QbJGbLhRqpRhtmj3c8BCYAygi5FXZWH4IeN6FK8xoZGR2bi/gY7VkhIUSzFAHnRi
PFXafzb8eWVS7O5k8xbxrjxdOAu8SjEzywG5I8PPn5IWFwhUwjGosv81QtxJOLVc
V9WwuTBK87nfvoMdfcl3YJXRs+4vKOQQ0Gqa5vTVTUmgdbJOqJi1MvLULnSnKxTJ
G+XplOeSI1N3gk+E2cycPasghTYziTtzEyrTHe0Uufgx+9t6VuN1g2zL81kDA7U9
10Oqqry4Z66V2BhGrDMnXKYGeQNGRO8vNLT2DuuZd5XTN/LpV0knJHm/9F2E+5zl
T+GgQwS0IhXDcbS70TcbxXHPyBe2/eXRH1+rkSlAEjl656JVbKefgi1VUsqSzkjH
JBF2+zCodYelbbnRP89Aj5/03t+VeHbNC/1jixoYDHR7drXiU2XQqjfFZeCHvxOQ
YCznpoC84gcDupGC5q4op3tHBmvULJn0KaHYWryaAEWlCxjdVcjBis48B+GQVww8
JnDMC5WGVvAAxPHc74EkyEvdROx4Q+8UeOj+TXnrRlowEF8Wymxcvy7NUn2Bqq2J
VsRCUzLIReKCckdJQ/+SxG8eb9JUxQRWG76+Q9zzTHbdaBSWuMc=
=9Oxg
-----END PGP SIGNATURE-----
