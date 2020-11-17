Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22002B701F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgKQUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgKQUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:32:22 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB72C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:32:22 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y22so10900366plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+ymwfagSIRQOkqqnEnUTwj2p7nXktO9WkHM8gsv90o=;
        b=aeNa7LHEWOkNKlQ/VU2rX1dcvbu+8EJM77jIf3hGFscomyPaPZXP1sdCxHI5s1Seom
         adL0m5UcKKh0oh0DQnUbPSQoNXixxuRV8Y1eMT5Vs5CJ+rA+7v1mrFzBYFmqy0yQJBWg
         bB5KWgwSIeVxmo2Vw317S5mQMv/Coq8wJoy81tMcm9g4ZB7oCL4LePPIhn+VCEWd1yyf
         RYiNU9EAtOcDUFOOU5EqOjBEcqUfUATBiym8cpGh42KT6Me4QREekrSTASlry/Slr036
         zRbLQJLCzbXdJoUfFHosTCuo9VYdjV+Ch7bjrhgBi3/tJEa3ilmGheYr2nomRbPeXfAT
         F9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+ymwfagSIRQOkqqnEnUTwj2p7nXktO9WkHM8gsv90o=;
        b=homw/FwEQJMxUanO8QLwFqmxwB2WtujBsYJHOBInLAn+1pBehxmJNXiItuloj7NqZ8
         AL47/nrqXqM0U+q9U9eCAF//FrLKLL4m5aAr1LHnjXDUqhDvgMXcMX+KoLjWCqg2Nfw2
         TyIHG9q0n7WjN9QoffjhOvgzGDTJyd9NbvOjQTLuE7HguFQCiymgnqTytDyTOopT9Uf9
         4n6rGe3MPlod7Nx7WiYF8t0V4UIuM/votIh9IfSz2wc66ksJFUNaPH4BfGlYRa2h7eAR
         aRoY4KvBtorR9x3GogrDNVISl9B2KD0vx4OuDg8OyfSQvSxtABeKFTGF7anM8zY9++H3
         dgDg==
X-Gm-Message-State: AOAM533d0vwchpcITnrnXMNCEj7GC0bM3FpIhkbwf7E+jpWffK4hLRHD
        9jVfKei9BSYP4Zq99JCRNLLdZ6Jk2hithsVk
X-Google-Smtp-Source: ABdhPJxmJpRlUoDLjNS4hVcNJSgahdYvoerLTWsz8Y+hiM2zFU+S21Pi8edDVGaSdEYY56S/GQMD+Q==
X-Received: by 2002:a17:902:be07:b029:d8:afa1:3d76 with SMTP id r7-20020a170902be07b02900d8afa13d76mr931181pls.14.1605645141830;
        Tue, 17 Nov 2020 12:32:21 -0800 (PST)
Received: from ?IPv6:2402:3a80:425:6282:bc1b:1de0:7718:e8a1? ([2402:3a80:425:6282:bc1b:1de0:7718:e8a1])
        by smtp.gmail.com with ESMTPSA id a3sm22066070pfo.46.2020.11.17.12.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:32:21 -0800 (PST)
Subject: Re: [PATCH v2] checkpatch: add fix option for MISSING_SIGN_OFF
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201111090143.9230-1-yashsri421@gmail.com>
 <CAKXUXMzg6Wg310s-N8hWOEiXFkg1ZAga+NkFQkFQ5_bS16TLnA@mail.gmail.com>
 <2b640e8b-69dc-2ade-3b9f-fae14eed1b17@gmail.com>
 <f21acc492ab37acc42390abffb61aed370a22118.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <13f3fc34-0ca4-66d4-92ca-db80b66f5fb4@gmail.com>
Date:   Wed, 18 Nov 2020 02:02:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f21acc492ab37acc42390abffb61aed370a22118.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 9:20 pm, Joe Perches wrote:
> On Wed, 2020-11-11 at 16:39 +0530, Aditya wrote:
>> On 11/11/20 4:00 pm, Lukas Bulwahn wrote:
>>> On Wed, Nov 11, 2020 at 10:01 AM Aditya Srivastava <yashsri421@gmail.com> wrote:
>>>>
>>>> Currently checkpatch warns us if there is no 'Signed-off-by' line
>>>> for the patch.
>>>>
>>>> E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
>>>> Completely remove --version flag") reports this error:
>>>>
>>>> ERROR: Missing Signed-off-by: line(s)
>>>>
>>>> Provide a fix by adding a Signed-off-by line corresponding to the author
>>>> of the patch before the patch separator line. Also avoid this error for
>>>> the commits where some typo is present in the sign off.
> []
>>> I think it should still warn about a Missing Signed-off-by: even when
>>> we know there is a $non_standard_signature. So, checkpatch simply
>>> emits two warnings; that is okay in that case.
>>>
>>> It is just that our evaluation shows that the provided fix option
>>> should not be suggested when there is a $non_standard_signature
>>> because we actually would predict that there is typo in the intended
>>> Signed-off-by tag and the fix that checkpatch would suggest would not
>>> be adequate.
>>>
>>> Joe, what is your opinion?
>>>
>>> Aditya, it should not be too difficult to implement the rule that way, right?
>>>
>>
>> No, I'd probably just have to add the check with $fix, instead of with
>> $signoff
> 
> I think it does not matter much which is chosen.
> 
> The bad signed-off-by: line would still need to be corrected one
> way or another and the added signed-off-line is also possibly
> incorrect so it could need to be modified or deleted.
> 
> 

I think I might have misunderstood here that I do not need to make
changes. Just confirming, Do I need to modify the patch?
Pardon me for my late attention to it.

Thanks
Aditya
