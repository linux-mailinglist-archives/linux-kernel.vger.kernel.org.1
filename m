Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE62A66D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgKDOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgKDOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:55:41 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18DC7223FD;
        Wed,  4 Nov 2020 14:55:33 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v40 10/24] mm: Add 'mprotect' hook to struct vm_operations_struct
Date:   Wed,  4 Nov 2020 16:54:16 +0200
Message-Id: <20201104145430.300542-11-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Background
==========

1. SGX enclave pages are populated with data by copying from normal memory
   via ioctl() (SGX_IOC_ENCLAVE_ADD_PAGES), which will be added later in
   this series.
2. It is desirable to be able to restrict those normal memory data sources.
   For instance, to ensure that the source data is executable before
   copying data to an executable enclave page.
3. Enclave page permissions are dynamic (just like normal permissions) and
   can be adjusted at runtime with mprotect().

This creates a problem because the original data source may have long since
vanished at the time when enclave page permissions are established (mmap()
or mprotect()).

The solution (elsewhere in this series) is to force enclaves creators to
declare their paging permission *intent* up front to the ioctl().  This
intent can me immediately compared to the source data’s mapping and
rejected if necessary.

The “intent” is also stashed off for later comparison with enclave
PTEs. This ensures that any future mmap()/mprotect() operations
performed by the enclave creator or done on behalf of the enclave
can be compared with the earlier declared permissions.

Problem
=======

There is an existing mmap() hook which allows SGX to perform this
permission comparison at mmap() time.  However, there is no corresponding
->mprotect() hook.

Solution
========

Add a vm_ops->mprotect() hook so that mprotect() operations which are
inconsistent with any page's stashed intent can be rejected by the driver.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/mm.h | 3 +++
 mm/mprotect.c      | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..eb38eabc5039 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -559,6 +559,9 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	int (*split)(struct vm_area_struct * area, unsigned long addr);
 	int (*mremap)(struct vm_area_struct * area);
+	int (*mprotect)(struct vm_area_struct *vma,
+			struct vm_area_struct **pprev, unsigned long start,
+			unsigned long end, unsigned long newflags);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56c02beb6041..1fd4fa71ce16 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -616,7 +616,10 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
-		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
+		if (vma->vm_ops && vma->vm_ops->mprotect)
+			error = vma->vm_ops->mprotect(vma, &prev, nstart, tmp, newflags);
+		else
+			error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			goto out;
 		nstart = tmp;
-- 
2.27.0

