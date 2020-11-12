Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F52B09FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgKLQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:30:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:35550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgKLQaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:30:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605198620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGoWo3n3zk5k19rM9cJv5sj/xj8kV7Kg66evSU/VnGk=;
        b=lmbpOK3oXQuZ0qkEeNhmzCkN8HSH7kwq69EJPrPpSZMDPbrnLLLJYtpadw0NXjfQoJXLaX
        RF/vqwiFahlO+rct3dnwuuVX+ZCG6244MHcFG5rntuN3H80RK9axhI/XvYyQXFFGrgmyra
        ixgiuqS+YLb9ucJ5kjIfcBbnjaE18Oo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC6A8AFD0;
        Thu, 12 Nov 2020 16:30:20 +0000 (UTC)
Date:   Thu, 12 Nov 2020 17:17:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
Message-ID: <20201112161746.GH20201@alley>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112111759.16377-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding other vsprintf maintainers and reviewes into CC.

On Thu 2020-11-12 11:17:59, Richard Fitzgerald wrote:
> Number conversion in vsscanf converts a whole string of digits and then
> extracts the field width part from the converted value. The maximum run
> of digits is limited by overflow. Conversion was using either
> simple_strto[u]l or simple_strto[u]ll based on the 'L' qualifier. This
> created a difference in truncation between builds where long is 32-bit
> and builds where it is 64-bit. This especially affects parsing a run of
> contiguous digits into separate fields - the maximum length of the run
> is 16 digits if long is 64-bit but only 8 digits if long is 32-bits.
> For example a conversion "%6x%6x" would convert both fields correctly if
> long is 64-bit but not if long is 32-bit.

I might be just slow today. But it took me really long time to
understand what exactly is the problem and how it is caused.
The description is nicely detailed but somehow cryptic.

My understanding is that there is a bug when parsing numbers
with a limited width like the above mentioned "%6x%6x".

The problem is how the width is handled:

 1. The width is ignored in the 1st step. The entire number
    is read using simple_strto[u]l[l] functions.

 2. The width limit is achieved by dividing the result from
    the first step until it fits the width.

It gives wrong result when there was an overflow in the 1st step.
The high bits were lost even when the limited number would
not overflow.


This patch improves the situation on 32-bit system because
it reduces the chance of overflow there. It also makes
it work the same on 32-bit and 64-bit systems.

But the problem is still there when the 64-bit number
overflows!

IMHO, the right solution is to copy only the limited number
of characters into a buffer and call simple_strto[u]l[l]
on this buffer. Then we do not need to divide the result
at all.


That said, I agree that simple_strto[u]ll() might always get called.
It is used internally by simple_strto[u]l() anyway. The value
is always stored into a local 64-bit variable. It is properly
casted later when the value is copied into the caller's variable.
But I do not consider this a proper fix of the width handling.

Best Regards,
Petr


> It is undesirable for vsscanf to parse numbers differently depending on
> the size of long on the target build.
> 
> As simple_strto[u]l just calls simple_strto[u]ll anyway the conversion
> is always 64-bit, and the result is manipulated as a u64, so this is an
> avoidable behaviour difference between 32-bit and 64-bit builds. The
> conversion can call simple_strto[u]ll directly and preserve the full
> 64-bits that were parsed out of the string.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  lib/vsprintf.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..63b6cddfa7f7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3444,13 +3444,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			break;
>  
>  		if (is_sign)
> -			val.s = qualifier != 'L' ?
> -				simple_strtol(str, &next, base) :
> -				simple_strtoll(str, &next, base);
> +			val.s = simple_strtoll(str, &next, base);
>  		else
> -			val.u = qualifier != 'L' ?
> -				simple_strtoul(str, &next, base) :
> -				simple_strtoull(str, &next, base);
> +			val.u = simple_strtoull(str, &next, base);
>  
>  		if (field_width > 0 && next - str > field_width) {
>  			if (base == 0)
> -- 
> 2.20.1
