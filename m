Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCFE2920DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 03:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgJSBWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 21:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbgJSBWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 21:22:46 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14020222C2;
        Mon, 19 Oct 2020 01:22:43 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.10
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <dae7af98-a47c-4225-b444-21d47cc27307@linux-m68k.org>
Date:   Mon, 19 Oct 2020 11:22:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.10.

I expect you will get a merge conflict on a27bc11f4b7c ("m68knommu: switch
to using asm-generic/uaccess.h") in arch/m68k/Kconfig. The resolution is
strait forward, you just need to add the single line:

     select UACCESS_MEMCPY if !MMU

as per the that commit. Geert ordered that list alphabetically, so it
now needs to go near the end of that list of selects, jut above
"select VIRT_TO_BUS".

Regards
Greg



The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

   Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.10

for you to fetch changes up to 9f5fd809d7a02e32c2e044acb9f6aed1c79a699b:

   serial: mcf: add sysrq capability (2020-10-07 21:58:36 +1000)

----------------------------------------------------------------
m68knommu: collection of fixes for 5.10

Fixes include:
. switch to using asm-generic uaccess code
. fix sparse warnings in signal code
. fix compilation of ColdFire MMC support
. support sysrq in ColdFire serial driver

----------------------------------------------------------------
Angelo Dureghello (1):
       serial: mcf: add sysrq capability

Greg Ungerer (3):
       m68knommu: switch to using asm-generic/uaccess.h
       m68knommu: fix sparse warnings in signal code
       m68knommu: include SDHC support only when hardware has it

  arch/m68k/Kconfig                  |   1 +
  arch/m68k/coldfire/device.c        |   6 +-
  arch/m68k/include/asm/uaccess.h    | 398 ++++++++++++++++++++++++++++++++++++-
  arch/m68k/include/asm/uaccess_mm.h | 390 ------------------------------------
  arch/m68k/include/asm/uaccess_no.h | 160 ---------------
  arch/m68k/kernel/signal.c          |   6 +-
  drivers/tty/serial/mcf.c           |   1 +
  7 files changed, 403 insertions(+), 559 deletions(-)
  delete mode 100644 arch/m68k/include/asm/uaccess_mm.h
  delete mode 100644 arch/m68k/include/asm/uaccess_no.h
