Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A692B27CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKMWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKMWEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:04:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8BC0613D1;
        Fri, 13 Nov 2020 14:04:37 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 59F91734;
        Fri, 13 Nov 2020 22:04:37 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:04:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: core-api/printk-formats.rst: Clarify formatting
 {cpu,node}mask
Message-ID: <20201113150436.40a256a7@lwn.net>
In-Reply-To: <20201110144121.3278667-1-geert+renesas@glider.be>
References: <20201110144121.3278667-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:41:21 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

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

Applied, thanks.

jon
