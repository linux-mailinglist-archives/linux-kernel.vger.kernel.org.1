Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335C3284892
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgJFI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJFI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:26:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B24C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CaaJg0+4HXhxYqVjEYhietri7tdgQvGNQD/n6w1akKM=; b=f48A63UpKPhN/WJD7npTs0ZjUW
        h79FU55g7JyG/6Wm9gI0gyCX1pJW/N+1cJyiKO2oLj7E4hygWB0fbrnKu8ePztMYMF9vu4pZ3dGi0
        HKb5MiDOIOd4xhXi+UheBj6xPBf44z3CCq1VbOEP1/A633SDFkixQDGAMoS7Tj8/2oQzRymgrtETn
        68aKM7N90Wo+3pK0uuRadlTQ/F6jBlqIADnh8ds2ffYz9weK38YT5/JbP2X3SiyalSAuhMvETxSbB
        BeuTA1pCkgwutL1DJrwy26uR/Mhhvw+WfEBT80zKzJ7CrjIX52MvuZFqoirRxmElJKN5+/EfSZ9rB
        O8UiOa7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPiIl-0007rL-H6; Tue, 06 Oct 2020 08:26:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A65D73019CE;
        Tue,  6 Oct 2020 10:26:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4495028B30F68; Tue,  6 Oct 2020 10:26:25 +0200 (CEST)
Date:   Tue, 6 Oct 2020 10:26:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <20201006082625.GM2628@hirez.programming.kicks-ass.net>
References: <cover.1601925251.git.luto@kernel.org>
 <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:30:03PM -0700, Andy Lutomirski wrote:
> @@ -441,6 +441,9 @@ struct fixed_percpu_data {
>  	 * GCC hardcodes the stack canary as %gs:40.  Since the
>  	 * irq_stack is the object at %gs:0, we reserve the bottom
>  	 * 48 bytes of the irq stack for the canary.
> +	 *
> +	 * Once we are willing to require -mstack-protector-guard-symbol=
> +	 * support for x86_64 stackprotector, we can get rid of this.
>  	 */
>  	char		gs_base[40];
>  	unsigned long	stack_canary;

I'm all in favour of simply requiring GCC-8.1 to build a more secure
x86_64 kernel. Gives people an incentive to not use ancient compilers.

And if you do want to use your ancient compiler, we'll still build, you
just don't get to have stackprotector.
