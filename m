Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68AB26AF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIOVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgIOVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:27 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED5C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:26 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 33so1726635wre.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ssmRcE1kYrAL6ZSKtgqrQSJk1HXoJcRhQCNgYvB5iuc=;
        b=hdJRfah27omL2Icwf/rxTkSFi5BnYgCVvskJ11E2UfIrsn1Mb/F7yTQcD06APh0cwH
         /PQM+iEq1I9X1SVCRt7GsbyaBFZ08nXIez8Ee31J+csXHA5G+18bpBS5Ki1z1hmKdAKU
         6aSiakRBh6ZFQ4FZoVBwXy53lbVrt3vVsusrJZHcUrT4kmDelLNgmQKyMb1LPB7Eyp/0
         9hxtjgFINQ+sYWtGquoG4hX7la9aJEm/9GWxIbMuRVtwFTKa9VItfgPlTwxd87Khgpfv
         /i9M6iSRPhprO4Ku7DQa5UReY8WpiUcbvMSF5+/rPjX3hDZ/4BKLyTMacs7ztFqkbKV6
         GPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssmRcE1kYrAL6ZSKtgqrQSJk1HXoJcRhQCNgYvB5iuc=;
        b=sJ3IlSHK5GRG8Sh8fuj4G8ztsKTYXkYDMemLX2juAusGnntXCGn4ogYyCeY7q9/6bi
         enxfg1rAmWvt81A6SmEySq8P9kYpWkNN6jr5e2FfAH9L82oTrEbz+llWGxAHRLLKGgU7
         I50ne4MAV1VbI0dk1J3pT8YmHZvZys4rzk1lhz5ZzDIMuz3v3Xepz2zlRB5CjnJpmFbo
         dz09l77UjY824x8be1/At2410fmQjJCJnRBHABpk0TG1p5h1s+tSfwVM5SS//e1UgKAH
         bqaYkzYV95y7HUkI5dc0FdK+ccFo8FVn1o7sXCXmotkEe0cySD93ygPqREbDuGd1G8KK
         fiig==
X-Gm-Message-State: AOAM532Zb0FLS1cnwJUrarjOc5TeRuOVH4YIOM3FWJv5bn4KlGEuGejf
        OJroiyyshWquEg6Pi68uzQEFhFFHDxfEKP09
X-Google-Smtp-Source: ABdhPJxK3f6kOYACU+1LPYljRJxMyomUs5lqQAssZQ0ReoMmGpVcJpTajmnKJKzKQyrcVQ3n/6jTySujdqs9K7LP
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:ffca:: with SMTP id
 x10mr15472756wrs.342.1600204585311; Tue, 15 Sep 2020 14:16:25 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:43 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <2de958570c5bccf438cde8eb8c2fce7e5a37deed.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 01/37] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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
Sender: linux-kernel-owner@vger.kernel.org
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
2.28.0.618.gf4bc123cb7-goog

