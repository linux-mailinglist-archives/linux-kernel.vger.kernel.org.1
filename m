Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F22F4F73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAMQEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:04:21 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FEC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:41 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q18so1156830wrc.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TionkskhfJFUpeI/OKXUNvEID4OHoy9zg6Ffh7JmH8U=;
        b=CDyrzARrVWFbuNifeul+Ll6GNbUn3MtdKoa0QdzHXSOPzMxbXAa7Z/FvEsSB2IPRrW
         enMrgXSKOeK3msMJO/vfXcb+9JOTd7R8a1VjRZ/ULWPr0g5AiDXOpZfbVIA7QbmrjjLC
         fpV17EGOTCPZOpybyXa7JbPD6CKpgp0WKU6sVKxPLH+PNidH+RTGfKve7sdwxM0Z16FB
         LWD2vekX5jUN8zAAl7Sf8PityLr6lD8t0vPjkwswCG6Ru8XRUIb2jRtx4a3ElWN9jXGD
         4CcvIiyT7b2Su7QJuJPuGTsoEbbxb2hkmLg2nDCnYXnMLK7KB4hqQnZEwCeqZha6aiPI
         OYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TionkskhfJFUpeI/OKXUNvEID4OHoy9zg6Ffh7JmH8U=;
        b=pEXFt2T0CdsqQjX+kh8mLUSD9ozuNecfqk3vJdVTX+Nr53f+hwsWRmKP0BRPl6ywAX
         JT9cXqh0JsXIZt5aUI9yTCZ4xyivHh55I4tHGB5BTx7yGdlTdWBmyWkcmEtM3GGjVKL9
         9tgWr4EczrKdZ1VFkw80YCMBT3+PZlkxXebbfyBARy/la4SEUf5S5NIV4rhGzRBzndkh
         MmddOQGF3gvI1HkIjjolv5mK1V96JGijgvJUjaYX37/5RmLxlc1csvzDLz4QcUE42XEa
         injf/i9Xt929YpdCzdMSlygv5ey03XnXm/pehNNmY6kyFsExBeBw1MKzf/Umb3ixG014
         UwTw==
X-Gm-Message-State: AOAM533/6a4oF5uqSeiKYYQRJH9HeVFpiDXC1DmLGixAnawOFf+ALIIN
        lXvutbA8RCWBI64Px+9Njk6Vf8EB3VS5OHVB
X-Google-Smtp-Source: ABdhPJxqarOEyeKYbqGN5d2jvJR/uvZGjSvQgP26Nb2T8OhUp0hSrBOuQZdB1FVfKQ+fxQyDVc8hMJzo5rC3Fwoe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:222:: with SMTP id
 l2mr3287308wrz.392.1610553819541; Wed, 13 Jan 2021 08:03:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:03:30 +0100
In-Reply-To: <cover.1610553773.git.andreyknvl@google.com>
Message-Id: <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/2] kasan, arm64: fix pointer tags in KASAN reports
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
that is passed to report_tag_fault has pointer tags in the format of 0x0X,
while KASAN uses 0xFX format (note the difference in the top 4 bits).

Fix up the pointer tag before calling kasan_report.

Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3c40da479899..a218f6f2fdc8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
 {
 	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
 
+	/* The format of KASAN tags is 0xF<x>. */
+	addr |= (0xF0UL << MTE_TAG_SHIFT);
 	/*
 	 * SAS bits aren't set for all faults reported in EL1, so we can't
 	 * find out access size.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

