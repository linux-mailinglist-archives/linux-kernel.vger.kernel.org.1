Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1E283B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgJEPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgJEPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:41:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3DC0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:41:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k6so2218846qvg.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=bMnBZVJZ0gP6yWIahq+ggDCPy47CsnYvJiYw0n333nM=;
        b=k5vN5lL8u+dk7kk1dVwMid1XenomFqovMOogievds6K5jd20VXgxbl2GFmp9kcpSBP
         6QTRISzHEYP0AwHteqslnrm2lDI4o6TNFzp3eLpPSYPYmosTOpjvr0Tcp5Evej0M8pOG
         NDN7DhJqs5Pc+2CCYJ9ilX5R5ax+1FWsqWBoizCPssscrao3rJH39V7UmzRBLCdDcBnv
         /c5HcLQ2tHg6VqfaazIcTVynqbkSBCGQGA1TdVjphaWV+Q9djLrapFHuVINGUeK58Iq2
         qSVxl7d+7HUqT/LF6PXQtIH5YrCQ55CM67kkpySUh+9u+hzZIqVOJTquW9YdjteNKCac
         uGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=bMnBZVJZ0gP6yWIahq+ggDCPy47CsnYvJiYw0n333nM=;
        b=gUd6+YCRvzGaI9FU3/GwguR3bXEaZDzsT56LGO5CFzDB/0hU3kGwvu5tJaASz+A9Hc
         Qvewzrcdf7GJ3AEQGDb0x3sM6ijlhbFT/p6nN7tRSCc5K8nnVY5ErtGz55Jnq0ulpDZ6
         UbBq7VvBgOwCZ3gQUYHbLcT8WwogNe0tQx2jLckuP4Ce80UCpsSAI62mxj85isVQgOcO
         kpdjPUOyerkW1ABJUwcqP2ax432C4qBBr90EPfJoKBSuRw9ufBf1AirapbUeoE4nP2nl
         wH93UNEkKCJBg9jUvuR0TVmJy3RXobFaVgwHSqbQIH998m+pMiiAKO5gyuZ3n71j46vD
         c6GA==
X-Gm-Message-State: AOAM530dmXwXl9mctDUnUgWB2EF1UrvIQp7fx41+F8mjQVoSAOKFpso/
        UVDROXj9KnmNE26q2+ZWR6cEAZpaZHge6H6XQg==
X-Google-Smtp-Source: ABdhPJxCbT3Tk7IhWxN1eyg5aVeN/8oSsg9g9VSjiEzr12333FvC/+nSCGHof4S0Ag8i51NGfN+bVC/79zdrCeEyvg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:4594:: with SMTP id
 x20mr337215qvu.4.1601912490402; Mon, 05 Oct 2020 08:41:30 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:40:08 +0000
In-Reply-To: <20201005154017.474722-1-kaleshsingh@google.com>
Message-Id: <20201005154017.474722-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201005154017.474722-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3 5/5] x86: mremap speedup - Enable HAVE_MOVE_PUD
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
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Brown <broonie@kernel.org>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE_MOVE_PUD enables remapping pages at the PUD level if both the
source and destination addresses are PUD-aligned.

With HAVE_MOVE_PUD enabled it can be inferred that there is approximately
a 13x improvement in performance on x86. (See data below).

------- Test Results ---------

The following results were obtained using a 5.4 kernel, by remapping
a PUD-aligned, 1GB sized region to a PUD-aligned destination.
The results from 10 iterations of the test are given below:

Total mremap times for 1GB data on x86. All times are in nanoseconds.

Control        HAVE_MOVE_PUD

180394         15089
235728         14056
238931         25741
187330         13838
241742         14187
177925         14778
182758         14728
160872         14418
205813         15107
245722         13998

205721.5       15594    <-- Mean time in nanoseconds

A 1GB mremap completion time drops from ~205 microseconds
to ~15 microseconds on x86. (~13x speed up).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..ff6e2755cab8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -198,6 +198,7 @@ config X86
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.28.0.806.g8561365e88-goog

