Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA070266A72
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgIKV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgIKV4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:56:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B990FC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so2317063pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=g1vRnfsD8m7ueG53tsKNPKs4doB1uhmhM7jbV2CqIGbxPPCi7tPSxcP5cbXOim2MFy
         xD0QUmCyC73y8wCetTdiRq4SQiifXwpUHBl84uIygpRLDQtIUCGC5fNYCB0jyJ78fdp0
         YbHk9M7AvrgRUsyQ5OHvPnBnYX/dHvO+/R73GkXalTZQWr6YPETDJFfi8e9mnyVVd2XR
         OlMSLAJ9kuywPDhxxSnUSpUG+IduMOvBaZEC/jaipqBuyhLqaleeCvbh8ZMkXRm4LVtC
         UrkDDxr8Toy5UefFzqLAZludBpWeukRxXLtyFwCsjkVRWrgTQDbGRIEFmp5wqn55ksis
         5ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=HI39YbSSr96hJ7nKE0NdcEcxtHIncBMS630nI6HtHunusfIQv+3buE7jUnlYiPEDLI
         bp79jVi1hWy5JB6/7F5cflcxlWMEFBfT43MwU38mjElO23cZ1xaHP5Zy2S1yt2B1aZ5t
         jFk8O8iRDb0ai/8fQwWVlUCO+N3mt+HLPF0PG9aPImVomKagFE6RR4I/hlTQ/VoFHdsP
         B8BVGT+wLfxStPvhyBUzoKUtA0MMmplzvwpchaxkbK7VlFeFuyLQHGshR3dwrcKZNVWw
         rgDCPz5cOwzE1y7/18+m9tx7NKyHp72Fgbqrr42ZnoLyDihLStB+aVPEpjp89s44FHR7
         6EOw==
X-Gm-Message-State: AOAM530fTkMbADdo1Pclz1SRMDHzxq+uIuHlP1lBgxmqjHjMLQSLvVoq
        UuEFyExLti0UmUtlrBS7yzg=
X-Google-Smtp-Source: ABdhPJz/myLbsxkV+GFYo/DtWNDDBhvmWiZ1v6vmj0NRM4A2phEIn6ULCgp+8t6sfozt71jNC488Yw==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr4064017plr.12.1599861369317;
        Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 14:56:08 -0700 (PDT)
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
Subject: [PATCH v9 2/7] iommu/uapi: Add argsz for user filled data
Date:   Fri, 11 Sep 2020 14:57:51 -0700
Message-Id: <1599861476-53416-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As IOMMU UAPI gets extended, user data size may increase. To support
backward compatibiliy, this patch introduces a size field to each UAPI
data structures. It is *always* the responsibility for the user to fill in
the correct size. Padding fields are adjusted to ensure 8 byte alignment.

Specific scenarios for user data handling are documented in:
Documentation/userspace-api/iommu.rst

As there is no current users of the API, struct version is not
incremented.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index c2b2caf9ed41..b42acc8fe007 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -139,6 +139,7 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
@@ -147,6 +148,7 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
+	__u32	argsz;
 #define IOMMU_PAGE_RESP_VERSION_1	1
 	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
@@ -222,6 +224,7 @@ struct iommu_inv_pasid_info {
 /**
  * struct iommu_cache_invalidate_info - First level/stage invalidation
  *     information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @cache: bitfield that allows to select which caches to invalidate
  * @granularity: defines the lowest granularity used for the invalidation:
@@ -250,6 +253,7 @@ struct iommu_inv_pasid_info {
  * must support the used granularity.
  */
 struct iommu_cache_invalidate_info {
+	__u32	argsz;
 #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
 	__u32	version;
 /* IOMMU paging structure cache */
@@ -259,7 +263,7 @@ struct iommu_cache_invalidate_info {
 #define IOMMU_CACHE_INV_TYPE_NR		(3)
 	__u8	cache;
 	__u8	granularity;
-	__u8	padding[2];
+	__u8	padding[6];
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
@@ -296,6 +300,7 @@ struct iommu_gpasid_bind_data_vtd {
 
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
+ * @argsz:	User filled size of this data
  * @version:	Version of this data structure
  * @format:	PASID table entry format
  * @flags:	Additional information on guest bind request
@@ -313,17 +318,18 @@ struct iommu_gpasid_bind_data_vtd {
  * PASID to host PASID based on this bind data.
  */
 struct iommu_gpasid_bind_data {
+	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
+	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
 	__u64 flags;
 	__u64 gpgd;
 	__u64 hpasid;
 	__u64 gpasid;
-	__u32 addr_width;
-	__u8  padding[12];
+	__u8  padding[8];
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-- 
2.7.4

