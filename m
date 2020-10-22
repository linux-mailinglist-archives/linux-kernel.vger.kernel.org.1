Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47187295FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899750AbgJVNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899672AbgJVNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:15 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E871C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:15 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m126so997682qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mqqQQdM8JUr2kVRXhQOSR7CrNIaI2iWXdt/tai4LwbA=;
        b=tYUeZ/yuoAUqpMMtT3/FXIgF1U5aJ/Y/E3Q07dKl0M4ZTDGyDLG1y7pJyS20XAVNjp
         GtwFPBc7sHc1pInjRGbbIz1G+Wddt8RvUgbEcqpQabJVabz83pxs5+iYGehudHLpTAGw
         1m+lZXfOUZGZief7N9zp6TU19VIeQLN8s64Pqc1PqicXS5zNDx+UXRHBHn6wBlGNneyA
         n6iavQ7gpjas2eEHo8v7WaeaT39jAeU1zFUaIgjC9oHg5SDhR1Y6IeCguJs4YTVJoi3o
         FsInPlHbbG8001FIuLQ92owi/jo5PvRhUCEMmIGJiU88BgUAUbDY0ZfnjrJ3lvI4BK7/
         swTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mqqQQdM8JUr2kVRXhQOSR7CrNIaI2iWXdt/tai4LwbA=;
        b=O/1f+T77RshQtn7i+AO0tlPcrguMzht1s9GeVSHd8eqEehae+xyPTqeI+Xy001bh2D
         v6ltnfa96QsE+ekkQlD+aslQJZtr4mZwWyuXQ1s9rgEW2kChqCc0TGPDspwcJJ/wL/ej
         +cJwQCX0vXYXf/i93DfXQ1k6AWZamvSSTi4nWb1vIgMAJxzQK29l3YAtHANpcDSRPf8B
         T4Iwc42xIkDe18sNwgSsQwf1Df0Y5mKNAyNxhyrxotzJD2WuB7C2Gpg4iOfUTq7cE2oM
         LwADQuKnXIMdYBjzlei8I2vl7sovGXRvBgaiuWssEVh3m2botqXF0PTRrUrJP/hScOlw
         3VdQ==
X-Gm-Message-State: AOAM532LOtUAbLKMGhgXrnAs0OKk34LvFl4lbn6kiu+vkaxiqBrwBlS2
        XNqym076PR5HL9PzYVO5jFrXyIKRODBkOxdy
X-Google-Smtp-Source: ABdhPJwJgylx1JUTQNojAJNRJerxaTTFGMzntqBoaDQwRIiDViUSDSWvbVuNd0NgpRRQCLWkPAGm38knN8O0I1xf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a261:: with SMTP id
 f88mr2273549qva.56.1603372814622; Thu, 22 Oct 2020 06:20:14 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:13 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <6ed65cca58736301a1cacb539a6e672aecd7859d.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 21/21] kasan: clarify comment in __kasan_kfree_large
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

Currently it says that the memory gets poisoned by page_alloc code.
Clarify this by mentioning the specific callback that poisons the
memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I1334dffb69b87d7986fab88a1a039cc3ea764725
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 3cd56861eb11..54af79aa8d3f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -445,5 +445,5 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
-	/* The object will be poisoned by page_alloc. */
+	/* The object will be poisoned by kasan_free_pages(). */
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog

