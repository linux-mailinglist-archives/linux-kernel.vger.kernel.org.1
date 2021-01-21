Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13852FE906
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbhAULje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbhAULYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:24:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72DC0613CF;
        Thu, 21 Jan 2021 03:23:58 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v19so1140129pgj.12;
        Thu, 21 Jan 2021 03:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dwMNQdsfc0B7LWCmiGdKrYTGwJcjbW3qAIMxL6EDkE=;
        b=q9jliqX0dMzwvBGgUDzDXXX02OOF2J6ETLKf+2D117zd2EQCM0xKHsPdgQbGJdIF3S
         xurB7KwcC3hKDLUPoLKLKsZ0LIIxp/f6TYeOJ6YMrL9oBq64v9th31GYDwlx3H1xfEUD
         MJmALiKZdEOjxT1L82ebbAfpoJQ6O8i/njTe0p6slk6ELGVKqM1KiUjLy1IH1fFidNJf
         CpvqvP1TMQgvqfUsFF0RlCKgMfMn0FSIkgayW3hfXDUKRC/PndIv9+AhMp9iIAHW6cYA
         1EUhgwJWH+oEIe8g4niaNwqzfPpnlqvjKHwkFDyeuQulxuNbIoGXHRFQ7uLK/pUnzrgC
         jAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dwMNQdsfc0B7LWCmiGdKrYTGwJcjbW3qAIMxL6EDkE=;
        b=jyM3C1xXGu8PhPMUlT21O10v6S0Py9NNHIhMvCIv/nqbWWEY9ka7296WhMZTGn9AvM
         HtkNwfnt7rSbawpSbfu9O8chbI0OnBfioptvm8v3/N2hYJUMs3J0eNF9/Dgufho3ewL3
         ei3xfsSOBz5p4/3JwE6XcAB+JtSXU7dVY2nz6I0896QUNn6J+X2B0ldMbW7uIWjjskz0
         4+DbTValRFgokUUDvgzeplqteQ0hP21clOgUa9LCXchfWuNfx2EsyOwNWncuy+ixs4/1
         5o/qArK7CYvbhilJ01tK5xtETTNZS9gSq90TQJH2eDmD7/R3upji+ZcniYj1TQkUsj2S
         14ew==
X-Gm-Message-State: AOAM530Sqd/gKBRrlvLI1YRWOORODotJKtUFyMZf4puQwWYi8CezN/Kp
        eqejNWm6RZu8OHDAlDFVMiw=
X-Google-Smtp-Source: ABdhPJzaNQk/PFHKh9VY/S1vQeP4i13jG0pKQ/8GVEMht4sAJP3A6JAJSTgKyUmaGUP05XtFcW4uLw==
X-Received: by 2002:a63:4851:: with SMTP id x17mr13776780pgk.451.1611228237897;
        Thu, 21 Jan 2021 03:23:57 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id me5sm5404797pjb.19.2021.01.21.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 03:23:57 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v1 0/2] Add Unisoc iommu basic driver
Date:   Thu, 21 Jan 2021 19:23:47 +0800
Message-Id: <20210121112349.421464-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since RFC v2:
* Addressed Robin's comments:
- Add COMPILE_TEST support;
- Use DMA allocator for PTE;
- Revised to avoid resource leak issue;
- Added ->iotlb_sync implemented;
- Moved iommu group allocation to probe;
- Changed some function names to make them sprd specific;
* Added support for more iommu instance;

Changes since RFC v1:
* Rebased on v5.11-rc1;
* Changed sprd-iommu to tristate;
* Removed check for args_count of iommu OF node, since there's no args
  for sprd-iommu device node;
* Added another IP version (i.e. vau);
* Removed unnecessary configs selection from CONFIG_SPRD_IOMMU;
* Changed to get zeroed pages.

Chunyan Zhang (2):
  dt-bindings: iommu: add bindings for sprd iommu
  iommu: add Unisoc iommu basic driver

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  45 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 566 ++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

