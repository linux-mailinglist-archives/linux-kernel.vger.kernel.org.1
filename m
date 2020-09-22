Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C486273CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIVII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIVII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:08:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600762106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3Fnu4c5n7J6p++H4ZD60S3b5QxIp1Wh55qX2DVOEXk=;
        b=E56EP0vF386Fc0NuJBEqwsX4UW/6X3uZD43wZUOvaGpTbris8TkkwTGNmAHK2KPG2EjATb
        IN0GJj7wF3mckhD2G5vI1MhB/C5gBY+zwTBpM5yuqQsFQMg5w1GJVsLczkW7w9Sz4TWsQ5
        XRup6V261F8vSm+Vb/hHvXmPuGhpgEs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1044BB0B7;
        Tue, 22 Sep 2020 08:09:03 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:08:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dyndbg: dont panic over bad input
Message-ID: <20200922080819.GJ14605@alley>
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
 <20200921190433.1149521-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921190433.1149521-2-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-21 13:04:32, Jim Cromie wrote:
> This BUG_ON, from 2009, caught the impossible case of a word-char both
> starting and ending a string (loosely speaking).  A bad (reverted)
> patch finally hit this case, but even "impossibly bad input" is no
> reason to panic the kernel.  Instead pr_err and return -EINVAL.
> 
> Reported-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 2d4dfd44b0fa5..90ddf07ce34fe 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -259,7 +259,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
>  		} else {
>  			for (end = buf; *end && !isspace(*end); end++)
>  				;
> -			BUG_ON(end == buf);
> +			if (end == buf) {
> +				pr_err("expected non-empty bareword");
> +				return -EINVAL;

My understanding is that the BUG_ON() was there to catch eventual bugs
in the algorithm.

IMHO, it was never reachable in the original code:

   1. The following lines will skip all spaces and bail out
      when we reached the trailing '\0':

		buf = skip_spaces(buf);
		if (!*buf)
			break;	/* oh, it was trailing whitespace */


   2. The following code will find the end of a quoted text:

		if (*buf == '"' || *buf == '\'') {
			int quote = *buf++;
			for (end = buf; *end && *end != quote; end++)


    3. The else part will find end of non-quoted word:

		} else {
			for (end = buf; *end && !isspace(*end); end++)

    4. The BUG_ON() will trigger when the above cycle reached the
       trailing '\0' or space.

       This will never happen because this situation was caught
       in the 1st step.


Your patch triggered the BUG_ON() because it wanted to handle
'=' as a special character and was incomplete.

If you want to handle '=' special way. You need to do it the same way
as with the space. You need to skip it in 1st step. And it must mark
the end of the word in 4th step.

But it will be more complicated. You must be able to handle
mix of spaces and '='. I mean the following situations:

    word=word
    word =word
    word= word
    word = word
    word = = word   /* failure ? */


Back to the BUG_ON(). It might be changed to something like:

	pr_err("Internal error when parsing dynamic debug query\n");
	return -EINVAL;


Best Regards,
Petr
