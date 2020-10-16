Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD932905BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395567AbgJPNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395302AbgJPNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:07:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B64C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:07:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n18so2846272wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QCwoc3JQrbxZFKFUPkaZE/66jxxiYQbsymhryLSI0WQ=;
        b=IvBhOULJo/koS9sAfdM270jHaHdzoqinJnF0ucQI+Or8MRW0CFGBauGPVUM9dwpW1C
         d5478o4BA8fwG4Xx5sMNKTB2sqzTqgnsjJHOeciPZ7HlEeP1O4YSL+M5/92j+2qaoMPs
         JbX097zG68Twuoszq/k5Ca9euXjWKzSqB0PxG2K+otxOSyJce0Ges8xut7AxlSoEgRLr
         +qlIj3Ld9Ew+F3OBSublI1uEB4A4MGG+Ft4WD9x7Mvrvt3QjR6IinTLHn+tkaA4nkfUk
         EZE3oFk+G9JeyqnA+mTWPPYIjg3rhxH4rZi430rJGocvUhgs14XLTDR1yIDOSTrwGD0G
         koMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QCwoc3JQrbxZFKFUPkaZE/66jxxiYQbsymhryLSI0WQ=;
        b=GDYlD3bcPlZp0qflDtghNUmBcWjQZMGo6l65QjmaH12wSuvWd53xWFLtOE1qWXDsVA
         7uG5NJTTTRp8M9Y3x6lX1uu87VGo/c/CB8Crbbr6I/chj7BASE3k71gzDbPELLD3DuWF
         kiCq1u+ers4wuwhF4CBsitVWhIjFZLFM4yc0BkxwLduewktjG8899UuTts/6UfUbLsXe
         YwR+zZv380RYEY48El3I6eSkjd97ObT4hbh6tcNHkAgirUzEv5/M0LhU6nP3frrS/NVd
         J3RpIAMs/16ti0jslR1Evyv4USbYYD1ADPla2LBpgBJqxITlakm+kmKIwzEmXA3d+SyS
         zYxw==
X-Gm-Message-State: AOAM530Yc+7wklmail65It6IYF41zqvYM0h0kwRjuTgR39IeRS3GHRD4
        0ZGj7tzhlRjpvTwnjrLxR7VtCBTlfz7xiw==
X-Google-Smtp-Source: ABdhPJyMOum6X/u0tcG0rrzebvZdQn2Qk20OZS/AadVTr1A5cQTeRKgz4w/W0JXqDgsnKW+Gbclt2A==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr3887073wre.317.1602853664820;
        Fri, 16 Oct 2020 06:07:44 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p13sm2871036wmb.5.2020.10.16.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 06:07:43 -0700 (PDT)
Date:   Fri, 16 Oct 2020 14:07:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>, Cengiz Can <cengiz@kernel.wtf>
Subject: [GIT PULL] kgdb changes for v5.10-rc1
Message-ID: <20201016130742.tkdahmll3qipf4wo@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.10-rc1

for you to fetch changes up to d081a6e353168f15e63eb9e9334757f20343319f:

  kdb: Fix pager search for multi-line strings (2020-10-01 14:44:08 +0100)

----------------------------------------------------------------
kgdb patches for 5.10-rc1

A fairly modest set of changes for this cycle. Of particular
note are an earlycon fix from Doug Anderson and my own changes to get
kgdb/kdb to honour the kprobe blocklist. The later creates a safety
rail that strongly encourages developers not to place breakpoints in,
for example, arch specific trap handling code.

Also included are a couple of small fixes and tweaks: an API update,
eliminate a coverity dead code warning, improved handling of search
during multi-line printk and a couple of typo corrections.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Cengiz Can (1):
      kdb: remove unnecessary null check of dbg_io_ops

Daniel Thompson (4):
      kgdb: Honour the kprobe blocklist when setting breakpoints
      kgdb: Add NOKPROBE labels on the trap handler functions
      kernel: debug: Centralize dbg_[de]activate_sw_breakpoints
      kdb: Fix pager search for multi-line strings

Davidlohr Bueso (1):
      kdb: Use newer api for tasklist scanning

Douglas Anderson (1):
      kgdb: Make "kgdbcon" work properly with "kgdb_earlycon"

Youling Tang (1):
      kernel/debug: Fix spelling mistake in debug_core.c

 include/linux/kgdb.h            | 18 ++++++++++++++++
 kernel/debug/debug_core.c       | 48 ++++++++++++++++++++++++++++++++---------
 kernel/debug/gdbstub.c          |  5 ++---
 kernel/debug/kdb/kdb_bp.c       |  9 ++++++++
 kernel/debug/kdb/kdb_bt.c       |  4 ++--
 kernel/debug/kdb/kdb_debugger.c |  2 --
 kernel/debug/kdb/kdb_io.c       | 22 +++++++++++--------
 kernel/debug/kdb/kdb_main.c     |  8 +++----
 kernel/debug/kdb/kdb_private.h  |  4 ----
 lib/Kconfig.kgdb                | 15 +++++++++++++
 10 files changed, 101 insertions(+), 34 deletions(-)
