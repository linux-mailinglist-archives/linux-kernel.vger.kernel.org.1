Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D782A7136
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgKDXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732745AbgKDXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:58 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:57 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id d18so6549838qvp.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=br613dpyefM6H17vxZ5Q4p0T39IrkLkDnZLDTiqqPDpFMMgCo+4VFo3LKvZ1P6Dslp
         Mf0CE4Fw8PeS1fwsbMEmuShN8+EPmelyh7nDN5LzLby357nasoxjb1LANRxkuexwVPYe
         LwxGSUVFyLKhDH7ttzPPyxGueeWEhdpcVUDqW8ywGJLzVo4fA0K/aUx0n7km3P0JtRv3
         Bp90RJW5FmSu2QzXaJFlBCHC5YOHK7dIZG60fFIdPzS0+fZH/bTCh+FrxoeQO07FhrqG
         RDBlgXLvB97eS/lAALxVKBMD+H2a58tt8HMP59QEf4qm99yP2PbJYpKXnSdMApGfMszG
         ugBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=SppzRfqLwecVHaMMjXAmK1zRvFDUD13Jz3yItRhopeyQ2m3plEtagW6TsAaqmOUFyP
         gF/ZQ40ovwupe2XN4XtIRGaBSg3nip8U91AliaI+sWCu3iEv3G2mVUcPKRp6ESNwnO5S
         eZ1EYN5R22MmyypfOqSaWfo/vNbCSgPH6n9tAPWYU6G8SMKY+UBQ3ZGbGg01wVqLRdzv
         cOtMRoglESiSgR/oX17RJzyDEinn8sANh7PBDEppvCHqlHBNkrzqApsplCL5tNa6tEwn
         BF+9n+L9Eodx86Guc9F/FLW58EKlle+zUe+m6F8Fttxm7Vb1/0rlwzOrBVif/uAzjbDv
         TfSg==
X-Gm-Message-State: AOAM531iArtndAlzgO6yMV+gH/Pn8fRAjXRYofQRl5hZfCs+huzG9sfS
        qry39aK2HAiJoKdW39hYTihx3BEbtYMGIDJu
X-Google-Smtp-Source: ABdhPJw3SygWDpOISuAZQmg79+TdwGrWwFo7fxBzvvQW4z2e0Vzd9qlw00Tr0XM9KlVC8zJMzixPFDkx2UiyGedC
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:414d:: with SMTP id
 z13mr147192qvp.37.1604531997034; Wed, 04 Nov 2020 15:19:57 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:36 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <45dce4028d9f5e4c5705b481a8ac37bf516caa16.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 21/43] kasan: kasan_non_canonical_hook only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

kasan_non_canonical_hook() is only applicable to KASAN modes that use
shadow memory, and won't be needed for hardware tag-based KASAN.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5d5733831ad7..594bad2a3a5e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.29.1.341.ge80a0c044ae-goog

