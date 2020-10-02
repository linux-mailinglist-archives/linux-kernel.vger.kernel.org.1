Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B952281770
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJBQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:07:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C8C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:07:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so1044344pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=4Sz1W2DE52gFF7nh9iGez9EPsakiNmf6sgNxs58KPjg=;
        b=uqFzlyETyZWAlKABRaH2ZoC+2wUipo9m3xecCVDzW3QIAhTPHpXdD4pBWai1mIhXm+
         Zs1Kde1/uhLirxFK2YFhjJErv/MOmocqeAWgav39GoLidcFUx2BIh1xVs+ccJspy+aYu
         dtFpKTbdVecOIjKKDU5zrgEVU95h67yO4qphXcU3kZ917H65Omj44ujuNB+67Xcmy4+i
         OiJ73SG8ilWxzrAR0HwKgrVwLpBTDcdzD7DEZjMOs1SG7vsOsORmlSSfffI6xaBcZtmz
         w+sDYwygnj28kDhwnJzCZicAmGbz97LTVFPzVjSCyxWyCIf6mdHM710mLrOfVa9tCEeX
         Y9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=4Sz1W2DE52gFF7nh9iGez9EPsakiNmf6sgNxs58KPjg=;
        b=GY2XgN6tnB59Q5/Ern0P8xECkGaGCUKM/0a5+kqQlLfPsvOrlZDNYKL3KWnz3nrrr3
         mmODWIlk5w3EYh6FSSrAxmHWnoAw/PnCp3MkGhmTQPeX18XvJTaNXTX4PVDGSgJwuLgO
         /bufsvvFMeSM/TWRVWgoULYC73omfcye/jiTQJlc9VE+lmL6QosqzrOsUeKWxJ8bUjQF
         tyca7n0ThoTvd/dJ264ElWYmbmspGDzsTvDpYKY4aoxuNzk1Fc6gTbRSZxMIKOCpbqnI
         pAt5Lkgp+Utm3bD0cSuzVtM8L/ByAQGlQeehBfwkYhnBAEttY+uvtxnuKOHtvpojC6pX
         GKRQ==
X-Gm-Message-State: AOAM530SQ8Omjv94ATqfkLzU0Ho+p/7yVTJhBeXkvsy/kloUttlgP8qM
        936ghaZkZm5zQk5h4JNWU4KkAWfc4io3tWf9
X-Google-Smtp-Source: ABdhPJzMfI9KBJJtkfT/opMngWA3qRt/UEd1r4XCkaD48LwLVcxqR2/P1HZGbuwpWMsa1ETyPFHpVg==
X-Received: by 2002:a62:d44d:0:b029:152:ebc:77f8 with SMTP id u13-20020a62d44d0000b02901520ebc77f8mr3634165pfl.14.1601654847806;
        Fri, 02 Oct 2020 09:07:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m5sm1934679pjn.19.2020.10.02.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 09:07:27 -0700 (PDT)
Date:   Fri, 02 Oct 2020 09:07:27 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Oct 2020 09:06:52 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.9
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc8

for you to fetch changes up to aa9887608e77b835d51f05a54940380391cd4e21:

  RISC-V: Check clint_time_val before use (2020-09-30 11:05:14 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.9

I have two fixes for this week:

* The addition of a symbol export for clint_time_val, which has been inlined
  into some timex functions and can be used by drivers.
* A fix to avoid calling get_cycles() before the timers have been probed.

These both only effect !MMU systems.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Check clint_time_val before use

Palmer Dabbelt (1):
      clocksource: clint: Export clint_time_val for modules

 arch/riscv/include/asm/stackprotector.h |  4 ----
 arch/riscv/include/asm/timex.h          | 13 +++++++++++++
 drivers/clocksource/timer-clint.c       |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)
