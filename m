Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E42B2824
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKMWRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgKMWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:10 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118FC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:09 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o81so4009900wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ieTC1eIMY6CyRmTdTXieBU5zsmVSQCTeilNuNPVSDIY=;
        b=MjJCBEncrj8xBilA3MC/IrhC8npF4MpFUeoSWqardwF8WtMHowBEkfz6QsdUp41VVr
         +J4LvzKWsrwbVrLLk2qpjJRcSyC87faUI6wp8IduCJHpX0K5ctr6GpzMr++5SnEP1y87
         0UBXVa9hB9ZtuA9UxkID+P9Hxj227nCG33QJ2EjQ414QYokM3eIkBHNlNKoj2v6ZHXgB
         yx/cW+lCrlswPD1AWZ5dSNn+ODkjv4OeDs6AGMrr9t85A6JbloSEMmf6fMAqj4XE3BY8
         mWoKocsiRCFzkRzItxEfdacuqEgtos4cU3LdtCx0wHSwMPsCeVKkp60KjHPyAlVbov+w
         yk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ieTC1eIMY6CyRmTdTXieBU5zsmVSQCTeilNuNPVSDIY=;
        b=sJWLdPM2BSbFAwT5SnFeTB60960H6twdjGTlMXjis/un/lmncFTedSVcMSgdNcaTyM
         p9/QvvMzZwHf1mmke22PYYTgyvR8m4/UscWAFGVoYBgTwFAdDxSGAzl9GqWqXFyUFSIq
         jDB20XMjGkgpQwFXwEfQ5mcPDnSDxyb3XYy+8ylk9G5dIf3aqYI23jbPTMSrmdEkUHgW
         giR1XFqbGT5FlBWJaqeGvrYHVkfD2asJX1udnmByfIl4Twvkj1TBKNJOHhmi/kjsW82X
         pzriS0A9EZqGcJRhh/zIzJ2B8f28VuenysudhvsADMk4IptvVEjXscMDJREDpvbTUF1A
         tqLw==
X-Gm-Message-State: AOAM531FkJcgBVWryGmzMr1Hl4tyDJjbeRuCnPqt3e2jhBBkv+aoFr0E
        4zA668LI0xjwSsxUdbm4rK8d+1ic1I7LrzGF
X-Google-Smtp-Source: ABdhPJxAkxb/vWxkz9GFySmQsalysA4yEOIyCzpzAAfKAgB22xPBn7T0twxoArdcJmC1sUoQgKSYA7ZdPPFXlJ2A
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:212:: with SMTP id
 18mr4736487wmi.175.1605305828107; Fri, 13 Nov 2020 14:17:08 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:50 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <c11b96789e1717583a63e10acde14d44260acdff.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 22/42] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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
index 2f0dd5bde83b..c999da4f2bdd 100644
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
2.29.2.299.gdc1121823c-goog

