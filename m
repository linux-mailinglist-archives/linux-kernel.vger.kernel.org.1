Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441C02B1D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKMO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:28:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7894 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:28:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CXgmn1tP2z75Fv;
        Fri, 13 Nov 2020 22:28:09 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 22:28:08 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/2] KVM: arm64: vgic: Fix handling of userspace register accesses
Date:   Fri, 13 Nov 2020 22:27:59 +0800
Message-ID: <20201113142801.1659-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had recently seen a kernel panic when accidently programming QEMU in an
inappropriate way (in short, accessing RD registers before setting the RD
base address. See patch #1 for details). And it looks like we're missing
some basic checking when handling userspace register access.

I've only tested it with QEMU. It'd be appreciated if others can test it
with other user tools.

Zenghui Yu (2):
  KVM: arm64: vgic: Forbid invalid userspace Redistributor accesses
  KVM: arm64: vgic: Forbid invalid userspace Distributor accesses

 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.19.1

