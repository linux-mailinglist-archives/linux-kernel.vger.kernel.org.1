Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8D2F5F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbhANKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728785AbhANKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610620673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Uf5hY6v/NV/gRDsCAVyz73OKrf+8fb0MqS39wgUdNY=;
        b=R//14ahdkHP24B72nNyKqeodMzGdlv0QyiNL11xakmKynze3FJt6z8oShy8Upnhb8uICY2
        3DTfRNcjMRNHlEiXqUl6SEY8T49EGho48Aeuap+TcLcLFzIo0SyIOMsN9VKKfZhLk47D3l
        09110HDFpUzn0ttM5cENkqZCwihgBkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-wLiTaTLGO2eG1D7j7Ja4qw-1; Thu, 14 Jan 2021 05:37:50 -0500
X-MC-Unique: wLiTaTLGO2eG1D7j7Ja4qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B29819251A2;
        Thu, 14 Jan 2021 10:37:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-165.ams2.redhat.com [10.36.114.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49DFB12D7E;
        Thu, 14 Jan 2021 10:37:45 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com
Cc:     alexandru.elisei@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        shuah@kernel.org, pbonzini@redhat.com
Subject: [PATCH v2 8/9] KVM: arm64: vgic-v3: Expose GICR_TYPER.Last for userspace
Date:   Thu, 14 Jan 2021 11:37:07 +0100
Message-Id: <20210114103708.26763-9-eric.auger@redhat.com>
In-Reply-To: <20210114103708.26763-1-eric.auger@redhat.com>
References: <20210114103708.26763-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 23bde34771f1 ("KVM: arm64: vgic-v3: Drop the
reporting of GICR_TYPER.Last for userspace") temporarily fixed
a bug identified when attempting to access the GICR_TYPER
register before the redistributor region setting but dropped
the support of the LAST bit. Emulating the GICR_TYPER.Last bit
still makes sense for architecture compliance.

This patch restores its support (if the redistributor region
was set) while keeping the code safe.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 7 ++++++-
 include/kvm/arm_vgic.h             | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 987e366c8000..7ff23c153128 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -277,6 +277,8 @@ static unsigned long vgic_uaccess_read_v3r_typer(struct kvm_vcpu *vcpu,
 						 gpa_t addr, unsigned int len)
 {
 	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
 	int target_vcpu_id = vcpu->vcpu_id;
 	u64 value;
 
@@ -286,7 +288,9 @@ static unsigned long vgic_uaccess_read_v3r_typer(struct kvm_vcpu *vcpu,
 	if (vgic_has_its(vcpu->kvm))
 		value |= GICR_TYPER_PLPIS;
 
-	/* reporting of the Last bit is not supported for userspace */
+	if (rdreg && (vgic_cpu->rdreg_index == (rdreg->free_index - 1)))
+		value |= GICR_TYPER_LAST;
+
 	return extract_bytes(value, addr & 7, len);
 }
 
@@ -714,6 +718,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	vgic_cpu->rdreg = rdreg;
+	vgic_cpu->rdreg_index = rdreg->free_index;
 
 	rd_base = rdreg->base + rdreg->free_index * KVM_VGIC_V3_REDIST_SIZE;
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 3d74f1060bd1..ec621180ef09 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -322,6 +322,7 @@ struct vgic_cpu {
 	 */
 	struct vgic_io_device	rd_iodev;
 	struct vgic_redist_region *rdreg;
+	u32 rdreg_index;
 
 	/* Contains the attributes and gpa of the LPI pending tables. */
 	u64 pendbaser;
-- 
2.21.3

