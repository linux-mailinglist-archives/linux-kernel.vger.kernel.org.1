Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE72E7E70
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 07:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgLaG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 01:29:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9706 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 01:29:32 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5yrK4GHWzkyWn;
        Thu, 31 Dec 2020 14:27:45 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.196) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 31 Dec 2020 14:28:38 +0800
From:   Shenming Lu <lushenming@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
Subject: [PATCH RFC] KVM: arm64: vgic: Decouple the check of the EnableLPIs bit from the ITS LPI translation
Date:   Thu, 31 Dec 2020 14:28:13 +0800
Message-ID: <20201231062813.714-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.184.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the EnableLPIs bit is set to 0, any ITS LPI requests in the
Redistributor would be ignored. And this check is independent from
the ITS LPI translation. So it might be better to move the check
of the EnableLPIs bit out of the LPI resolving, and also add it
to the path that uses the translation cache. Besides it seems that
by this the invalidating of the translation cache caused by the LPI
disabling is unnecessary.

Not sure if I have missed something... Thanks.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-its.c     | 9 +++++----
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 +---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 40cbaca81333..f53446bc154e 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -683,9 +683,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 	if (!vcpu)
 		return E_ITS_INT_UNMAPPED_INTERRUPT;
 
-	if (!vcpu->arch.vgic_cpu.lpis_enabled)
-		return -EBUSY;
-
 	vgic_its_cache_translation(kvm, its, devid, eventid, ite->irq);
 
 	*irq = ite->irq;
@@ -738,6 +735,9 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 	if (err)
 		return err;
 
+	if (!irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
+		return -EBUSY;
+
 	if (irq->hw)
 		return irq_set_irqchip_state(irq->host_irq,
 					     IRQCHIP_STATE_PENDING, true);
@@ -757,7 +757,8 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
 
 	db = (u64)msi->address_hi << 32 | msi->address_lo;
 	irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
-	if (!irq)
+
+	if (!irq || !irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
 		return -EWOULDBLOCK;
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 15a6c98ee92f..7b0749f7660d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -242,10 +242,8 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 
 	vgic_cpu->lpis_enabled = val & GICR_CTLR_ENABLE_LPIS;
 
-	if (was_enabled && !vgic_cpu->lpis_enabled) {
+	if (was_enabled && !vgic_cpu->lpis_enabled)
 		vgic_flush_pending_lpis(vcpu);
-		vgic_its_invalidate_cache(vcpu->kvm);
-	}
 
 	if (!was_enabled && vgic_cpu->lpis_enabled)
 		vgic_enable_lpis(vcpu);
-- 
2.19.1

