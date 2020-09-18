Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D434026F5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIRGQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRGQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:16:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF58C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 23:16:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so4942675edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHQx1wQutwZZW5bRfLDKRYtGAOo0t33qpYibPb8HS6w=;
        b=AqMgvz0/lfT7OGWSexawLGbk4NpHUWhJratmRvo0/XGdcK4QMSrc1xW6mFxTA820ZC
         QegZrAlf09ZOuc6VlVNj6/ODciH+guMGwjGJx76l/Zgx65iaRRnkjd54UCMPPzHJUFjQ
         ZNmzJOq9WaRE/FjE7LXdJFVvQKPfY4oSFXmFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHQx1wQutwZZW5bRfLDKRYtGAOo0t33qpYibPb8HS6w=;
        b=MnVgC938HLaTkzfgpwYF4MoLLQgt55mQulsWcFOq4NUkszquHuiN1SLSVM6UdKmzKg
         aKZW/TqRNbMgXCE8Ip6Vy0uKlYeLNlKj9WYOm45V4xHzBJP+hv4NNSR3AnBSBIUd0QRO
         kXvKARQ+40UrZZY/lrZlcd2gYbxI2o1xeZn8avOkZ9QKatUM4APp/aJ+x4ZZbwPSk6Ob
         +1fdA4kPKA+eBA7M8a5zuXLlsoSh30KPPOOrXCtaISjSEPwCak5YM8C8xks5ihpb6cjY
         k9u1skszxrjcdKHhiS/6xb3DrNlABC8he2S2ioj5DVpXoQIGwRo2jEw07ZGs83kyQNDs
         yaXw==
X-Gm-Message-State: AOAM5309bvkw33Ia/LTVt08r09gwWq6qEJAgSZJNNZl7jNQW2Q0fjNd0
        rTPaysH5RvLUdnucWx+f8bo8hjf9Faa78M42f2M=
X-Google-Smtp-Source: ABdhPJxIBM+KYJ5bSJQq3RsFx9o3XJLWtQKrCvPQ9nyf/hUJ3q6u8cLvkG8UgQ9VSoM5SvTO+yVLyw==
X-Received: by 2002:aa7:cb0e:: with SMTP id s14mr36133966edt.225.1600409798710;
        Thu, 17 Sep 2020 23:16:38 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ef3sm1482056ejb.114.2020.09.17.23.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 23:16:38 -0700 (PDT)
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to
 dev_printk_info
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
Date:   Fri, 18 Sep 2020 08:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917131644.25838-3-john.ogness@linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 15.16, John Ogness wrote:

>  	if (dev->class)
>  		subsys = dev->class->name;
>  	else if (dev->bus)
>  		subsys = dev->bus->name;
>  	else
> -		return 0;
> +		return;
>  
> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
> -	if (pos >= hdrlen)
> -		goto overflow;
> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);

It's unlikely that subsys would contain a %, but this will be yet
another place to spend brain cycles ignoring if doing static analysis.
So can we not do this. Either of strXcpy() for X=s,l will do the same
thing, and likely faster.

Rasmus
