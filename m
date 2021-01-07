Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80512ECDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbhAGKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:32:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35724 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAGKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:32:07 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210107103122epoutp0111ab074b7b5593e9c24331ff0d6598dd~X7Iz8ZBxc1363413634epoutp01N
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:31:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210107103122epoutp0111ab074b7b5593e9c24331ff0d6598dd~X7Iz8ZBxc1363413634epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610015482;
        bh=zgnGkAl5H6GoKUAcYr+wE27/PBdE+8JptgJAmhAjafY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jbUuGpct6UFoDu/hTwtofLLe09pRuvs7uq4N5cZUaDkUcYiMsD0pQ9mxyN9gIlPco
         w+r/1POzrzXlT17HNqdHdP4ByLDen8AelFRPa89DUoFNOVWLKtTKdEMsg8bkoh6R/y
         wgHQS8OYyuO1As0BS1OUAekYBreImQnsDcbihJIQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210107103121epcas5p2a322f86c7f7f9d4734f37bddee79ddc1~X7IzbAEcp1382213822epcas5p2B;
        Thu,  7 Jan 2021 10:31:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.8D.33964.9F2E6FF5; Thu,  7 Jan 2021 19:31:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b~X6R4CDmyx1773217732epcas5p1v;
        Thu,  7 Jan 2021 09:28:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210107092826epsmtrp28d27298a12781770605a65a82b78e522~X6R4Acp9C2963029630epsmtrp23;
        Thu,  7 Jan 2021 09:28:26 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-26-5ff6e2f95641
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.A2.08745.A34D6FF5; Thu,  7 Jan 2021 18:28:26 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107092825epsmtip28c5b3966d940a0ebee719140eb1f8f94~X6R2s12Ec1431714317epsmtip2O;
        Thu,  7 Jan 2021 09:28:25 +0000 (GMT)
From:   Ajay Kumar <ajaykumar.rs@samsung.com>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will@kernel.org, robin.murphy@arm.com
Cc:     Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from other
 masters
Date:   Thu,  7 Jan 2021 15:03:40 +0530
Message-Id: <20210107093340.15279-1-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmpu7PR9/iDXbMlLQ48P4gi8WC/dYW
        nbM3sFtsenyN1eLyrjlsFkuvX2SyaN17hN3i4IcnrBYtd0wdOD2eHJzH5LFm3hpGj02rOtk8
        Ni+p95h8YzmjR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGXcb1nNVvBCuOL45dnMDYwLBLoY
        OTkkBEwk/nRcYeti5OIQEtjNKDHvxCQ2kISQwCdGiZbeQojEZ0aJzuvHmGA69l19zA6R2MUo
        8XvSVaiOFiaJ9tXMIDabgLbEtuk3WUCKRATOMUpMWD8TLMEsoCmxdGk3mC0sECqx7nM3Yxcj
        BweLgKrE5M+GIGFeAVuJWd/+MkMsk5dYveEAM8gcCYFT7BK3Ht1kg0i4SLz9PI8dwhaWeHV8
        C5QtJfH53V42iIZ+Romn9/9Ada9mlHjw8ALUWHuJA1fmsIBsBrlo/S59iLCsxNRT65ggDuWT
        6P39BOplXokd80BsDiBbTWLrCj+IsIzEmYNXoEo8JGb+2skOCYhYifufN7FMYJSdhbBgASPj
        KkbJ1ILi3PTUYtMC47zUcr3ixNzi0rx0veT83E2M4NSg5b2D8dGDD3qHGJk4GA8xSnAwK4nw
        Whz7Ei/Em5JYWZValB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC1CKYLBMHp1QDk5KD
        m/GEjc1/2Peodh/Zz3QoYf+fD7IyGp9auf+l9sas5o2/dV8l54bc4gbHI4bVT/6ZVXYErLWu
        ULw5y5x79XSus3YvPh9iSGvgPnZtUo1FxAqTsBkRSflzb1l3MOVqnTn2ur/izKYbn3IUY+w2
        njl8c4b3whsaUknn5Q7/jQ77MOv8jkof1e2Nrz8ev+dqySr+c4rfGxMBpaLYRZIOx71vnV/d
        f+Du1i0zsy8sUH3TmZJwjv/QtExfpeXXzjm8dMxceFPq+MHQ63y/0xSCtxQ2XPTa/ePTCl+L
        U3PT3uyqlndKlO11vrV43+cZMc5rFqx6cGBxpVKjiPmBpemGL104nrf/vVo+T8rciu18wVkl
        luKMREMt5qLiRAB6SC90fAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJXtfqyrd4g3/zdCwOvD/IYrFgv7VF
        5+wN7BabHl9jtbi8aw6bxdLrF5ksWvceYbc4+OEJq0XLHVMHTo8nB+cxeayZt4bRY9OqTjaP
        zUvqPSbfWM7o0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBn3W1azFbwQrjh+eTZzA+MCgS5G
        Tg4JAROJfVcfs3cxcnEICexglFh9ficzREJG4vmOpywQtrDEyn/PoYqamCRWt3xiB0mwCWhL
        bJt+kwUkISJwg1Hi8o07rCAJZgFNiaVLu4EmsXMICwRLPAvsYuTgYBFQlZj82RCkgFfAVmLW
        t79Qq+QlVm84wDyBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgINPS2sG4
        Z9UHvUOMTByMhxglOJiVRHgtjn2JF+JNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJ
        anZqakFqEUyWiYNTqoEp7cMr5ncXr0p7bdP5dy8jY03xtIpZ8SztltHC59xnb+2OPH9E9HPJ
        X8ltGQo3Dv8/nh0zjfVI9ia1T0IPl20+NEXZUmjzNi2ls7Ktcyac5FWr3uv8uqb12o5TGpWz
        cjYIV/r0c8+1ZHm+NZM1wzSrdHtK6qSbbrGWlhetdWw3Rn9MtpY+N8n6x4HNNdYHDr59EPM1
        NVzkQvPaKX+NZ3xTvsXHtLSWkf+Q6L9Np07IH8ic/tRv5VMWL9Fuz8q5YYmyzw3uZcgG2/8P
        OGie9VKPW2uNhMxx+eWePDwFl1Y+qmzj35wWH3ax8tKjZytcrn1nNv1/Q9+Aa1Vx1u4s+y0L
        mxbucPKp+JK3782E7b66SizFGYmGWsxFxYkARhXFXqECAAA=
X-CMS-MailID: 20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PCI function drivers(ex:pci-endpoint-test) are probed for already
initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
then we encounter a situation where the function driver tries to attach
itself to the smmu with the same stream-id as PCIe-RC and re-initialize
an already initialized STE. This causes ste_live BUG_ON() in the driver.

There is an already existing check in the driver to manage duplicated ids
if duplicated ids are added in same master device, but there can be
scenarios like above where we need to extend the check for other masters
using the same stream-id.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e634bbe60573..a91c3c0e9ee8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2022,10 +2022,26 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
+static bool arm_smmu_check_duplicated_sid(struct arm_smmu_master *master,
+								int sid)
+{
+	int i;
+
+	for (i = 0; i < master->num_sids; ++i)
+		if (master->sids[i] == sid)
+			return true;
+
+	return false;
+}
+
 static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 {
+	bool sid_in_other_masters;
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	unsigned long flags;
+	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_master *other_masters;
 
 	for (i = 0; i < master->num_sids; ++i) {
 		u32 sid = master->sids[i];
@@ -2038,6 +2054,23 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
+		/* Check for stream-ID duplication in masters in given domain */
+		sid_in_other_masters = false;
+		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		list_for_each_entry(other_masters, &smmu_domain->devices,
+								domain_head) {
+			sid_in_other_masters =
+				arm_smmu_check_duplicated_sid(other_masters,
+									sid);
+			if (sid_in_other_masters)
+				break;
+		}
+		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		/* Skip STE re-init if stream-id found in other masters */
+		if (sid_in_other_masters)
+			continue;
+
 		arm_smmu_write_strtab_ent(master, sid, step);
 	}
 }
-- 
2.17.1

