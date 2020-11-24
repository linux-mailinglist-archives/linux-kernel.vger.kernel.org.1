Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071922C3189
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgKXT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgKXT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:59:49 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F58C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:49 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 202so18203921qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rWgaVCW+QceCYmZ+e8PPcTXSX7aed0mfmYVc7ooA0KU=;
        b=v3ZxLsvQ9xr4M8QHnQqG0QWYZCUqCJqOdA+Cf+CqWHZqPXEvpsSuwMRsOxCarRAh4X
         LiKfMXGsyi3GYu1vqWadscL76UG0ErAYr+hVn80tOX9nnCsdG2omk3YljX0cvKH0kYfC
         aJsD1ntuBJIEQHOV1xvRN6afe66OZI0BiJVeT2mTpoF70kPjvdusx5EKyWfeyDLfGvBs
         cf6OWdJHqfA1u1usZzN0KTU1IR5puJMxPhHWeSCoyo+MDv/9dC5ePcBAZRWn8+mjsgHZ
         s5ZUAryVwDDM5ASX19Q3Hwn7e1/7EnAFAUCwLdAoGc9ZxEOH1G1KeVcwdTr80vRjdiGk
         Mgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rWgaVCW+QceCYmZ+e8PPcTXSX7aed0mfmYVc7ooA0KU=;
        b=t8PvUTOKevgomWO5buHEMnJ+rWZhFSOpvOo7ub4Y+7ABokO88cO/BS/o2RYL4W9/3F
         BeazMGjnEJTG3SCoI8H4NOdl3Byev9seyrQ+Xu3aBiwO2992JesxlOknYt/XV8vOkZS5
         Fz+Q239jlWBM63kweHzDcAndApfuYJQGEbclJwJq2qZGIfNvf7i/e5F5kyVBsyFdv+5L
         IAumktWVl3/I58VgibxB2gp00qEwI7800Qz1PN4NDDILg9QYpYsWbEmeRkZr0mfX9PgW
         aN8Xx28DrHxrnQe5qvm1WlmJq3E+mvn3C0q9l10GXAsl2m4IuAB9Vax+9/0nPGvesxYH
         tSkw==
X-Gm-Message-State: AOAM533Cg0i/YA6uPZerkrSTp/hGsZF07BkUE1QXeC3HcMphSPOA2ijG
        M5nHtYHLdYRM4UNpHXj59gPtYRD9ncr5Hq9RZTk=
X-Google-Smtp-Source: ABdhPJwKSq/Y/s8hSuqpDDA2NvpgjaDe14765SIGecYkH9SScEVCVzmrsSw64L3IWSbCGHlpcNbkzcDsvUdPjJE0hQQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:484c:: with SMTP id
 t12mr246309qvy.15.1606247988958; Tue, 24 Nov 2020 11:59:48 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:59:38 -0800
Message-Id: <20201124195940.27061-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 0/2] scs: switch to vmapped shadow stacks
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed a few months ago [1][2], virtually mapped shadow call stacks
are better for safety and robustness. This series dusts off the VMAP
option from the original SCS patch series and switches the kernel to use
virtually mapped shadow stacks unconditionally when SCS is enabled.

 [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
 [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/

Changes in v2:
- Added SCS_ORDER and used it to define SCS_SIZE, switched vmalloc() to
  use SCS_SIZE and removed the alignment.
- Moved the kasan_unpoison_vmalloc() to scs_alloc() when using a cached
  shadow stack instead of calling it in scs_free().
- Added a comment to scs_free().
- Moved arm64 IRQ and SDEI shadow stack initialization to irq/sdei.c,
  and removed the now unneeded scs.c.

Sami Tolvanen (2):
  scs: switch to vmapped shadow stacks
  arm64: scs: use vmapped IRQ and SDEI shadow stacks

 arch/arm64/kernel/Makefile |  1 -
 arch/arm64/kernel/entry.S  |  6 ++--
 arch/arm64/kernel/irq.c    | 19 ++++++++++
 arch/arm64/kernel/scs.c    | 16 ---------
 arch/arm64/kernel/sdei.c   | 71 +++++++++++++++++++++++++++++++-------
 include/linux/scs.h        | 16 ++++-----
 kernel/scs.c               | 66 +++++++++++++++++++++++++++++------
 7 files changed, 142 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm64/kernel/scs.c


base-commit: d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
-- 
2.29.2.454.gaff20da3a2-goog

