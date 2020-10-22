Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7E02960D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368101AbgJVOXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368093AbgJVOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:23:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B297C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:23:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f97so800860otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ThoojCMS9n916uUwbFZTI/TVO3lj7KeiRUZqFFXX1hI=;
        b=f8eV8FLeoW2IzH5aZNSUuvh1hH5UpFjwrqRj/sUgHbU8d8Ycu8nunck45PuPVy1aec
         NLHvrX35XdcbNoOJaIe7ovo/SLitLxa4xLW+gTiCPKR8/Tlq6qoac7RKTvV7ZWwvrZQJ
         za0D+3xe1jO/jLdc+EjnGSgQLr61W/HfS/AbjV6i7zVTZU4n7t9aPE4by5uO1lS/DNLm
         12LHXj6ooBbrzxw6lbiecAV6QqqvM4FSjiQly8cW7zABm46EeTyCtIHbZQ3pfjcKNBeZ
         O92a0Tj8mbc03Qv1FrKS4REjAT3kdWKOPg7gWNgpDxVdkP0CryGVS9aqgeD6SRDPD/L0
         SvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ThoojCMS9n916uUwbFZTI/TVO3lj7KeiRUZqFFXX1hI=;
        b=A/FN3MuVTMWf4KcLJiW35RqecF4VZXV8H3P+/O/N+mVQihNbIUPz1gQJkfukGwXXHS
         j89/Ekzz+PlAXgPh2QcQ675d7avV9rRUPwunyWXSIauL/35i4aQXg+4kalxsqP3aIwBB
         PjdYZn3ICPBnw9kmXjRhHKgi5aEWEz39CULgFE5V54GwqXqD3aQAGE2A1KrTxXv2ShAk
         in0phxvI49mQDUPwx223367nQuQCT7R0DloSED2L1xFuBxQEvJUj5blWIjm36t2hyyZX
         p7HETyb5B4RLvDDfAnzHDHdy1/rW4snNH+N4tMDRuoEesxrw9V6NlZj9yi3QmA++MVtu
         ENFg==
X-Gm-Message-State: AOAM5302Q2rljaScaOt3VAQpV4iNVr+J1J0VPqIy5nR0SSPqN3Ggcftv
        K6nDB60AL7dot8f6g8sbZ8iRnEfxuAk=
X-Google-Smtp-Source: ABdhPJzKlTAnbLKkBzLsJR60ox0qOizvlxJOO/Aa/K5DkctrL8irVgyfY/P8akAp3ch1k9+owqeiIw==
X-Received: by 2002:a9d:7085:: with SMTP id l5mr1916304otj.159.1603376582192;
        Thu, 22 Oct 2020 07:23:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3sm482045oov.48.2020.10.22.07.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:23:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: RFC 2/2] printk: Restore and document obsolete ways to disable
 console output
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20201022114228.9098-1-pmladek@suse.com>
 <20201022114228.9098-3-pmladek@suse.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <74ac4f63-2a5f-5b0c-a2d3-4758c264b137@roeck-us.net>
Date:   Thu, 22 Oct 2020 07:23:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022114228.9098-3-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 4:42 AM, Petr Mladek wrote:
> The commit 48021f98130880dd7 ("printk: handle blank console arguments
> passed in.") prevented crash caused by empty console= parameter value.
> 
> Unfortunately, this value is widely used on Chromebooks to disable
> the console output. The above commit caused performance regression
> because the messages were pushed on slow console even though nobody
> was watching it.
> 
> "mute_console" kernel parameter has been introduced as a proper and
> official was to disable console output. It avoids the performance
> problem by suppressing all kernel messages. Also avoids the crash
> by registering the default console.
> 
> Make console="" behave the same as "mute_console" to avoid
> the performance regression on existing Chromebooks.
> 
> Do the same also for console=null which seem to be another widely
> suggested and non-official way to disable the console output.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  kernel/printk/printk.c                          | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 52b9e7f5468d..14472f674a89 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -670,11 +670,16 @@
>  		hvc<n>	Use the hypervisor console device <n>. This is for
>  			both Xen and PowerPC hypervisors.
>  
> +		null
> +		""	Obsolete way to disable console output. Please,
> +			use "mute_console" instead.
> +
>  		If the device connected to the port is not a TTY but a braille
>  		device, prepend "brl," before the device type, for instance
>  			console=brl,ttyS0
>  		For now, only VisioBraille is supported.
>  
> +

stray whitespace change

>  	console_msg_format=
>  			[KNL] Change console messages format
>  		default
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 63fb96630767..08c50d8ba110 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2208,8 +2208,15 @@ static int __init console_setup(char *str)
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
>  
> -	if (str[0] == 0)
> +	/*
> +	 * console="" or console=null have been suggested as a way to
> +	 * disable console output. It worked just by chance and was not
> +	 * reliable. It has been obsoleted by "mute_console" parameter.
> +	 */
> +	if (str[0] == 0 || strcmp(str, "null") == 0) {
> +		mute_console = true;
>  		return 1;
> +	}
>  
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;
> 

