Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A51266A73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIKV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:56:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5EC061786
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so2360204pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=M9c9cpcOTriraBeGVD0L44z8T7iovTmc7GfDi51tJSUUohbR6doa1N8kc5HvhwTJHV
         Tp4Xxx2OxcZt4mE7UWXzWqaxUxFZoJ8b0DTIk+b5Z6qS25qoBngJI8VzY9kGazPqvGb0
         wT/bx73Nfnq7xYxvUG9tEQvM614OAxYcOy0rmuWNMjnLcJmUdrarVDfCBlp5+48jt5F3
         Lu44cYCXeDXWf2XVT2qo+WH51FT32bLWM0ucq7KvzYQoxF9mkKTNKd2mgu2BVfXRwQeA
         yRgBai4wBDSx1zaei02e5ykE8zoY9mcKrXyfKs5OjRRgfNqp4REaqE5RP+grXiBpEiWi
         xzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=nTQzKaSDRALlQhbo30/HGusPSV4P6VDoSoFoT9af/EaR7Z1NJzdB3VdEJYW4VCXrNp
         t7jRlvJsZRuolM4jNrMl/1LLDORueOGryYaS2LU4rTrn5+fygg/CAnC/ZSC8RRMDD99J
         5/fpHujDpILoyGZTGGJzenkCv3QRLS72Bw7Kvhaqd0rUCrUHPsHIV9sMFFSp2BFsuBEn
         abHzTUKY0Th58BuoQ/iIF3y4JkNnLW/ucYj93xwIedprRnPF9b/rkwhJHUMt/WOKU9GJ
         d708tfcNMcocRZS6lOy73w7piLboREdFdtRxannC59dyIfPHHcaikrqVu7DXPC1EoTw/
         BV4A==
X-Gm-Message-State: AOAM531lzAkd0dkeWgbjSFlk6JuwwcLJ1rqRo7k+/FB6W/vqcQOQIUor
        MqFyQFI9ZtDvpazxhXFb0v0=
X-Google-Smtp-Source: ABdhPJwmlK92M6fOcS/u0j8EYjUggKjel2zlw8APVsrNZIfOrBuKW6614COgHfMo5xYNUB/gh/Lf+g==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr3916986pjb.151.1599861370416;
        Fri, 11 Sep 2020 14:56:10 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
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
Subject: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data format
Date:   Fri, 11 Sep 2020 14:57:52 -0700
Message-Id: <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be multiple vendor-specific PASID data formats used in UAPI
structures. This patch adds enum type with a last entry which makes
range checking much easier.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index b42acc8fe007..7cc6ee6c41f7 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PCD |  \
 					 IOMMU_SVA_VTD_GPASID_PWT)
 
+enum iommu_pasid_data_format {
+	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
+	IOMMU_PASID_FORMAT_LAST,
+};
+
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @argsz:	User filled size of this data
  * @version:	Version of this data structure
- * @format:	PASID table entry format
+ * @format:	PASID table entry format of enum iommu_pasid_data_format type
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
  * @hpasid:	Process address space ID used for the guest mm in host IOMMU
@@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
 	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
-#define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
-- 
2.7.4

