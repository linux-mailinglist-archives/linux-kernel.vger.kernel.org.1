Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2942526FC89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIRMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:32:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F19C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:32:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so7819312ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iuc5m9/kDsSEpPNuGwwLdOkmCI2s2nCNMJRf5ItOupU=;
        b=ERghTVqwXCuXBchY2G+WvNu+juueyZDOAuLk6cLErGEVBjXnNf93oco6A0+j6evzix
         O42c6d/3rsEVv2AllzTllL8eWAz507J6UlFLqNuPXXhie/3eOUmVddsLaZEr8jukF5T8
         RAMuKL3+UYAKNxiacuG1AERhpvEZJZIvYGKSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iuc5m9/kDsSEpPNuGwwLdOkmCI2s2nCNMJRf5ItOupU=;
        b=YX3K44quZPGZT2OX1rDBAtCoVuTa7V5LraZfJghpmtSzovOPO4qhbN/FBAEgFns3Yl
         /pImrOQk1u2/tiy+XyligRJ0erdstFUI5qeRKFJlgqlb5xG4X1Q5JCQLzYrY2LZsPKtZ
         CXhg4g6GfJIAd/ltrwn6SzaCvaY7AzVUwl0QC+7M2zRnTYEyrl/EggporWmS6+fgy0wM
         dgRZtG0RhDi0vtDQ3CpYmKhii3J95S4yPN57YyYoVuYMOIv+y4QQZ8nlGoCP7SD3GhPg
         ALp5QYhSJWME8xSOppPMC+ps5yf2KlcALLvZZGKGcFO9CVrqsce9ZhUAV2I+Yg4iL/y9
         u5yw==
X-Gm-Message-State: AOAM532KMtVSDZwaAOERkf56VY/LW4LVUepGtgER586chn3KvJ+Seo5h
        x3W8sf+mBX0cj3+MVxR+Dal9JwBTIbT17Z060fw=
X-Google-Smtp-Source: ABdhPJxXp3avTeXQvgg6x1ntVimrH3nBQsjfDYeNxfaH91vRwiEGvcLOibVfkPmdCI0cj6dw564oBA==
X-Received: by 2002:a17:906:eced:: with SMTP id qt13mr35059733ejb.357.1600432362801;
        Fri, 18 Sep 2020 05:32:42 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x12sm2078455edq.77.2020.09.18.05.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 05:32:42 -0700 (PDT)
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to
 dev_printk_info
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
 <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
 <20200918121342.GD14605@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
Date:   Fri, 18 Sep 2020 14:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918121342.GD14605@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2020 14.13, Petr Mladek wrote:
> On Fri 2020-09-18 08:16:37, Rasmus Villemoes wrote:
>> On 17/09/2020 15.16, John Ogness wrote:
>>
>>>  	if (dev->class)
>>>  		subsys = dev->class->name;
>>>  	else if (dev->bus)
>>>  		subsys = dev->bus->name;
>>>  	else
>>> -		return 0;
>>> +		return;
>>>  
>>> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
>>> -	if (pos >= hdrlen)
>>> -		goto overflow;
>>> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
>>
>> It's unlikely that subsys would contain a %, but this will be yet
>> another place to spend brain cycles ignoring if doing static analysis.
>> So can we not do this. Either of strXcpy() for X=s,l will do the same
>> thing, and likely faster.
> 
> Good point! Better be on the safe size in a generic printk() API.
> 
> Well, I am afraid that this would be only small drop in a huge lake.
> class->name and bus->name seems to be passed to %s in so many
> *print*() calls all over the kernel code.

So what? printf("%s", some_string_that_might_contain_percent_chars) is
not a problem.

printf(some_string_that_might_contain_percent_chars) is.

And yes, one could do

  snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), "%s", subsys);

but one might as well avoid the snprintf overhead and use one of the
strX functions that have the exact same semantics (copy as much as
there's room for, ensure nul-termination).

Rasmus
