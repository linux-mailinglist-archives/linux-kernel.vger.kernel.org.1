Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0473E26BFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIPItB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIPIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:48:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:48:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so5423620edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0GVkzQNMl0xSZNo17pC/g2Cx7MYz6dChnH+c0tOLbsY=;
        b=YgupfEYWBBPgZKTyIsaY+Y3INovUQUarZLbaxazRnT8E+fURSBjg4wepTS/wVUVugL
         vFCXbaWL+aK35vawd90s8oUjgdtR71bbHzeKvjqSDr0ROmysKlfdvzkiNosiGx4e1UFc
         /E9agmHokp+sTu+6w+pkfU3EUWxzXBfV5ZdL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0GVkzQNMl0xSZNo17pC/g2Cx7MYz6dChnH+c0tOLbsY=;
        b=AIfLZ2/V+XQoV6zHu1sPCOoVidNGdoQALtnS5/rf94DbB0aVDYdCc7D4USRtiWYw1z
         NWpSxdQLJYxpw1pDX7r8FlApHts+8yC4+1yY3wLOl2sGiuGSMcn+pnNz3oS7v2VEBBLU
         hNf/Tmofg3hBngmgCeSLAkK1z609icaQMyh0k6ySIQckCV7klMzZmdQKB7tTp1SdBhLr
         0g6wrhA7kf+pMuzfZtJJsVE78h2Zqxr6Rc5PRYV8qXVhW5+rKyrkic7oOJuQWfkSV03u
         +v92bt5cIme69Y8leZaoOpT6YreH8AFqX8muuoewpBDL5okGvZ504YaOIuKoOVgYdLGH
         vgwQ==
X-Gm-Message-State: AOAM530gbY11bSImLQBolallaUNeCBwSgkxJ31pjLGbHvoiWh9ImRznb
        /6XMKpD1376L5OX38mIDz8Qw17CVHsNR2UD3
X-Google-Smtp-Source: ABdhPJx+j6ckbg2+QtZSC+A+Sy2q08IJTJrUhjX2D7fwKsQTPWbX0lst5VbmICYfw2G9v+9cYev6DQ==
X-Received: by 2002:a50:ab13:: with SMTP id s19mr25788397edc.357.1600246130201;
        Wed, 16 Sep 2020 01:48:50 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id g16sm6229017edf.20.2020.09.16.01.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 01:48:49 -0700 (PDT)
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more
 reliable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e779698e-97b3-6a34-a556-d0d5ccb54bcf@rasmusvillemoes.dk>
Date:   Wed, 16 Sep 2020 10:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2020 16.34, Masahiro Yamada wrote:
> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
...
>>
>> So in order to avoid `uname -a` output relying on such random details
>> of the build environment which are rather hard to ensure are
>> consistent between developers and buildbots, use an explicit
>> --abbrev=15 option (and for consistency, also use rev-parse --short=15
>> for the unlikely case of no signed tags being usable).
>>

Hi Masahiro

Can I get you to carry this through the kbuild tree? Unless of course
your questions/concerns haven't been addressed.

Thanks,
Rasmus
