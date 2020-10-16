Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284212908CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410426AbgJPPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410407AbgJPPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:45:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86102C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:45:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so1476494pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYbQaDMfS+fMZq0SRvCKUeB9Qm+Ttaw/Z4j/8qnPYOE=;
        b=1s+Gq/VoGaNBXHCyTy3bIT3PcIMErPRCTXabyg86Jme4mJeO9Lc49fjNgMUDaPChO2
         G1RJePs8H7z5f444uk+/xlJpDeHbLbiXk7gthvRaa69vJGi32Kj88/HGJd9KNFwr2SlD
         KSFSQBEB1FIhSeXR2jtNkA8VKSfj5R9/AmAlfFd5GWn28p0hR8UBr/zWbJSsk9LDef/3
         MsvvCxVwftCgfRFh2LpJJlqguLWGQgSCdvTzZebQpoh2kp3TUcv/TcoNPQHk5F9LMX50
         WtI4G1pLMyaKVlizw/mFkzp2g7/QMideKKoaTuRgV4vqgdJfvijiKkGE3e1q/c3QW3s3
         cB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYbQaDMfS+fMZq0SRvCKUeB9Qm+Ttaw/Z4j/8qnPYOE=;
        b=jzYBaR0t3zuncoJmCeLjGRAXrnHrymQX5GaOwOTN/LPxH1v8Yc6VK2r88O1d62fNDK
         qCPZqDaaItcGYZTzw1jWSVJw/66TGrI4R1Sx8dmT37HP21glcbl4kbdq7IK1h8fQDapZ
         VYEaEmftOPGkQkxXt0ZIPZGDzGlHiPmrP2FrdQ6y+skp4is8jc8HF1gBP8wXJhhYA5j9
         NLkFNNMl3PiykkJTqX03fKwKUwj8lAIMboJw9eqKQ5RKTMaoxySLvZThe3aw29IM5LYM
         rVjRYTfM4IrrwXFtFFiExOerV7EgyO5IThrutvB2HbPdPvC9LGqi8H0R0Fyqq6zkbZxe
         ieCQ==
X-Gm-Message-State: AOAM530r79aKNq/iPKPMGxC7w+SRBMmCgNShC4QCnTn18Kk+Hlzatp1b
        V5IZqzs0E2Tzell4BG+qSOGDXMi2Cyk07Tgj
X-Google-Smtp-Source: ABdhPJwvF9FFrNcgFujKeZXR0opNZ/gKUbtuMLnGZMVFx3YChFqPX9AngahOT8+4q30PcCWhZDlfYw==
X-Received: by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with SMTP id l2-20020a170902ec02b02900d1fc2bfe95mr4839637pld.79.1602863151729;
        Fri, 16 Oct 2020 08:45:51 -0700 (PDT)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s11sm3346194pjz.29.2020.10.16.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:45:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de
Subject: [PATCHSET v6] Add support for TIF_NOTIFY_SIGNAL
Date:   Fri, 16 Oct 2020 09:45:43 -0600
Message-Id: <20201016154547.1573096-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The goal is this patch series is to decouple TWA_SIGNAL based task_work
from real signals and signal delivery. The motivation is speeding up
TWA_SIGNAL based task_work, particularly for threaded setups where
->sighand is shared across threads. See the last patch for numbers.

Cleanups in this series, see changelog. But the arch and cleanup
series that goes after this series is much simpler now that we handle
TIF_NOTIFY_SIGNAL generically for !CONFIG_GENERIC_ENTRY.


Changes since v5:
- Don't make TIF_NOTIFY_SIGNAL dependent on CONFIG_GENERIC_ENTRY
- Handle TIF_NOTIFY_SIGNAL in get_signal() for !CONFIG_GENERIC_ENTRY
- Add handle_signal_work(), and change arch_do_signal() to
  arch_do_signal_or_restart() and pass in a 'has_signal' bool for that
- Dropped TIF_NOTIFY_RESUME patch from this series, sent out
  separately.


 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/kernel/signal.c           |  4 +--
 include/linux/entry-common.h       | 11 +++++---
 include/linux/entry-kvm.h          |  4 +--
 include/linux/sched/signal.h       | 20 ++++++++++++---
 include/linux/tracehook.h          | 27 ++++++++++++++++++++
 kernel/entry/common.c              | 14 +++++++---
 kernel/entry/kvm.c                 |  3 +++
 kernel/events/uprobes.c            |  2 +-
 kernel/signal.c                    | 22 +++++++++++++---
 kernel/task_work.c                 | 41 +++++++++++++++++++++---------
 11 files changed, 120 insertions(+), 30 deletions(-)

-- 
Jens Axboe



