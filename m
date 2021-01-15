Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D982F82BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbhAORnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbhAORm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:42:59 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D40C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:04 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 14so1484777wmo.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2Jh+PMvtwPBdOf35KI8y5U59fASZU17QcTjkcKex3tI=;
        b=Hd2IN4XMaOhARll1q80OAre7pjVfYDxXAVwkYziln0JBQl6QbZlfrmyN+WlNgylyWU
         pIaRrBzcotlT2eZMrDvmrnwfyeoANkWceg612cwXsWqYdVaiErMhEKNDdohjPzMPYd/H
         55ovgJKab/CQUxTOgOefpS+wa9DeexWd/gKfu1rB2+Upw5JdPIdRXP1uyvJUjtq21IxU
         tseFZahjTU9om4RhlW5xYn0HIsNnWgBJ04W6+DTt0sdqmXFQvWtH1AiiUPDkQ2hkPbF5
         T+aqk8C3k5N9mZhTqK2lNPrt256CFiYczEGa0r+9tU9/1NEzYb8n3fshYQ+XiSG6hS+P
         BrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Jh+PMvtwPBdOf35KI8y5U59fASZU17QcTjkcKex3tI=;
        b=Rk4+BxW5mfkFXD9NxhXPDB2nn36FPLbL5T39QQe2+us4WMRAzJAWn0ZoqH2Gg2ZT0c
         9+rWb1b85W6MqcWjoFKA3WkmXzvfhIHq4oebe2jWQaU9TQA/rsDGeyAeuVi8EkVWE8VZ
         tqeGH3mkOGririGevEzCJfsOTM5jUNVDJ2tnNhsYyBd4wBzXNADICuh6DELJUjsiX7Xw
         TBk+ZOcD5SMFRDflQQ4SJjevedD+VmWpCrzY9+co6+5hQujAXFZd+JofTE+VZKZOVPw1
         5cF8XSLIAlVs14ml9fek7q5pOIJg4Dc416PoNEL6IvWPuFbGMjkK9/g+gVReOnY9Tp7C
         Xaqg==
X-Gm-Message-State: AOAM5309Vmmz5EOc6Qz6bnZURav/pP8W7cHhhd5YkPP6q2F2H4CrrqYp
        ctr8woD0zJoJ8fVozCs/mBLaUiEwjoBAGLUN
X-Google-Smtp-Source: ABdhPJwtveqVzh/mz1rxuVT8+JjfpWP10vB1hMpqRtgEBmDO+OrhmMhVsyLbeqMFYIRBQSX7tuyjEk70XhttOV8N
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:58d7:: with SMTP id
 o23mr14634604wrf.288.1610732522952; Fri, 15 Jan 2021 09:42:02 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:41:53 +0100
In-Reply-To: <cover.1610731872.git.andreyknvl@google.com>
Message-Id: <ff30b0afe6005fd046f9ac72bfb71822aedccd89.1610731872.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610731872.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 2/2] kasan, arm64: fix pointer tags in KASAN reports
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
that is passed to report_tag_fault has pointer tags in the format of 0x0X,
while KASAN uses 0xFX format (note the difference in the top 4 bits).

Fix up the pointer tag for kernel pointers in do_tag_check_fault by
setting them to the same value as bit 55. Explicitly use __untagged_addr()
instead of untagged_addr(), as the latter doesn't affect TTBR1 addresses.

Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3c40da479899..35d75c60e2b8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -709,10 +709,11 @@ static int do_tag_check_fault(unsigned long far, unsigned int esr,
 			      struct pt_regs *regs)
 {
 	/*
-	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
-	 * check faults. Mask them out now so that userspace doesn't see them.
+	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
+	 * for tag check faults. Set them to corresponding bits in the untagged
+	 * address.
 	 */
-	far &= (1UL << 60) - 1;
+	far = (__untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK);
 	do_bad_area(far, esr, regs);
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

