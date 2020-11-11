Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F252AF4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKKP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:29:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:42118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKKP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:29:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605108574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sDXXEr4je5Qj8STdejDddgjD8UXPI7WrWvNpATUfJE=;
        b=h+INSi/kBPnCA17voUdGQn1OAIzVkLYVyIBp78cfssukqs9oqHWB8liFUjp3MSMsIut53o
        qMyrzMOPXC32Pxc6PPFVOdPWUbl32V33skLWWpMmyXaSGRF2dzCJhWktb/OqqxPVRAZNTq
        z5PKDAmhFW5zw+12staEUeAkxnTSoP0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 516B7ABD1;
        Wed, 11 Nov 2020 15:29:34 +0000 (UTC)
Date:   Wed, 11 Nov 2020 16:29:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: core-api/printk-formats.rst: Clarify formatting
 {cpu,node}mask
Message-ID: <20201111152933.GA1702@alley>
References: <20201110144121.3278667-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110144121.3278667-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-10 15:41:21, Geert Uytterhoeven wrote:
> Clarify how to pass the field width for bitmaps, and mention the helper
> macros that are available to ease printing cpumask and nodemask.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/core-api/printk-formats.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 6d26c5c6ac485cec..160e710d992f3a36 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -531,7 +531,9 @@ For printing bitmap and its derivatives such as cpumask and nodemask,
>  %*pb outputs the bitmap with field width as the number of bits and %*pbl
>  output the bitmap as range list with field width as the number of bits.
>  
> -Passed by reference.
> +The field width is passed by value, the bitmap is passed by reference.
> +Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
> +printing cpumask and nodemask.

I like it and I would go even further. I have never used these modifiers
and was really confused by the entire description.

IMHO, it is just an implementation detail that the number of bits is
passed via width in struct printf_spec. It is the asterisk '*' that
defines that one more argument is needed. And it is up to the
documentation to define what the argument is for.

The following text shows the idea. I am not a native speaker.
I am sure that the working might get improved.

<cut>
	%*pb	0779
	%*pbl	0,3-6,8-10

For printing bitmap and its derivatives such as cpumask and nodemask.

It takes two arguments, see '*'. The first argument defines the number
of bits in the mask. The second argument points to the mask.

%*pb outputs the bitmap as a hex number. If the size is bigger than 32-bit
then 32-bit values are separated by a comma.

%*pbl outputs the bitmap as a range list.

The number of bits is passed by value. The mask is passed by reference.
Helper macros cpumask_pr_args() and nodemask_pr_args() are available to
ease printing cpumask and nodemask.
</cut>

Best Regards,
Petr
