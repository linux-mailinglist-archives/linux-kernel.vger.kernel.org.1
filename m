Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8E27F500
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgI3WVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgI3WVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:21:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D6C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:21:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo17so1901870qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=5nGapf7xO2rZTSaxGiPwPbuengbwYhe3dVDIYorRiWY=;
        b=FInMstcRCnnn+Uwb4uVZz2nOr0YsNe2fsrv2kqony8tTtnivnPNz7vNuxsLLqKt2WJ
         7XPavd/j9HHPjLjnosmvSIix+mb0vxh/gY4VKOfM8P8BR8OMeGSrUC/wTxKidQ8pCTQe
         Sm7OTzOhdOAtg3DByPpqY0zvTUI2i3YrSnjdfbSWuxmila0sOR5kl1pQLE8zY7NSNTpz
         HI+IRGKji9bQMdE+BJ07zmdSj7CKbTJZNkaSuSc5xIClV3PCsYA+RxKm6B1yH8mYzXli
         V/Odoyc22NVRZmUoSt07JUBp3CPreD9H8XzC7mXd4FeYw5zZmotd3fbx/viALT0egfZB
         71qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=5nGapf7xO2rZTSaxGiPwPbuengbwYhe3dVDIYorRiWY=;
        b=MHqaDHp1IVdrJ81U8x39gDmK7/oBPTCtObox9RwmzFvstxSAZ0nuIpeP5DyNntzC5u
         kHyKtlH6XzBuyMWheJI/nYVoB7NbyCnWNHf9X5nYQa6j9lO98YEZqWztozkP6TWeacJW
         YsbDG6+pSC70zd65LowlR7G99H/D6Px+epErRq+Tw0h6s3N6X3esukGXbwPZPuozA5ZC
         zYKAT8BlhGufnkNbRpYKFuqUNlHkEify2RPpP+SVow6IJeepfEMgNJ3qQ03wFy4pzUEp
         AG5DG0PRdUeyI5uBQZ1mrxhLt2tkEsuhRANZOQNwhPocogHkxB/Xv2J+JmLqZbD3Cc/P
         tsLQ==
X-Gm-Message-State: AOAM530Q5RJEGUB3L5vXhLgPz+bTOR+5cy2yR1vcb3PNGsCT2FDUZF9G
        8uXZIGy6yPLLSck+LJThe7JvVJG0Vs8xH0MHzg==
X-Google-Smtp-Source: ABdhPJwMH+jLJIkmc9uf9QzQWk3mmJCatGwOYHysyGXnujsIvGHjAJ+hKWsevgMRuqUWSCI/u7YMo7gHIuj/AdeMGA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:d443:: with SMTP id
 r3mr4849305qvh.20.1601504494642; Wed, 30 Sep 2020 15:21:34 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:17 +0000
Message-Id: <20200930222130.4175584-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 0/5] Speed up mremap on large regions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mremap time can be optimized by moving entries at the PMD/PUD level if
the source and destination addresses are PMD/PUD-aligned and
PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
x86. Other architectures where this type of move is supported and known to
be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
and HAVE_MOVE_PUD.

Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
region on x86 and arm64:

    - HAVE_MOVE_PMD is already enabled on x86 : N/A
    - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up

    - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
    - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up

          Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
          give a total of ~150x speed up on arm64.


Kalesh Singh (5):
  kselftests: vm: Add mremap tests
  arm64: mremap speedup - Enable HAVE_MOVE_PMD
  mm: Speedup mremap on 1GB or larger regions
  arm64: mremap speedup - Enable HAVE_MOVE_PUD
  x86: mremap speedup - Enable HAVE_MOVE_PUD

 arch/Kconfig                             |   7 +
 arch/arm64/Kconfig                       |   2 +
 arch/arm64/include/asm/pgtable.h         |   1 +
 arch/x86/Kconfig                         |   1 +
 mm/mremap.c                              | 211 +++++++++++++++++---
 tools/testing/selftests/vm/.gitignore    |   1 +
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/mremap_test.c | 243 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests   |  11 +
 9 files changed, 448 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/vm/mremap_test.c

-- 
2.28.0.709.gb0816b6eb0-goog

