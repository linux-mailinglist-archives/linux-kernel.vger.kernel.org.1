Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62E2E95C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhADNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhADNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:20:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4vbh5rgk+lxV2PnusB2jyRkAlKCmIM48/QAFdRFOrH8=; b=i+ztVAJDR1PUo2Auesb/pU9qJF
        /QJKHodz/kMeo8MZq7PiKdwjPHMMbkSgPPSbpZLakxvZ/KVvyoAYR75FSfUwgU7xGYkViAb+lsHTi
        6adVwA+nftqqMdTX0zqw2ST9isV7SXGBFx9wwI0yXVBCTamf4kcFod9OWvxOAG82nrxcrMJR6yLpo
        tsszYNEDLZn4jb6GpMTyQ35Jg9Oh6xycc4DdRaSYzUthh0ysPXjY02rI4hWlw6uNa+HfTLVaRdEQ6
        zlVpH9e5IQVTtKm2xWRm8WjdYg+ng6FnCRdGzJthI4n2GA52/wRcKS2DxLrnxzG5981Ui5xI1qnwZ
        3lVTFXFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwPlY-0007nW-FF; Mon, 04 Jan 2021 13:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 394E83013E5;
        Mon,  4 Jan 2021 14:19:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18C0320CBF483; Mon,  4 Jan 2021 14:19:19 +0100 (CET)
Date:   Mon, 4 Jan 2021 14:19:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 06/19] perf/x86/intel/ds: Check insn_get_length()
 retval
Message-ID: <20210104131919.GN3021@hirez.programming.kicks-ass.net>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-7-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223174233.28638-7-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:42:20PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> intel_pmu_pebs_fixup_ip() needs only the insn length so use the
> appropriate helper instead of a full decode. A full decode differs only
> in running insn_complete() on the decoded insn but that is not needed
> here.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/events/intel/ds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 67dbc91bccfe..3786b4e07078 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1265,14 +1265,14 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
>  		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
>  #endif
>  		insn_init(&insn, kaddr, size, is_64bit);
> -		insn_get_length(&insn);
> +
>  		/*
>  		 * Make sure there was not a problem decoding the
>  		 * instruction and getting the length.  This is
>  		 * doubly important because we have an infinite
>  		 * loop if insn.length=0.
>  		 */
> -		if (!insn.length)
> +		if (insn_get_length(&insn) || !insn.length)

Do we really still need the !insn.length? That is, it *should* be
impossible to not fail insn_get_length() and still have a 0 length,
seeing how x86 doesn't have 0 length instructions.
