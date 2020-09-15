Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8324326B86F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIPAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIONBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174DCC06121C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so1902857pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzCS8EXafsw22jW584WXehOSckVkzDoTlfnh4khNpEo=;
        b=CI847Zj/5nu95tSosrklznikRuaOObypKdPqj4HUZgUNRmt1XbVJmWuAzag/0OYlb6
         MIGYKd7dTEHGbBXlsWNf/ZCrc78x/gqum2NxuSvIwKBO715W2IU/8DRtrBTNGrbWvdXd
         QrygLlTpB14MP06uq2TL7JQ7Yrh01EPoneHp1zmT3h9j+d8WvGM+t3Cwm0rsX2GAdRab
         eh+43UF1Kan1r/1cT840y1nng8NrB7JVRUvt2zXfY0s+zTg+P+91O7u7DhWIbn7Q43E7
         i8jshMwDwUQp1gvaOWrDFLXCmupOF/M7AAEDAQPyKhFtBzsH6aD/dbzHSNep9XripEWb
         LnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzCS8EXafsw22jW584WXehOSckVkzDoTlfnh4khNpEo=;
        b=Reuk+StXVq4oI+dOqmtvhD0M5S3zUnTRVSZUrMXv2GxVFYIc5WBxhC+GSNeThbKXzi
         cV+nhhm1tUuu53cRXstYzRh/Cfn7iMpPV0Vqa/rLpZiWYPrqUJ5AWjNgDeq8e1hcQ4ec
         NzUgF/3UUNXcs6v6wU1cx6Gzbjiae7DIFn7+MUTE0nqPE7IH2cvLoqVRNdxu5yTLWSPR
         WVb2TpuxLfmBKUW/NYEZinKz7UN5dE7CdSKG/XGTMEBRKBM1QDdjZzE4/tSSWf92J2Kb
         eDhUzvsStht03xwErw1W5gjhYC5AjkOPquzTWXc2CPZtijEqgy8dcn+rsrlZ3uMInLhT
         5eeA==
X-Gm-Message-State: AOAM532bPA8uwEM98GbvonlGuG+A0qXMH4peDe09AnLG5AoCO4cVjDkB
        z9Kd487GMVt5fCp3ZIzKLLTe/A==
X-Google-Smtp-Source: ABdhPJwWLmX2bwK4KzR5iePJzhj4/eXQJhfo6bmr7reawoCL346+hlc0xAAcCfx3B+T4ZfR4bCJVUg==
X-Received: by 2002:a63:d14b:: with SMTP id c11mr14914316pgj.64.1600174896481;
        Tue, 15 Sep 2020 06:01:36 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 09/24] x86/mm: Introduce VMEMMAP_SIZE/VMEMMAP_END macro
Date:   Tue, 15 Sep 2020 20:59:32 +0800
Message-Id: <20200915125947.26204-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we will walk the page table for vmemmap area.
So we want to know the range of vmemmap area addresses in order to
distinguish whether it comes from vememmap areas. If not, just we
can do not walk the page table.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/pgtable_64_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f2240d..bedbd2e7d06c 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -139,6 +139,14 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+/*
+ * VMEMMAP_SIZE - allows the whole linear region to be covered by
+ *                a struct page array.
+ */
+#define VMEMMAP_SIZE		(1UL << (__VIRTUAL_MASK_SHIFT - PAGE_SHIFT - \
+					 1 + ilog2(sizeof(struct page))))
+#define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
+
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
-- 
2.20.1

