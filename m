Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC4271F63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIUJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:56:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:56:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600682158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEZAInpj1oTWxrddjQHo382Tz8I/0hhGW4I2Ie8w6dA=;
        b=jRvnSP1kuwtZzuFURDJL28NQV8mCQ4e1Nu+3kFE07EQ3IjxWNBXN4h1ghozhVPlS2D/oZC
        KdN62pQxU/AQz26/WmPlNBLjQnAE9tWgcPA/MryYG4LNlIwDx+yvxO+eipE9ZrWk60iwYd
        KcGDyykbWyh9lYA9UN1z60bStr1ulzk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71E7EAF83;
        Mon, 21 Sep 2020 09:56:34 +0000 (UTC)
Date:   Mon, 21 Sep 2020 11:55:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/3] printk: move dictionary keys to
 dev_printk_info
Message-ID: <20200921095557.GH14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
 <20200918223421.21621-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-19 00:40:20, John Ogness wrote:
> Dictionaries are only used for SUBSYSTEM and DEVICE properties. The
> current implementation stores the property names each time they are
> used. This requires more space than otherwise necessary. Also,
> because the dictionary entries are currently considered optional,
> it cannot be relied upon that they are always available, even if the
> writer wanted to store them. These issues will increase should new
> dictionary properties be introduced.
> 
> Rather than storing the subsystem and device properties in the
> dict ring, introduce a struct dev_printk_info with separate fields
> to store only the property values. Embed this struct within the
> struct printk_info to provide guaranteed availability.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -629,36 +624,43 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
>  		else
>  			append_char(&p, e, c);
>  	}
> -	append_char(&p, e, '\n');
> +	append_char(&p, e, endc);
>  
> -	if (dict_len) {
> -		bool line = true;
> +	return p - buf;
> +}
>  
> -		for (i = 0; i < dict_len; i++) {
> -			unsigned char c = dict[i];
> +static ssize_t msg_add_dict_text(char *buf, size_t size,
> +				 const char *key, const char *val)
> +{
> +	size_t val_len = strlen(val);
> +	ssize_t len;
>  
> -			if (line) {
> -				append_char(&p, e, ' ');
> -				line = false;

I double checked this and found that the above code prefixed dict
values by ' ' in /dev/kmsg.

It slightly improves readability and it is handy for eventual filtering.
It would make sense to keep it.

> -			}
> +	if (!val_len)
> +		return 0;
>  
> -			if (c == '\0') {
> -				append_char(&p, e, '\n');
> -				line = true;
> -				continue;
> -			}
> +	len = msg_add_ext_text(buf, size, key, strlen(key), '=');
> +	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');

Slightly ugly but simple solution is:

	len = msg_add_ext_text(buf, size, "", 0, ' ');	/* dict prefix */
	len += msg_add_ext_text(buf + len, size - len, key, strlen(key), '=');
	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');

With this fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>


Now, this is the only problem that I have found. It is not necessary
to resend the entire patchset just because of this.

It might be enough to either respin just this patch. Or I could
commit the below one on top of the patchset. Either solution works
for me.

From dcc5dc0467c6e7d13202d98bbefb505a1db693fd Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 21 Sep 2020 11:45:16 +0200
Subject: [PATCH] printk: Put back dict lines prefix into /dev/kmsg

Put back prefix for dictionary lines in /dev/kmsg. They have been removed
by the commit  XXX ("printk: move dictionary keys to dev_printk_info").

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 77660354a7c5..1fe3d0cb2fe0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -637,7 +637,8 @@ static ssize_t msg_add_dict_text(char *buf, size_t size,
 	if (!val_len)
 		return 0;
 
-	len = msg_add_ext_text(buf, size, key, strlen(key), '=');
+	len = msg_add_ext_text(buf, size, "", 0, ' ');	/* dict prefix */
+	len += msg_add_ext_text(buf + len, size - len, key, strlen(key), '=');
 	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');
 
 	return len;
-- 
2.26.2

