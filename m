Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BC280B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgJAXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbgJAXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:58 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB82C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:57 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id b14so42552wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1KLKr1XfEclxqghDKYb7g6gC3yvYfdSQNk9s8vHxzWM=;
        b=pAocIZmCdrK18/pcUyk0kRLkY7vku2ZhnCyWBIKxyayg8lqGQBOAgkQySwzDu2DFC6
         jsuAjjq3PmgHo3AEEAxEycEbfMIN9W9EbYsYdnopK+PoGX8+1lYky2x+mUfDuE19Kzdm
         aaP5sQP682XeHJ/EnB14NG0I0nmBDgzy+HbhmafwFI6kScpx5Vdv8nOoSTFWlaAL9WU3
         peG8isNen+o3EFz7+CKjsCkNZ1gg+1A33HyDaEJfSqB7/RQSABpmihHPp95OWD8EP6lx
         SaLEiHfg9gXU2JuLyytmSNIlHYMdqTKeTgl7Kh8Eu+jgndW+TTx7rpxOiGYu/Swg3/qO
         MZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1KLKr1XfEclxqghDKYb7g6gC3yvYfdSQNk9s8vHxzWM=;
        b=hQH/mlmhaMlnY4B3iF/Yec+f8WSGQAr6fhoqk7fTYqdXS94IZmPWvQG2CT6bbgZDP2
         xm1zwNLvD9qM2r57K5i9j0IBnGDO14ESwIpOrtqH3WjLLeucRWWBehKJq6CvV0raFCsB
         gE8UCDVFTPSC9OzpNot7Pyoysxrhl4vqfxpRsPIx9RKGHSkVFwRMzha5Yyq+/dIyBo5l
         mxpWSqneq9lXfISN9zuGMjT0t967fFLBHudUFV/P+xhTkv4FNPdWGvvX5nk7zKXfjSVq
         HpAgx/6B4+Gi422S2qkbqcKQlnDi7xLg9cDQWyZpTaM6IUGb4xI4eww4BqcYF9rPcUD8
         SBVQ==
X-Gm-Message-State: AOAM530G51bRs1vAS9mPOGfSy/sfUa5TFop6dvhHJOaOyG9hpSfns4or
        6ql5iYVfDq/YBNhhwEwDtOEUlMu5Pvo4r8ur
X-Google-Smtp-Source: ABdhPJz1HKy+CKpPFSBpvpcMel4ghpzhrYfd+Q7Tszdd14oileWUr2W9f7KBBhkjd+oJPGsOjiRg6rtWYGzY0XYU
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:56cd:: with SMTP id
 m13mr11181249wrw.261.1601593916429; Thu, 01 Oct 2020 16:11:56 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:31 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <bcd566b9e00a28698d12a403f02dc89fcfd03558.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 30/39] arm64: kasan: Enable TBI EL1
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) that is
built on top of the Top Byte Ignore (TBI) feature.

Enable in-kernel TBI when CONFIG_KASAN_HW_TAGS is turned on by enabling
the TCR_TBI1 bit in proc.S.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I91944903bc9c9c9044f0d50e74bcd6b9971d21ff
---
 arch/arm64/mm/proc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 6c1a6621d769..7c3304fb15d9 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -46,7 +46,7 @@
 #endif
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1
+#define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1 | TCR_TBI1
 #else
 #define TCR_KASAN_HW_FLAGS 0
 #endif
-- 
2.28.0.709.gb0816b6eb0-goog

