Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52432F91BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbhAQKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbhAQKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:24:48 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E484BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 02:24:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DJWH85FFPz9sVF;
        Sun, 17 Jan 2021 21:24:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1610879045;
        bh=0EmwnWPG3h6QdX/Idod84V/+amJZC6KEpzuu75oLgmM=;
        h=From:To:Cc:Subject:Date:From;
        b=iph2P3y2oJiuZtmNHM3RGAn9nVr19mbBj8N/X94xgKopIWVLLyJWqjQQZ9wSspKwW
         W5kFcg1hZ3Up+SJxTNi+p7lhXxeO8kGtFOK5X4R7hmab1TTbMCQ+kq32Me+8iwBzo/
         V6PY03NtS5VoH9fNLh+mpt9vSw9bJ+zdDnDJT9yu6vHeKe+2Y2hfcaQxb+8tiyAyiM
         0KsQbIL7cgFfol55GQAE50qfEWJb1A8jpuTtuVRFs/nBHsLPLJCXirLkZi4K6zWhlu
         fPUcNPDU7xgVzSdsfyqgJSdGWnC0hwnwV7tOfPWrou0J+n23Q3nyJgkF+VXwC925Eq
         0nnMk6KofEkxg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arielmarcovitch@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, schwab@linux-m68k.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-4 tag
Date:   Sun, 17 Jan 2021 21:24:00 +1100
Message-ID: <87o8hnn9of.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.11:

The following changes since commit 3ce47d95b7346dcafd9bed3556a8d072cb2b8571:

  powerpc: Handle .text.{hot,unlikely}.* in linker script (2021-01-06 21:59:04 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-4

for you to fetch changes up to 41131a5e54ae7ba5a2bb8d7b30d1818b3f5b13d2:

  powerpc/vdso: Fix clock_gettime_fallback for vdso32 (2021-01-14 15:56:44 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.11 #4

One fix for a lack of alignment in our linker script, that can lead to crashes
depending on configuration etc.

One fix for the 32-bit VDSO after the C VDSO conversion.

Thanks to:
  Andreas Schwab, Ariel Marcovitch, Christophe Leroy.

- ------------------------------------------------------------------
Andreas Schwab (1):
      powerpc/vdso: Fix clock_gettime_fallback for vdso32

Ariel Marcovitch (1):
      powerpc: Fix alignment bug within the init sections


 arch/powerpc/include/asm/vdso/gettimeofday.h | 16 +++++++++++++++-
 arch/powerpc/kernel/vmlinux.lds.S            |  8 ++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmAED74ACgkQUevqPMjh
pYAyFRAAr2/3tLnaJgu8LIkr64AUuNAXsAhTaVb3MEemJtR7FSEK8pJjw/AtQmHh
aTB9Y4qp2kOSQq6C6j4cMitGUYOiDEayCHPP1SserIRVJXmC453jqKb/iHrpaVWo
zBdrqrMzgFhlfT6/IDVw/+e5rjycwp9QicQZ0DRX15ZXlqlMSr1b6VH3opku4DyV
a9OP/LlR6PAgZQn+qTfeB/z7HnwOdy9R5i/UnrALqrzKGOneQXd+jv7THbudMs/D
aVTapfuoon1SPSLWy7xSVKIjFxwV4KUMi0R5kjWlWkXFqdLA2r8XRE3sKcLW1IN1
0Yibv1DRddsnluqe5lclQgzWPfRLdjPhgoIwIq3Ze50aSMuLXU5TatPzXVVKFDWT
emVMyQ/SOzWdI7mwsbN1GK85x7cvWW7wMLtEnvJ82vQJpJtAJEyWEZ9UozfpBrPq
/H2rrisWMFyZhl3eDdcJCwV7YeOxdCnmqmJnnkTMypRRXyWlfJDHs0CP7fWiKu+j
XMsPhxM1hyfrueOW7iPBEt/ZkB17Eq1V0Z2OQU+chXqJmmh9gwSBb/F8iJ48Iphi
4L2ynxJTAHwFY27xE1CQIF0VKycIc7djkDhYoJaL8PaVXQkUo/NWy4zOVNzJpeen
HbeLjHKGeeGetWxOniBCgD0PxoOQH8ThQauz+NwzeACGgyPzkM0=
=fJl5
-----END PGP SIGNATURE-----
