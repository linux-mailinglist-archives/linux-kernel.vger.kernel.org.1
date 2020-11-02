Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4F2A2F50
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKBQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgKBQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:00 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B64C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id c10so2652926wmh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=49TVXy6Rr5NIl62UeWZUyRusw+C/T2q2yO6DUxLqnOs=;
        b=p/cULzh/olAO0iM8ayouZFYayA9JSTM+/S7R5GichfMlpZdGKj5zjVM6xx9wSnCOiy
         x0fRxAGFbFi1WuJYf0+NtT6P55mXyFhmzk0po2RNoiKn4Sq+BK4nBFhYArWv/DdLOH6d
         rLV4Hw+wC9V5CPzVB+RKkwqNVZ5jWfIDnN6E9xBZWWSSlgyfgDZ6qwfyVlZ4THbhdTEQ
         GP/72X55+maz9MkEXnt0os0uHB+WdL5E2akGOaBpuFAPYnVJhrBqqic5PU5/paOyIwa5
         qyg8fE0lZ5b0zzQG5SDwQbbIvi+RTv2voU2Dm9bFNPjIf7FJcT+JVUjKVA3F7zhObB/V
         LWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=49TVXy6Rr5NIl62UeWZUyRusw+C/T2q2yO6DUxLqnOs=;
        b=LK9tvxU74N07ht+rbI7L6kCUrsmDGyEUMszYd6l31gO6bxK64DyAeI0D3SCrtMPikj
         hqrbnGfBAhOfQlIOTtUk7xPx3LJ+W6DKDzCXikcdYbFHbHrWsFf5maQW4fLqGlNAfO4f
         knnX8VU/7jf75bYf9XU8Lv+5UW3eXDrjtx/IY4uv7ILLsrHWY7/csGlJTvmBSI7CsqQF
         oJYTN7ZYkuU89FVT5LO3jjoUZz/K5VBiVWBMLfcTDc2VQjBotTdj6mpX2HtSY2KREvK9
         yVMGfvS0YPuDlabUTCx6rcEB1znp8sTBiv6zbWFtIUiqIsucG2mMPEaeSdFD+I7YWFfX
         FP3w==
X-Gm-Message-State: AOAM533OsrjAhoUD4VkvqjHynhZdQLxkF7zUNcRreweBnNEiJAqSwH0q
        dtBQk4zLc5yIXpvKqz4yg4AltD8y7yT9MqMv
X-Google-Smtp-Source: ABdhPJzwNa8E50aKpbon1ABTRVn0CBFk9uyP4WAb1fGotbnmx1wtGO54klML5Jad1noaRI+c3dFREMDypbB+Hl6+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:ce0c:: with SMTP id
 m12mr14013286wmc.114.1604333097658; Mon, 02 Nov 2020 08:04:57 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:53 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 13/41] s390/kasan: include asm/page.h from asm/kasan.h
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/kasan.h relies on pgd_t type that is defined in asm/page.h. Include
asm/page.h from asm/kasan.h.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
---
 arch/s390/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
index e9bf486de136..a0ea4158858b 100644
--- a/arch/s390/include/asm/kasan.h
+++ b/arch/s390/include/asm/kasan.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
+#include <asm/page.h>
+
 #ifdef CONFIG_KASAN
 
 #define KASAN_SHADOW_SCALE_SHIFT 3
-- 
2.29.1.341.ge80a0c044ae-goog

