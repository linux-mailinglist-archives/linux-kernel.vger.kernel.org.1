Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA427F370
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgI3Ukq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Ukp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:40:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119C72064E;
        Wed, 30 Sep 2020 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601498445;
        bh=HSIi+z4+6zDGtzfYvkCV+4MaQTyMOGFoRZ7A/A6Oyg4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gztbrPbSLZIkeo8dERp62j9vvJ2n/MCPlJPGdHNtanlazsTNRh8bLUb/hYT0uThkj
         6fO82z+ztvFeUEYJqSg6OC/rz9ttIVJ2dLBcDLFaKleNzS/N85t/cZTEu5R0AjXLt0
         lnCi21u3u/J+7tJL4E6GqdPaXX6cYNMmNN7h4S/g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BBB6C352303E; Wed, 30 Sep 2020 13:40:44 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:40:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <20200930204044.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192549.501516-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

I am guessing that this needs to go up with other patches.  If so:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

If not, let me know and I will queue it.

							Thanx, Paul

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
