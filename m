Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41E302508
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbhAYMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbhAYMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:24:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DFE9222F9;
        Mon, 25 Jan 2021 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611574119;
        bh=Xp2YXhN5fYQEq2trNt3KUwGwkgV2teZlMQj7za+4IoI=;
        h=From:To:Cc:Subject:Date:From;
        b=QvKH9jeOavEWiOczUcI4W4UQQaWsny3NOCFBCniUa95Ut30fB55x3xS5KzuKfAle+
         NYQr9nE8Cb70EEV3bYUcMyxgvvj8GA8gU12vzqQC8w+bxVIa4k8wF76DK0QttkQonH
         28SovmJyPSmHPPykeccrah8i5dcqVr/oxcU9Umlv4FRsZ4gynvg6oX9R9piHSc2Q33
         OSNavd2AKbUVT3YXYBhsuTBeTNcFTAHNIqG/Ihe+PKQJ09UnefFHyOi1sKa6IOVqAY
         mqm7fqRrZ7ffiUoF31ODqeHQHfUVicGx9JbdYViqefWxp4Fy7IdHtY515fZ7mdk4+2
         5YDbFxLOSjh4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: export kasan_poison
Date:   Mon, 25 Jan 2021 12:28:13 +0100
Message-Id: <20210125112831.2156212-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The unit test module fails to build after adding a reference
to kasan_poison:

ERROR: modpost: "kasan_poison" [lib/test_kasan.ko] undefined!

Export this symbol to make it available to loadable modules.

Fixes: b9b322c2bba9 ("kasan: add match-all tag tests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kasan/shadow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index de6b3f074742..32e7a5c148e6 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -94,6 +94,7 @@ void kasan_poison(const void *address, size_t size, u8 value)
 
 	__memset(shadow_start, value, shadow_end - shadow_start);
 }
+EXPORT_SYMBOL_GPL(kasan_poison);
 
 void kasan_unpoison(const void *address, size_t size)
 {
-- 
2.29.2

