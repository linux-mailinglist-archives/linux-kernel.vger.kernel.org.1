Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257B0301BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbhAXMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbhAXMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:16:37 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6FC061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 04:15:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DNsQx5SSgz9sVr;
        Sun, 24 Jan 2021 23:15:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1611490553;
        bh=5I29EgT4xN799chPfGNVThEwYnGxWyw8FVeDGXWCQDw=;
        h=From:To:Cc:Subject:Date:From;
        b=eu+/sMz+m6sIQIi8QHPBaEi0FnEGB5nH+yj8q2mVjgvsonfEM5SVowDd3b4TvMlLo
         /oCBGN0byNTACb8YPMpcnJV48HAHnpY4VS2KWgue93yqX6qELN8m20PLMDnmN5PH69
         SDU3M4wl2W3q8sXtXkUsQKDvVJdTk+fhbD53bZrw/75vJUwmH2PxegecIj8h20ccsl
         ovlmqPB25TaaV3IvrlGpA2xkkPFUsi7uNOWjyoGSN7XjnLmAqvAbJAC1s9rcTH9OeA
         Iw1HBvYdSSGL3pIYHBhcGeVY6u1Kkr/L78zaOeiIk862ghmPukfGM0qO68IZJ47p30
         JGz0Lxq3WFVKg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, sandipan@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-5 tag
Date:   Sun, 24 Jan 2021 23:15:52 +1100
Message-ID: <87tur6pm2v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.11:

The following changes since commit 41131a5e54ae7ba5a2bb8d7b30d1818b3f5b13d2:

  powerpc/vdso: Fix clock_gettime_fallback for vdso32 (2021-01-14 15:56:44 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-5

for you to fetch changes up to 08685be7761d69914f08c3d6211c543a385a5b9c:

  powerpc/64s: fix scv entry fallback flush vs interrupt (2021-01-20 15:58:19 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.11 #5

Fix a bad interaction between the scv handling and the fallback L1D flush, which
could lead to user register corruption. Only affects people using scv (~no one)
on machines with old firmware that are missing the L1D flush.

Two small selftest fixes.

Thanks to Eirik Fuller, Libor Pechacek, Nicholas Piggin, Sandipan Das, Tulio
Magno Quites Machado Filho.

- ------------------------------------------------------------------
Michael Ellerman (1):
      selftests/powerpc: Only test lwm/stmw on big endian

Nicholas Piggin (1):
      powerpc/64s: fix scv entry fallback flush vs interrupt

Sandipan Das (1):
      selftests/powerpc: Fix exit status of pkey tests


 arch/powerpc/include/asm/exception-64s.h                      | 13 +++++++++++
 arch/powerpc/include/asm/feature-fixups.h                     | 10 ++++++++
 arch/powerpc/kernel/entry_64.S                                |  2 +-
 arch/powerpc/kernel/exceptions-64s.S                          | 19 ++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S                             |  7 ++++++
 arch/powerpc/lib/feature-fixups.c                             | 24 +++++++++++++++++---
 tools/testing/selftests/powerpc/alignment/alignment_handler.c |  5 +++-
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c           |  2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c             |  2 +-
 9 files changed, 77 insertions(+), 7 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmANYaoACgkQUevqPMjh
pYDyFRAAqwsxxbbCe+AlggURQi7nap5JL4qHV0bEYPR34IEIPs9blDOb5ECQNbNt
fbxDK9y3ij5ceETsdzM6d3gkocBo/O8JMa9scfmHNFpQLWQk013MUg3YJQnycDkE
vpmaXPMdkcZv82VXdYe4DonhlS3FBTpbL1jPVZn6KIJGpiWfuS7vgptLeBqtMMZz
Mz4lAkzMKbSw/NmKe+Iq3Rc8zsw4C6gXPIhkNsD32s5U+lVMKLpFpxtwhxcGFxDy
sTUBWXJn+mW4+XJVNHQOvLN3gTPNgEcg2xoKkQiwB5/y+GKgPco24Ep6bUalYfNG
dViUAEgzpyhwTfkBxwwV8bpxSaw9HAQRjVC18QJ7sLM+ogHEJm7ejipAOmAfAzuf
+BwQgkSZ2I/peJJDNvVjC3vRIDl29LEA73ZORcp4ynDP/cKuhgvaYBTPCVCzcc0r
+bPXFEfS0OofLBkLekHIdSRfCLQjmQF/TB3CVkDAlDKjiMwTJk/khTn0+0RD6DRK
i/iBkCXjOBuizXkIzRUAit6YMMoO6Yt/nuyrPhDetBFpMPmZgAuLZCs1UI+qUR/L
lS4jOSUQnZqLXsDJqT7uUIdaWZPODdV1U8XEl1+C9xAZ5A4Juy9fFr2K91OtBa2e
/45tUCpDCmtt5aXZXWgwghJeQteBI0Ng5U4NH0asH2W8oVDFyRM=
=f+xY
-----END PGP SIGNATURE-----
