Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EEC2CEA34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgLDIvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:51:51 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34025 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbgLDIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:51:50 -0500
Received: by mail-ej1-f65.google.com with SMTP id g20so7579351ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GwkYozyuYkSJzQ66Wy4YG7jbCUKS/kTrRERj/Igh/g=;
        b=nG72YHbWxZ9NZkX6QLu2bsshGSCnBHJ2ByJhxseOrb33DyA0W68YrvYa67OATTNW6S
         mkYW3w2XW+JjSD/7hxG95WGoOPdA3sBV9681kuhdge4IGBD77syDOc9CCXFwB3F5KA80
         smigX5JuM33a8k/HdxTtf4fFYlhLfQhjQEZmyOAI6Uj1FxfnpSROqMGBLVdndVqTtgC+
         DbGY8CJHysUFve3gttco0WtrEWFMyGO4kCw7GBOPcIVJCDIx8kgOPzq9GuCzpxjOo7ZG
         J71YaZS5URXUotcBfeujQnTbW1afZEUgGJSbwPyOwHPUmvvjsxSsYuBFOp0OQfbF9SL6
         nZhg==
X-Gm-Message-State: AOAM533yabXYDEUZuMn26rvjNo0chkLZHT3DtgmSZERHRTtAwiSNl42w
        i0/K51qOnUALDokEktIzcOf4fCnSsp/MbA==
X-Google-Smtp-Source: ABdhPJzArQiiYNoHZBDKYUo2yq8ns58GIG4w5hfjUGyhFm8dzBbXTB3CDo2xQNwua9kEr2fuFbTzVg==
X-Received: by 2002:a17:906:2932:: with SMTP id v18mr6061514ejd.144.1607071869141;
        Fri, 04 Dec 2020 00:51:09 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x16sm2592942ejo.104.2020.12.04.00.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:51:08 -0800 (PST)
Subject: Re: [PATCH] tty: Remove dead termiox code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
 <X8n1JiDS8ZVA6e6o@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8e993706-46e2-cbed-265f-1ba63cc9274d@kernel.org>
Date:   Fri, 4 Dec 2020 09:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8n1JiDS8ZVA6e6o@kroah.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 12. 20, 9:36, Greg Kroah-Hartman wrote:
> On Fri, Dec 04, 2020 at 09:20:39AM +0100, Jiri Slaby wrote:
>> On 04. 12. 20, 9:17, Greg Kroah-Hartman wrote:
>>> On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
>>>> On 03. 12. 20, 3:03, Jann Horn wrote:
>>>>> set_termiox() and the TCGETX handler bail out with -EINVAL immediately
>>>>> if ->termiox is NULL, but there are no code paths that can set
>>>>> ->termiox to a non-NULL pointer; and no such code paths seem to have
>>>>> existed since the termiox mechanism was introduced back in
>>>>> commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
>>>>> Similarly, no driver actually implements .set_termiox; and it looks like
>>>>> no driver ever has.
>>>>
>>>> Nice!
>>>>
>>>>> Delete this dead code; but leave the definition of struct termiox in the
>>>>> UAPI headers intact.

Note this ^^^^^. He is talking about _not_ touching the definition in 
the UAPI header. Does the rest below makes more sense now?

>>>> I am thinking -- can/should we mark the structure as deprecated so that
>>>> userspace stops using it eventually?
>>>
>>> If it doesn't do anything, how can userspace even use it today?  :)
>>
>> Well, right. I am in favor to remove it, BUT: what if someone tries that
>> ioctl and bails out if EINVAL is returned. I mean: if they define a local
>> var of that struct type and pass it to the ioctl, we would break the build
>> by removing the struct completely. Even if the code didn't do anything
>> useful, it still could be built. So is this very potential breakage OK?
> 
> I'm sorry, but I don't understand.  This is a kernel-internal-only
> structure, right?  If someone today tries to call these ioctls, they
> will get a -EINVAL error as no serial driver in the tree supports them.
> 
> If we remove the structure (i.e. what this patch does), and someone
> makes an ioctl call, they will still get the same -EINVAL error they did
> before.
> 
> So nothing has changed as far as userspace can tell.
> 
> Now if they have an out-of-tree serial driver that does implement this
> call, then yes, they will have problems, but that's not our problem,
> that is theirs for not ever submitting their code.  We don't support
> in-kernel apis with no in-kernel users.
> 
> Or am I still confused?
> 
> thanks,
> 
> greg k-h
> 


-- 
js
