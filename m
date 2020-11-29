Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6C2C7877
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgK2I4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 03:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2I4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 03:56:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325BC0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 00:55:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so5634627pgj.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=asdqBoIk1ZdzjfqdX/jQ+vQPjLAQMqzWC0xNbHtbH/M=;
        b=RG7aCMZCbbpDxaV4pWpEo01Q/1oq0fy8d7t/whwLwnwkmEhpEcXuZHhE086oRR/+do
         bl3+Hl1jjuqKGCLXqxAxaKtxOiIP4+A9dZ2vsTJsNxX2BPHVkVgLVYVj0jb2vexkCId+
         x5xQmuOCddJe9NVF+ITdnVofNmSwbhhhookzEIuGeiw2dXzfoTEVVQYWca+FaCQDX8AN
         Nby53fbLjf1c8ZiWewkVPhqgYUDWvZIF6eiVBIBi++bb1MyF4Qh++8hICTkS3mbqXFXQ
         9/CpOPZm510m89YQB/fVyFCiuOhj4ykbYxkW5fkrTd3kcxb3adMJP3bcTlXO1eyTtNGR
         BwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=asdqBoIk1ZdzjfqdX/jQ+vQPjLAQMqzWC0xNbHtbH/M=;
        b=PR+NKOrusSbjMLmVqWNUO8vTx2hGVLAJYafhRjX9jcfn2kQK27JNrGGQvzIPhQya5j
         BP0V2X1RQeIqHSYOCsESsxH3vRzhEdl/FYNjwdOVELJfnGc7afe1VX5vg6UJKEG5kWqh
         cluZ9+Fvgc+IqKIU0GsxrRrjvgV5aEXsgLUzfNA+akbjQ4bkg4UxoMg1QmIxcNq4xqen
         6aJmBRxyyXZu86ccqyYv3rHQoZd9yQjZ6fqYc9ThgUfSTD5KBXwhKXhTBGU28NX5qdiZ
         Ft53pQGEs19/ussmhpzI521MD0LMenT3w73lGVMXbOUH1REIhZGIDtXj1qLrXfJiFt5m
         QvpQ==
X-Gm-Message-State: AOAM531A90B1TIwY2ttYxnKJdaSBsoZRU7OOUuqQmSRW+uRjodkNsKIJ
        pvJWlb9GLk5BVtKT6V9RKnl6xziljQYULw==
X-Google-Smtp-Source: ABdhPJyIk08effv0WRJDXi9p8cYwoDb4KiIBSTOMrIW6LBoPezP0AjX81vOC1ix5VdHIfSHU7qLZ8g==
X-Received: by 2002:a17:90a:2b0b:: with SMTP id x11mr20233613pjc.65.1606640116459;
        Sun, 29 Nov 2020 00:55:16 -0800 (PST)
Received: from ?IPv6:2402:3a80:43d:11a0:15a2:ad13:ec3b:4e56? ([2402:3a80:43d:11a0:15a2:ad13:ec3b:4e56])
        by smtp.gmail.com with ESMTPSA id h4sm11513617pgp.8.2020.11.29.00.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 00:55:15 -0800 (PST)
Subject: Re: [PATCH v7] checkpatch: add fix option for LOGICAL_CONTINUATIONS
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <afaa79a6d86a4184878595ced3f2de1a92a4058c.camel@perches.com>
 <20201123102818.24364-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <a0f6479e-0c1b-a2f8-a265-32cc31313870@gmail.com>
Date:   Sun, 29 Nov 2020 14:25:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201123102818.24364-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/20 3:58 pm, Aditya Srivastava wrote:
> Currently, checkpatch warns if logical continuations are placed at the
> start of a line and not at the end of previous line.
> 
> E.g., running checkpatch on commit 3485507fc272 ("staging:
> bcm2835-camera: Reduce length of enum names") reports:
> 
> CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
> previous line
> +	if (!ret
> +	    && camera_port ==
> 
> Provide a simple fix by inserting logical operator at the last
> non-comment, non-whitespace char of the previous line and removing from
> current line, if both the lines are additions(ie start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2: quote $operator at substitution
> 
> changes in v3: add a check for previous line ending with comment;
> If so, insert $operator at the last non-comment, non-whitespace char of the previous line
> 
> changes in v4: improve the matching mechanism by matching line termination at comment or white space;
> insert the operator before comments (if any) separated by a whitespace;
> append the comment and its pre-whitespace after the inserted operator (if comment was present),
> ie if no comment was present nothing will be inserted after the operator
> 
> changes in v5: improve regex for comment and line end with '$;'
> 
> changes in v6: remove if-check; modify commit message
> 
> changes in v7: add an extra '$' symbol at '$fixed[$fixlinenr - 1]' regex substitution to ensure match at line end
> 
>  scripts/checkpatch.pl | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5b1a5a65e69a..fb3c50e0bde2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3553,8 +3553,16 @@ sub process {
>  
>  # check for && or || at the start of a line
>  		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
> -			CHK("LOGICAL_CONTINUATIONS",
> -			    "Logical continuations should be on the previous line\n" . $hereprev);
> +			my $operator = $1;
> +			if (CHK("LOGICAL_CONTINUATIONS",
> +				"Logical continuations should be on the previous line\n" . $hereprev) &&
> +			    $fix && $prevrawline =~ /^\+/) {
> +				# insert logical operator at last non-comment, non-whitepsace char on previous line
> +				$prevline =~ /[\s$;]*$/;
> +				my $line_end = substr($prevrawline, $-[0]);
> +				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E$/ $operator$line_end/;
> +				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
> +			}
>  		}
>  
>  # check indentation starts on a tab stop
> 

Hi Joe
You probably missed this patch. Please review :)

Thanks
Aditya
