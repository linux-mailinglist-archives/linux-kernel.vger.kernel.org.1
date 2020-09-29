Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85E527DCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgI2XqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI2XqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:46:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5537C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so6402816pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BE3IS0ree7QIjSeFdWMob24S2TufDcRFBlLIISZlO6M=;
        b=QXOBgazQg6wlfqddFVNOmR1+eQ18ANNoedSzhVTOd76Xb9OOzbsuJfr5rFfxMrMfhu
         YnIJwwUHOi0+iOL5DJILilajKT7+URNJ1ZG8ypreA9OSPm7I8EHA9g+QV2XFZMFeKA1M
         +eKJ6pajmTC/5hm6LrFI6NNsy1BbxGftvEmb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BE3IS0ree7QIjSeFdWMob24S2TufDcRFBlLIISZlO6M=;
        b=czWYmXXAtsz1jdaBs4ULsPc6sTqXHclPmYgb3epAKfi6J+UauPwbBkpcgRvweywg+u
         ANgl6PW41A2lO8WLnMXoig2E5U7/s8Jbq1svxBFbze5H/N7Lq/CKYoRHRMdyaVYgpS14
         PEC968F7PPPCPQFGciJcAuC9EM/oRDTOT6+AZujsy50wY3yyViB8VcYup9enDkvJzG4t
         yvI8uRF3BhsAjQzmEQpApm7O10MUmy5rL65uTl0meEd3hZCH2Gg14iHhBdfnZLZfZRWQ
         7NdRRWpiorERElnoZJVtgp8xl9DZtM/XUf4wd259kUDZHoc4MAbOfQ3Gqvmdstxj0KnM
         c1AQ==
X-Gm-Message-State: AOAM530rn/Bm4il/o0RO5ypKoYssjj5SoFRimkfrzKvFVBhEPVQXPETh
        Lek8/vWEe++VIj9eqLcjqehd6Q==
X-Google-Smtp-Source: ABdhPJxIkpLcpVnapCDkZNX9W2yXBh/3YDEom0sH8C5ml1NdWeGB1F+0AyKjMGoFTKhuU1viFEF2iA==
X-Received: by 2002:a63:511d:: with SMTP id f29mr4006pgb.11.1601423161354;
        Tue, 29 Sep 2020 16:46:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15sm6744827pfk.145.2020.09.29.16.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 16:46:00 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:45:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <202009291645.283040FE80@keescook>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192549.501516-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> The stringification operator, `#`, in the preprocessor escapes strings.
> For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> they treat section names that contain \".
> 
> The portable solution is to not use a string literal with the
> preprocessor stringification operator.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Ah, ignore my earlier question about also fixing this instance. Here it
is! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes V1->V2:
> * drop unrelated Kconfig changes accidentally committed in v1.
> 
>  include/linux/srcutree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 9cfcc8a756ae..9de652f4e1bd 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -124,7 +124,7 @@ struct srcu_struct {
>  # define __DEFINE_SRCU(name, is_static)					\
>  	is_static struct srcu_struct name;				\
>  	struct srcu_struct * const __srcu_struct_##name			\
> -		__section("___srcu_struct_ptrs") = &name
> +		__section(___srcu_struct_ptrs) = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)					\
>  	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 

-- 
Kees Cook
