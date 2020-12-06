Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8D2D05E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLFQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:22:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLFQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:22:25 -0500
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607271704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=274El5B09MwkXHRKFDzJ1crhgPsfgSwWs7YHlF6J+1w=;
        b=L6OrQ2ZHR+GnMnqjaahoqby97f1nPIGNd0jFWA0bCnmrsM3nEOAR5dI4qN8Th79vDAD41s
        5W+IC2m2UwvKdFosbMHZdA0DngMviNXN0r+laXO5PqaZ6ErO/4ItProagjPLLOf7pputvK
        oL6d4SEbXU+6Pcw7msbAogFYaiPUVXnHk5cA1O0LNkvKfFSn+hWROX/eCRDczPWg4HfTm1
        AWKGRKrO5ulKpDfuG0GLaa3oNM7qd70FFZ20M07UH9Zub4bBw39NsmkrNwtE8Iq1JCETzN
        QI//JbwROXJEtusa9qXfBKoNuol4x4YA568kdRf326Aom/yhw4DUTv69tcZtPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607271704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=274El5B09MwkXHRKFDzJ1crhgPsfgSwWs7YHlF6J+1w=;
        b=Lk2PiDLshFOdwZBnjeAzeGybsRcDGz+DkqwcPJAA9+8enLweTPfAcGM6n0dVlkMZ7MQXsy
        RgW3TXshmLKWhXCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH -tip v1 0/3] seqlock: assorted cleanups
Date:   Sun,  6 Dec 2020 17:21:40 +0100
Message-Id: <20201206162143.14387-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When the seqcount_LOCKNAME_t group of data types were introduced, two
classes of seqlock.h sequence counter macros were added:

  - An external public API which can either take a plain seqcount_t or
    any of the seqcount_LOCKNAME_t variants.

  - An internal API which takes only a plain seqcount_t.

To distinguish between the two groups, the "*_seqcount_t_*" pattern was
used for the latter. This confused a number of mm/ call-site developers,
and Linus also commented that this was not the standard practice for
marking kernel internal APIs. [1]

Distinguish the latter group of macros by prefixing a "do_".

A number of call-site developers also complained that the automatic
preemption disable/enable for the write side macros was not obvious, or
documented. [2] Linus also suggested adding few comments explaining that
behavior. [3] Fix it by completing the seqcount write side kernel-doc
annotations.

Finally, fix a minor naming inconsistency w.r.t. seqlock.h
vs. Documentation/locking/seqlock.rst.

This series does not change the output "allyesconfig" kernel binary:

    text         data            bss      ...        filename
  247616963    289662125       81498728   ...  ../build-x86-64/vmlinux.old
  247616963    289662125       81498728   ...  ../build-x86-64/vmlinux
  145054028    78270273        18435468   ...  ../build-arm/vmlinux.old
  145054028    78270273        18435468   ...  ../build-arm/vmlinux

Note: based over -tip locking/core, instead of latest -rc, due to -tip
      ab440b2c604b ("seqlock: Rename __seqprop() users").

References:

[1] https://lkml.kernel.org/r/CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com
[2] https://lkml.kernel.org/r/20201030235121.GQ2620339@nvidia.com
[3] https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com

8<--------------

Ahmed S. Darwish (3):
  Documentation: seqlock: s/LOCKTYPE/LOCKNAME/g
  seqlock: Prefix internal seqcount_t-only macros with a "do_"
  seqlock: kernel-doc: Specify when preemption is automatically altered

 Documentation/locking/seqlock.rst | 21 ++++----
 include/linux/seqlock.h           | 83 ++++++++++++++++---------------
 2 files changed, 54 insertions(+), 50 deletions(-)

base-commit: 97d62caa32d6d79dadae3f8d19af5c92ea9a589a
--
2.29.2
