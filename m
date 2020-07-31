Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC9623488C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgGaPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 11:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgGaPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:34:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38438208E4;
        Fri, 31 Jul 2020 15:34:52 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:34:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 3/3] lib/vsprintf: Force type of flags for gfp_t
Message-ID: <20200731113450.4f31c3e6@oasis.local.home>
In-Reply-To: <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
        <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 15:31:45 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Sparse is not happy about restricted type being assigned:
>   lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
>   lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
>   lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]
> 
> Force type of flags to make sparse happy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 90d818ef03c5..118e2727d058 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  		names = vmaflag_names;
>  		break;
>  	case 'g':
> -		flags = *(gfp_t *)flags_ptr;
> +		flags = (__force typeof(flags))(*(gfp_t *)flags_ptr);

Do we really need to say "typeof(flags)" ? What about simply using
flags' type?

		flags = (__force unsigned long)(*(gfp_t *)flags_ptr);

?

I mean, it's not like flags is a global. It's defined a few lines above.

-- Steve


>  		names = gfpflag_names;
>  		break;
>  	default:

