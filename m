Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593422BAD66
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgKTPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbgKTPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:07:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFD0221F8;
        Fri, 20 Nov 2020 15:07:06 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:07:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] lib: vsprintf: Fix handling of number field widths in
 vsscanf
Message-ID: <20201120100705.3a7fb747@gandalf.local.home>
In-Reply-To: <X7ei9cENZ0dVkGZh@alley>
References: <20201116143252.19983-1-rf@opensource.cirrus.com>
        <X7ei9cENZ0dVkGZh@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 12:05:25 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2020-11-16 14:32:52, Richard Fitzgerald wrote:
> > The existing code attempted to handle numbers by doing a strto[u]l(),
> > ignoring the field width, and then bitshifting the field out of the
> > converted value. If the string contains a run of valid digits longer
> > than will fit in a long or long long, this would overflow and no amount
> > of bitshifting can recover the correct value.
> > 
> > This patch fixes vsscanf to obey number field widths.
> > 
> > A new _parse_integer_limit() is added that takes a limit for the number
> > of characters to parse. A length of INT_MAX is effectively unlimited, as
> > we are not likely to need parsing of digit strings >INT_MAX length.
> > 
> > The number field conversion in vsscanf is changed to use this new
> > _parse_integer_limit() function so that field widths are obeyed when
> > parsing the number. Note also that the conversion is always done as a
> > long long - as there's currently no overflow checking there is no point
> > implementing separate long and long long conversions.
> >
> > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > index a14ccf905055..9867501a4ab0 100644
> > --- a/lib/kstrtox.c
> > +++ b/lib/kstrtox.c
> > @@ -39,20 +39,23 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
> >  
> >  /*
> >   * Convert non-negative integer string representation in explicitly given radix
> > - * to an integer.
> > + * to an integer. The maximum number of characters to convert can be given.
> > + * A character limit of INT_MAX is effectively unlimited since a string that
> > + * long is unreasonable.  
> 
> The INT_MAX value meaning is obvious. It does not need to be
> mentioned. It is the same as with vsnprintf().

Yeah, but I never think that restating the obvious is a bad idea.
Especially when something that is obvious to us, is not obvious to a new
comer. There's been lots of times I wish someone mentioned the obvious in a
comment somewhere, because it wasn't obvious to me ;-)

I vote to keep it in.

> 
> 
> >   * Return number of characters consumed maybe or-ed with overflow bit.
> >   * If overflow occurs, result integer (incorrect) is still returned.
> >   *
> >   * Don't you dare use this function.
> >   */
> > -unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> > +unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> > +				  int max_chars)  
> 
> Please, use size_t. Passing negative value usually means
> that the caller did not handle some situation correctly.
> And it actually happened in this patch, see below.
> 
> nit: better ballance the length of the lines above. I mean to move
>      *p to the next line:
> 
> unsigned int _parse_integer_limit(const char *s, unsigned int base,
> 				  unsigned long long *p, size_t max_chars)
> 
> 
> >  {
> >  	unsigned long long res;
> >  	unsigned int rv;
> >  
> >  	res = 0;
> >  	rv = 0;
> > -	while (1) {
> > +	for (; max_chars > 0; max_chars--) {
> >  		unsigned int c = *s;
> >  		unsigned int lc = c | 0x20; /* don't tolower() this line */
> >  		unsigned int val;
> > @@ -82,6 +85,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
> >  	return rv;
> >  }
> >  
> > +unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> > +{
> > +	return _parse_integer_limit(s, base, p, INT_MAX);
> > +}
> > +
> >  static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> >  {
> >  	unsigned long long _res;
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 14c9a6af1b23..8ec47b5da2cb 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -53,6 +53,25 @@
> >  #include <linux/string_helpers.h>
> >  #include "kstrtox.h"
> >  
> > +static unsigned long long simple_strntoull(const char *startp, int max_chars,
> > +					   char **endp, unsigned int base)
> > +{
> > +	const char *cp;
> > +	unsigned long long result;
> > +	unsigned int rv;
> > +
> > +	cp = _parse_integer_fixup_radix(startp, &base);
> > +	max_chars -= (cp - startp);  
> 
> Negative value means that _parse_integer_fixup_radix() already
> proceed more characters than allowed. I would handle this
> the following way:
> 
> 	if (cp - startp > max_chars) {
> 		cp = startp + max_chars;
> 		result = 0LL;
> 		goto out;

Agreed. I was looking at what sscanf() in user space does.

And testing it with the following:

	char *line = "0x123456789abcdef0123456789\n";
	int i;

	for (i = 0; i < 10; i++) {
		char str[32];
		long a, b;

		if (i)
			sprintf(str, "%%%dli%%9lx", i);
		else
			strcpy(str, "%li%6lx");

		ret = sscanf(line, str, &a, &b);
		switch (ret) {
		case 1:
			printf("read 1 '%s': %lx\n", str, a);
			break;
		case 2:
			printf("read 2 '%s': %lx %lx\n", str, a, b);
			break;
		default:
			printf("Failed to read: '%s' ret = %d\n", str, ret);
		}
	}

And the above produced:

read 1 '%li%6lx': 7fffffffffffffff
read 1 '%1li%9lx': 0
read 2 '%2li%9lx': 0 123456789
read 2 '%3li%9lx': 1 23456789a
read 2 '%4li%9lx': 12 3456789ab
read 2 '%5li%9lx': 123 456789abc
read 2 '%6li%9lx': 1234 56789abcd
read 2 '%7li%9lx': 12345 6789abcde
read 2 '%8li%9lx': 123456 789abcdef
read 2 '%9li%9lx': 1234567 89abcdef0

The first line I'm assuming is because %li overflowed (more digits than a
64 bit could hold).

But yeah, we could very much have cp - startp > max_chars.


> 
> > +	rv = _parse_integer_limit(cp, base, &result, max_chars);
> > +	/* FIXME */
> > +	cp += (rv & ~KSTRTOX_OVERFLOW);  
> 
> out:
> 
> > +	if (endp)
> > +		*endp = (char *)cp;
> > +
> > +	return result;
> > +}
> > +
> >  /**
> >   * simple_strtoull - convert a string to an unsigned long long
> >   * @cp: The start of the string
> > @@ -126,6 +134,15 @@ long long simple_strtoll(const char *cp, char **endp, unsigned int base)
> >  }
> >  EXPORT_SYMBOL(simple_strtoll);
> >  
> > +static long long simple_strntoll(const char *cp, int max_chars, char **endp,
> > +				 unsigned int base)
> > +{
> > +	if (*cp == '-')
> > +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
> > +
> > +	return simple_strntoull(cp, max_chars, endp, base);
> > +}  
> 
> Please, use this in simple_strtoll() like it is already done in
> simple_strtoull(). I mean:
> 
> long long simple_strtoll(const char *cp, char **endp, unsigned int base)
> {
> 	return simple_strntoll(cp, INT_MAX, endp, base);
> }

Agreed.

> 
> > +
> >  static noinline_for_stack
> >  int skip_atoi(const char **s)
> >  {  
> 
> Finally, it would be great to add some selftests for this into
> lib/test_printf.c.
> 
> Thanks a lot for working on this. I like this approach.

+1

-- Steve

