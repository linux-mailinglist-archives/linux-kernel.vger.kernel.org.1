Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9039E1F1469
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgFHIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFHIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:21:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EB7206A4;
        Mon,  8 Jun 2020 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591604515;
        bh=ukk9VRIP+NjAOTVBv02xmYFvysWUmJ7wdix9Sz1YUBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=przoaiwQeAzLSZk7wk1fXs7LbXR2q1ElpNm4y4G4hry5jp8BG3bmFL4W7pvFh+nMY
         S+XH4vrnwcNbV7M5QamQrf/gsc1k0nNmXnlyWjlmU4/04j56h2zuZF3/+Kbks36fue
         PI6l3TokD7x551whAvn2qViDrcSEepnoFN6GrnK4=
Date:   Mon, 8 Jun 2020 09:21:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Possible PATCH]arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
Message-ID: <20200608082150.GB1542@willie-the-truck>
References: <b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 12:25:50PM -0700, Joe Perches wrote:
> CONFIG_FTRACE_WITH_REGS does not exist as a Kconfig symbol.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> I don't have the hardware, so I can't tell if this is a
> correct change, but it is a logical one.
> 
> Found by a test script that looks for IS_ENABLED(FOO)
> where FOO must also exist in Kconfig files.
> 
>  arch/arm64/kernel/ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 8618faa82e6d..86a5cf9bc19a 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -69,7 +69,8 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
>  
>  	if (addr == FTRACE_ADDR)
>  		return &plt[FTRACE_PLT_IDX];
> -	if (addr == FTRACE_REGS_ADDR && IS_ENABLED(CONFIG_FTRACE_WITH_REGS))
> +	if (addr == FTRACE_REGS_ADDR &&
> +	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
>  		return &plt[FTRACE_REGS_PLT_IDX];

Ha! So much for 100-char lines ;)

(fix looks good to me, I'll queue it for -rc1)

Will
