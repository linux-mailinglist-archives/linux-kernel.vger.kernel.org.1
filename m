Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822F26B87B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIPAo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIONBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD8C061355
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so1888942pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZrW0owKm5Gu/md3j3csp/5vC7YMmkDgEblXZgaxGvk=;
        b=rKQ26Puop/3DC0nrZnzSaunkjQvxjCcWAFcRgsiFlS5oDPySzDrGYBOFscTRKZ4YlM
         HaZkWdGc00lfINkpTlQMky/65NALAje0ARqIxEgH8YHLW7y7qMzJoRrKyRVuYSbP/nf+
         XH+MsNGqG3VKJTq7YO2bdVXuP1ZxSlHHxR7GFhsEItGdJemBjAS1la5HsrJ/eZvvGPT+
         uMOO4JsqFuKv6FtCD0c5rWItP6VMCkdTcNiPG/pDcH2K7Gwv8fleIR1REqxGU8d0hvRN
         zVLvYD5ThV6VB1WeSJIJx6TUdr4YJgoVoF3sNLFaVYR08jBnTX5fXC9FmrD2eOTInsFw
         GDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZrW0owKm5Gu/md3j3csp/5vC7YMmkDgEblXZgaxGvk=;
        b=he3vZ48qAVzzKkIiit73RQlgsL4SOLFlT5TAdcXi1VqCMgYKJkHJOdy5U1EOJjzppd
         0b6Gs1zq5eQh3Wk68y5rfynMvFy9+zQm4KGQpraA2l1oq6Uq8I+5xDeYETUHm3QvO0o0
         ZFrz28u43xnZHzm2ihuNB1U0JZplsLU7x8e7kr1r1FRNCXFxJF8ox/SFRCFF2wzIrJD/
         K4VsruTDe633kAAfsXWxUTEz+dTfXZq1xvShh9qTMuxLLYwQGg6XFt53qT0Jh1vFtcSe
         s4ZD6hdPOrarbiQ/o1MT1Q1ycqLzRC/yVdukrQHiFy2eESbtMoTEtNNez4hgPMijSPIM
         DX9A==
X-Gm-Message-State: AOAM532dJa97sWZbBH8ytIL6U5VERshp7LQtvvQtduQPe3m297ZO3Vfx
        EdxaOKqFDI3bXMtrQZeQezi+BQ==
X-Google-Smtp-Source: ABdhPJw36/tEPEk+vlzhPHIn06m+FQnqNgd2oPnWDmzY+7j8re+39DQktUux3tDDjqBaTAXQu8D/0A==
X-Received: by 2002:a63:1226:: with SMTP id h38mr14256662pgl.196.1600174876644;
        Tue, 15 Sep 2020 06:01:16 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:15 -0700 (PDT)
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
Subject: [RFC PATCH 07/24] mm/hugetlb: Add freeing unused vmemmap pages support for x86
Date:   Tue, 15 Sep 2020 20:59:30 +0800
Message-Id: <20200915125947.26204-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 architecture, we use hupe page mapping vmemmap area. We
should define VMEMMAP_HPAGE_SHIFT to the correct value to support
freeing unused vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 1721b1aadeb1..f5e882f999cd 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -5,6 +5,11 @@
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
+#define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)
+#endif
+
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
 #endif /* _ASM_X86_HUGETLB_H */
-- 
2.20.1

