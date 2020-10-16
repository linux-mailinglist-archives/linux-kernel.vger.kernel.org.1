Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966128FC41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgJPBdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 21:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388978AbgJPBdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 21:33:36 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC97120760;
        Fri, 16 Oct 2020 01:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602812015;
        bh=Gyq0Uk2XEfl9xmWYnLkSM9zvUTO4aNfnfhPhd5Y8Dyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Mlbr9r5bcAnUqGUfWwMD8DGKhMJgxyOMR+rHZeKITFbo1+QN6xLqfguFM4Au1Ffa
         x7WVxZVJFg2GS/N1H9LufkM09Jo4ykEZBVbBg4Lu61FnoV6qMy8jBXwQgKLEmzoMEY
         oiJdHOWokM8FXajrQsmzrA/Zp+s3sZuqD2NbOnGI=
Date:   Fri, 16 Oct 2020 10:33:30 +0900
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
Subject: Re: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Message-Id: <20201016103330.668783f6d4e19ec2ac2ca1f8@kernel.org>
In-Reply-To: <20201015161216.1563600-1-irogers@google.com>
References: <20201015161216.1563600-1-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 09:12:16 -0700
Ian Rogers <irogers@google.com> wrote:

> From: Numfor Mbiziwo-Tiapo <nums@google.com>
> 
> Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> these are forms of undefined behavior.
> 
> These problems were identified using the undefined behavior sanitizer
> (ubsan) with the tools version of the code and perf test. Part of this
> patch was previously posted here:
> https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> 
> v2. removes the validate_next check and merges the 2 changes into one as
> requested by Masami Hiramatsu <mhiramat@kernel.org>

Looks good to me. This may be OK on x86, but now this code will be run
on other arches for cross compilation.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  arch/x86/lib/insn.c       | 4 ++--
>  tools/arch/x86/lib/insn.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 404279563891..be88ab250146 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -20,10 +20,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
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
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 0151dfc6da61..92358c71a59e 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -20,10 +20,10 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
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
