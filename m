Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13E27B3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1SC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:27 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50441 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1C73EEB0;
        Mon, 28 Sep 2020 13:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=fKNGPn4b5sGwL
        Rh+ItgDgX7lMBGsorph0sms9B238k0=; b=XEu86+j+e7gcMHEv92P5s4xJp20rp
        zMFVKS65FnuMSKgAA77Gtj5Ut+FUrecE44+tUeEk6LFeW9NtYgTpYMm120lIOWGx
        HKht3fcFgqTYoq5eaVGgHK5PK8AhelDj/mEBUuq3cgVpjZ/OUSU++DpMZI8K84LG
        YIjEjqIXnkDi3RUfoY0XSLSIu8G2ETQ2XsEyId1umd5KLN01DJxt3rkbIv7rr1tm
        +KOna1sKXCp+cZEAZPGdRN+hzk+oS+y6HttZbrD3q2+llWNhzOpswf1GxRE0V73e
        SjuI2T4VXRU3LOUm/1Wvi0b8EELHFNSaY2bSuHMRsFt7//jDROOkxq96Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fKNGPn4b5sGwLRh+ItgDgX7lMBGsorph0sms9B238k0=; b=lsRyCnmS
        nAcktrPPtkfFAhB7BBGBbHqNo/gPpg3cChaqKww8YC0T6Y+zAygHI2S+g8Z4bVjX
        QRR7zu1tFpCbO4aHf6IPZAAd5fF2hhY/x+P0wHq3Kh/6KQDOZCpvOGuMFZ98KziJ
        Ex+CzzF4D+kBV6HuNyknRSav09t+z9bSTYrRziX7HxBtd9kOVQ7dxnLFhVXHSAwl
        HuN9o7AsduqJLdKQCbPw6wlAdkrTCqJki99q1sUS5+CN8FYdGRBspor/Y9zn7UZc
        wP7XsClW4DokSWczCjfxpj78fTugYYgGOlTD2TEFkL+BZ427ytqKodqCX7ZSEiE5
        +9DfsXEmWWATMQ==
X-ME-Sender: <xms:jyNyXzw97N3Autf9BzgcqiJZX788T6Yj5tTFmKGu6yknk5WmMeUBqQ>
    <xme:jyNyX7QW4H90Bap9JNeENDWriuvUtdfjk2MNUcw6W85DcPhsmUCRDdVq1zjKSwoe3
    OPXjKmxF4utoUvEpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jyNyX9W6H8R-8fdGjnT8-MHmqP_r-votdahNnx4Ca8VYFyMS7PG02g>
    <xmx:jyNyX9hWnTrQY7bUREvYW1Gc5uAwnH5-wEZsRQ8bBjNsvtB3YaV3Aw>
    <xmx:jyNyX1DOZ-wOyXBmL5u3CvZY3JWX6YYKjbKrHuGjZhFNKSIwnTOHaA>
    <xmx:jyNyX9YjCb3kjFXAgTX-TGmxo4ylxjBy7zGCwcs-JDmftoiQOZ8InqmnPNs>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C6BB3064686;
        Mon, 28 Sep 2020 13:55:27 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 26/30] mm: thp: add a global knob to enable/disable PUD THPs.
Date:   Mon, 28 Sep 2020 13:54:24 -0400
Message-Id: <20200928175428.4110504-27-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Like the existing global PMD THP knob, it allows user to enable/disable
PUD THPs. PUD THP is disabled by default unless user knows the
performance tradeoff of using it, like longer first time page fault
due to larger page zeroing and longer page allocation time when memory
is fragmented. Experienced user can enable it and take advantage of its
benefit of suffering fewer page faults and TLB misses.

* always means PUD THPs will be allocated on all VMAs if possible.
* madvise means PUD THPs will be allocated if vm_flags has VM_HUGEPAGE_PUD
  set via madvise syscall using MADV_HUGEPAGE | MADV_HUGEPAGE_PUD.
* none means PUD THPs will not be allocated on any VMA.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 mm/huge_memory.c        | 38 ++++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  2 +-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c7bc40c4a5e2..0d0f9cf25aeb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,6 +119,8 @@ enum transparent_hugepage_flag {
 #ifdef CONFIG_DEBUG_VM
 	TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG,
 #endif
+	TRANSPARENT_PUD_HUGEPAGE_FLAG,
+	TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG,
 };
 
 struct kobject;
@@ -184,6 +186,18 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 }
 
 bool transparent_hugepage_enabled(struct vm_area_struct *vma);
+static inline bool transparent_pud_hugepage_enabled(struct vm_area_struct *vma)
+{
+	if (transparent_hugepage_enabled(vma)) {
+		if (transparent_hugepage_flags & (1 << TRANSPARENT_PUD_HUGEPAGE_FLAG))
+			return true;
+		if (transparent_hugepage_flags &
+					(1 << TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG))
+			return !!(vma->vm_flags & VM_HUGEPAGE_PUD);
+	}
+
+	return false;
+}
 
 #define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 61ae7a0ded84..1965753b31a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -199,6 +199,43 @@ static ssize_t enabled_store(struct kobject *kobj,
 static struct kobj_attribute enabled_attr =
 	__ATTR(enabled, 0644, enabled_show, enabled_store);
 
+static ssize_t enabled_pud_thp_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	if (test_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags))
+		return sprintf(buf, "[always] madvise never\n");
+	else if (test_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
+		return sprintf(buf, "always [madvise] never\n");
+	else
+		return sprintf(buf, "always madvise [never]\n");
+}
+
+static ssize_t enabled_pud_thp_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	ssize_t ret = count;
+
+	if (!memcmp("always", buf,
+		    min(sizeof("always")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+	} else if (!memcmp("madvise", buf,
+			   min(sizeof("madvise")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+	} else if (!memcmp("never", buf,
+			   min(sizeof("never")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+	} else
+		ret = -EINVAL;
+
+	return ret;
+}
+static struct kobj_attribute enabled_pud_thp_attr =
+	__ATTR(enabled_pud_thp, 0644, enabled_pud_thp_show, enabled_pud_thp_store);
+
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf,
 				enum transparent_hugepage_flag flag)
@@ -305,6 +342,7 @@ static struct kobj_attribute hpage_pmd_size_attr =
 
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
+	&enabled_pud_thp_attr.attr,
 	&defrag_attr.attr,
 	&use_zero_page_attr.attr,
 	&hpage_pmd_size_attr.attr,
diff --git a/mm/memory.c b/mm/memory.c
index ab80d13807aa..9f7b509a3aa7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4282,7 +4282,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) && transparent_pud_hugepage_enabled(vma)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.28.0

