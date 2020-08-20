Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B60B24B067
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHTHus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHTHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667AC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TmRXqH/EmNx/wRQEcUvQeVtWyXDi/UTB5MgtGt6yHow=; b=XDpv7uYdRq2pn0YpOzOt4zJXbY
        G4o7BJPTxhodFGxK9O83lXYMf68b8zAvvoYAu907WyqyGE7A2vhKLPnUsMkJkzLOy1EhXpGr6ru+n
        IEiMsWoTBM78o9OY7T4RzVpbWQGjU/mUS0jD+S1eWGnptD84lom9+I9ezU1DA3w1es8tlmluPZZYO
        jt7CsYAFVT/N8VuBOH8Hhj85o//GmP8/Pzq5aWcTkzC4tgKZ/CJ/vUZo4wcQze7k0hfioTY+2Hbqf
        j+XfIztDGUNMxrSmxvAM+q6sZT262MiQcQ0nl7C9rWPEEIDtKpQ6g2/vdPllZDmQ5IHmJznojq4Xc
        AlOig1oQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKX-0007Df-Ly; Thu, 20 Aug 2020 07:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40A643075F1;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6C7A028B7E845; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.693984299@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 7/9] nds32: Implement arch_irqs_disabled()
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/nds32/include/asm/irqflags.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -34,3 +34,8 @@ static inline int arch_irqs_disabled_fla
 {
 	return !flags;
 }
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}


