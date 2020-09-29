Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF34027BD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgI2HF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI2HF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:05:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9kawJvAFm/r2cBtZDaKI8NZRqczi1W/P4nsVgilq4Ss=; b=qxjLXffFoddrO7D0GyZZy4syv7
        FUM5lR8JmfuUE9i/gypoGTn59k541DQsgkstXQbDWmZfkhiz+ElJlldFMSiMldmKsFA5Ip0XsaLFz
        /E+zuw/joubEIQp3OkSZJg6z4yTnxZn1/YHtOjX08KpQEWSRmBD9su87FD4LTG7KpcX20yDs7vlDa
        4v+q8xBx+MjlTf9xgnfYFBh6i1qHsHoqvFgR7qanZwDdsRcNmjdOqPM23ose/aAsgENjYS0IMkvnG
        LhOzRqTlzPbhTWjV3ktokRlr3a0rV4CN7pPIvvEQ/8pzN0u96TuMfGw/BwbXMFlsOXwGRTmh7GL24
        k+O8cdHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN9hq-0008JL-9M; Tue, 29 Sep 2020 07:05:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F65B302753;
        Tue, 29 Sep 2020 09:05:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B5D7200D4C43; Tue, 29 Sep 2020 09:05:44 +0200 (CEST)
Date:   Tue, 29 Sep 2020 09:05:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] objtool: Permit __kasan_check_{read,write} under UACCESS
Message-ID: <20200929070544.GI2628@hirez.programming.kicks-ass.net>
References: <20200928224916.2101563-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928224916.2101563-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:49:16AM +0200, Jann Horn wrote:
> Building linux-next with JUMP_LABEL=n and KASAN=y, I got this objtool
> warning:
> 
> arch/x86/lib/copy_mc.o: warning: objtool: copy_mc_to_user()+0x22: call to
> __kasan_check_read() with UACCESS enabled
> 
> What happens here is that copy_mc_to_user() branches on a static key in a
> UACCESS region:
> 
>         __uaccess_begin();
>         if (static_branch_unlikely(&copy_mc_fragile_key))
>                 ret = copy_mc_fragile(to, from, len);
>         ret = copy_mc_generic(to, from, len);
>         __uaccess_end();
> 
> and the !CONFIG_JUMP_LABEL version of static_branch_unlikely() uses
> static_key_enabled(), which uses static_key_count(), which uses
> atomic_read(), which calls instrument_atomic_read(), which uses
> kasan_check_read(), which is __kasan_check_read().
> 
> Let's permit these KASAN helpers in UACCESS regions - static keys should
> probably work under UACCESS, I think.

It's not a matter of permitting, it's a matter of being safe and
correct. In this case it is, because it's a thin wrapper around
check_memory_region() which was already marked safe.

check_memory_region() is correct because the only thing it ends up
calling is kasa_report() and that is also marked safe because that is
annotated with user_access_save/restore() before it does anything else.

On top of that, all of KASAN is noinstr, so nothing in here will end up
in tracing and/or call schedule() before the user_access_save().

> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> Calling atomic_read() on a global under UACCESS should probably be fine,
> right?

Yes, per the above.

>  tools/objtool/check.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index a88fb05242d5..1141a8e26c1e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -583,6 +583,8 @@ static const char *uaccess_safe_builtin[] = {
>  	"__asan_store4_noabort",
>  	"__asan_store8_noabort",
>  	"__asan_store16_noabort",
> +	"__kasan_check_read",
> +	"__kasan_check_write",
>  	/* KASAN in-line */
>  	"__asan_report_load_n_noabort",
>  	"__asan_report_load1_noabort",
> 
> base-commit: 0248dedd12d43035bf53c326633f0610a49d7134
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
