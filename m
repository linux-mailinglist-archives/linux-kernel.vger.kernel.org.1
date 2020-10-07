Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973E82864FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgJGQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgJGQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:45:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25355C0613B2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:44:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so4899230wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=le1GUptU9JjBH114uU563JmUcYegKwYn9xh0zAQdRv8=;
        b=a2SgXBBUMUv5rmGUViyhFF3lXGILq+ogZQ2bnU5yTikNVO1UZPKFkXR+cMKdD1Rm41
         5hVocxtJ1ruQTjzYF+j/kcPmUrlEoxcZlfmxmNQGpyMtXOQYmsEC5x5GfoD+TsHChPd5
         kBGdx5zpKgy7OHc0eDbqjMmuhQ+fylwUh0bkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=le1GUptU9JjBH114uU563JmUcYegKwYn9xh0zAQdRv8=;
        b=Yrp3Ojr67kjllw8n3nUqqOKdtA3hk6juhKFOPn1175CSTz5L1peDFXwJYrMhFkWxjz
         Qkc6v5gEAJDR60owxzJq9OJWBau5KSc4PjaQfo60tASE/KoxGOXtUsQ333mmwWGBtTjt
         iZLqLO+vzsvjw9HOUYDwgq9hfJNBslPLZSiDCzBriBRZpkWilNgpP3yGXKpzrCZH9juj
         NNgswSj+eqcEkKKeT/r6x8mZvb3j8vJolp8U9P8z8xRN1Z/vf+5fS7t9D4yk22RWBnKx
         x1ugAMgYpxwxeGBdJNDyjvPQO+Aqe4pTPXsguoyFLAACr2ZRac+gBN4ESLhrcdboC4xk
         qHqg==
X-Gm-Message-State: AOAM530LGQ7s+qZVX4bLXWm7Y3FuMe6xVuhMXZ09TGk2RJJW0BiHvMF9
        q0vsuHRdxr1W/f3kPum5q8DuGg==
X-Google-Smtp-Source: ABdhPJyl2kosXxLomdssAdbm1Dfrg8OGKCCvnST/uKNr1+7zqiZZaytFpiBFyLEYCms+wEDhkOE1tw==
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr4000978wmb.7.1602089091831;
        Wed, 07 Oct 2020 09:44:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z191sm3332280wme.40.2020.10.07.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:44:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 13/13] vfio/type1: Mark follow_pfn as unsafe
Date:   Wed,  7 Oct 2020 18:44:26 +0200
Message-Id: <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code seems to stuff these pfns into iommu pts (or something like
that, I didn't follow), but there's no mmu_notifier to ensure that
access is synchronized with pte updates.

Hence mark these as unsafe. This means that with
CONFIG_STRICT_FOLLOW_PFN, these will be rejected.

Real fix is to wire up an mmu_notifier ... somehow. Probably means any
invalidate is a fatal fault for this vfio device, but then this
shouldn't ever happen if userspace is reasonable.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5fbf0c1f7433..a4d53f3d0a35 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -421,7 +421,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 {
 	int ret;
 
-	ret = follow_pfn(vma, vaddr, pfn);
+	ret = unsafe_follow_pfn(vma, vaddr, pfn);
 	if (ret) {
 		bool unlocked = false;
 
@@ -435,7 +435,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 		if (ret)
 			return ret;
 
-		ret = follow_pfn(vma, vaddr, pfn);
+		ret = unsafe_follow_pfn(vma, vaddr, pfn);
 	}
 
 	return ret;
-- 
2.28.0

