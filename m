Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A72303748
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbhAZHWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbhAYPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:45:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA00C0698C3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:33:07 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q1so27286737ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2talsnklJaVWOGtsgs8EdiY+cMK9LMTP+0Z5YlQJtd4=;
        b=P7ErHoA/+D5d+b8kMTYT1LddbEtINrboZFlaN3z8uGxV0oWIoLCWPw6oBNwR5GRvYt
         psAiLFGGow+NL4Ke6hnZu9IvshizfPkjGOIz6+89O5ziHVJNAupK3243HNTsXMwuM+v1
         EWC/CMdFqfrLg9QiCHHnDIv9qgIaACZfumqe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2talsnklJaVWOGtsgs8EdiY+cMK9LMTP+0Z5YlQJtd4=;
        b=tXt9xGlGXWfHpbGiyHljf8zXDcbVRw5oiOD/U4lYQ5Zyr5qAisMpewd2kqYpFHfqgb
         CsGBbhtjDKt601ggbrs0ho/S2HK+bD3tGiJlDdMf6UsHoQ2IbLJ6a6c5wyh14kTvuWjO
         D0lJVexx/djt25WMgofHUlru68V+6SJcFtlVPPWueAHNW3y2PPiFZJKdWo7sVd3QJ1I4
         8u640ld/OFpn/3UWfoU0eOtcPWdYByn0+mYeohiXjCl7YYprguB4tC5r0U8J82NbB0ly
         QxZ5+t0KaN41yYOXMrXLfBZNs2pqbW4Scm64wNb/87R2oEsdeNxED74afY1XbnvBWwR2
         SQWA==
X-Gm-Message-State: AOAM532IRz7DYGjufDrPtOht+qsvmBkEk/EbchWUpsOAVMg/WwNpaGFP
        izQeg4PxxK6lNf4tivexYCy59OdOW8KbIA==
X-Google-Smtp-Source: ABdhPJxUbmcMeGkX2ysM9tPtrszMYhXUtSY+ZmpqNQmJ+gFt0A0XM83EtVGyjMYhMg2XhRw9u1tP8g==
X-Received: by 2002:a05:6e02:1032:: with SMTP id o18mr819698ilj.13.1611588786484;
        Mon, 25 Jan 2021 07:33:06 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v7sm11885285iln.79.2021.01.25.07.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 07:33:05 -0800 (PST)
Subject: Re: [PATCH] [net-next] ipa: add remoteproc dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210125113557.2388311-1-arnd@kernel.org>
 <YA7iVQtm8P2F1VAN@builder.lan>
 <CAK8P3a21TwzvESbnmGYpj9vrvpWM5uayZjpk9KA4Cg9wk78C4Q@mail.gmail.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <a41bb573-f133-0188-275f-4637e10bbbaf@ieee.org>
Date:   Mon, 25 Jan 2021 09:33:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a21TwzvESbnmGYpj9vrvpWM5uayZjpk9KA4Cg9wk78C4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:30 AM, Arnd Bergmann wrote:
> On Mon, Jan 25, 2021 at 4:23 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>>
>> On Mon 25 Jan 05:35 CST 2021, Arnd Bergmann wrote:
>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Compile-testing without CONFIG_REMOTEPROC results in a build failure:
>>>
>>>>>> referenced by ipa_main.c
>>>>>>                net/ipa/ipa_main.o:(ipa_probe) in archive drivers/built-in.a
>>> ld.lld: error: undefined symbol: rproc_put
>>>>>> referenced by ipa_main.c
>>>>>>                net/ipa/ipa_main.o:(ipa_probe) in archive drivers/built-in.a
>>>>>> referenced by ipa_main.c
>>>>>>                net/ipa/ipa_main.o:(ipa_remove) in archive drivers/built-in.a
>>>
>>> Add a new dependency to avoid this.
>>>
>>
>> Afaict this should be addressed by:
>>
>> 86fdf1fc60e9 ("net: ipa: remove a remoteproc dependency")
>>
>> which is present in linux-next.
> 
> Ok, good. I was testing with next-20210122, which was
> still lacking that commit.

Yes, for various reasons this took a while to get incorporated.
It just got accepted over the weekend.  Thanks for mentioning it.

					-Alex

> 
>        Arnd
> 

