Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F291A1035
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgDGPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 11:30:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36223 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgDGPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:30:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id b1so4228929ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OFTX/G/GDJAyIu0gLFtbbOxK0H+/HJaZ3Xln3eUsdVc=;
        b=WyU+Ob5ZKNu6vY2FusNgAEiawa344umKOZy878Bq4M/9oQzmJ+i1OAStdaNB7a3JRh
         J0t1FUPvAh9QZ73HTLhVQSL3ore3uvEz8fDuC+QMSknfkJkwgORtv7tt2Aopp3JsAhH3
         fvqL7YEqAOrEuL7hHbU2C/nFB8SPTXAxchEDiJzPYssYfT1BgC44FvFxf/zrCGi3bu8o
         jnEfnBeq7Of/rQk0EdB9ZGiopZ6fQDBt29SxvoPkX4fUXqx+GWqR34Uzq4UXlFGmgbqy
         iqyM5IjqJiPq2q08CFmn+U3QSsAuzD7mtUux7RXo8GRN/RKNS9vnwBV+brYBj2V6e0lA
         +Vyw==
X-Gm-Message-State: AGi0PuYc8QCTZomo7odft3JIEiH+vC2r8hNmiYWnnof+GbyTXoqq1v8r
        NbY05sDGzhLSK1mf6SU/SQFnrUoRpFg=
X-Google-Smtp-Source: APiQypIXCiz2LmQPL0e6MAdUwvQqfWpT0vDecyiosAXd1AP5+UrJjF5hoCE9K2TAFRjw7kzNaAid8g==
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr2022632ljp.142.1586273421584;
        Tue, 07 Apr 2020 08:30:21 -0700 (PDT)
Received: from [192.168.42.234] ([213.87.128.127])
        by smtp.gmail.com with ESMTPSA id l3sm13591119lfk.53.2020.04.07.08.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:30:20 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] gcc-plugins/stackleak: Avoid assignment for unused macro
 argument
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com
Cc:     Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org
References: <202004020103.731F201@keescook>
From:   Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <13c90df4-a422-bb73-a119-b8ccd11fc4f1@linux.com>
Date:   Tue, 7 Apr 2020 18:30:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202004020103.731F201@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kees,

On 02.04.2020 11:10, Kees Cook wrote:
> With GCC version >= 8, the cgraph_create_edge() macro argument using
> "frequency" goes unused. Instead of assigning a temporary variable for
> the argument, pass the compute_call_stmt_bb_frequency() call directly
> as the macro argument so that it will just not be uncalled when it is
> not wanted by the macros.

Do you mean "it will just not be called"?

Thanks!

> Silences the warning:
> 
> scripts/gcc-plugins/stackleak_plugin.c:54:6: warning: variable ‘frequency’ set but not used [-Wunused-but-set-variable]
> 
> Now builds cleanly with gcc-7 and gcc-9. Both boot and pass
> STACKLEAK_ERASING LKDTM test.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index dbd37460c573..cc75eeba0be1 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -51,7 +51,6 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
>  	gimple stmt;
>  	gcall *stackleak_track_stack;
>  	cgraph_node_ptr node;
> -	int frequency;
>  	basic_block bb;
>  
>  	/* Insert call to void stackleak_track_stack(void) */
> @@ -68,9 +67,9 @@ static void stackleak_add_track_stack(gimple_stmt_iterator *gsi, bool after)
>  	bb = gimple_bb(stackleak_track_stack);
>  	node = cgraph_get_create_node(track_function_decl);
>  	gcc_assert(node);
> -	frequency = compute_call_stmt_bb_frequency(current_function_decl, bb);
>  	cgraph_create_edge(cgraph_get_node(current_function_decl), node,
> -			stackleak_track_stack, bb->count, frequency);
> +			stackleak_track_stack, bb->count,
> +			compute_call_stmt_bb_frequency(current_function_decl, bb));
>  }
>  
>  static bool is_alloca(gimple stmt)
> 

