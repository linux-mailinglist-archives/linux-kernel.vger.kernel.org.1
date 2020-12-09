Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357342D48EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbgLISZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLISZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:25:04 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F23C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:24:24 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k128so884591wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=MhUwCIKPiL199xHdJxg2Ck7LBpRQrLyYixHELfUbAyc=;
        b=WwUpx13KzT7qOuh5g3F9arl34WO+3CEjo/xR1WuMOSPXo/tEePsrWHUOxKM8SeWrer
         oc97FEvV7huA5J8WVbQqeV7U7XdAZPlCzGSIA9JDGaZS49fHd8vDjzRHc4g/o3MLuaOp
         w0G8HZDuwyCOmg+iiNXmZTgEj4ks3HeXYCrSBlm1Km5S0Ykyv9B2X/nZvDddOFQAuj2W
         cxoG4tuWhXgAInrUQ36TGYi4ml1TgwCiIbgraTstErdTKeyKfHlBKL+KroiHh8id9hgs
         1f4Xe/1Bz/EySnkrE5BgmQpYX4QvlsR1cKO7j2V2W7duM880zotL9YwY1Coi8URFNSe1
         9uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=MhUwCIKPiL199xHdJxg2Ck7LBpRQrLyYixHELfUbAyc=;
        b=JJi9xmLEltj0q5WNI1clJaRgZ8R1rdhKBn3BxlaccPKuIoD3OGmAH6QOz6A5kxFQJJ
         s6ivk1L9azXvvf4RPeN9JJnCmpOjZrH4+b8SVvYItjLFYb1577DI2aJNPq3BP67xQHZu
         l7t9BGP062kHXiP9MeTlyx2PblHK/HK6ImmiYBezpF0ZcytijeKIfL/bOMxt6NivUoPE
         Ofxtvu/NYJEqz0LrPF1lDQWJG64Vs1UPf+omEqkd9SgZoKlYPVhQKiiU62Pa015qw1KC
         vCbVkNsUYb/r4VD+wZtlKgP5WlqefNpzwwKmnM2kFk4XlWLk18s0sK+eupfRzwRJaxcu
         24IA==
X-Gm-Message-State: AOAM5319arkeubFaNwlEatMFfeh6dY900Z1XJEqXLS01mB/Hco7aM1+c
        hbZfIquVk9WYKCwbTXPf9KywpggEu3jlrN/A
X-Google-Smtp-Source: ABdhPJxVgIzNZ4y2IZ7rX1yQCGfd8xeHX7ymrOfJX6tpGlbqXBEsN+PMj0WMsF1BoYGzxQp7HlG7PLCDe82wejay
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:2e16:: with SMTP id
 u22mr4177436wmu.149.1607538262970; Wed, 09 Dec 2020 10:24:22 -0800 (PST)
Date:   Wed,  9 Dec 2020 19:24:14 +0100
Message-Id: <cover.1607537948.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH mm 0/2] kasan: a few HW_TAGS fixes
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

Hi Andrew,

Could you please squash the first one into
"kasan: add and integrate kasan boot parameters".

And instead of applying the second one, it's better to just drop
"kasan, arm64: don't allow SW_TAGS with ARM64_MTE".

Thanks!

Andrey Konovalov (2):
  kasan: don't use read-only static keys
  Revert "kasan, arm64: don't allow SW_TAGS with ARM64_MTE"

 arch/arm64/Kconfig | 2 +-
 mm/kasan/hw_tags.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

