Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7153277BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIXWvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:50:58 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:50:57 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l26so272121wmg.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Vj3UBI45JrVAWbqportzsgEf+6x4gUm8mMtKJtG/e0A=;
        b=DlhSwUvsvG5ney4/WbDRXQjLDE8VX04/nvBLfN1Sp8tHaKlEcYZnH0sa+/9KqW1lRQ
         Yfah80SPxhT/RtqVkeTgJlxYcxrNeEFkgDgXgoj3OxY0/6GsJBrBCyDMR2GCQVRt5RR+
         gXLLofpuCpFTun78TYCbtw600vHbKuE88RwYb8qO2LAuDz1UD8T6GaSTgfhEH8ACtKx+
         apYgnx8EgbbqWDqCJEEzwTXKB8Vu/P9aRF1wLVoF6K+EbTIwk/Z4ShIzS/GHZ3iUOrTF
         VMXkzQG6NATE5lrhW0yAJE70OJzaL/Sv2MkmzRFxMYCrJD9w4Y18Giur1XRxaqAe6Y1h
         lziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vj3UBI45JrVAWbqportzsgEf+6x4gUm8mMtKJtG/e0A=;
        b=U6xpr8UYNainxzlzuf4NlCz2fIexYFvDe73+LicXZfy44UosNw7mHcyQApY990xVR4
         DTnGZu62vqMbCbDg3FkNmJffsg4rHbD4SLO457jjNd+4YCkifAxb1L7ucDqWPOk1dHRX
         xB44KoKcFnqKgJW+4f6QExDJEFo/2VxWz4V4vZM91KHgdoP3Cu+aGG5yHaXAKtUN22Rt
         t7dZSszeI/YuU/bHuSrX0hLY5g5t7GoP9Zynm+uOZeiponZqJArdeFUYdMcachgHZFP5
         6fCz73kVwtRc1tGBACsTjVkqkHYM8Q9atKmYFxxBQTsfrQRSH/YmeuLVNFb8R2dyYHxM
         b6cQ==
X-Gm-Message-State: AOAM530cbHvM3K7K8p/kQQV8pRr3Fnux2FShkLgv8Z5LpV+2Fv/Zfw/6
        a9nOxP3RC9o0SGeiYAEBeN+TGBJawBC0f479
X-Google-Smtp-Source: ABdhPJwVV4AcVw9lJIdC7mfL63JXwHJydw2yMoIrlQ9U/5fT0W3cDFbolT052QnjoNHuMtf1anCLjx8ZYTnNQ7P8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cd8b:: with SMTP id
 y11mr864526wmj.172.1600987856018; Thu, 24 Sep 2020 15:50:56 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:09 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <bc98612aeb00e3ffad45a103fdbfa4fc383b3d0d.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 02/39] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 047b53dbfd58..e1d55331b618 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -156,7 +156,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.28.0.681.g6f77f65b4e-goog

