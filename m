Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21CD204CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgFWIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgFWIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:39:50 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB018C061573;
        Tue, 23 Jun 2020 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FMNlTrNFAQom/fM3Ojz/Fdv/nPQOBbOyqE/rlw7eqec=; b=CwkFXbXWqPUILWTCSOQfNZsMpr
        dk318OA7fw8HN5vE/SECPGzq7honG7rlRILJCv4/d6eyGqXnwYOegXo9kghJ7rGQ1KiocuD6QaxZw
        jp1iVULoN1w2ERoRlXSvpYyPyg5soeg+EeM5aa7Cy8UUyiJiffEMHB9zE3jCkrA0bYtCvZRGgFgSK
        gZaspPStNlDhcY/jrvgjpkNsxu3r1xKLqGUKeTkeNE6/11dmmSRqViaO7rUqEZQOqMNXoKqw9jf0e
        wvRXQyqshVsnGYIL94bq0kc8lUmpH0HhRiaJfQrt4m7NAsfTlUC/SG7bY/WGvRi+yIi218eNrGNPy
        OvVXu6aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jneS3-0000fw-Qn; Tue, 23 Jun 2020 08:38:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEA81307959;
        Tue, 23 Jun 2020 10:38:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EFB1A237095FE; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083721.454517573@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 10:36:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: [PATCH v4 6/8] arm: Break cyclic percpu include
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/percpu.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -10,6 +10,8 @@
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
  */
 #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
+register unsigned long current_stack_pointer asm ("sp");
+
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	/* Set TPIDRPRW */


