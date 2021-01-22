Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99CD3009D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbhAVRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbhAVP5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:57:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F29522248;
        Fri, 22 Jan 2021 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611331032;
        bh=2q9jzIlTX6HLSbm2PDPJud2i9jj2YBRvZIjrpTQhNOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBKWu7+9IV9yBWD9dtflpn58N2O3uZeLg3UcclXVYO3fktFkmQUbWqKnQCSmS7Yoj
         v2v9OA5ol3bNMOmXtM4qHv1ZaXY8CiUPEaw4ILbkYi4LTz3jReQM0jOLxhT6XiL26A
         1tJ6hwD6CWH+hW3gjnMcMhv+9aD4UnTrTRQcgDuD+G0GQWNt/mpd7UwDbU+WHLSb2X
         9C9KWVyRz46Xz7qw3I908fwdSK5fb2MgZ9RfRIe9CIF2siVnmWGn5Sciy4tQwN3S6W
         kFs+D2CQYBdPQC8EEySj+HUZOH8EPa4/q3SPTiuotB7AP1VGXmZVZZorm+oBX0wpld
         foXDmXFwUkOXg==
Date:   Fri, 22 Jan 2021 15:57:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
Message-ID: <20210122155708.GA25088@willie-the-truck>
References: <20210122110909.3324607-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122110909.3324607-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:09:09AM +0000, Qais Yousef wrote:
> I was hitting the below panic continuously when attaching kprobes to
> scheduler functions

[...]

> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 89c64ada8732..66aac2881ba8 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -352,8 +352,8 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned int esr)
>  	unsigned long addr = instruction_pointer(regs);
>  	struct kprobe *cur = kprobe_running();
>  
> -	if (cur && (kcb->kprobe_status == KPROBE_HIT_SS)
> -	    && ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
> +	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
> +	    ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
>  		kprobes_restore_local_irqflag(kcb, regs);
>  		post_kprobe_handler(cur, kcb, regs);

Acked-by: Will Deacon <will@kernel.org>

Catalin can pick this up for 5.11.

Will
