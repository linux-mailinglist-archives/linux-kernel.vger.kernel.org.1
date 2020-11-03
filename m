Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5492A3B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 05:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCEz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 23:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgKCEz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 23:55:28 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A5222243;
        Tue,  3 Nov 2020 04:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604379328;
        bh=+/Zb/Rd1pwj4ivtng24HgDPmrWpJWrx1iasx4QMAmCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPKVNGX3SHWfoC3mgv91kVID9sQ5o+RHNVJfdwSBIcDlD+nKCRFYHcldiaiw3TpGl
         sYrxQq4DY8FkNgCWTfuQFyuXAhpfhX284/vOkmxZzLQG/gBAGMnzDRdX/CGNi/bD8F
         /KxbYvjnKNJi2I/lc55H8Vm8sms7/1Vj0SKL1jCg=
Date:   Tue, 3 Nov 2020 06:55:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201103045521.GA58906@kernel.org>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902225911.209899-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.
> 
> We plan to remove workarounds for older versions now, which will break
> in subtle and not so subtle ways.
> 
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Acked-by: Marco Elver <elver@google.com>
> Acked-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Sedat Dilek <sedat.dilek@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Link: https://github.com/ClangBuiltLinux/linux/issues/941
> ---
>  include/linux/compiler-clang.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..230604e7f057 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,14 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>  
> +#define CLANG_VERSION (__clang_major__ * 10000	\
> +		     + __clang_minor__ * 100	\
> +		     + __clang_patchlevel__)
> +
> +#if CLANG_VERSION < 100001
> +# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
> +#endif


I'm trying to compile a BPF enabled test kernel for a live system and I
get this error even though I have much newer clang:

➜  ~ (master) ✔ clang --version          
Ubuntu clang version 11.0.0-2
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

Tried to Google for troubleshooter tips but this patch is basically the
only hit I get :-)


> +
>  /* Compiler specific definitions for Clang compiler */
>  
>  /* same as gcc, this was present in clang-2.6 so we can assume it works
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

/Jarkko
