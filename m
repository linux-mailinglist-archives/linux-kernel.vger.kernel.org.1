Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D80244A06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHNM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 08:56:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:56:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSk2Z3KXkz9sTQ;
        Fri, 14 Aug 2020 22:56:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1597409767;
        bh=bogzDs0eFlK9z17SgplhUpIaznIoXiLERASJ9R6Xlzc=;
        h=From:To:Cc:Subject:Date:From;
        b=RZhdiK1WUFC6v9LI3nKxMo+BGaO9Axqm+Z+u2H/hMWvE2pbVZsResCNCziDBRUZuO
         lZGAYGgiLxgKyvV6kyLIoPfwgZ+xtlitSzN4aGJzAP8NhaMM/kOPYOQVIHHoO85mu3
         zAfhox0nvoFd76EEAvmAjjYfGCs9Hgi/JOkjPwqVm2zVkDArAhzN0XfHTQ7PuCm+SR
         BMR5etLd+GuBlYepUF+bEVqg9kyPdaKY+KDorMNJrwvMKHeMbHl6L+hoiGwE0qAV8Y
         jkUh7GKVqOQt1nzCgctCa/eh3djXnsH5joP1y/L0JHl4sspj1uMWS7AsncWwzR9kmF
         thau5OFCN0Hiw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-2 tag
Date:   Fri, 14 Aug 2020 22:56:04 +1000
Message-ID: <87ft8p9yjf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull a powerpc fix for 5.9:

The following changes since commit 7b9de97711225559af213dc52b6ea883ef1ea7a8:

  powerpc/ptrace: Fix build error in pkey_get() (2020-08-07 18:27:26 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-2

for you to fetch changes up to 6553fb799f601497ca0703682e2aff131197dc5c:

  powerpc/pkeys: Fix boot failures with Nemo board (A-EON AmigaOne X1000) (2020-08-10 23:07:21 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.9 #2

One fix for a boot crash on some platforms introduced by the recent pkey
refactoring.

Thanks to:
  Christian Zigotzky, Aneesh Kumar K.V.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/pkeys: Fix boot failures with Nemo board (A-EON AmigaOne X1000)


 arch/powerpc/mm/book3s64/hash_utils.c |  5 ++---
 arch/powerpc/mm/book3s64/pkeys.c      | 12 ++++++------
 2 files changed, 8 insertions(+), 9 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl82iYIACgkQUevqPMjh
pYAlBQ/7BXZI6UMWb9QS4QDu3CaBEEmVtnOnHmN1OsLnyjWArf+MLkipuoEiNeBc
bZIr7Zah2tE4/ZpOEaELu4Vgr+AAk2HGzRw19eYHMewgjfdO1n1jmORrGnfECkKL
0ygQv/g7rKTpSDoK3qNT0n0BRMCzmdlzsdhE9Oj4gMSTy+ThJnakS7Js79aqHaFz
obZbytwDDE2jSoKl4T+AlokDDiXpUm9OXIxSuyzGSrljm/vwQxGI7TH7IjZUwE9v
rPtxPJyvEkmXa4cVrTrY7AxP3yMvoJTd4EMISxtrqKSghSpVjAmm0Ie2fa6+8yCB
aI7nRp4fIoTKr8o7rjBwraNNQejq8aFE/EHBKPamgZ7F+yNqenNJREjPTJpC2RKF
N33aX6hqK2vuL2KRN5KPAaSDys1TsMot0Xlghvu/hzopVGGnNkP03jBLT6uFk1aD
tEW3ZModf/SJoXb88Y5+oWvgSbzheWv+DlnfLKZ5Uvuf/dOlUWOmcElC/rD99SMz
IFEW3XarOcMBcpFLF1+ZTCRzgkmYyLyJh3mK/4ykxm8XP9bi8Yv3VqPEEUk4tPWj
BUoviQHDgJ8TUgkAqmecJQDi0iYmQwUe3CfQb8FB5k7itQawWuK+exdqZhJpbPLO
mdM8+/RyjPfYSRvrtBRcWOAkxGrzC/eT7eLAEwQFIYhLDJL2rYI=
=Rgq5
-----END PGP SIGNATURE-----
