Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215DE26BA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIPC2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:28:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbgIPC17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 678E9B7BD0C502CE24B5;
        Wed, 16 Sep 2020 10:27:58 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:47 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] KVM: arm64: vgic-debug: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:23 +0800
Message-ID: <20200916025023.3992679-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-debug.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index b13a9e3f99dd..f38c40a76251 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -260,34 +260,14 @@ static int vgic_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static const struct seq_operations vgic_debug_seq_ops = {
+static const struct seq_operations vgic_debug_sops = {
 	.start = vgic_debug_start,
 	.next  = vgic_debug_next,
 	.stop  = vgic_debug_stop,
 	.show  = vgic_debug_show
 };
 
-static int debug_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	ret = seq_open(file, &vgic_debug_seq_ops);
-	if (!ret) {
-		struct seq_file *seq;
-		/* seq_open will have modified file->private_data */
-		seq = file->private_data;
-		seq->private = inode->i_private;
-	}
-
-	return ret;
-};
-
-static const struct file_operations vgic_debug_fops = {
-	.owner   = THIS_MODULE,
-	.open    = debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
+DEFINE_SEQ_ATTRIBUTE(vgic_debug);
 
 void vgic_debug_init(struct kvm *kvm)
 {
-- 
2.25.1

