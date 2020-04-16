Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D81AC05A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634357AbgDPLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633922AbgDPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ERVnhrOAMNmB+Ir478MINnn9jvj4hJPxpbmAuuBvSY8=; b=kxfvQXrYVh/ws3JzQAnHBpjt0O
        qhOGpK9pjpWWOxC+SNzMJ4rVY97hG8NevfdQ86//aTaFbNoUIWFxTW04MyoR9TpbtO7ssHaYLegrj
        bFNBGC51HnovOawHu3z4dcdu/iwutdiHIdDJ1dsTe/ci6ZGYJUC0Uih5KjmWF6RVcUys6zmRY3rUU
        8Ma/Q7+D79Z5GlBR7DOaXF+/HHPk/iBuN9OjohJi3Kc4qGUmC2NX7+sKatGfh+mx1Z5nsW6JA+2D1
        ShWJubwjX7K52pBfgjxvG3vZ2/cxPrEwgws7cCjm6ra41wK01XSmAodARRJeFWN3vWBHBKOMPQT48
        RcVhJQbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0006jN-C5; Thu, 16 Apr 2020 11:52:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A40C304C22;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1B60D2B0DE4C1; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416114706.625340212@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 00/17] objtool: vmlinux.o and noinstr validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As should be familiar by now; these patches implement the noinstr
(no-instrument) validation in objtool as requested by Thomas, to ensure
critical code (entry for now, idle later) run no unexpected code.

Functions are marked with: noinstr, which implies notrace, noinline and sticks
things in the .noinstr.text section. Such functions can then use instr_begin()
and instr_end() to allow calls to code outside of this section in sanctioned
areas.

On the way of getting there, it also fixes the x86/ftrace trampiline ORC
unwind.


