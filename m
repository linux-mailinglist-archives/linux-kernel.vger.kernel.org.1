Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17F31A2FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 09:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDIHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 03:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIHAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66991AC64;
        Thu,  9 Apr 2020 07:00:05 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/xen: fix booting 32-bit pv guest
Date:   Thu,  9 Apr 2020 09:00:01 +0200
Message-Id: <20200409070001.16675-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2f62f36e62daec ("x86/xen: Make the boot CPU idle task reliable")
introduced a regression for booting 32 bit Xen PV guests: the address
of the initial stack needs to be a virtual one.

Fixes: 2f62f36e62daec ("x86/xen: Make the boot CPU idle task reliable")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/xen-head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 7d1c4fcbe8f7..1ba601df3a37 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -38,7 +38,7 @@ SYM_CODE_START(startup_xen)
 #ifdef CONFIG_X86_64
 	mov initial_stack(%rip), %rsp
 #else
-	mov pa(initial_stack), %esp
+	mov initial_stack, %esp
 #endif
 
 #ifdef CONFIG_X86_64
-- 
2.16.4

