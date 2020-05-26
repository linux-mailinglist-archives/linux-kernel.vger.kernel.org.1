Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822A51CEBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 06:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgELEJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 00:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELEJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:09:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CCC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:09:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so8845811pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aGIDKJhsEoY1eFnx3GCg/ODucM/74uibRkoUrBNgnI=;
        b=MbXe+HW+y1nKNTeJX7Rkc7vQR92xitRyMqVJP0a6SsxnDbH6iUYomnq74hWzkTZ68f
         VsDEXcDNI+WiQL7KRKURgC+DnubpxvtlSqRn6orZ3t6ahJUtWU/jba1VmPfGbrAQFqe9
         d0BOXtDZ+KmfLxAs01EAm+ZevUv5lCcWOdbmkxj/n/F+TajL6AyfojV7uQRSExlmsqBt
         LzIIpV/HCvUMd5y8iKO9j+SJ+YZ0MESDLDGKnwdAtg4g2nGjok30yTiubZY4Wdh/s4tp
         eZT6ISiSZ2ssxGHdJ8crKSCVmJ+01cXY+GFP12rW456eaMSvowo+kn4HrkR1btVPh/JZ
         jPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aGIDKJhsEoY1eFnx3GCg/ODucM/74uibRkoUrBNgnI=;
        b=WkiS4lUm68Q44PibBBG6NLAODhUpZJZb0+8le9ZSlZmbHqLoOvik01P35B3mYveK5d
         mno6MkUuQC780wNVIQTHjBtJgijLEaukp2/+f/2yanWGyaQCri2VeLLyoOHwj7YWJeR+
         j7TsQ+2gqEcL4OzlbkDPvAOUhPw4+DHZf97PHDKMyXYomWAqNcXaNboVrObNrBlUPiWS
         MkHeb2z1x/WYw272Y7YSJPP3emlECtFW5EqEep9Uy5vXgg2rGvVYaF8sEwYsVR4kpUAh
         L7Ih04cstWf9nUKJlE2DKrcIszuByz0casSXhhuk8uQJvk/iOvwP5kn6o6jKwll0qXfa
         VYfw==
X-Gm-Message-State: AGi0PuaTLs2O8DJSCwa5UKakT27qo1p2bNLaWey8He6xz3MKAtbvUuMo
        ky88pr1QG8B2aLnuczdQ/ZUXUg==
X-Google-Smtp-Source: APiQypLaB23RJirP/v+StJWLJjQaMOF0325fVzznuPTbvKpEkcQWNB3eHs32G8ciUzq8DPIby5tNug==
X-Received: by 2002:a17:902:c281:: with SMTP id i1mr18100582pld.85.1589256563703;
        Mon, 11 May 2020 21:09:23 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:443:6f00:91af:f25c:441c:7ba4])
        by smtp.gmail.com with ESMTPSA id e4sm9471527pge.45.2020.05.11.21.09.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:09:23 -0700 (PDT)
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
Subject: [PATCH 1/2] iommu/of: Let pci_fixup_final access iommu_fwnode
Date:   Tue, 12 May 2020 12:08:30 +0800
Message-Id: <1589256511-12446-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
References: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling pci_fixup_final after of_pci_iommu_init, which alloc
iommu_fwnode. Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_final after iommu_fwnode is allocated.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aac..c1b58c4 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -188,6 +188,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+		pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
 	} else if (dev_is_fsl_mc(dev)) {
 		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
-- 
2.7.4

