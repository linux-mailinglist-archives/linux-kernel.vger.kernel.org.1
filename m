Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0422428CEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgJMNLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgJMNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:11:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224EC0613D0;
        Tue, 13 Oct 2020 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bKWuOpqTvvPutJLjCgDeEC9YLBcPFZ6MunEhJpI05qU=; b=K3yIru4s0IaQ3mv7rDbfgarPND
        DhuLAbhRsi9BRBBguLna9wGjBTevRzXf3teOrYnx7NmuoVzp9jVC1hEifBpbZolvybVHa3j6qI0Bc
        NUdi2ejkq35SCuPvVaj+KqMQydYNolF9yQxxXRMNoP87Ez/ltkIq4tM8dYuXLTU8ICmnwJZy796op
        i1u5wHzlhCkp1wgnhdDiLCBTpq085s2IhQ9T6ao9Qm4WwoFSGA1kd5bx1HCb+p+FO+WhXv+3L07YR
        Xpj7CYfwIRuWGJz99sKeag4VwMttUOnMfqYGupeBI/Qg2SZMJfimyJdXgorPSDsYK4/x1HRXktpFE
        NglBQWtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSK5E-0000bf-Rw; Tue, 13 Oct 2020 13:11:16 +0000
Date:   Tue, 13 Oct 2020 14:11:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/24] docs: lockdep-design: fix some warning issues
Message-ID: <20201013131116.GG20115@casper.infradead.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
 <20201013125206.GU2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013125206.GU2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:52:06PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 02:14:31PM +0200, Mauro Carvalho Chehab wrote:
> > +   =====  ===================================================
> > +   ``.``  acquired while irqs disabled and not in irq context
> > +   ``-``  acquired in irq context
> > +   ``+``  acquired with irqs enabled
> > +   ``?``  acquired in irq context with irqs enabled.
> > +   =====  ===================================================
>
> NAK!

You're seriously suggesting that:

-   ===  ===================================================
-   '.'  acquired while irqs disabled and not in irq context
-   '-'  acquired in irq context
-   '+'  acquired with irqs enabled
-   '?'  acquired in irq context with irqs enabled.
-   ===  ===================================================
+   =====  ===================================================
+   ``.``  acquired while irqs disabled and not in irq context
+   ``-``  acquired in irq context
+   ``+``  acquired with irqs enabled
+   ``?``  acquired in irq context with irqs enabled.
+   =====  ===================================================

this change makes the lockdep docs less readable?

It's not the markup that makes the lockdep documentation hard to
understand.
