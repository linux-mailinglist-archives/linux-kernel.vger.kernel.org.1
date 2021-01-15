Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203F32F81E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbhAOROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbhAORN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEf8T0Go1KzAUeqBOwWH7qIZostwBrdc7d1MGMOL0rE=;
        b=BX92HX4Ixkj2IE0CaeWvZzz4pKXAxFTj4C2MM5m0lkcafMFgqYtw5fLnSvvH/0jA3iPIbh
        wWsjUmLh94ySw2cPoX0X1ieCqWfxtKOppToFAUhK+NMsavrm9oO9LafORiim8vvBdAlYIS
        0Yjc7piTqeUM5D3pqpn5NSHOVyThzQA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-E9O-XXxsOo6_BZSSTPVIqw-1; Fri, 15 Jan 2021 12:12:30 -0500
X-MC-Unique: E9O-XXxsOo6_BZSSTPVIqw-1
Received: by mail-qt1-f197.google.com with SMTP id t20so7903106qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEf8T0Go1KzAUeqBOwWH7qIZostwBrdc7d1MGMOL0rE=;
        b=koyadlh08WnBNN1sE7lBMD43yLcOrexTdlCBws8CInGgWB4BCRX1K/uSv+zfhbhkVz
         APsZ+uL3YHS1K+rliqbNIhwb1/kFVlQjz4NJQ9+da8iXG7XyWcgTDLuHsGPaa2w9xywT
         zSspb3WDCJBeq5T0IMgEhel/s2eh8F+tyF/WIv2GVNoIMK6Ap0ND28o5q7WNiORw5Ihh
         irLWZOpJoYlPXgTmh+65IiOm61FpNDgtePqNoV4GklEnHxqDlVQsje18VD2pGbINqU5L
         s/qVWwfPDdBWz94M8jP0Y4Dwj11pKJaXNH9SGrTYqC66kE1nF3k1G7oiEq7ncXL6BZBE
         Guiw==
X-Gm-Message-State: AOAM531yl+dK1ebImMCe/n/pQVxHien5o3IZ/r2iC6B3s45X0K8nsVdw
        oJvTkEilhTp8reB/FonsWiUI4PJ2UljyjdW8ytMbfELbnHyuRjr4adUp85UzvrcKmgyCdoD0GjB
        3U+fiG9LodYdJ3SrgGZrx3uHz5fDfOJ+c7RsQMY6yTPX0rl5iz5odrgeu4Mp7EMnfzl2hxgz2Og
        ==
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr12717694qvb.18.1610730748451;
        Fri, 15 Jan 2021 09:12:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrBIMScW0Akbh1tP53btOa7oiIiWgBQH32e/IJAnpRq/urGVjQU2YQNcHoeHxeMdk+kjiB3w==
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr12717658qvb.18.1610730748161;
        Fri, 15 Jan 2021 09:12:28 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id x134sm5418843qka.1.2021.01.15.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:12:27 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 30/30] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Fri, 15 Jan 2021 12:12:26 -0500
Message-Id: <20210115171226.25127-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we added support for shmem and hugetlbfs, we can turn uffd-wp test on
always now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index c4425597769a..219251c194da 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -77,8 +77,8 @@ static int test_type;
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
-/* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
+/* Whether to test uffd write-protection.  Default is to test uffd-wp always */
+static bool test_uffdio_wp = true;
 
 static bool map_shared;
 static int huge_fd;
@@ -295,9 +295,9 @@ struct uffd_test_ops {
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 };
 
-#define SHMEM_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
+#define HUGETLB_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
 					 (1 << _UFFDIO_COPY) | \
-					 (1 << _UFFDIO_ZEROPAGE))
+					 (1 << _UFFDIO_WRITEPROTECT))
 
 #define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
 					 (1 << _UFFDIO_COPY) | \
@@ -312,14 +312,14 @@ static struct uffd_test_ops anon_uffd_test_ops = {
 };
 
 static struct uffd_test_ops shmem_uffd_test_ops = {
-	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
+	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
 	.alias_mapping = noop_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC,
+	.expected_ioctls = HUGETLB_EXPECTED_IOCTLS,
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -1453,8 +1453,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.26.2

