Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDD42A2F17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKBQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgKBQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:04:54 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D71C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:54 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id j15so6610426wrd.16
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=U8TbU6Or9tF6NdTdyIM/i7kxRRXG3zvwVg7uJei8rIMJcTZSkDhiinrbl76M34dfdu
         HvgsRAKkA1wp12YthpAIpaiE9heJWdRi32o4EAqBDOIHF7Tnf/8o7pzDjNfW6S1747gi
         U4JmjsAa6xgvRzBf9TCxH6snmyetzmYhWeYGxzp6rI2Brt8AuSqMd/IR1d/W6sWFmT/1
         2dJCIYZt6R8kYUbYXF68Zcj22CCskjPd/UPpa2l1RlRztpQKbNNp4eNHW4y/WF2BS3C9
         IQ4+ZkIfq4BOu9N51riq6cJAEe5TNJh06qUmMn3JMdV0f66nJfAEXyyYfvyhxH9ID0vJ
         t0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=BOY4m0N7TbIpRfCrqkKIP+pySKhEBp5ynUbUi+s069n88xIr3pIL1a7Rwnwqr8MixY
         L6W/gSJP6it3KpbBFoFyJ9IrXcC8nz/QxPUZVt2dOA7xIEznuGY+3sDVsQ9Jwaf7ugFt
         s6EDqcZz7v22rFpQkVa5D7nDlEhRPX2UjgYourgRFJwhyEXrvV2kDqFyB4qbdzEBePDN
         2Se5ACbf5wR5TllSHU4K0nkiM4uNMPZCsl3f6eUAUFd9jddzUnMwv4tXkxSjmAcJTbel
         qNFm6gKPdrPqxzJHUb+1ZOeUTXIj6iLKStz512tUg7eeLQSkWACiZQN9kqxsU3P1cgCg
         aTMQ==
X-Gm-Message-State: AOAM531z7gRzgZdzRHB2eMBM1RV41/b5HUjDMgLuTqeI6xo4Zx0KEqjE
        1yX5yrzXr0ptz0cjDZ7VNCR0PwUG97p4aWdL
X-Google-Smtp-Source: ABdhPJxCEvp+v/YzAfjQjY0zm0EyrvfnbcJNKOHkfPgL9GS4J1VHkjBo0q8nWAvofosG96BJyurF9OCJIDe9ka50
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:dc4c:: with SMTP id
 m12mr8197981wrj.177.1604333093213; Mon, 02 Nov 2020 08:04:53 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:51 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <d8fef04e7ddb79187d76865d7f3da7077288da44.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 11/41] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 542a9c18398e..8f0742a0f23e 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -155,7 +155,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.29.1.341.ge80a0c044ae-goog

