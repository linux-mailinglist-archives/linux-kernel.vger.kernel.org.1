Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8998A2C3D73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgKYKMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgKYKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:12:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1EEC0613D4;
        Wed, 25 Nov 2020 02:11:49 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 81so2059632pgf.0;
        Wed, 25 Nov 2020 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vv5V+2hLr729rED7Crr86lpX2HrSw0iB0zF2Ja4Hlcc=;
        b=BZFjviglzi+xn8MJO9vBkgjTXTqH74pv4S2JyLBfeD5UBXB5izYqrI3gq2bWEG50nr
         xVVOwMzzPQXfdC8s8vRJ7QOFqwpRXbHum/rIUzB5L+R+r87dFM5mEawigVWchUtzo3Q4
         qpcHu3QrGNNooL5tDQOxR0v7BVjhUhnZW+hzB6+pcvbsRKN1faNd4QXZkWInduJEt2rw
         KAGVVT8hgZqK/TJ6rBFyOE33gOrbwjL97r0kRtCDwqCaq+H1pkkvJumHHAsXvHELNDB6
         Vd8jIKM3ndooyhgF4G+kRGZMjSpviuxas4amU+SLyrm1+YLve3DZbyo8hb4HJ60iMYLR
         RTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vv5V+2hLr729rED7Crr86lpX2HrSw0iB0zF2Ja4Hlcc=;
        b=Obs3XW/sIwhQvmQsN6fOOzeSldAjum7AG7GUIiPdMD7mXjIA3Ac+p9VxZR5yH/1Jzu
         um11nyO/DKMVVutPNJDrWaSGa7lEsyCClFDCaZGdrxvS4WVESc6oytH1WegKMCXXNT7w
         01YDQhALcmPqfozf3hF2xLGZWzI0f8pIBlPzEmSovNKX0sVGoveoZ23W4OT3t7Yq96Gw
         uvFAPKwfebjB9A8oh6JlsEPljhkhmhBwH4L8hkV0teM7F7bT4Cz9gdu3UV0LULuYQGtZ
         QrUIy3XEDMDiWMPWsj8HBSduDhk3bJh36sGZVBvfqniZhECeSOvMSW0/O5oM6J+xAu5T
         d7uQ==
X-Gm-Message-State: AOAM533moY26CA7uJah2B9Z+H9zWEEC5Udxvdj4/wVxru37OsKfvj7sX
        WV1ODeyJCMSulcWwY+OMgKtahbAzZ1QnMw==
X-Google-Smtp-Source: ABdhPJxq/2D0BIqUKB3jpZKYr+0pPg7cu62GgJEVH3AbieyOZ7p/7UkiIkhfttl25qwYqtzPafEuLg==
X-Received: by 2002:a65:688a:: with SMTP id e10mr2468380pgt.347.1606299109247;
        Wed, 25 Nov 2020 02:11:49 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r130sm1599496pfc.41.2020.11.25.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 02:11:48 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     will@kernel.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com, thierry.reding@gmail.com, joro@8bytes.org
Subject: [PATCH RESEND v2 0/5] iommu/tegra-smmu: Some pending reviewed changes
Date:   Wed, 25 Nov 2020 02:10:08 -0800
Message-Id: <20201125101013.14953-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v1->v2:
 * Added Thierry's acks to PATCH-3~5

This is a merged set of resend for previously two series of patches
that were reviewed/acked a month ago yet have not got applied.

Series-1: https://lkml.org/lkml/2020/9/29/73
"[PATCH v4 0/2] iommu/tegra-smmu: Two followup changes"

Series-2: https://lkml.org/lkml/2020/10/9/808
"[PATCH v7 0/3] iommu/tegra-smmu: Add PCI support"

Nicolin Chen (5):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expand mutex protection range
  iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
  iommu/tegra-smmu: Rework tegra_smmu_probe_device()
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 240 ++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 152 deletions(-)

-- 
2.17.1

