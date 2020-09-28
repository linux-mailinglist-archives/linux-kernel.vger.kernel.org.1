Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82B227B3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI1SBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:53 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41017 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 875AFE7E;
        Mon, 28 Sep 2020 13:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=hEDfPgaD0F1Ir
        Gg16yzXHXns+J50v05ddCe9x/z5XhY=; b=bqH0Bi6Pd970v1YMJbeVN95QTRqME
        aldJWGE6nstMyTGKIMSyKYimhbyFk7WMzI7vCdR8PdVq0PicpFSustr4hZluwT06
        CGjolCRuoWo4KLxCp61sy+TocJr55EjF2Hd5xIYj6hGyHxScwTwixkJmM5KotHMT
        +BvfQo3OwWd5RCdzkiqqsDLz9833zLZFkaO2wctsD7KXQzo0DOWEjUn6/QVKTKt4
        9EadzdhIQxAiHU9TrefdMSjAVgraKQ+4zCNH2Tvq/CHZfWrg6BHOrRRaRGsTdmOs
        75EXkC2YZ1JD/d4M6gj0BNmgWB+1ll2C6gWN4JvUN0Bt1j5R9ejkHtCng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hEDfPgaD0F1IrGg16yzXHXns+J50v05ddCe9x/z5XhY=; b=OK7wJUb5
        P6iKo/6Sh7RSJTZp9j4cEOt8OWrjc7IEw2eS+nqU5Dhs0vP34uu6WQ0UAIEW6oWK
        JbM8PByEmH3TM1N1VHJCP3q+svIFLcGctbECZr2kUdT5Oim5pT8bsjFxIk8PO6Ru
        Pswwd90kxdBEYcmS+bW/uUUJlN8JCkhowhTmqK9xdFNQ58Bf+Wx6Owe4rUkV9dBO
        qmLn11tFo4dxgQYh5azhsybW395xB5vEnqRhvU2JXI8TA2kbaa6UyPvxVvgPpVzk
        SthMtmmzeS9tQZYPJJQjjxZ497WHtp6C1DUapLbkXwUdCyxvQtjbVJEnpJHg4LI3
        e0YDPIRVDotUeQ==
X-ME-Sender: <xms:kCNyX5rMtxwZwm2TQpoFCa9bZF4-2g5LTVXBKgFFA3ix5Kxbjzrhsw>
    <xme:kCNyX7qVAs6X1WRUomMSNWewDI1xrjT0BwThu0vERDX4sRkozzM8Bf5A9X4hCYOmn
    HGLJxbskbVSt-JYLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:kCNyX2M0d1RHquYtLCelFHxNdkkiXFL5X9-wGdBEcdtpjw1XT24UkQ>
    <xmx:kCNyX06s-XkJfObyv8QU-rqwVb7FPkWgTU-Zqe1oTNudxp18yvQvVg>
    <xmx:kCNyX441SPi5XusrKPbbfYh18zhVyLTmDWOC9RanlilFGTgLw126dw>
    <xmx:kCNyX3SE8cRj6alXJZc8Fp-3OSD1VRe7_lydzanYLxfuoTpfUrFguk1jUZg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id A13CB3064688;
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
Subject: [RFC PATCH v2 27/30] mm: thp: make PUD THP size public.
Date:   Mon, 28 Sep 2020 13:54:25 -0400
Message-Id: <20200928175428.4110504-28-zi.yan@sent.com>
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

User can access the PUD THP size via
`cat /sys/kernel/mm/transparent_hugepage/hpage_pud_size`. This is
similar to make PMD THP size public.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  1 +
 mm/huge_memory.c                           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b2acd0d395ca..11b173c2650e 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -159,6 +159,7 @@ Some userspace (such as a test program, or an optimized memory allocation
 library) may want to know the size (in bytes) of a transparent hugepage::
 
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
+	cat /sys/kernel/mm/transparent_hugepage/hpage_pud_size
 
 khugepaged will be automatically started when
 transparent_hugepage/enabled is set to "always" or "madvise, and it'll
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1965753b31a2..20ecffc27396 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -340,12 +340,25 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static ssize_t hpage_pud_size_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", HPAGE_PUD_SIZE);
+}
+static struct kobj_attribute hpage_pud_size_attr =
+	__ATTR_RO(hpage_pud_size);
+#endif
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&enabled_pud_thp_attr.attr,
 	&defrag_attr.attr,
 	&use_zero_page_attr.attr,
 	&hpage_pmd_size_attr.attr,
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	&hpage_pud_size_attr.attr,
+#endif
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
-- 
2.28.0

