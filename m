Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A22817C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgJBQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:22:28 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C7AC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:22:26 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w10so1363384qtt.23
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=LRJDXnxkqiv1fXN9f+/QaOavubXnRcM3sdCzYDHh/KU=;
        b=hDQngTLlwEHOqbG2+qPgfBLtWoEqSz0RkrlSy0B5xHc4i/KeZ/R920ykBSSrSrqDgX
         CEX4Tgn8ZKwrNAh0SCxx3MqEG1DqjESis+XdXBnejPZw0+2u+FY9vYO4kxboKo2PiyEQ
         3iBxhoVO+LzKAusmFIm+4JGhC1ynyXra7m+eLxYhBZxVxK4E0ZBejCp4qEzKcGsWpJZE
         puM1f74zS6RH4HpPzKX98Rg31esYNa7V4eey0WQFt5clFp1JKfoZGwplRwD6lHtSQ9F4
         6x6NO+IrtXl6t5Fyg5dLe+13Pu8d05KrIWnvnQtTqOQg/lZsiJgR/56sN9FPpKJIu6P+
         hpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=LRJDXnxkqiv1fXN9f+/QaOavubXnRcM3sdCzYDHh/KU=;
        b=qe5p0TVOTWcINA4ZVV7mxjcu5HEGjGTrM0+VuJMSmd2SiH16Z6/Hh4TnxxAnUscE/k
         IQqXCmgpNp+XPCXc1lELhGfSjS7W5felkS808UoCBgXDB6s+iDQ01LzzvWR1nO9UC8KE
         vGM+m1JSHIbxousHPaeq2slRmimZNAxmPCHaDOiKUAdPnD4w3bDI+NLbsYIyhCPLcUaT
         aL1yziG8wdWBdKPLd4plGK2bF6X1MhE34nZwONrPes/0tQoV+2uge32kmLarYAc15onD
         m7Rf05n7lNZ88Z9crlDzunHHgosa9UHEBoPqUbviCy3+tg4lLk+rU32k9UeRu+HO3d2i
         e8KQ==
X-Gm-Message-State: AOAM533KD1HI52gIDDIBidYax04mIsGuUrxKa912q9ZL+gTw8RRCg3X8
        r2RE9Tau3vQW1OzfgI6sUSllr1zCCkMpX7bCig==
X-Google-Smtp-Source: ABdhPJw5Qv2OwIK9h4CVpf46tlO/7EN7KFe9wLwV6R2ARAWl/2Z2ldNw6qedIQHz6XTQMkbUNtRhsapSAzj+MENlEg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:b0d:: with SMTP id
 u13mr2886535qvj.17.1601655745859; Fri, 02 Oct 2020 09:22:25 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:50 +0000
In-Reply-To: <20201002162101.665549-1-kaleshsingh@google.com>
Message-Id: <20201002162101.665549-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 5/6] arm64: mremap speedup - Enable HAVE_MOVE_PUD
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
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE_MOVE_PUD enables remapping pages at the PUD level if both the
source and destination addresses are PUD-aligned.

With HAVE_MOVE_PUD enabled it can be inferred that there is approximately
a 19x improvement in performance on arm64. (See data below).

------- Test Results ---------

The following results were obtained using a 5.4 kernel, by remapping
a PUD-aligned, 1GB sized region to a PUD-aligned destination.
The results from 10 iterations of the test are given below:

Total mremap times for 1GB data on arm64. All times are in nanoseconds.

Control          HAVE_MOVE_PUD

1247761          74271
1219896          46771
1094792          59687
1227760          48385
1043698          76666
1101771          50365
1159896          52500
1143594          75261
1025833          61354
1078125          48697

1134312.6        59395.7    <-- Mean time in nanoseconds

A 1GB mremap completion time drops from ~1.1 milliseconds
to ~59 microseconds on arm64. (~19x speed up).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 844d089668e3..4d521f0a5863 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -122,6 +122,7 @@ config ARM64
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
-- 
2.28.0.806.g8561365e88-goog

