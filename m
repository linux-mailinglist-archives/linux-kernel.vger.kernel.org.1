Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E644295FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899542AbgJVNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899491AbgJVNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:38 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53438C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:38 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f11so611393wro.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hz6KTz5FwSVcKdBcrWKk1T0dlNcGWPgygtgKcp7KEb8=;
        b=FFBTC951UmrhzpM9y+uLT8ZyOJj5GaA4k7AAgHlI5bzWx5afJoz6OzMm5XOyKBSXEM
         33gEVoauyorNsYP0Q+ECaBpvPq/DZsJ5GgUIr7AP8JaxkCXd6/ck44zNbrnvejRmGtPt
         EHfugNeWva1kLDKx2Qx1nxAVs6bGYzf2jmT6eIkENmOIa53fxT0rEq/NEicFsH/oNwGr
         kyZxIJNVaHioOKRiM7oaMAGLtWsmEWjRiP1xlZvhqFVIvyiM18wlBZsZyxxnH1h+QpZD
         MTSh30CAWNtQXA81JdLugm9ci6jQbTia/3CdNk9dj5LNdLvS1N9838gPFioY0FC54Psv
         Ekjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hz6KTz5FwSVcKdBcrWKk1T0dlNcGWPgygtgKcp7KEb8=;
        b=RGAsjX/oPCxczP9QcVm2cnBv5xHKROQK98GvtSlS7lOiRmeJ5AfWguA0zEwQ2wgIhd
         cOr3alXFKrkWVVPNGgVtmN6OZtNH6tmIBQaWzV2MKp/V1ZS+FjiTUKW8b9Lx6CKXxZ9L
         W6nHvfFnI/GB7Kb4kyy0S3riDS8uWxztFLyjkSW2ULCXKlBQ2KqOjYbLCAkeWV0jO+2L
         bsikLyMGjh5uvFxnvnsVvJA9ERDpb9LxP3K7mWJNh72eCnji+TMRMhS7n9H3rKi1o3Pv
         FYhBE1gev9S32JY+kQS2BDlGFIPxVXKQSOC1mVU+iZSQx/ZFlcnrkPgLNDlQaLQAufu5
         sc7w==
X-Gm-Message-State: AOAM533g/H/pO/8ebR2/5TITQ7a6tVywNmwNM6DOYNMVoIFq2MKPjaJW
        jwLew5IFqwQGVQkkxXqLdvTO4KsPNuwDvynf
X-Google-Smtp-Source: ABdhPJx5O4kSUaBGwRtLvKusVioF7tY95svs/rFufga7Cd+WWBIpFFtwb4jM57egcfFrxBGA7vCl5k+pvkZDaTLZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:108:: with SMTP id
 o8mr2676067wrx.256.1603372776882; Thu, 22 Oct 2020 06:19:36 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:57 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <1049f02fb4132390a6a314eb21dccfe5500e69d6.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 05/21] kasan: allow VMAP_STACK for HW_TAGS mode
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

Even though hardware tag-based mode currently doesn't support checking
vmalloc allocations, it doesn't use shadow memory and works with
VMAP_STACK as is.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..3caf7bcdcf93 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -868,7 +868,7 @@ config VMAP_STACK
 	default y
 	bool "Use a virtually-mapped stack"
 	depends on HAVE_ARCH_VMAP_STACK
-	depends on !KASAN || KASAN_VMALLOC
+	depends on !(KASAN_GENERIC || KASAN_SW_TAGS) || KASAN_VMALLOC
 	help
 	  Enable this if you want the use virtually-mapped kernel stacks
 	  with guard pages.  This causes kernel stack overflows to be
-- 
2.29.0.rc1.297.gfa9743e501-goog

