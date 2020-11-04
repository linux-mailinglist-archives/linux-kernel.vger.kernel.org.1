Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080122A66E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgKDO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbgKDO5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:57:00 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE2B223AB;
        Wed,  4 Nov 2020 14:56:52 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v40 22/24] x86/sgx: Add ptrace() support for the SGX driver
Date:   Wed,  4 Nov 2020 16:54:28 +0200
Message-Id: <20201104145430.300542-23-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclave memory is normally inaccessible from outside the enclave.  This
makes enclaves hard to debug.  However, enclaves can be put in a debug mode
when they are being built. In debug enclaves data *can* be read and/or
written by using the ENCLS[EDBGRD] and ENCLS[EDBGWR] functions.

This is obviously only for debugging and destroys all the protections
afforded to normal enclaves.  But, enclaves know their own debug status and
can adjust their behavior appropriately.

Add a vm_ops->access() implementation which can be used to read and write
memory inside debug enclaves.  This is typically used via ptrace() APIs.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
Changes from v39:
* Check only for SGX_ENCL_DEBUG in sgx_vma_access(), so that a debug
  enclave's memory can read and written at any phase of its life-cycle.

 arch/x86/kernel/cpu/sgx/encl.c | 111 +++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 328d5f61f1cc..5551c7d36483 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -282,10 +282,121 @@ static int sgx_vma_mprotect(struct vm_area_struct *vma,
 	return mprotect_fixup(vma, pprev, start, end, newflags);
 }
 
+static int sgx_encl_debug_read(struct sgx_encl *encl, struct sgx_encl_page *page,
+			       unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+
+	ret = __edbgrd(sgx_get_epc_virt_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *page,
+				unsigned long addr, void *data)
+{
+	unsigned long offset = addr & ~PAGE_MASK;
+	int ret;
+
+	ret = __edbgwr(sgx_get_epc_virt_addr(page->epc_page) + offset, data);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Load an enclave page to EPC if required, and take encl->lock.
+ */
+static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
+						   unsigned long addr,
+						   unsigned long vm_flags)
+{
+	struct sgx_encl_page *entry;
+
+	for ( ; ; ) {
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		if (PTR_ERR(entry) != -EBUSY)
+			break;
+
+		mutex_unlock(&encl->lock);
+	}
+
+	if (IS_ERR(entry))
+		mutex_unlock(&encl->lock);
+
+	return entry;
+}
+
+static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
+			  void *buf, int len, int write)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+	struct sgx_encl_page *entry = NULL;
+	char data[sizeof(unsigned long)];
+	unsigned long align;
+	int offset;
+	int cnt;
+	int ret = 0;
+	int i;
+
+	/*
+	 * If process was forked, VMA is still there but vm_private_data is set
+	 * to NULL.
+	 */
+	if (!encl)
+		return -EFAULT;
+
+	if (!test_bit(SGX_ENCL_DEBUG, &encl->flags))
+		return -EFAULT;
+
+	for (i = 0; i < len; i += cnt) {
+		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
+					      vma->vm_flags);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			break;
+		}
+
+		align = ALIGN_DOWN(addr + i, sizeof(unsigned long));
+		offset = (addr + i) & (sizeof(unsigned long) - 1);
+		cnt = sizeof(unsigned long) - offset;
+		cnt = min(cnt, len - i);
+
+		ret = sgx_encl_debug_read(encl, entry, align, data);
+		if (ret)
+			goto out;
+
+		if (write) {
+			memcpy(data + offset, buf + i, cnt);
+			ret = sgx_encl_debug_write(encl, entry, align, data);
+			if (ret)
+				goto out;
+		} else {
+			memcpy(buf + i, data + offset, cnt);
+		}
+
+out:
+		mutex_unlock(&encl->lock);
+
+		if (ret)
+			break;
+	}
+
+	return ret < 0 ? ret : i;
+}
+
 const struct vm_operations_struct sgx_vm_ops = {
 	.fault = sgx_vma_fault,
 	.mprotect = sgx_vma_mprotect,
 	.open = sgx_vma_open,
+	.access = sgx_vma_access,
 };
 
 /**
-- 
2.27.0

