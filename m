Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B392B1D70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKMO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:28:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7232 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgKMO2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:28:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXgmp1DY1zkWqj;
        Fri, 13 Nov 2020 22:28:10 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 22:28:16 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/2] KVM: arm64: vgic: Forbid invalid userspace Distributor accesses
Date:   Fri, 13 Nov 2020 22:28:01 +0800
Message-ID: <20201113142801.1659-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20201113142801.1659-1-yuzenghui@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing registers in the Distributor before setting its base address
should be treated as an invalid userspece behaviour. But KVM implicitly
allows it as we handle the access anyway, regardless of whether the base
address is set or not.

Fix this issue by informing userspace what had gone wrong (-ENXIO).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 30e370585a27..6a9e5eb311f0 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -1029,11 +1029,15 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg, bool allow_group1)
 int vgic_v3_dist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 			 int offset, u32 *val)
 {
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_io_device dev = {
 		.regions = vgic_v3_dist_registers,
 		.nr_regions = ARRAY_SIZE(vgic_v3_dist_registers),
 	};
 
+	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base))
+		return -ENXIO;
+
 	return vgic_uaccess(vcpu, &dev, is_write, offset, val);
 }
 
-- 
2.19.1

