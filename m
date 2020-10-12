Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBD28C337
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgJLUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731440AbgJLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B94BC0613DA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:10 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c3so11547307qvj.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yun2eenyP8tmp8dDLy7lH/4hFLH7rzsqZ0SoQ3Etw3s=;
        b=sZhcn8kF8DYVAhrqt1Ns7gnxUS61NytSR1Qk7PgqMkL9aNaMxgQX69tEO0l1guxBSs
         bZgU6A4nbr73Ut469qWALvD2+w6hN6cclcXKk9r1sA05Dbv7xyF/ckxyKyxfiT844mWy
         ItHaG78IlWYuBJudH9uIxuU1IKvC8RYYtOMlsQpKPsEdRX77D/r90H/hr8gP9ASNMTnu
         QvbREZM2hstwDMQ9NzBH8xrP2oB+E4NHJnLJroqdOmFUM7d88ki3jWdWKzcUfxLAiIba
         4zArHEaWWqQVEsVE8PTTTBA886452t4zQlM16LlFIR7WZhYSCrV97xeYhct9hfMfwvRW
         pmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yun2eenyP8tmp8dDLy7lH/4hFLH7rzsqZ0SoQ3Etw3s=;
        b=MkqOpdGx7zJt9Numjkl55eXPnKswED8isl73Z57WU18+zqmdq1dRdW4PvnSqdQvFZn
         Jyqzkn3kUokAvXuq+aYvtbT/0p2WRI+vM1v3wvlRPlWQY8IBGV+eXGXKOSllFBzUWwHq
         yxdgoo5DcO7hhovPwunw5I960ezUuLaB9i6JcjLLOwDsYnovfyRjusOE9QkIyjBYJUZ2
         dKN5JFDOUvPaPHC/IrGiPBKb2bDoVrGSPKsr7Xt/gfMlB9t2vy5uocWh51qyToC4Evii
         TyPUs3PnWqIf3nca0iFXZGoFFpN9FG6W4fP70hfmPq45TsI37E4qef1HBeamfJUAQdN5
         351w==
X-Gm-Message-State: AOAM531qOsR7UP6grXFWrvPZ6LbO9iR4EcKMNyoJD7T6sFS/gDLtxrWL
        PdFNJfO55oyFrbhbO9iwWWyBZpMW7uiVadq4
X-Google-Smtp-Source: ABdhPJxvJYqpGTrX7MXBIX+oGzP6+JrRIjDYnYPIdl63cInxop4XWZB5BKL1uA19ulvb+2PgLgkwGr8+w0DH88Ec
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:48c6:: with SMTP id
 v6mr3525139qvx.11.1602535569462; Mon, 12 Oct 2020 13:46:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:38 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <e91065e84521993ac7756822267353ac3deaff64.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 32/40] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 9c73f324e3ce..cf03640c8874 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	MTE_GRANULE_SIZE
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
-- 
2.28.0.1011.ga647a8990f-goog

