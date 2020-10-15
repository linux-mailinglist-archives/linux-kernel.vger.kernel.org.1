Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB928EE17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgJOIBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgJOIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:01:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:01:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id md26so2230691ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BETpnWxQsiY3uUYF0arnulp2j8hnL6pUYuI01v4wjds=;
        b=kTGoV64fzSEKXWuEgxEE12/ZS7+MOJGmP8jS+NT8CdqxRXAeTdWMOV2Zcs4ggfwDFE
         ZXKGgE50ivn1Are8mjKTJrb8CiGaFPhZ4p7656XfaRzN87ua7+H2OljMItKMh9CexGaN
         Q+l1t/5Q2N4yICbVp6T3w0w2E9lf+4DNTFBm6wtYIBH56qKaIHW40xEWWVBElFmNOKjW
         kk65Kpkq3x+s6Z8KHP5W0CICNd/uBv0WnR9mTe9oRZmjdlAfAcj2B0hDd1DdpQb6C50f
         p9Fi8cU7FCEf3i2D1/L9uvG5moiDg8gaoQHOGh9eVoxyi/L3yvEDoJOq3lAhzy8hxA48
         hFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BETpnWxQsiY3uUYF0arnulp2j8hnL6pUYuI01v4wjds=;
        b=g/Mvpj/aMTL9xQ2zykR0Bp47QyTBOuSf/n+71H8h78zQkqEK9J4JlKATmLOH6vCA7R
         7PK3UWAFvQjxK4Icll34VSWTefILerY6kD7zxlPXW7K9vCoFtqG9F0mOe0RXHKdD3+YL
         mf+nzPkbLLlL7qfOhSMZXhjbSyqA5NlnZ9LIHCbaIgHc68YwAQ1ObCAadgrwpcmA/09p
         8oKWbUz3c6+1pM7n6R5hxuv062WGxUET3UX68TAFxuTYXN4ShwNsmiP5+vPNJMqchaSg
         g8GAp/CCtkLhGZPdNRM+s0x/eLhTVU6Rkvhk3QPi7WRzkyAQYPluc8tctaz0BuKJw+fO
         g7Pw==
X-Gm-Message-State: AOAM532GQoSBngxgh/sMFjYnuneIygvWZnvuYf9IGPO7U6UVbzIAYesj
        d+SSGyeVCWdoRnHDZ3eeGWs=
X-Google-Smtp-Source: ABdhPJwciWO2r+6CFSAN3LcgOLGfr6DtfxtUiM1Ia5jfb2YYlspBwM31nIIuiiZpjZz3ggBnHh/SkQ==
X-Received: by 2002:a17:906:c094:: with SMTP id f20mr3255160ejz.550.1602748894330;
        Thu, 15 Oct 2020 01:01:34 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id s1sm1037941edi.44.2020.10.15.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 01:01:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 15 Oct 2020 10:01:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: Re: [PATCH 1/2] x86/insn: Fix some potential undefined behavior.
Message-ID: <20201015080131.GA894367@gmail.com>
References: <20201015062148.1437894-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015062148.1437894-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ian Rogers <irogers@google.com> wrote:

> From: Numfor Mbiziwo-Tiapo <nums@google.com>
> 
> If insn_init is given a NULL kaddr and 0 buflen then validate_next will
> perform arithmetic on NULL, add a guard to avoid this.
> 
> Don't perform unaligned loads in __get_next and __peek_nbyte_next as
> these are forms of undefined behavior.

So, 'insn' is a kernel structure, usually allocated on the kernel stack. 
How could these fields ever be unaligned?

> 
> These problems were identified using the undefined behavior sanitizer
> (ubsan) with the tools version of the code and perf test. Part of this
> patch was previously posted here:
> https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  arch/x86/lib/insn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 404279563891..57236940de46 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
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

Is there any code generation side effect of this change to the resulting 
code?

Thanks,

	Ingo
