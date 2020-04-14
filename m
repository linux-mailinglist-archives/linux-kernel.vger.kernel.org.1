Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548F11A880C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503108AbgDNR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729303AbgDNR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:56:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aOEWolJUyLqA27JZUumiZsYRtpTHiV6d3H874l+n2Fw=; b=Abw9X48FNm4E7mic7yBwqElwMn
        2J2Wa7wftM2+G5htUWYnYHhH6xV1yP8chDD48ZFWZn0CSWeNB3xjZVnQrk+hL+iMQtzzmIBo+H+yy
        aqOuoK18l0RaNRhNODeWnbNO+SsYVDGI3O0nVCcsx1+OGRYxAKQ8NDG+piKYJ91ov7wYYUWuy7OdM
        EbAs0WROEiDMJKP0VH/xVnfaE8/GcKIQQWRBAkWIfk5vVBXkM1jNTrLF0B3JF0QL3xpyGbBFIbtE2
        yssYZmm/e3K3kObu9tk3+RCHnSEzZJG/HY7Z3+vaFFFrV0bzsTowlmbL61l4GZtIQZ8GeiEzW/oPy
        9brLTW6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOPn3-0001t4-St; Tue, 14 Apr 2020 17:56:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DB4981086; Tue, 14 Apr 2020 19:56:04 +0200 (CEST)
Date:   Tue, 14 Apr 2020 19:56:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
Message-ID: <20200414175604.GD2483@worktop.programming.kicks-ass.net>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
 <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 06:40:12PM +0200, Alexandre Chartre wrote:
> 
> On 4/14/20 6:16 PM, Peter Zijlstra wrote:
> > On Tue, Apr 14, 2020 at 12:36:14PM +0200, Alexandre Chartre wrote:
> > > Add the UNWIND_HINT_RADDR_DELETE and UNWIND_HINT_RADDR_ALTER unwind
> > > hint macros to flag instructions which remove or modify return
> > > addresses.
> > 
> > I'm confused by this thing; why? AFAICT the rest of the patches are
> > actually simpler without this one.
> > 
> 
> This is required to indicate to objtool that assembly instructions are
> changing return addresses. For example, in patch 8:
> 
> For retpoline:
> 
> @@ -88,6 +96,7 @@
>  	lfence
>  	jmp	.Lspec_trap_\@
>  .Ldo_rop_\@:
> +	UNWIND_HINT_RADDR_ALTER
>  	mov	\reg, (%_ASM_SP)
>  	ret
>  .endm
> 
> The unwind hint indicates that the return address has been altered, so the
> code won't return to the return address which was on the stack.

But if you hadn't added that return stack stuff in the first place,
you'd not have needed that HINT.

So what actual problem is it solving?
