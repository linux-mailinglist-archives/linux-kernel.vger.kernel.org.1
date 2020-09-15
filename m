Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57826A6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIOOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIONxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:53:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99198C0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1732111pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PL538uCf4O1rvxMafK+xno0ava7nNmchjlBFnDOvCxs=;
        b=TkOrTnS/RYGwioOfQxWLY+brMGn5tlgGufygSBn6z37VCQDSeDaqtHZkRl2tGlQc4Y
         bvLUXPpnZNP069g52vrzZIRyMQXhWhES3Yw7x16m/yn2ABkt5aguMt6zvAqrqecXM9gC
         CB1MoJOeqv1+VyBIo3HNSBivadVQh8hg/UsQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PL538uCf4O1rvxMafK+xno0ava7nNmchjlBFnDOvCxs=;
        b=aSSOnN2Mfwd7qL1eAuoL4FGJTjasFIysDPVibRByXMtlSaubygGrCBE376vdRyX53h
         le96jg6yk92s06O44LPn4iHkvAQmGS2mJ4d6s0SQ6kCWT/2UxtvXghIDLZXOlsz5BXIS
         k5tA7074jGpOu0YXZh7PccA/HAbUE0wef5uZlDxbO2IvDdg4Jh1rki516V466tvjq3g+
         laJx4wq664ypjTmDzm5h/G6kKG9YrBPMUFrZ0rFbvoHCGfDJdG1dP1i5OPYJD6Sl5iMa
         uKmLrJXtZqFCTVbj8VAs2iyL8lsfa9bgcrpX+VSNnaXxPZ++iQ7zcZwkP58XAFHkb9bF
         XfHA==
X-Gm-Message-State: AOAM533WfAsTtW/AAoZs2ARIA+j0VSqWhQN6j7b536bLzMpU7TfdDFbV
        Ef2QPw8+7nedLgSRHQ168ZM1jA==
X-Google-Smtp-Source: ABdhPJwNbBXknbEj3cP0la5qIjQxFssxA2A+fWq8qa9gVHPn4tU4U1Cile235ZEU6vSs0aZbOU/Yog==
X-Received: by 2002:a17:902:9308:b029:d1:9bd3:6775 with SMTP id bc8-20020a1709029308b02900d19bd36775mr18753679plb.26.1600177579026;
        Tue, 15 Sep 2020 06:46:19 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz6sm12471478pjb.22.2020.09.15.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:18 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roman Bacik <roman.bacik@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 2/3] PCI: iproc: fix invalidating PAXB address mapping
Date:   Tue, 15 Sep 2020 19:15:40 +0530
Message-Id: <20200915134541.14711-3-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915134541.14711-1-srinath.mannam@broadcom.com>
References: <20200915134541.14711-1-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Bacik <roman.bacik@broadcom.com>

Second stage bootloader prior to Linux boot may use all inbound windows
including IARR1/IMAP1. We need to ensure all previous configuration of
inbound windows are invalidated during the initialization stage of the
Linux iProc PCIe driver. Add fix to define and invalidate IARR1/IMAP1
because it was missed in previous patch.

Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index d901b9d392b8..cc5b7823edeb 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -192,8 +192,15 @@ static const struct iproc_pcie_ib_map paxb_v2_ib_map[] = {
 		.imap_window_offset = 0x4,
 	},
 	{
-		/* IARR1/IMAP1 (currently unused) */
-		.type = IPROC_PCIE_IB_MAP_INVALID,
+		/* IARR1/IMAP1 */
+		.type = IPROC_PCIE_IB_MAP_MEM,
+		.size_unit = SZ_1M,
+		.region_sizes = { 8 },
+		.nr_sizes = 1,
+		.nr_windows = 8,
+		.imap_addr_offset = 0x4,
+		.imap_window_offset = 0x8,
+
 	},
 	{
 		/* IARR2/IMAP2 */
@@ -351,6 +358,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_OMAP3]		= 0xdf8,
 	[IPROC_PCIE_IARR0]		= 0xd00,
 	[IPROC_PCIE_IMAP0]		= 0xc00,
+	[IPROC_PCIE_IARR1]		= 0xd08,
+	[IPROC_PCIE_IMAP1]		= 0xd70,
 	[IPROC_PCIE_IARR2]		= 0xd10,
 	[IPROC_PCIE_IMAP2]		= 0xcc0,
 	[IPROC_PCIE_IARR3]		= 0xe00,
-- 
2.17.1

