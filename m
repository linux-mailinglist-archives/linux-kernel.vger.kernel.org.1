Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852D22B9751
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgKSQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727356AbgKSQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605801779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsFZ0hQNQRNmuGnSwAh2380F9EOTYHnybWt5Ieopw9A=;
        b=gf1pMC55NnVfvG+6A6XJrM0XE3EddkAyzYDB0zC0tmqsGelpsgCab2OkFzdQOsXS0C284b
        ODZp1pldXMxRLfMzPGHNSFEioOUHlcAL8289hxdhZ2SGZ1AgmD9mkfKG2CcmM5aY0DJTfH
        ASVixUN6VBHPwrSjKWdPiVzdq8PJOpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-37pkQnoHPu-nnk6oAV5kEA-1; Thu, 19 Nov 2020 11:02:55 -0500
X-MC-Unique: 37pkQnoHPu-nnk6oAV5kEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4606518C43D0;
        Thu, 19 Nov 2020 16:02:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id E02B51002382;
        Thu, 19 Nov 2020 16:02:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 19 Nov 2020 17:02:53 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:02:47 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201119160247.GB5188@redhat.com>
References: <20201119160154.GA5183@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119160154.GA5183@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
but PTRACE_GETREGS still copies pt_regs->softe as is.

This is not consistent and this breaks the user-regs-peekpoke test
from https://sourceware.org/systemtap/wiki/utrace/tests/

Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/powerpc/kernel/ptrace/ptrace-tm.c   | 8 +++++++-
 arch/powerpc/kernel/ptrace/ptrace-view.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-tm.c b/arch/powerpc/kernel/ptrace/ptrace-tm.c
index f8fcbd85d4cb..d0d339f86e61 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-tm.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-tm.c
@@ -87,6 +87,10 @@ int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
 	struct membuf to_msr = membuf_at(&to, offsetof(struct pt_regs, msr));
+#ifdef CONFIG_PPC64
+	struct membuf to_softe = membuf_at(&to,
+					offsetof(struct pt_regs, softe));
+#endif
 
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
@@ -102,7 +106,9 @@ int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
 				sizeof(struct user_pt_regs));
 
 	membuf_store(&to_msr, get_user_ckpt_msr(target));
-
+#ifdef CONFIG_PPC64
+	membuf_store(&to_softe, 0x1ul);
+#endif
 	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
 				sizeof(struct user_pt_regs));
 }
diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c b/arch/powerpc/kernel/ptrace/ptrace-view.c
index 39686ede40b3..f554ccfcbfae 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -218,6 +218,10 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 		   struct membuf to)
 {
 	struct membuf to_msr = membuf_at(&to, offsetof(struct pt_regs, msr));
+#ifdef CONFIG_PPC64
+	struct membuf to_softe = membuf_at(&to,
+					offsetof(struct pt_regs, softe));
+#endif
 	int i;
 
 	if (target->thread.regs == NULL)
@@ -233,7 +237,9 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 				sizeof(struct user_pt_regs));
 
 	membuf_store(&to_msr, get_user_msr(target));
-
+#ifdef CONFIG_PPC64
+	membuf_store(&to_softe, 0x1ul);
+#endif
 	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
 				sizeof(struct user_pt_regs));
 }
-- 
2.25.1.362.g51ebf55


