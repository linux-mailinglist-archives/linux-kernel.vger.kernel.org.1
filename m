Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0952A7117
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbgKDXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgKDXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:12 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC68C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w1so47057wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=bHVBEntxz8CISEU0UMN8g7zfiBYpgf9c3dPv6MGEzxLVFboSh9vX2gqioqWBXXsrKP
         N/z4fsTpVdinl1om2cC5j2OqJwtVuA1IwvmbAWZCF+nzFoZSZziKk4GDpcISqdFenC7m
         rpxqL8/6eID74piQHXlL2mI7svrDnPRnGWjaJ8yLj2TYEpxrEuEDIuPk2SEYJUd5e1/E
         NshGMDmoGdoc0ZoCeU958YNH8F8FVgzCipVqYsjgxe4rW0byTujl4L3kkg1lzkpeTJaF
         o81go1Z4TGVOEkQWgauTM+6m9WM+Aeirf6pRMTzBN/bn/BAuo4GS7mJMrxJRlrWpnvif
         PF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=biMS+vtLP3vdI0XJkdbaMn+4mVu4akzHll7/C23ZKMCyK3pTUD408Muh/T4NpAM+Ir
         +oFB8ykPQVHou4ETGJscctgVukeE1D1PQIXwxY0D/s8oVi4+AFysFlekxoRnidx0dnGW
         BqfxTEcuoB4A0woC4Z3mgJLklXNh70qkNezuion6QE/z2Rl4pMwmWZzBlJ9KKIFV5dKE
         7HnzkgAFmDpumLz6NpbKCtoC9eikpoK5936rwhVORbjISSpbqY+M/sbZSbIdzzSaiY1x
         RhZ9JkFfYPoJwf/yk5sMnLfBZ4efn/2Z9OZxCzVZVdA+Y3zpzdSwFc9h6gWG/lyLae12
         EdTQ==
X-Gm-Message-State: AOAM531BTPfJo2GLYRNg5lVnRIZQhzCWNK+HSffWCHtU8/6+qUFaH0t7
        PjkqbQxOrZi9fqaK8W3NpoujibBNlBAnDOOA
X-Google-Smtp-Source: ABdhPJz8PA1RC6TbYkCijZyVacH+F5qN5v5VA7bYMHwRsUMGn/QRHb6T2stA1tcRlIPO7sX4wK7ZATIKTk0Xn1vX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:309:: with SMTP id
 9mr83135wmd.80.1604531950904; Wed, 04 Nov 2020 15:19:10 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:17 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <f6161319e205bf6aff30ad4d46c93e66e60bb7ed.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 02/43] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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

