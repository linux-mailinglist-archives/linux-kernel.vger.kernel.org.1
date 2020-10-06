Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6015D284BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJFMbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:31:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgJFMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:31:02 -0400
Date:   Tue, 6 Oct 2020 14:30:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601987460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhFcoPzFYI/4m2fbtizw1MozBQgqfqg3O3LLboTR2OU=;
        b=yMJPSpLy70AOzRFpkjeIv5NPQNhu/4FVyO17/F7hd8Q1PKxxGhEA1ujqGgebvTzf0oVrKZ
        rcZOsC+ixjzp8uBME44whFS4e52CkD50L/i6nv3xE5DcgtP9O/035WtmqpneaVZQHTEg24
        rd/cHIEkIgBjpmKA9qWCDT5RjhF+k4GnT9L6YwctXtvY02hnWsoT/tDeP4yQ3RaaxTjcI/
        +eAyb9Uf5IviQCXX8B1U8rdWzAWJUfsd2IfSlAitNzkdHVAL/PrgkHCwRNIzMvNCrRRk2/
        qWVIMDY6lc0oOAFbo8KuW3oqjJMqPBbbY0XkJEJeKPZ/zlJqARPvN+HieHMKqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601987460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhFcoPzFYI/4m2fbtizw1MozBQgqfqg3O3LLboTR2OU=;
        b=B5Xs0Fmobz1fgt6Qxck++p/aQBrMzfExMRzQnYnH1z4QyRdJvfTU2+TsZR1RxqLPH75xqM
        O26bgNjM/uJfHtAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc
Message-ID: <20201006122932.o7hn7hvucbl5n6fu@linutronix.de>
References: <20200924154851.skmswuyj322yuz4g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924154851.skmswuyj322yuz4g@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-24 17:48:53 [+0200], To linux-kernel@vger.kernel.org wrote:
> ctags creates a warning:
> |ctags: Warning: include/linux/seqlock.h:738: null expansion of name pattern "\2"
> 
> The DEFINE_SEQLOCK() macro is passed to ctags and being told to expect
> an argument.
> 
> Add a dummy argument to keep ctags quiet.

ping.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/seqlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 962d9768945f0..4a69e74dc7ce9 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -735,7 +735,7 @@ typedef struct {
>  	} while (0)
>  
>  /**
> - * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
> + * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
>   * @sl: Name of the seqlock_t instance
>   */
>  #define DEFINE_SEQLOCK(sl) \
> -- 
> 2.28.0
> 
