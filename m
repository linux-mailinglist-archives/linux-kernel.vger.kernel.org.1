Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED12C15E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgKWUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbgKWUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:17 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFFC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:17 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t22so9782456qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GkFr0u14154TKCLNsFsUNWuX9c3ApyttswFdMFuJ7qM=;
        b=gFQRB1/Ztxk4aNYuOz98+wWRnqsWnkzavuDoYOnJukdqNKXxEmrKlFlfox9MQYjDUv
         iDTNcah6dQcJGyaX01kO6QQ/zy7mWD0eTwNntP4yxyjQQiq55gIcDmzz+oCCLmtFfj0d
         K/DI15HRxY9NaOU7ZZjnUC5dIdjE+TLJwjRJoNkkC6FkbphEai2gApd45z+mqYyGtGmt
         2dkq3NASyKm6IfoN3bDSc+n47tWwJvRw3IYpqgQMLi2C49nR6D0qFvush1WELnho8eSp
         3hUEG+FY+PHsnJ2AaP9/VLS9KQQlGxvkUovlHGSIjbjtg7r+EGC08jJ7VkHVOzYQ1SVg
         GkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GkFr0u14154TKCLNsFsUNWuX9c3ApyttswFdMFuJ7qM=;
        b=GO0HikXf/R6dMYB7tR41h0gylTtOYf1TqbpOqhF5dmrGL1sDgRCKwVc5cWMVeB7MQ7
         +osn5qdfvRd+Nmn/eBcoKgI2vNRQuUF2iVrT9OT2FYCj2MD2VEtKcghN8R6rmpdCo39s
         FceIQ4Xv+WCXmCjPC1AT8fTsAsgMoYRXIhWYF66Ahcl2C7aW0J3YXNFvovR8fwu24KAt
         liBW/6FPO4HZjh/o01GO0ESBXHbzkXSIbDUyEHNc100yvO5as73LQkFGncugISpFASDe
         HUAHVzYITyMnpx+LUtUb1t25JUNyJChSuPRq7nl7EEDmns+Gg0/osoFfN52QpgYlB2sG
         /jKA==
X-Gm-Message-State: AOAM531pyIvKVLIgZYGHVvxghe5R//tXKfmmmsOtJZ8ok5kOemliq24Q
        0cG5GhDOviyk3TCvqn4cH9ASq3AQRKmesLdP
X-Google-Smtp-Source: ABdhPJy+Em8K3byHGlsLgNIzvAr8pDHSt17yd+2X1s/6Oyq+9Qs/ZOC0L9tbCW7Fl74HrEKfzwW5BXUoN41l2Qv2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:9a9:: with SMTP id
 du9mr1076956qvb.47.1606162156981; Mon, 23 Nov 2020 12:09:16 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:46 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <0b8cd898a49ba0c9574f822c87e351ea567a80d3.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 22/42] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 629a293cc408..026aaa64a7e0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,7 +135,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
-- 
2.29.2.454.gaff20da3a2-goog

