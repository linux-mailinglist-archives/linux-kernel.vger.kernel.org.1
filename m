Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FB28C327
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgJLUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgJLUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:21 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BEC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:20 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v14so6156211wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u0M3JfYyWMkI/QXNLQNS1i7R0v419+PHcT21ye/NQ34=;
        b=P9Bpbwrf7ePUhyg1bikYYDEAn4iMMRGflZLHgA94OwWkBJvLeRLI0TD+N2h3rjq9WU
         ePvc/SV1ZU015SzB+N82JCRCVsnz76wO3rPJ/D7YGIexU4qJ0x2QiueGqd7Dr4HrKvER
         C6DdJc4S3kCS7IS/zY7H5E5z56U/TGqmBDbiLHCHXczsuc8JExoDfpIKEMzb+SNH8U4e
         Luid7EB3t8xDJeTmSBQ5aaLg9srqBvXuI58+ISJ+n8+S4+tVRvw9NZnuueV7zmzE1YcR
         tLB3o08bUxD+KZN/X++ZHDEsZheFR047U9lTt0hgYnpMZXgpJjcR3n0L03K6yF8BtMRX
         ViSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u0M3JfYyWMkI/QXNLQNS1i7R0v419+PHcT21ye/NQ34=;
        b=nwO2SScaBG/1iS/F1JbF/9qwdpNrZaCaN697yEbPJ1RkQsxgoRX2VLrqZPmz0TERfU
         us11g/WYGPGGJg2uiovSodJTjXIoFNwZSWy14Be9Tvj988k4j/CO0BCEySO70dbXoGUc
         iCDrOBlaNv+TiGd0t3ERAHe41lF/EHFS4tW2JONb5zYW2vomkM86TumQFAIDiaY3hO6T
         jpCnFkn3tlmKHDxkcv9whOfImdhdmSRI97OMy2FhGOFGduUdsTk6wAdrhJRHZ4IgftV7
         Vm2PVEGq2CXChek/HLFB0xSQkkQ0UFVP7DMZi6l7F3y5JYVCU9q8Vq9swapDePQ4Ax/1
         rSNA==
X-Gm-Message-State: AOAM533XzWBTX31CLwtOiujjlXR6DeV+v67U8hMBbHZJ2VdLWRHO3M4e
        8iPQip5L7PHk75bekrJyalGqmKbnCuxP4dzO
X-Google-Smtp-Source: ABdhPJyyxG8grU7eqYgObWn3nFjQk7eP/gjqZUskR1yxWnL9GL59C4nJ3sTyRA75A74D3mWMbqtw1uPINXIN4Mfj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c10c:: with SMTP id
 w12mr12912546wmi.175.1602535519488; Mon, 12 Oct 2020 13:45:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:17 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <6106512e93a35c20a082b052f01b799b259f698f.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 11/40] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
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
2.28.0.1011.ga647a8990f-goog

