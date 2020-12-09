Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B62D48EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgLISZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLISZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:25:07 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DCDC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:24:27 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g198so652208wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=V2rDh/PTRpe6NWZnEeAWnr3LbupuxXOheZwv6czKP7I=;
        b=sJrzjf+rsOdspdQKnYG9pg0y0KJCU2rf0QxkpTRnNcP3e6Aub3MH1asP3rLsM6Yq64
         6sisT6KMQfH8oNrgEGWsXTZd3a3ZzfQwWKmo2YeftvCEs8fMbw2aspmzE5p531i4LWib
         1VibozdtcpLde7sbMU6UwWyMSZ89dNKXMFuU8igBRvKCyjCCajbL1nH1Xjfeuq0wS6bN
         JOZE9p0wa5eM3Zr0LFT/S393AuaG2VtA5OsN7wa9eLZD46TKUlW2qLXWAuuXjEA/yxPZ
         Tlswk9BfFM5KF/UwXKuc/0LtX+iT/vGi4np7MS7nlxVqpQPKBSpyre6qGHsDxa5L2Nyg
         gaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V2rDh/PTRpe6NWZnEeAWnr3LbupuxXOheZwv6czKP7I=;
        b=Ug/5PUnp6B5aJqDNCyyiwtLuMw3LohFUCilSKSZD+tYvStU3d8OP0Mq/CFaaK8MzSj
         RJwKKHunOayyY4zyTekqwFhiAMYR7cwO999SRxx/D4Gped7mx4yVzLcGTtgw+07EJ+eG
         +DPX4lhX18y4x0GjlHOZqiMCqoT6GB/NlyfGnNmNeuVsv8JS+pqb/lWMD1t56Ympzpca
         gVySnp5DkLYgwXOcIIcYsn5rGLwZwATaFikQZmwBnZ1UOFqqOMarQVU5atIzpl0v15nq
         YORZ+ljEmmz/79TRsmLzv2Vni6VEjR07mOtGWvT1154dS873keJ73fHCy1OAChIw1tYc
         /VOg==
X-Gm-Message-State: AOAM533Syt5TgR6C1IcALTh11n0X+OB/zMwBhVLJl/Z2RDWQabdlbqmW
        +GifATgcYaHCBK9HK8p6aohXEZhXuWttY/XH
X-Google-Smtp-Source: ABdhPJyP0L7+kNbjb687i7w1wzyg+YrLTPf+fehJ67MnVyUl7tP85xcGPS2oT8rxgT392YbT4bW+Ohr26jGwv8aY
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e710:: with SMTP id
 c16mr4123641wrm.295.1607538265727; Wed, 09 Dec 2020 10:24:25 -0800 (PST)
Date:   Wed,  9 Dec 2020 19:24:15 +0100
In-Reply-To: <cover.1607537948.git.andreyknvl@google.com>
Message-Id: <f2ded589eba1597f7360a972226083de9afd86e2.1607537948.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1607537948.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH mm 1/2] kasan: don't use read-only static keys
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

__ro_after_init static keys are incompatible with usage in loadable kernel
modules and cause crashes. Don't use those, use normal static keys.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This fix can be squashed into
"kasan: add and integrate kasan boot parameters".

---
 mm/kasan/hw_tags.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index c91f2c06ecb5..55bd6f09c70f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -43,11 +43,11 @@ static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
 
 /* Whether KASAN is enabled at all. */
-DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
 EXPORT_SYMBOL(kasan_flag_enabled);
 
 /* Whether to collect alloc/free stack traces. */
-DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_stacktrace);
+DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 
 /* Whether panic or disable tag checking on fault. */
 bool kasan_flag_panic __ro_after_init;
-- 
2.29.2.576.ga3fc446d84-goog

