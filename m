Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740DD2D813A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406383AbgLKVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392509AbgLKVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:42:25 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:41:45 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so5244671plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=OqjIcjsaSVYgyvXXV3i2mpONbBYJYWxTgql2pHHuIgk=;
        b=uIrN2MGJP0BtkwPzQ73wbsoyKLwaQ21sAZy/zPeBXzOSytiRI9k5Y9Bmbs5iRJyYil
         8buLeAu/qp5cIPxjE1Y81AQ+tFE/jJYaLz6lTerCZWu6pZuGpF2KUynnAycyiFVdcBZ6
         rgh2dd9DzrJHZYp1QIcV/EEgghQrPzMRETA//9FV9f9ylThijp8ThYKmF5QYOFrOpE6o
         Zdndu3j84YSnGAie9EWquGMYQJKq8zhyiAymikpcOgo0LOz/0PmsiWLJMaGJfaOBWUKC
         LWfVbWTo5oBO2XQEiaPApt0sGA7WPb/k3rB3bQjjYUX25HqQMdsf0t7mbINkgi1rfMan
         8gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=OqjIcjsaSVYgyvXXV3i2mpONbBYJYWxTgql2pHHuIgk=;
        b=RR/Rf7C5bZAotETNIL59n16rA2fkSJyu2QmdlYFFvlGH1RFq1Sp1YMqC8g+hiN6aId
         kPQJq+HslxJKmMA2z1rbGobafRKyaqlRhpPchshEVGQXhyuOdcACAox0KUAsuoPF9jSa
         //ovtJmUmqz121f8nqsIPjo+tTZgx1fVcvKzh3B9N3ITGhBOaYz+3Pnv5zM1PLfY5Ftn
         yM7K1sXRZJ9YxdRjfrpOzD2exPQQ2e+mJHezaHkqVAwpLem6xlDC+kz0xH0ZFVlBl6Qj
         P20xJloDZz0m01igsJ1caS7wA8vm/+tW/NXiNb+NKA1ApWTwqAsqeFVF+Aw0HODShezU
         5kDQ==
X-Gm-Message-State: AOAM5328rOgrSoQIW8uItf2lQUIm9Mk9E70jHRMUN5lwrmjce37AOjDA
        xSWUtxZpNPCN5KNttCwkjZDvr2ny7J1Bi7IHxlc=
X-Google-Smtp-Source: ABdhPJwQu1ifve1Ve6v4KZb1RslVL+vY0LZn8c4Gq3ZfjULHarWsue0KMY8MhO/9J8gGbC+FIeEu2A==
X-Received: by 2002:a17:90a:8a82:: with SMTP id x2mr14772502pjn.107.1607722904525;
        Fri, 11 Dec 2020 13:41:44 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b10sm12121192pgh.15.2020.12.11.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:41:44 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:41:44 -0800 (PST)
X-Google-Original-Date: Fri, 11 Dec 2020 13:41:41 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.10 (unless there's an rc8)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-5e629583-5ff4-4523-bfdf-c4254276d95e@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 30aca1bacb398dec6c1ed5eeca33f355bd7b6203:

  RISC-V: fix barrier() use in <vdso/processor.h> (2020-11-25 09:44:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc8

for you to fetch changes up to ccbbfd1cbf365b38d014351d1482fedd26282041:

  RISC-V: Define get_cycles64() regardless of M-mode (2020-12-10 17:39:43 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.10 (unless there's an rc8)

I've just got one fix.  It's nothing critical, just a randconfig that
wasn't building.  That said, it does seem pretty safe and is technically
a regression so I'm sending it along for 5.10:

* Define get_cycles64() all the time, as it's used by most
  configurations.

----------------------------------------------------------------
Palmer Dabbelt (1):
      RISC-V: Define get_cycles64() regardless of M-mode

 arch/riscv/include/asm/timex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
