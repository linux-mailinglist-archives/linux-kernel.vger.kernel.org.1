Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D502DC5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLPRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgLPRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:53:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 09:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tN0yIKZX5W2VZwRAEvec4t5YNl/Os/C/QJ8fNnYq6OI=; b=fZFcpSXHbrNJqj4iURL7Wq2uWW
        E/6ZTCwx6tdcRcCHrbFlcaKCQVoiK8Rpxm6pesJucwXF7OsttjFazQZVaqX+/SjPNFXmH1Zr3IGv6
        W45rVEQbx4o8Sd+5q3oAD2yjIz5STVBr49GQvsRkWRpkKWIJ6GdY5fxCqlF83dJTzgQKppjPIv4Vq
        pWvGMbASPf9p7oDHu4uBVerHHh5OadWNKJynBOqKuDhiJXCsA89v5GDMliRcMX6qocsgLTKlX6Bjw
        /PM/XxdOrN6J7NeQsW3+vRY0BUzMFhmnO516LXRMeMCg3dfSU+VgTY4T6YgbDnkFddKWwPg4G7ErM
        /R+9TOsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpaz1-0003cB-Tb; Wed, 16 Dec 2020 17:53:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7594A304D28;
        Wed, 16 Dec 2020 18:52:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CCCA202A3CFE; Wed, 16 Dec 2020 18:52:59 +0100 (CET)
Date:   Wed, 16 Dec 2020 18:52:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201216175259.GP3040@hirez.programming.kicks-ass.net>
References: <20201215190152.GA22285@osiris>
 <20201215144724.40ab7612@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215144724.40ab7612@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 02:47:24PM -0500, Steven Rostedt wrote:
> On Tue, 15 Dec 2020 20:01:52 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > Hello,
> > 
> > the ftrace stack tracer kernel selftest is able to trigger the warning
> > below from time to time. This looks like there is an ordering problem
> > in __local_bh_enable_ip():
> > first there is a call to lockdep_softirqs_on() and afterwards
> > preempt_count_sub() is ftraced before it was able to modify
> > preempt_count:
> 
> Don't run ftrace stack tracer when debugging lockdep. ;-)
> 
>   /me runs!

Ha!, seriously though; that seems like something we've encountered
before, but my google-fu is failing me.

Do you remember what, if anything, was the problem with this?

---
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d5bfd5e661fc..9d71046ea247 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -186,7 +186,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
 	 */
-	preempt_count_sub(cnt - 1);
+	__preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*

