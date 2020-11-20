Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE32BB0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgKTQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:32:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:46646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgKTQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:32:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605889926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsauMcZoPjp06OSiAxcg+9pDZWmLIkplASL0yTnLwbw=;
        b=mOkmqiTdOXWTLHdRzpA0hFISchqT58Mnqr1pOAetS9HpyzY6w4oh/sc0huzHsMYM+8qv9/
        L9d8qfH0W72WK3ndUhvU6BhWm1y52l8WpM/fncLtENTiTd6P5yVZq6Agfy16KfH+hJ+YaF
        lVItTqyCh8FgjIwSRkdRar2kGOB002Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3BD8ACC6;
        Fri, 20 Nov 2020 16:32:05 +0000 (UTC)
Date:   Fri, 20 Nov 2020 17:32:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] lib: vsprintf: Fix handling of number field widths in
 vsscanf
Message-ID: <X7fvhY51RIugA7Vq@alley>
References: <20201116143252.19983-1-rf@opensource.cirrus.com>
 <X7ei9cENZ0dVkGZh@alley>
 <20201120100705.3a7fb747@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120100705.3a7fb747@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-20 10:07:05, Steven Rostedt wrote:
> On Fri, 20 Nov 2020 12:05:25 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2020-11-16 14:32:52, Richard Fitzgerald wrote:
> > > The existing code attempted to handle numbers by doing a strto[u]l(),
> > > ignoring the field width, and then bitshifting the field out of the
> > > converted value. If the string contains a run of valid digits longer
> > > than will fit in a long or long long, this would overflow and no amount
> > > of bitshifting can recover the correct value.
> > > 
> > > This patch fixes vsscanf to obey number field widths.
> > > 
> > > A new _parse_integer_limit() is added that takes a limit for the number
> > > of characters to parse. A length of INT_MAX is effectively unlimited, as
> > > we are not likely to need parsing of digit strings >INT_MAX length.
> > > 
> > > The number field conversion in vsscanf is changed to use this new
> > > _parse_integer_limit() function so that field widths are obeyed when
> > > parsing the number. Note also that the conversion is always done as a
> > > long long - as there's currently no overflow checking there is no point
> > > implementing separate long and long long conversions.
> > >
> > > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > > index a14ccf905055..9867501a4ab0 100644
> > > --- a/lib/kstrtox.c
> > > +++ b/lib/kstrtox.c
> > > @@ -39,20 +39,23 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
> > >  
> > >  /*
> > >   * Convert non-negative integer string representation in explicitly given radix
> > > - * to an integer.
> > > + * to an integer. The maximum number of characters to convert can be given.
> > > + * A character limit of INT_MAX is effectively unlimited since a string that
> > > + * long is unreasonable.  
> > 
> > The INT_MAX value meaning is obvious. It does not need to be
> > mentioned. It is the same as with vsnprintf().
> 
> Yeah, but I never think that restating the obvious is a bad idea.
> Especially when something that is obvious to us, is not obvious to a new
> comer. There's been lots of times I wish someone mentioned the obvious in a
> comment somewhere, because it wasn't obvious to me ;-)
> 
> I vote to keep it in.

Fair enough.

I have suggested to remove it because it was somehow hard to parse for
me. It confused me more than helped. It is funny because I often write
these long and complicated sentences as well. And I really confuse
people from time to time.

I wonder if the following is more strightforward:

	* Convert non-negative integer string representation in
	* explicitly given radix to an integer.
	*
	* @max_chars limits the number of converted characters.
	* Use INT_MAX when unlimited. It is an arbitrary, big enough,
	* number that is used also by vsnprintf().



> > >   * Return number of characters consumed maybe or-ed with overflow bit.
> > >   * If overflow occurs, result integer (incorrect) is still returned.
> > >   *
> > >   * Don't you dare use this function.
> > >   */
> > > -unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> > > +unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> > > +				  int max_chars)  
> > 
> > Please, use size_t. Passing negative value usually means
> > that the caller did not handle some situation correctly.
> > And it actually happened in this patch, see below.
> > 
> > nit: better ballance the length of the lines above. I mean to move
> >      *p to the next line:
> > 
> > unsigned int _parse_integer_limit(const char *s, unsigned int base,
> > 				  unsigned long long *p, size_t max_chars)
> > 
> > 
> > >  {


> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 14c9a6af1b23..8ec47b5da2cb 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -53,6 +53,25 @@
> > >  #include <linux/string_helpers.h>
> > >  #include "kstrtox.h"
> > >  
> > > +static unsigned long long simple_strntoull(const char *startp, int max_chars,
> > > +					   char **endp, unsigned int base)
> > > +{
> > > +	const char *cp;
> > > +	unsigned long long result;
> > > +	unsigned int rv;
> > > +
> > > +	cp = _parse_integer_fixup_radix(startp, &base);
> > > +	max_chars -= (cp - startp);  
> > 
> > Negative value means that _parse_integer_fixup_radix() already
> > proceed more characters than allowed. I would handle this
> > the following way:
> > 
> > 	if (cp - startp > max_chars) {
> > 		cp = startp + max_chars;
> > 		result = 0LL;
> > 		goto out;
> 
> Agreed. I was looking at what sscanf() in user space does.
> 
> And testing it with the following:
> 
> 	char *line = "0x123456789abcdef0123456789\n";
> 	int i;
> 
> 	for (i = 0; i < 10; i++) {
> 		char str[32];
> 		long a, b;
> 
> 		if (i)
> 			sprintf(str, "%%%dli%%9lx", i);
> 		else
> 			strcpy(str, "%li%6lx");
> 
> 		ret = sscanf(line, str, &a, &b);
> 		switch (ret) {
> 		case 1:
> 			printf("read 1 '%s': %lx\n", str, a);
> 			break;
> 		case 2:
> 			printf("read 2 '%s': %lx %lx\n", str, a, b);
> 			break;
> 		default:
> 			printf("Failed to read: '%s' ret = %d\n", str, ret);
> 		}
> 	}
> 
> And the above produced:
> 
> read 1 '%li%6lx': 7fffffffffffffff
> read 1 '%1li%9lx': 0
> read 2 '%2li%9lx': 0 123456789
> read 2 '%3li%9lx': 1 23456789a
> read 2 '%4li%9lx': 12 3456789ab
> read 2 '%5li%9lx': 123 456789abc
> read 2 '%6li%9lx': 1234 56789abcd
> read 2 '%7li%9lx': 12345 6789abcde
> read 2 '%8li%9lx': 123456 789abcdef
> read 2 '%9li%9lx': 1234567 89abcdef0
> 
> The first line I'm assuming is because %li overflowed (more digits than a
> 64 bit could hold).

Yup, it looks like LONG_LONG_MAX.

> But yeah, we could very much have cp - startp > max_chars.

Thanks a lot for testing it.

Best Regards,
Petr
