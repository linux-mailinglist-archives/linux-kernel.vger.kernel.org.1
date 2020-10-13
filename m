Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D126528CEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgJMMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgJMMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:52:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71939C0613D0;
        Tue, 13 Oct 2020 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+NnF8mXNakRlzoqAgkjq1DF0tdaTbndVS0Kzp4/RQv8=; b=A19mXaDMPQsr3FhPWF2UXpJ7XG
        YeIVyZgXhf5umYX/r2JsYFErELnBSXQGZruOQCU+UQ2s5xN5+gdRpqSieWngDw9irvE+kRzsflk+U
        BvcdMCER/qjonBmM3Gq/HSHRlPuVyo4LAc7Wu7UrehXDob6mVeABVncf53KlG/28ej+tccGIu6ZIt
        bMBwSSXcofP3dCvy08oosGaaMACgLjQVrcZzFW9h7HgjEcQCBK/iHZbnZyYuVBVetISjIaMuz3zWO
        x1QHz+peNsj/dG1enb92qMLJwuSS3AcoN/yTPSTplv9lhS6jmOKw6+30JcYmAJ78sKPukF4snTfYP
        6BjBOppA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSJmj-0008Mk-0D; Tue, 13 Oct 2020 12:52:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E458301959;
        Tue, 13 Oct 2020 14:52:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03A442B4F909A; Tue, 13 Oct 2020 14:52:06 +0200 (CEST)
Date:   Tue, 13 Oct 2020 14:52:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/24] docs: lockdep-design: fix some warning issues
Message-ID: <20201013125206.GU2611@hirez.programming.kicks-ass.net>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:31PM +0200, Mauro Carvalho Chehab wrote:
> +   =====  ===================================================
> +   ``.``  acquired while irqs disabled and not in irq context
> +   ``-``  acquired in irq context
> +   ``+``  acquired with irqs enabled
> +   ``?``  acquired in irq context with irqs enabled.
> +   =====  ===================================================
>  
>  The bits are illustrated with an example::
>  
> @@ -96,14 +99,14 @@ exact case is for the lock as of the reporting time.
>    +--------------+-------------+--------------+
>    |              | irq enabled | irq disabled |
>    +--------------+-------------+--------------+
> -  | ever in irq  |      ?      |       -      |
> +  | ever in irq  |    ``?``    |     ``-``    |
>    +--------------+-------------+--------------+
> -  | never in irq |      +      |       .      |
> +  | never in irq |    ``+``    |     ``.``    |
>    +--------------+-------------+--------------+
>  
> -The character '-' suggests irq is disabled because if otherwise the
> -charactor '?' would have been shown instead. Similar deduction can be
> -applied for '+' too.
> +The character ``-`` suggests irq is disabled because if otherwise the
> +charactor ``?`` would have been shown instead. Similar deduction can be
> +applied for ``+`` too.
>  

NAK!
