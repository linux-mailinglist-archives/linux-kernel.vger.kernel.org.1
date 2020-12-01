Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE432CA7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbgLAQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLAQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:17:26 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE129C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so1472562pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktiBTqbjFAD6ffRKByOoWmP2o55vmJOJ49Xz+HTLOBA=;
        b=nMVol2MbqeRm1ME8ZCx4q5FQy/6FnTLRoo0uT3QwUXVdnICzf95JYxDl0Ku/Qfm8KB
         m7ud9zijGlPMWe4ffBlX6sLOdDZv6+jzTqcJlKX7lDk2SfpA8M+f8bXeZn6PAWFk3oe4
         f5g1svqNrW2w5c/+vabfoLINQtbdLDQ0Z4msI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktiBTqbjFAD6ffRKByOoWmP2o55vmJOJ49Xz+HTLOBA=;
        b=NuupYAnFjQ+KmVmXHvfvz8LAQOVQbXF0INZJOYtFdMRIwnm2WhBZXThAZ2Z6PYINq6
         hEJjfRhFemftfl87gZDInBoDHlHv0+LXfI2zLEOkSSVSmhAbybFDYYPG7AEI2q3VOrSL
         HSVWd6UAC6zjaXKzDFXHh1OJmOA+31l9YCTLlJ5YJmeXaTD8WCe3JDmeckjsZF8pyVsq
         WdXVw7MBHHQxnEKkAtn7MDWKUpxwDtgZ0LgvdNHt0i+Lza7ylbcAeshCaWWaxNAyanJC
         jabH1QfRv0PsZ2gAOsGOLvJ3Jc5Vg0ZCAOjNsgmcVDJA6a8ql26mwr2OIh3mA+DB/XEG
         0F6Q==
X-Gm-Message-State: AOAM530zVEedoyscmYRNh/5v7AEaIfKljAXtsH4PHDW0x0R5+U+rR9pc
        d60C4aCT2eHAxD4rxMpwF6M9kQZH1PfRLg==
X-Google-Smtp-Source: ABdhPJxe/iHg9AKjvKSBXr2X/NJHI4J9BcoDNkvJXtHFX2PKH0KNKCgpa3c2HYXTBvQEAO5qretNPg==
X-Received: by 2002:a62:7f56:0:b029:18b:a70:4f76 with SMTP id a83-20020a627f560000b029018b0a704f76mr3167081pfd.8.1606839406112;
        Tue, 01 Dec 2020 08:16:46 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id jz7sm160129pjb.14.2020.12.01.08.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:45 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v9 2/6] kasan: allow architectures to provide an outline readiness check
Date:   Wed,  2 Dec 2020 03:16:28 +1100
Message-Id: <20201201161632.1234753-3-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
References: <20201201161632.1234753-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to define a kasan_arch_is_ready() hook that bails
out of any function that's about to touch the shadow unless the arch
says that it is ready for the memory to be accessed. This is fairly
uninvasive and should have a negligible performance penalty.

This will only work in outline mode, so an arch must specify
HAVE_ARCH_NO_KASAN_INLINE if it requires this.

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

I discuss the justfication for this later in the series. Also,
both previous RFCs for ppc64 - by 2 different people - have
needed this trick! See:
 - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
 - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
---
 include/linux/kasan.h |  4 ++++
 mm/kasan/common.c     | 10 ++++++++++
 mm/kasan/generic.c    |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 30d343b4a40a..3df66fdf6662 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -20,6 +20,10 @@ struct kunit_kasan_expectation {
 	bool report_found;
 };
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..ba7744d3e319 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -117,6 +117,9 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_arch_is_ready())
+		return;
+
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
@@ -134,6 +137,9 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 {
 	u8 tag = get_tag(address);
 
+	if (!kasan_arch_is_ready())
+		return;
+
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
@@ -406,6 +412,10 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
+	/* We can't read the shadow byte if the arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return false;
+
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
 	if (shadow_invalid(tag, shadow_byte)) {
 		kasan_report_invalid_free(tagged_object, ip);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 248264b9cb76..e87404026b2b 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -169,6 +169,9 @@ static __always_inline bool check_memory_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	if (!kasan_arch_is_ready())
+		return true;
+
 	if (unlikely(size == 0))
 		return true;
 
-- 
2.25.1

