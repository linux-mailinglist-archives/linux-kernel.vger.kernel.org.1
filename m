Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3D2AE2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgKJWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732184AbgKJWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:12 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:12 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id e18so6178715wrs.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+WfGVmUcfITRHEHJPKcL2vISbLS+w5GU8CW99F+itqc=;
        b=vg43E0A6yOkdBKlSumbG23HIPKHMG2fFGlW5x7XCoPytCblD7QRpMmkKrDE+/qj5rJ
         QQnFAaY6Ikc5fIjCKfGfC9HSXAICPfJPjJVHmOD01Njx2amC0j3uHCY+HqIITfq4mdDY
         wvozL6Sca7h1Czs+9+8f1u00f1LmE11omJEvWkkPiKNG1IscyHhwjoXvwvn3cNkuNCX+
         mNGwrhe1iCjYruI0qxA0SXLM42ZaNQRSI3QCqCgR99c5DbB3tWECE3qFGewWC71Uahdr
         u2LJhhN+AS6SyQNMNwIbpEMNReb0X9uzw4nHjzAYtLjhBwExjT1Yhwqrq5UwZX7yBwGe
         38GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+WfGVmUcfITRHEHJPKcL2vISbLS+w5GU8CW99F+itqc=;
        b=ivm2hZUylMNyUsE3cBqqU4wWtw52e95u7QC4/B69u7xs/rtpgsm+6k4wtAwnamOlnE
         gK1b/9TJSe9HgAUKIRWdVgYGEi3a9/qzJZCAnojJeT4Ch7VQESo31NcrbsSf7E0ksGg7
         m8FnGoTAAW0NUOdb1Yz4JCW3vqD+ujmtmRVu2PXsFnOxGutrAqY87Dmo7jOOTFgyLg4h
         RGpkQsZWVHR/bVVfh+5xu9dCWizm3SFRGkqGiPk2vl2MvZvCIWC7Bokj/VxVUZMwD+t/
         QmAxV6rRM5rIgGYbLS3hxuyYU8nQhfd7cEMIG/XG8u9N068HcDY5Ww+xZZ6xjp9duV4V
         gQWw==
X-Gm-Message-State: AOAM533/7Sgf+myUqnNddglKf+rPkFMgfTe7u/demlabYA3c5pfMAJ01
        VLKZAdVKWfiT8TiN9zpVihHwGa4O/AIc2dcf
X-Google-Smtp-Source: ABdhPJxwTbk0NjoJxDDMQxpQd7p4SPRLkqnor5eNLvNVXgVYdd+g7ivbLYQMqr3PppMVQh7kzrEzI2rhySIOEZ4v
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:ce99:: with SMTP id
 q25mr243582wmj.35.1605046270971; Tue, 10 Nov 2020 14:11:10 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:09:59 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <24a25ef0fcfa07a94129e2ae5ec72f829c57ac42.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 02/44] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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
2.29.2.222.g5d2a92d10f8-goog

