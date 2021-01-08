Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D02EF17C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhAHLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbhAHLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:39:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3452C0612F8;
        Fri,  8 Jan 2021 03:39:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q4so5521916plr.7;
        Fri, 08 Jan 2021 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqhNu7rpIl9rLybT73zELGUOuCv+WJC3uqUOvsWqqA0=;
        b=eqfwQ3Fp762qCIok60TM5s2O/Sr5NX1OOSHYUTd/Pn+A8pGLVj1V6pRRB2LXSVUJlr
         gU1bweZFHACXbd5FgP/+NndsOZW9eTeev4wiFC0cSzXGk8z+jFzY0mSbmseFZb/++Stn
         H05bgYKavXqxY2g+4mVVBdPDws4P8YEzevsSvlJUzRmlqn8He9k4a4X/T/ZRwwrMOPOA
         vVG6SdtiziVm/dVbB+goHJFPRybzlNpxwc+Q3jXZJRrvki3y7Ez7pcln05Id65JGau+i
         lXG4Ulf3qpfGNL+7N5HCRSXGJdhAsapzuxGU50XhpLeN7JSfbb2wx44YTqA6ua9j/wsm
         m6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqhNu7rpIl9rLybT73zELGUOuCv+WJC3uqUOvsWqqA0=;
        b=faTXEEcfpyZVOAqaI6vSm1NZ4Nse8R9Y51nhdGrPrrOuD5PK3XDVHCajkymh3N+DX1
         5EwSdwN1KnD5ijsBwBz4e5xRq0UTepEFo3YFpOB21cDJc9HSt0J1e4SOuI8Zc4QSG34/
         ljR1kkGxOB4jzEd2oCACkxm8JSCXiXnGSCJiiCdJEBc5T3A+RudZhfG04IOuFe507Xwy
         cjpYe2bbt8/UFLEtOK4KUc4n+nSw5oMuQfvKQByKKCdH+/mpLkio3wxWxtKar607QbxA
         QzjDlruRlB3DuKnYRF1VEm+BO92SmAOESJzE1a+GkkzkGYpb6r1GX8qvCGSTwQrfRel/
         o5bQ==
X-Gm-Message-State: AOAM533BOSesmAy2+RNWgJTvzhEOoTguM2e5OGAbv60DrnNsiLsFp0WG
        gSRwmf1PNHjopLHPPEXb+sI=
X-Google-Smtp-Source: ABdhPJzrdL2ounVef6ajtJjfdM7Td6F/cZRbaDKql8n+e0SLpSuJYPUM19pG3R5DiYRHqBhjdpixCg==
X-Received: by 2002:a17:902:bf44:b029:da:d140:6f91 with SMTP id u4-20020a170902bf44b02900dad1406f91mr6594936pls.51.1610105959252;
        Fri, 08 Jan 2021 03:39:19 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id gm18sm4589136pjb.55.2021.01.08.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:39:18 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH V2 0/2] Add Unisoc iommu basic driver
Date:   Fri,  8 Jan 2021 19:38:49 +0800
Message-Id: <20210108113851.354947-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

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

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  44 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 546 ++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

