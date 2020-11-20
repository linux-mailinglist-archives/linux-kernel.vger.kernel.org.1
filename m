Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7512BA8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKTLFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:05:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:34488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgKTLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:05:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605870326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1w9loi2gYQIuhefXRwYe40jcicVCbs9XTRSMRxOefjQ=;
        b=iVNYvn5YShdu7EGWTvQjzcWfcsQPxkTj5cPWX++ME+wLY5uChMTHlzYXCydZro9hBbuG+d
        EeeMCVUwPTI75IYVNxuEyNRxsWjxqd8A5InmkRPj5d8bU6XuMASVF0UwTm8bDsgrzTm6W5
        prvtj2P+5c7jR8fqBfVYW6Vc6bOcAb4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BA5FAD63;
        Fri, 20 Nov 2020 11:05:26 +0000 (UTC)
Date:   Fri, 20 Nov 2020 12:05:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] lib: vsprintf: Fix handling of number field widths in
 vsscanf
Message-ID: <X7ei9cENZ0dVkGZh@alley>
References: <20201116143252.19983-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116143252.19983-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-16 14:32:52, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then bitshifting the field out of the
> converted value. If the string contains a run of valid digits longer
> than will fit in a long or long long, this would overflow and no amount
> of bitshifting can recover the correct value.
> 
> This patch fixes vsscanf to obey number field widths.
> 
> A new _parse_integer_limit() is added that takes a limit for the number
> of characters to parse. A length of INT_MAX is effectively unlimited, as
> we are not likely to need parsing of digit strings >INT_MAX length.
> 
> The number field conversion in vsscanf is changed to use this new
> _parse_integer_limit() function so that field widths are obeyed when
> parsing the number. Note also that the conversion is always done as a
> long long - as there's currently no overflow checking there is no point
> implementing separate long and long long conversions.
>
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index a14ccf905055..9867501a4ab0 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -39,20 +39,23 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>  
>  /*
>   * Convert non-negative integer string representation in explicitly given radix
> - * to an integer.
> + * to an integer. The maximum number of characters to convert can be given.
> + * A character limit of INT_MAX is effectively unlimited since a string that
> + * long is unreasonable.

The INT_MAX value meaning is obvious. It does not need to be
mentioned. It is the same as with vsnprintf().


>   * Return number of characters consumed maybe or-ed with overflow bit.
>   * If overflow occurs, result integer (incorrect) is still returned.
>   *
>   * Don't you dare use this function.
>   */
> -unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> +unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> +				  int max_chars)

Please, use size_t. Passing negative value usually means
that the caller did not handle some situation correctly.
And it actually happened in this patch, see below.

nit: better ballance the length of the lines above. I mean to move
     *p to the next line:

unsigned int _parse_integer_limit(const char *s, unsigned int base,
				  unsigned long long *p, size_t max_chars)


>  {
>  	unsigned long long res;
>  	unsigned int rv;
>  
>  	res = 0;
>  	rv = 0;
> -	while (1) {
> +	for (; max_chars > 0; max_chars--) {
>  		unsigned int c = *s;
>  		unsigned int lc = c | 0x20; /* don't tolower() this line */
>  		unsigned int val;
> @@ -82,6 +85,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
>  	return rv;
>  }
>  
> +unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> +{
> +	return _parse_integer_limit(s, base, p, INT_MAX);
> +}
> +
>  static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  {
>  	unsigned long long _res;
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..8ec47b5da2cb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -53,6 +53,25 @@
>  #include <linux/string_helpers.h>
>  #include "kstrtox.h"
>  
> +static unsigned long long simple_strntoull(const char *startp, int max_chars,
> +					   char **endp, unsigned int base)
> +{
> +	const char *cp;
> +	unsigned long long result;
> +	unsigned int rv;
> +
> +	cp = _parse_integer_fixup_radix(startp, &base);
> +	max_chars -= (cp - startp);

Negative value means that _parse_integer_fixup_radix() already
proceed more characters than allowed. I would handle this
the following way:

	if (cp - startp > max_chars) {
		cp = startp + max_chars;
		result = 0LL;
		goto out;

> +	rv = _parse_integer_limit(cp, base, &result, max_chars);
> +	/* FIXME */
> +	cp += (rv & ~KSTRTOX_OVERFLOW);

out:

> +	if (endp)
> +		*endp = (char *)cp;
> +
> +	return result;
> +}
> +
>  /**
>   * simple_strtoull - convert a string to an unsigned long long
>   * @cp: The start of the string
> @@ -126,6 +134,15 @@ long long simple_strtoll(const char *cp, char **endp, unsigned int base)
>  }
>  EXPORT_SYMBOL(simple_strtoll);
>  
> +static long long simple_strntoll(const char *cp, int max_chars, char **endp,
> +				 unsigned int base)
> +{
> +	if (*cp == '-')
> +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
> +
> +	return simple_strntoull(cp, max_chars, endp, base);
> +}

Please, use this in simple_strtoll() like it is already done in
simple_strtoull(). I mean:

long long simple_strtoll(const char *cp, char **endp, unsigned int base)
{
	return simple_strntoll(cp, INT_MAX, endp, base);
}

> +
>  static noinline_for_stack
>  int skip_atoi(const char **s)
>  {

Finally, it would be great to add some selftests for this into
lib/test_printf.c.

Thanks a lot for working on this. I like this approach.

Best Regards,
Petr
