Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF229F51A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgJ2T1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgJ2T1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y8so2424516qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hmgLBwrpZmM2Ob1pVeE+PUpkn+sXRrzyuWPTws3FeSQ=;
        b=kyhG/LpR7btF1RBq+LoUUCSlOIfkLYEdG6k2VdmcpEkDIDEqJLcXznACt8kkkIubPt
         HLL2GMJ8LUeqmZATeYjV1x+GwGDDv9NXGt2qbXsJnQKHJBPJzP60W60sRL8jbSpqsnN9
         5jLj8IKcK7aTMJDr3Uhmdvo9m7rSkFK9jEwmuLFxjNnBVaaQUMXqEhYo1QK8iEDjcNwi
         HFV+V2SG84c3SQlgWhu/pmS6/+8950cibIQHNJIwi+ySo119Daa7jGt/979agORRr9c2
         C0DYEaO2dLtSWOd83aP7hjVOn8PPO4B6L0jn2rfGxHksupE0coRVpqV8CHhcXIz2aQkd
         v6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hmgLBwrpZmM2Ob1pVeE+PUpkn+sXRrzyuWPTws3FeSQ=;
        b=kP4L0RwhUGSogsXzM9FE6RrlnqK4N0cUg6+Np3Er5lqqaUgTmOCXPe6o4SubYM/SA4
         /rT75j9u6qyviT8j8Y2a9CA15XvGMaemmkRGRcBy81QirzKDNJyG1ggEZzy3FUYUDUIP
         edmSctrtoej2AhKlcr3AlwqmyEZlBCxO1wZfECKQChV7FLX+B/aesjC8UxutZqtW+3Us
         TuY4sme8xbAigORYFTwUgm2kw8YdxQqLpyAK+LzLS4jE7lecrqju816lnrb/sFrvygf6
         SzvYjXXxyDYUlZ4NVWl9RPOJtr88AzulldjcfO+RpJlSDdZZniUH6E+5LWo2RCJsnrtF
         iwmA==
X-Gm-Message-State: AOAM533cBswh57yQn5amy/xylRI+PTkZsjUJ9wpG6NsA3GSVJwdupsWy
        0V5zfKqizefrnxdvh47nKXBVMn6fG3+fc3fA
X-Google-Smtp-Source: ABdhPJxb7i5v0jMUlh3xUTuo7OjkcEywxPvKLWy6o8r8H6DQV0pJn2YQ8FY2iCVwP2F1TqOCRkULDSCdIS/3O9eG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:2ed:: with SMTP id
 h13mr5419776qvu.26.1603999640531; Thu, 29 Oct 2020 12:27:20 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:51 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <8730eee8f88eafbb3148458ea8d2f55c89a94fbf.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 30/40] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f13ab297b7a..9e5049ffa160 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,7 +134,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.29.1.341.ge80a0c044ae-goog

