Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8871928EE85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgJOIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgJOIbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:31:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E356522249;
        Thu, 15 Oct 2020 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602750697;
        bh=eSFEJu4t9jHJq5suNGPILfIMLCMSD1vW71f0sb4ceVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s0Cxttfkq/x8Vr6FTGpWqIvMuvLTgepkDUZlL0m4SBJ02kL2jS8AiIvK17RI27Rbu
         EXLqaNbTzqwxcac3sjNGjwmKtsa6oOm9qje4RVS1wsxLqspoUsdFjJ2ErKBuI08fAt
         GSKGhdmEtqNX6Ic10IuojYA8zld58flXzspMGIeM=
Date:   Thu, 15 Oct 2020 17:31:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH 2/2] tools/x86: Fix some potential undefined behavior
Message-Id: <20201015173124.16ce3e27253f2fa1df0c8b46@kernel.org>
In-Reply-To: <20201015062148.1437894-2-irogers@google.com>
References: <20201015062148.1437894-1-irogers@google.com>
        <20201015062148.1437894-2-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please merge the change on arch/x86/lib/insn.c and tools/arch/x86/lib/insn.c
to a single patch for bisecting.

Thank you,

On Wed, 14 Oct 2020 23:21:48 -0700
Ian Rogers <irogers@google.com> wrote:

> From: Numfor Mbiziwo-Tiapo <nums@google.com>
> 
> If insn_init is given a NULL kaddr and 0 buflen then validate_next will
> perform arithmetic on NULL, add a guard to avoid this.
> 
> Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> these are forms of undefined behavior.
> 
> These problems were identified using the undefined behavior sanitizer
> (ubsan) with  perf test. Part of this patch was previously posted here:
> https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/arch/x86/lib/insn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 0151dfc6da61..e8874a8cac2c 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -17,13 +17,13 @@
>  
>  /* Verify next sizeof(t) bytes can be on the same instruction */
>  #define validate_next(t, insn, n)	\
> -	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
> +	((insn)->end_kaddr != 0 && (insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); r; })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
> -	({ t r = *(t*)((insn)->next_byte + n); r; })
> +	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
>  
>  #define get_next(t, insn)	\
>  	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
