Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE82C3034F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbhAZFa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbhAYKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3873222597;
        Mon, 25 Jan 2021 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611568439;
        bh=OOn7cmzw71J8lu3YYw6ES8LmbvuXLKRJR9o9mJxQkLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbvRBgTG48DsX8aTGhXT7RZuODV1evwh4xCr95tV4R9TzXJZAxmuA9AnVmG13jQ+5
         PPtN2LRUYlp/oogxLh5KRxa+wdduJi8vKN8zzKxaK9CNlNOtyB2tEIjmOOyZj2HlFf
         adYgLAX0MGmV5dzfq3tSomR87ZQzHh1QA23V345u30+JIbb3vMTqtang+2etUsfZnm
         uzdH2kj7YlmIlPHOEZZKx9dySrc3J7fg6uqDl/ZKdzBUa1nymuHyBk21kw/7SBJWjP
         x0eni/48tLa87cEm1JGV/JMdsiuItHQwsyWEsb4TVWZJun59witX3qqAvUapYkhg55
         YE0LlnSp5F5GQ==
Date:   Mon, 25 Jan 2021 10:53:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     corbet@lwn.net,
        "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Make the description of return value
 readable
Message-ID: <20210125105353.5c695d42@coco.lan>
In-Reply-To: <20210125081905.145569-1-jarkko@kernel.org>
References: <20210125081905.145569-1-jarkko@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 25 Jan 2021 10:19:04 +0200
Jarkko Sakkinen <jarkko@kernel.org> escreveu:

> The description on how to describe return values is over-complicated, and
> hard to follow. For alien reason, the body of the section is a note, and
> the first paragraph speaks about 'Return', albeit the section name is
> actually 'Return:'.
> 
> To give a better help when both implementing and reviewing patches, provide
> a straight-forward guideline, how to decribe return values, instead of
> providing a note that starts by "blacklisting" one of the infinite possible
> options of doing it wrong.
> 
> This decreases the cumulative amount of time, which is probably
> substantial, on this otherwise somewhat trivial topic.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 34 +++++++-------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index 79aaa55d6bcf..dc5e1722c150 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -136,34 +136,18 @@ Examples::
>  Return values
>  ~~~~~~~~~~~~~
>  
> -The return value, if any, should be described in a dedicated section
> -named ``Return``.
> +The return value, if any, should be described in a dedicated section named
> +``Return:``.
>  
> -.. note::
> -
> -  #) The multi-line descriptive text you provide does *not* recognize
> -     line breaks, so if you try to format some text nicely, as in::
> -
> -	* Return:
> -	* 0 - OK
> -	* -EINVAL - invalid argument
> -	* -ENOMEM - out of memory
> -
> -     this will all run together and produce::
> -
> -	Return: 0 - OK -EINVAL - invalid argument -ENOMEM - out of memory
> -
> -     So, in order to produce the desired line breaks, you need to use a
> -     ReST list, e. g.::
> +In order to describe multiple return values, a ReST list should be used. That
> +way Sphinx knows how to line-up them properly::
>  
> -      * Return:
> -      * * 0		- OK to runtime suspend the device
> -      * * -EBUSY	- Device should not be runtime suspended
> +  * Return:
> +  * - 0:	The run-time is allowed to suspend the device.
> +  * - -EBUSY:	Device should not be suspended.
>  
> -  #) If the descriptive text you provide has lines that begin with
> -     some phrase followed by a colon, each of those phrases will be taken
> -     as a new section heading, which probably won't produce the desired
> -     effect.
> +Using a dash rather than asterisk an is probably a better idea, because it does
> +not meddle as much with the C-comments.

Well, there are different opinions with that regards... Some devs think that
using:

	- -EBUSY

is confusing. I ended agreeing with that. That's why the recommendation is
to use an asterisk.

Thanks,
Mauro
