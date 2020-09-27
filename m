Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF827A0E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI0M3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0M3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:29:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05B323718;
        Sun, 27 Sep 2020 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601209744;
        bh=j0QP36WYATNJ3FwgZM1LE2LH5S0hG8ZqfT3GRwI76rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2Eaiv46cvZ9UJLIVHzO2imJDClR2H70Rrqr5W9zQ7ZkqOI1AlQ/jx6gSrh6AAfm/
         bSjF0DzbkcFrS8yz68kK7FQQdFUnlRYmxunC/TR5ATCcEc2oxVk+txiohasWQt5fvo
         TZ02zW5xc5BCy1eXEDFAFBkufXgsfygWrzr70ZRM=
Date:   Sun, 27 Sep 2020 14:29:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] dyndbg: dont panic over bad input
Message-ID: <20200927122909.GA186979@kroah.com>
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
 <20200921190433.1149521-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921190433.1149521-2-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:04:32PM -0600, Jim Cromie wrote:
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

Need a "\n" here, right?

thanks,

greg k-h
