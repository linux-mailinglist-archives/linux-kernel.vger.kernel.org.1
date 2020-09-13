Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F4267F87
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgIMMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 08:42:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgIMMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 08:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600000939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A6XG2fJLHeDjdaV/7MOzK55rA0FpDa4k55hAmmbHojo=;
        b=huPHGHgaX6Jc4pr5RQ2kvepPjTecZpoauD14blPF49+bAjEJqZ9ro+uKeKIf2SAdZqjWop
        k0K/NRBymUf01+ZLAHCiPks9H3nfQQlMnUdg6uRB9MW2cqwBydwBOO5ns8qU5sUAamKdMF
        wl8XhgAoKqabx9K/7L1jRwo+LpwjVxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-dsjiyH1PPLOpul9vJsB81w-1; Sun, 13 Sep 2020 08:42:15 -0400
X-MC-Unique: dsjiyH1PPLOpul9vJsB81w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C59185A0FC;
        Sun, 13 Sep 2020 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90DF827BC0;
        Sun, 13 Sep 2020 12:42:12 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] iommu/amd: fix interrupt remapping for avic
Date:   Sun, 13 Sep 2020 15:42:11 +0300
Message-Id: <20200913124211.6419-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
accidentally removed an assumption that modify_irte_ga always set the valid bit
and amd_iommu_activate_guest_mode relied on that.

Side effect of this is that on my machine, VFIO based VMs with AVIC enabled
would eventually crash and show IOMMU errors like that:

AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xfffffffdf8000000 flags=0x0008]

Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07ae8b93887e5..aff4cc1869356 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3853,6 +3853,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
+	entry->lo.fields_remap.valid = 1;
 
 	return modify_irte_ga(ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry, ir_data);
-- 
2.26.2

