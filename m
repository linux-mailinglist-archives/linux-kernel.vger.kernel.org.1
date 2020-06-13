Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C01F800B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgFMAmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 20:42:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:1255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgFMAlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:41:53 -0400
IronPort-SDR: 34ZjVntc9J+UzRTu199GGJSjDq5lMWPNnPWe7FohRj5vErcqdW4i1KPm7QQ/aJAAfWLdWEtKlp
 yxAjjoeQai4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 17:41:52 -0700
IronPort-SDR: BiFZdLQU/2ZsAJaAhFSUIxQzESoPLxP778H5G1z+nD1VLagLl5+itUKiQIO/7L5DmXTImtazEQ
 f+Sqx7eaG2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="261011226"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:52 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Frederic Barrat" <fbarrat@linux.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 08/12] mm: Define pasid in mm
Date:   Fri, 12 Jun 2020 17:41:29 -0700
Message-Id: <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PASID is shared by all threads in a process. So the logical place to keep
track of it is in the "mm". Both ARM and X86 need to use the PASID in the
"mm".

Suggested-by: Christoph Hellwig <hch@infradeed.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- This new patch moves "pasid" from x86 specific mm_context_t to generic
  struct mm_struct per Christopher's comment: https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/T/#mb57110ffe1aaa24750eeea4f93b611f0d1913911
- Jean-Philippe Brucker released a virtually same patch. I still put this
  patch in the series for better review. The upstream kernel only needs one
  of the two patches eventually.
https://lore.kernel.org/linux-iommu/20200519175502.2504091-2-jean-philippe@linaro.org/
- Change CONFIG_IOASID to CONFIG_PCI_PASID (Ashok)

 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc..5778db3aa42d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -538,6 +538,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_PCI_PASID
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.19.1

