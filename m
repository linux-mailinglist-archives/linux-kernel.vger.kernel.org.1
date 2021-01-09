Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7032F0254
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbhAIRfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAIRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:35:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55DC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 09:34:57 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so9720379pgl.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ci8Rwo7wSWlepYSUEBT32YwLjFU7IeIoOa4VGDSs+48=;
        b=f6XrFpR6K/FHcmqI/Zkowti3KnZsxdM2ETh2WmGfkb9FK5aJ+I1Ncnd8q8NWTH+aZU
         +rbXKjta7mPAAxBzkUUqYw/BoMuK6ResiR0m+i5ZRHNQZJMRcRoJcCXSgbYeUlabJpnp
         NDWrrHAgCaxB3YwByiO91x2YJBBkMcp8rcx69vqLOsn3c7lq3KdKIwBd5z8xyO/ITzR7
         QWEANNnXhYC2/271eWV2BOTutv97acq7j0BRYZw7qx6mtDP36aZXFpVi4t2tA3+YieOb
         QLzIkCH1A427AiZtdNVeM9ALS3cHy8jdqEagVFJvqhVrOLx1HucBlqDNcPK/2I+fbWPl
         dsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ci8Rwo7wSWlepYSUEBT32YwLjFU7IeIoOa4VGDSs+48=;
        b=ijvuDtRYOudQUl737HhzTv1N2ynHLLLiNBQU/kRaS4ZrU4VKpph7RAVfv59wrqAr4Y
         BHKa6xIuw+vPOC0mnS3e2QRD4Gnu30LgV1DwAWPEi4NOn/3fSolJSyCz3ETtG71GqZvS
         7OQGmKH/rW8BhfHmKi5avaq0dVoxVCq6stgOJ72Z3s5t7y5jwFhw9ANHKpe+BDXtJIfX
         TfNFOZUkn5w1ALfSGnugspHeR6tbYbHgwh8EHIEixOqRUjPcUQNJb9zphGJAirA0DhUl
         pNNDlVvKr2GqL8Udq738gMQbMegsyfRF0gZG8L+DsNiuqZ7q5O4+x3xCWRfcr3sAZqgz
         Uy7A==
X-Gm-Message-State: AOAM5318pSbZb/xqMgc4fmvLZravmO4+jRikc9DMpgTga+wjQkSTMprz
        GxnTXRF0bAPtlW2kIegLx1Q=
X-Google-Smtp-Source: ABdhPJx3+joeP5SbM+q4zPeLYKHz0LUhGpd4Y3bXKpkKVXjy+vTt9ZlQ7kRqIfxiDnwITEiY9zrDKA==
X-Received: by 2002:a63:520e:: with SMTP id g14mr12109392pgb.378.1610213696986;
        Sat, 09 Jan 2021 09:34:56 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l8sm11469626pjt.32.2021.01.09.09.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 09:34:56 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0f363c27-608d-76be-3af5-189d812f805d@gmail.com>
Date:   Sat, 9 Jan 2021 09:34:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2021 2:55 PM, Arnd Bergmann wrote:
> After v5.10 was officially declared an LTS kernel, I had a look around
> the Arm platforms that look like they have not seen any patches from
> their maintainers or users that are actually running the hardware for
> at least five years (2015 or earlier). I made some statistics and lists
> for my lwn.net article last year [1], so I'd thought I'd share a summary
> here for discussion about what we should remove. As I found three
> years ago when I removed several CPU architectures, it makes sense
> to do this in bulk, to simplify a scripted search for device drivers, header
> files and Kconfig options that become unused in the process.
> 
> This is probably a mix of platforms that are completely unused and
> those that just work, but I have no good way of knowing which one
> it is. Without hearing back about these, I'd propose removing all of
> these:
> 
> * asm9260 -- added in 2014, no notable changes after 2015
> * axxia -- added in 2014, no notable changes after 2015
> * bcm/kona -- added in 2013, no notable changes after 2014

I have a development board that I occasionally turn on for testing
upstream kernels, it has not broken in a while which is why it did not
get much updates. I don't feel strongly with respect to keep it or
dropping it though.
-- 
Florian
