Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3A266A76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIKV44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgIKV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:56:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B6C061796
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so8332481pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
        b=A0qlapw3A4c7YtVi00FmPl8ymWgrjPsx2DrrKrqLzsqHLrCchxkEbpMQmSlzA7Sr5p
         n/auoNjGPqafmkPfgHDVFdpx7Td+mnRaIaaSwKqMbjsJDJIfQWxAur7UTSbWjnILbr40
         iDkZWsaH8G+GarxsjJgU2HpZQZT9pXAhqvHAs2idHczElTilkkYmfr2q3DabeqFdJF7n
         JmYQcShfkWH6dgTkO79WIZJjjZY6RjPOPT/WSOhNY+6xA60CSk06FXKSFYonacQYylxy
         yb3xYMlJP5Qs8yXiJSBhH/qLBCsK8gi5h0ra1n1o4Qili+K6ALFN3B7w3q1Iek47mMey
         0BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
        b=eR0IxEKJFOdeZFbuWGWLxUDJTxzuhbZnI5Wo58FXvgETP87U8yGP0jeJVnEytmbOs1
         aS67bbP/WtsUOkOgMJ5pAh9/MUg7PBBgAG9oFCyc11bq7IN/tzL3MJbZ5dNQyQOGCFQv
         RBTs8uLbi3JuiKz1AMO+aTBeByIXoqSxJL4NzVVGEpJ+OJnKqpGgm5I1ai8p9ExmLvI7
         OQF4UoOgMHYkt/9LotuuaCX/kTtvzqHH4LtIPPn/DGpU4ov25vmmqXWLSlXzGO2MVEGp
         lnSS7Ai6wCJz91Kn1jjzCK4oVz0JMLB+7E0Qm+rNqjDUsyFo2jg3LDZJU6MIi0LXHQ4X
         7OIQ==
X-Gm-Message-State: AOAM533c1urYcESC7wi4pwpLvGgX8JFfjg3CevQD0QQ30ls+B6TuL7l0
        eufCryfUj64N0nBEHghPWrE=
X-Google-Smtp-Source: ABdhPJzJv7fOGfnTOBv70jtm8/s87p0cnbQsFvJYFt5ONU+NmlUlWogNW93c4y4sEoiYDMFBOTtBSw==
X-Received: by 2002:a63:30c:: with SMTP id 12mr3140253pgd.66.1599861372261;
        Fri, 11 Sep 2020 14:56:12 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 14:56:11 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>
Subject: [PATCH v9 5/7] iommu/uapi: Rename uapi functions
Date:   Fri, 11 Sep 2020 14:57:54 -0700
Message-Id: <1599861476-53416-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User APIs such as iommu_sva_unbind_gpasid() may also be used by the
kernel. Since we introduced user pointer to the UAPI functions,
in-kernel callers cannot share the same APIs. In-kernel callers are also
trusted, there is no need to validate the data.

We plan to have two flavors of the same API functions, one called
through ioctls, carrying a user pointer and one called directly with
valid IOMMU UAPI structs. To differentiate both, let's rename existing
functions with an iommu_uapi_ prefix.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 18 +++++++++---------
 include/linux/iommu.h | 31 ++++++++++++++++---------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..4ae02291ccc2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1961,35 +1961,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info)
 {
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
 	return domain->ops->cache_invalidate(domain, dev, inv_info);
 }
-EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+			       struct device *dev, struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_bind_gpasid(domain, dev, data);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 ioasid_t pasid)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_unbind_gpasid(dev, pasid);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..710d5d2691eb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -424,13 +424,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_cache_invalidate(struct iommu_domain *domain,
-				  struct device *dev,
-				  struct iommu_cache_invalidate_info *inv_info);
-extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-		struct device *dev, struct iommu_gpasid_bind_data *data);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+				      struct device *dev, struct iommu_gpasid_bind_data *data);
+extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1032,21 +1032,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int
-iommu_cache_invalidate(struct iommu_domain *domain,
-		       struct device *dev,
-		       struct iommu_cache_invalidate_info *inv_info)
+static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+					      struct device *dev,
+					      struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
-static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-				struct device *dev, struct iommu_gpasid_bind_data *data)
+
+static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+					     struct device *dev,
+					     struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					       struct device *dev, int pasid)
 {
 	return -ENODEV;
 }
-- 
2.7.4

