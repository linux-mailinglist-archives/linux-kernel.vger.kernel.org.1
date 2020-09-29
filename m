Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEB27CF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgI2Njh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbgI2NjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:39:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A46C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u23so2663914qku.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3tnm6vmpSMHKvgeLXX0r5hzQnU0w3hMCi/2IZuY8XC4=;
        b=B8oKuahjPhaobOS0+ZDZGeKP9b3kVA3jwzCcxNIsL5l1hg6A5Zc2U7KFaMS3MAGMY0
         O2hL41mHABBucJ709F1NABK5TlE3h6kkzR3QjUDxvA69lT2Vmg+yqtS1B3XgMaAjvzE+
         4mgLADkAmStachF+w18Th9hgSjlkxnNdA2E+2i5jhFaedCK3jmA81x81mzqGH5xIBIyK
         TkMYQ2Kj9iLx5+B4T/SPDvnT0Vw3vVftV8o6Nh1/NgB6hH97rCmgsyRflrUvp714+JV1
         oewV3A8DvxbQp4xOKTchYf3ipkGxIuyOJaeI8Huuw90A7+lq5iDbB1TqBs3kuFRIJ003
         1ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tnm6vmpSMHKvgeLXX0r5hzQnU0w3hMCi/2IZuY8XC4=;
        b=Vmkql/gVHaMPeDZeBllv0UfxBjCNT2GoSZXJyzdXYEpZdwDjYU+L8R8koRRGY1fWH1
         s9M4b70v7wUcXonTTsoAvtC/lBR3191Hg28xuzveA4JZB4MH/qUSDShNJ45n7CtyWdXb
         vVKoURx4okkp10OPAH7gAonSyAzt52rKoXXwFnS+FtUhwwcUF61P1NjukNoxaeV1HmRh
         UtJ7c9hF9c4VgsN/RvUSULq3YFC8wghdm3Yh3hGcalQ8uqSTRyp/bBPwSnl87jQ7vlEF
         ux7RCVaTA+fBx3hn2kVooJC81y1K3E1Tkm/Gf0+hX75iEbx6To1voGrFdTtayMpu7//L
         znAA==
X-Gm-Message-State: AOAM531ZBmWmu50sf8MKx1omTJXsqTXLOKxcZGJvKxVNV/xx3dl0669K
        ppDu2twCimQC9CVJ9Lbg+oV7ioWqXg==
X-Google-Smtp-Source: ABdhPJwtIaHl0p1/67p2AF0f5fwhdcugbouYy5zrrvCrbYXz74CVzZuBR+e9JMHZddr7RXMLFJNheXoidg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:fe8b:: with SMTP id d11mr4599326qvs.48.1601386739523;
 Tue, 29 Sep 2020 06:38:59 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:38:10 +0200
In-Reply-To: <20200929133814.2834621-1-elver@google.com>
Message-Id: <20200929133814.2834621-8-elver@google.com>
Mime-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 07/11] kfence, kmemleak: make KFENCE compatible with KMEMLEAK
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add compatibility with KMEMLEAK, by making KMEMLEAK aware of the KFENCE
memory pool. This allows building debug kernels with both enabled, which
also helped in debugging KFENCE.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
* Rework using delete_object_part() [suggested by Catalin Marinas].
---
 mm/kmemleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5e252d91eb14..feff16068e8e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -1948,6 +1949,11 @@ void __init kmemleak_init(void)
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
+#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
+	/* KFENCE objects are located in .bss, which may confuse kmemleak. Skip them. */
+	delete_object_part((unsigned long)__kfence_pool, KFENCE_POOL_SIZE);
+#endif
+
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
-- 
2.28.0.709.gb0816b6eb0-goog

