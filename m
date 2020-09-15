Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DD26A6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIOOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIOOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:08:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E4EC061224
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r19so1371676pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgoatpPEep+AjT30Mye6VvozNsyBb0uBUKnSsty40P0=;
        b=FE/uY5xZIO2hyih0TY8Kk+GNLuKbNHwGhwfJlJlTn0x25KvEKzKwPIXhtT1FiH82ky
         RvvXicGvXhRegmv+6a3/aG9rthMjIg5O5vM+D2AsADTOl5CvyKHgcY7xwaMiUw5qckDt
         gBSrWdy4AdPAUh+T4wM1AjGZfJ21HHvWZCVio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgoatpPEep+AjT30Mye6VvozNsyBb0uBUKnSsty40P0=;
        b=p8RsmcuLi1OFtEcPvkZCaN3EAn54Tumv2dsAbciGAjca/9CzbIlStRlpPDuY3CxCXG
         NQjW/Ia4ljh3FDCgwWjN5tV2g9Qn1rufGiywFobPe/7V9AfvxFalMyy6Tqb7r7wk9zuF
         T+KYeSOmxw9q0Lyle8UDUC0hrbQJQdrirJjgdRrcTq8jrxuUHZvI4GZBFZo4a+8CVmn+
         uj/MqyjgZTcdHFtg9H+LQJO4WPmwO8qYif98x3bpI0QRKlzEeSqi0Aj3dJTlojj/D6zk
         hLHVn15AHkaZtrTvH5JG33RTnDhMI2apN7sYSxRzgwd6VH0eKtajYDZCdDxPWIK1reYi
         eYEw==
X-Gm-Message-State: AOAM53108pogvXFMKqjXNMUoIzvq3s1+ZklzlSE1a/D9LEy/ATbqKPn3
        DuZL4856svRS/khfKPSFnm9NEQ==
X-Google-Smtp-Source: ABdhPJxYK1MAcd2/B7aGqsEyn9aiL4htZpxzgynwGVzaM1yHVH97Hv0zf4MumRJTswkc/O3h4l46Pw==
X-Received: by 2002:a17:902:fe0b:b029:d1:9bd3:6e20 with SMTP id g11-20020a170902fe0bb02900d19bd36e20mr19833487plj.31.1600177582178;
        Tue, 15 Sep 2020 06:46:22 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz6sm12471478pjb.22.2020.09.15.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:21 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/3] PCI: iproc: Display PCIe Link information
Date:   Tue, 15 Sep 2020 19:15:41 +0530
Message-Id: <20200915134541.14711-4-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915134541.14711-1-srinath.mannam@broadcom.com>
References: <20200915134541.14711-1-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After successful linkup more comprehensive information about PCIe link
speed and link width will be displayed to the console.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index cc5b7823edeb..8ef2d1fe392c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1479,6 +1479,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	struct device *dev;
 	int ret;
+	struct pci_dev *pdev;
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
 	dev = pcie->dev;
@@ -1542,6 +1543,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		goto err_power_off_phy;
 	}
 
+	for_each_pci_bridge(pdev, host->bus) {
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+			pcie_print_link_status(pdev);
+	}
+
 	return 0;
 
 err_power_off_phy:
-- 
2.17.1

