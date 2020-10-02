Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B09280D55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJBGO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:14:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA238C0613D0;
        Thu,  1 Oct 2020 23:14:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i3so215027pjz.4;
        Thu, 01 Oct 2020 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2q/oTmH3kZ+Yc6Epzks1Kzv6rqnQJPyOrzwLjdgg9AQ=;
        b=lVOALg2vj/xq/3vCp/mo596ub/QGT+sIQ0KD29J1NAc4VFcPdOCg4OXTsz4OUpRkCp
         rAZffe2nOlwBx1Uz5t4RZQmJ9rC+CDkJhirIpB3EFHmLDEQp9Ur7MRDtR0/SQOj//XCK
         u8UhM3TE64ENOQI/pxQQMp7EfiQ9mFpNxwIpXnsUB44lj1XtlkrS/mCoiS79gFyO7Sel
         /33QvQAC6RQpwHGlNUHwqAjabxD8g9fNloJMZc9qv9YpcsURx3w9KYnJ88ejGaPKNZeZ
         rzWQZGgpbIrIt+tIVmfdDO2I8litrGVkhj3sqYz/AY1N5V6Nj8kVgKsm6ajcFYTh5rXF
         NEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2q/oTmH3kZ+Yc6Epzks1Kzv6rqnQJPyOrzwLjdgg9AQ=;
        b=F8yTIJj+P7sR/JgQeK+vesIcXBoA+nPV2LYqBHrmStxHwMlEuFQhRZGKlMMqg3IBfL
         gkIkmF3El1bgt7x3GurDPwkam4JWA4E2Yzf4Ma/CXTKyyv4Hl89NsxqLrEeYkz/uzaxU
         xooTvZWM85zwXrVv9vT2Z7TRHG8rhqwwCPeQbQnqbHsqqigUp9Hmg7hDwminf2mDY820
         n4wbxl2IjXfaJuQUtwEHOYNeQPW2P57PRMhwS9zJ8BbXSDAmpS0knUjNkY7TkkTPtTRI
         j2PW4AfpGcpOW1gq/ZPabb8AxSwoaFUuE8DR1r8TF5uLLQ/+8Fh7HK14SN3e8GAmaoA6
         tfBQ==
X-Gm-Message-State: AOAM531udrDzBXdv+tyCw9v4O3NjfFXSFBGIWCyV56oa0OSLvqYXYovT
        Qx5IB9WEPYAjhcimu8qrNys=
X-Google-Smtp-Source: ABdhPJzjDlu8UeoudA4M3CFxiBY+oelv4pMVn67m1p3wD5j0WECnIVyr2j/P+hFe5sV6sn2yzDBbUQ==
X-Received: by 2002:a17:90a:f187:: with SMTP id bv7mr22770pjb.198.1601619296301;
        Thu, 01 Oct 2020 23:14:56 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x4sm577429pfm.86.2020.10.01.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 23:14:55 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org, digetx@gmail.com
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iommu/tegra-smmu: Add PCI support
Date:   Thu,  1 Oct 2020 23:08:04 -0700
Message-Id: <20201002060807.32138-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to add PCI support in tegra-smmu driver.

Changelog (Detail in each patch)
v3->v4
 * Dropped helper function
 * Found another way to get smmu pointer
v2->v3
 * Replaced with devm_tegra_get_memory_controller
 * Updated changes by following Dmitry's comments
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Nicolin Chen (3):
  iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
  iommu/tegra-smmu: Rework tegra_smmu_probe_device()
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 177 ++++++++++++-------------------------
 1 file changed, 56 insertions(+), 121 deletions(-)

-- 
2.17.1

