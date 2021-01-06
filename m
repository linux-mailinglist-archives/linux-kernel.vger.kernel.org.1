Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F12EBFD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbhAFOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbhAFOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D91C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2vfDZYufeDV4lqPSrUxc0PEz+J78eEQhcA1CNR3a2cA=; b=B9adYhM36+hB5pBPY/jBF2OYcQ
        vuUmc8bJhGhHNJyJH+NadrPCowflLg9MUsCnEdtWZQWOEvj11F0PmDVak3k7gZndO/6Pe9hEhA/Ue
        HGrm2Yx9G4I9LoyFVOx/kWV0gowrBSPAR6piU3Jx24b5xuk0AZxuMIKOTMUhMKOLCo87fsLG7Ldxz
        woq9XESVWQjFLPhgut7E3arZ9vXOgzWV/f83z/DpBjZUjnapR/BMNw4npudRAxhMBZWBYXMCZzp7Q
        wf0L114cdUX7U4JLXkokDVkD7J7Z+2VMwcwr1Z9rH4T30xKv8iL4sHqgvCJ/Bo6SptjEUyPzaWGbJ
        kQRI+hHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxA3I-002QUa-V9; Wed, 06 Jan 2021 14:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B68EA3077E1;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A049C2029C718; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.532902065@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 2/6] x86/sev: Fix nonistr violation
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler fails to inline; we violate nonisntr:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section

Fixes: 4ca68e023b11 ("x86/sev-es: Handle NMI State")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/sev-es.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -225,7 +225,7 @@ static inline u64 sev_es_rd_ghcb_msr(voi
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
 }
 
-static inline void sev_es_wr_ghcb_msr(u64 val)
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 {
 	u32 low, high;
 


