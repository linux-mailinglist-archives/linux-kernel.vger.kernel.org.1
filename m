Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F072C2A711A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgKDXTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgKDXTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:17 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B95C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:17 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 8so9122wmg.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z3coWAI2tcKTBrlblI3/IYJAWnH07Z1QBuIRVdtXJnY=;
        b=XQOwaLsjIcVG6su3AN+CYUdsA5WUuBobYe8xvDWSId42JpjafUyuC5mkuGD9M7cJEO
         IRBpNjzWtQCQhoCS+AwXFlU/pJfHm4LUhojUCMSB5U7R+GQbyxixrZ3kmDIUuyHLxmiw
         D9JlmNxbc3wdURiVDE9fVjAUeid0zK0zFixaEt2UXw7Z2kx6Tc1s2UsqJfbLEYFJsNVX
         +FT5O6bxqlJZRiXsdHIY57GSre77QLnVThkrJu0ASjZCNtLRSexnsbU2gvQItwdvP3B8
         xPC3JjiYAn62Q8QZ8HIQB1chVyCv4Q6GeZmmhIutTOV6zEgaFUeNhwKcV0fFQmGB7sFh
         5iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z3coWAI2tcKTBrlblI3/IYJAWnH07Z1QBuIRVdtXJnY=;
        b=ldIdTL4MdqpXtdUlLFDgDjXP+ZtnWXqMFecVg1PyL5PofUOGdzPPeuOo3cLDHgjva2
         XoTHN+n3pyjriXWc4qA09JjhDggqPT3U/My0aoKpNR9vxtpUlqlFLsYYHU+oHxiTnHgp
         YP4qbz9yAN/G4zZtQlWjZdL/K2rXh827zRuzzH/e9Bunq/GkYQDp5jkg2pIF94hYmqXm
         mbLKS5GtpAaKQgmjUPhw+KBdlPdKRqSFn8z+XWJgKWneV9fDYiv2gNh6C/zzXLTM5S8M
         BMjodrsC3FVecvfrnIOcSwEEelPPNAQ64r4RMmVBwnR5KwpRCUM8RyV5DlsNDhCQHVj6
         y/VQ==
X-Gm-Message-State: AOAM5306Snbbv3okvw8OItNoWt5vGpvtJPctsmWmJMYJ7D+sssqsn5mR
        ZRH54UXu/rnZmmi9WjM8dTg9iUfvSslSxLYJ
X-Google-Smtp-Source: ABdhPJwNrhTgbZprL0G3S2ieCLesniBqAGqR/k9jY6mA8OpBniFVTsIN+owzPS7pLTwiZuVt4MXWlGO+IR55i+eQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:a752:: with SMTP id
 q79mr97594wme.24.1604531956154; Wed, 04 Nov 2020 15:19:16 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:19 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <f105f0703bd0c80a538f0f1f78a8edd342b81a1a.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 04/43] s390/kasan: include asm/page.h from asm/kasan.h
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/kasan.h relies on pgd_t and _REGION1_SHIFT definitions and therefore
requires asm/pgtable.h include. Include asm/pgtable.h from asm/kasan.h.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
---
 arch/s390/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
index e9bf486de136..4753ad0c3cba 100644
--- a/arch/s390/include/asm/kasan.h
+++ b/arch/s390/include/asm/kasan.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
+#include <asm/pgtable.h>
+
 #ifdef CONFIG_KASAN
 
 #define KASAN_SHADOW_SCALE_SHIFT 3
-- 
2.29.1.341.ge80a0c044ae-goog

