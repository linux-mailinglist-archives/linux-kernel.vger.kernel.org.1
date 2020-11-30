Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D32C92C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbgK3Xfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388692AbgK3Xfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:35:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA6C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:46 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id j145so10092345pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RJPEIfxPO98jtMQ2iTruMKJbRWxcjWOx8NddA41MlBc=;
        b=WEB3DIYA6nkMmNQjC6vU28U3uSAX/cYqowTJDhDkwU86T/5UnUgTUwtYT+B2iSQRn8
         C0+UUZjl/96BWKByUmc4NS25UD0St+8iV5+dy5zjAJvV6qTOdTggRHwIuTDgX6Be39WJ
         9zVpbjZol9Z/+/7eemmhyMalaTnNjdhj0dkl2LcRhKoL8y8aj2Nn2+BxHHUiCGuRBbvZ
         vx3waah7EsbtgB6zOt8r3ukahzNgYyNE31LSSuaTbUEzynVZTvCymSiVqJCiDYhDBips
         FCoS4Rb6denzLu/TsC7jgEykIcdBhaJdv3wdqZO4I2CvYxKz9Svx/OZfMVFEUOweJW19
         y7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RJPEIfxPO98jtMQ2iTruMKJbRWxcjWOx8NddA41MlBc=;
        b=epgohXDSYY40gpBH9soQpabbIl+a59lVwOXBXfY7PN8BXIaiwtC1sZn0Yumc5OID0E
         Wqr7PgmiO197MEL4XJdF+YSs84V2RZwXlUwpDPYWWRm/XNltxDg0oZODO05mAKThflum
         RKFKm9/0GXvXlj/h2sMNb3RcuUqf+Kc1N6RXgeI6iywIm3TY3uiARvBVSrfVKLYTzA94
         5fb4PdB9DBFPhbgYMJH6aVdOdxvr+q578FEDwKJY0+3J/2gfoH88y/YNsDusGZYarrF+
         yT77yd6EX5qU7T7oGX37ZLHkyAoj9aRTOURNTpVN1DfljPovSXoWwM1gk1YaR1S5AYTn
         GBfQ==
X-Gm-Message-State: AOAM530bgBeOxbuTBjUR8Nykky1VealOZiu9IvBJ+sr53UpRGNP+hpUo
        RSBnmzbbhkF8IBAD3TC0HWtz6ZKr1GMQ2/c8UUk=
X-Google-Smtp-Source: ABdhPJx064nCnIzD6kUlHafx+ACN0Dt6yWCyE3LQ/YNi37Ctc+LLjg17YIGs5RzUaAu8Yb6+xHdWdxQcJVTqvlcefOY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:16c4:b029:198:a95:a2ef with
 SMTP id l4-20020a056a0016c4b02901980a95a2efmr17889pfc.43.1606779285726; Mon,
 30 Nov 2020 15:34:45 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:34:40 -0800
Message-Id: <20201130233442.2562064-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 0/2] scs: switch to vmapped shadow stacks
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

Changes in v3:
- Split the actual allocation to __scs_alloc().
- Moved SDEI SCS initialization to init_sdei_scs().

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
 arch/arm64/kernel/sdei.c   | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/scs.h        | 16 ++++-----
 kernel/scs.c               | 71 ++++++++++++++++++++++++++++++++------
 7 files changed, 158 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm64/kernel/scs.c


base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
2.29.2.454.gaff20da3a2-goog

