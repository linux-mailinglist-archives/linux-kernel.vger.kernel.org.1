Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA61CEBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgELEJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 00:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:09:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4164C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:09:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so5734608pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yP6D/ixJy1go9I3dKKTs64wSH22i2lwmmxRms2M5Log=;
        b=rFjrz9rDOYj5kTHRA9iW5hkbpiDEvFt+HIsb9wikLbrAcUSBldbXdKbYpt7EC1eJDu
         vRHSLfztu+FL84B8qSEaDPj8TR5zF5dkvnWMEeUDhSnZ+o/ZnUI+g+/glbL5QZ2l26Ub
         Kf+pFuNVkyX/xujz123lwbFV/+v26ivFpNzRv/JeytkerLige4bEVIcCMmxeDtRlBM8m
         kZUZMWJ0WGaufznZ5GG/vWLyEE2dRwH2mFe4SPaUAVgmMAn5sVG2MoyfJcODZO8umdGA
         2Dmm/WMEM2kcg5U7AGkly7XNwyB+33DyaTkJex9y2wstyBJ+GIEa26FYtJloj3tV8CIr
         oPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yP6D/ixJy1go9I3dKKTs64wSH22i2lwmmxRms2M5Log=;
        b=WlLyy1gsXfYrObTIQudAO4OIR3qCnmzBdBfXTwTaTjY8rmfWuHEXYaT0tb8COI5ZPO
         UFMribwGwBVF/qwHABzVnZzLCcaI1EiyP2l8q8QeV/WJopKYPVbJy9l4SBPts35q7Mvd
         wtvgztEYLMLIk7tjfR7wJwDhIaTzss4M5DBwpJm8IFp0gByzDt3HPnd+X7gpnFvJNRYJ
         cZtgTtdy6svjmV1GX5rHzce0R3bp3ETj7KT2dqzMcYd61ptr2L//eML96dMCRW3hl+4D
         ChVsnVtJ7ifVX/I722LNsH7sPiptEC4kFozGZeGSLYHBDAV7rwbh5wDbLEcyTA4dD6wI
         RT4Q==
X-Gm-Message-State: AOAM530P2hA0IAqyTUn08IYIh+P7gtE7ThnMhH0MB8hPd9dTKRPZEvBT
        ya2jMFuX5xKrYJRCBimvMQkM1RVXyo0Xlw==
X-Google-Smtp-Source: ABdhPJwR/mT3M4ET0gUnmGWVdzywReAuxXeomuc5BK5uwflbMkhGQbsFgUJAeMnqFKRm6B3nbWRNqQ==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr8207696pga.358.1589256549383;
        Mon, 11 May 2020 21:09:09 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:443:6f00:91af:f25c:441c:7ba4])
        by smtp.gmail.com with ESMTPSA id e4sm9471527pge.45.2020.05.11.21.08.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:09:08 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] Let pci_fixup_final access iommu_fwnode
Date:   Tue, 12 May 2020 12:08:29 +0800
Message-Id: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_final after iommu_fwnode is allocated.

For example: 
Hisilicon platform device need fixup in 
drivers/pci/quirks.c

+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+	struct iommu_fwspec *fwspec;
+
+	pdev->eetlp_prefix_path = 1;
+	fwspec = dev_iommu_fwspec_get(&pdev->dev);
+	if (fwspec)
+		fwspec->can_stall = 1;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
 

Zhangfei Gao (2):
  iommu/of: Let pci_fixup_final access iommu_fwnode
  ACPI/IORT: Let pci_fixup_final access iommu_fwnode

 drivers/acpi/arm64/iort.c | 1 +
 drivers/iommu/of_iommu.c  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

