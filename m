Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D42808F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgJAU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgJAU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4FF5229D10C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 7/9] x86: Use current USER_CS to setup correct context on vmx entry
Date:   Thu,  1 Oct 2020 16:58:17 -0400
Message-Id: <20201001205819.27879-8-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_prepare_switch_to_guest shouldn't use is_64bit_mm, which has a
very specific use in uprobes.  Use the user_64bit_mode helper instead.
This reduces the usage of is_64bit_mm, which is awkward, since it relies
on the personality at load time, which is fine for uprobes, but doesn't
seem fine here.

I tested this by running VMs with 64 and 32 bits payloads from 64/32
programs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7b2a068f08c1..b5aafd9e5f5d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	savesegment(es, host_state->es_sel);
 
 	gs_base = cpu_kernelmode_gs_base(cpu);
-	if (likely(is_64bit_mm(current->mm))) {
+	if (likely(user_64bit_mode(current_pt_regs()))) {
 		current_save_fsgs();
 		fs_sel = current->thread.fsindex;
 		gs_sel = current->thread.gsindex;
-- 
2.28.0

