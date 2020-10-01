Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A97627F7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgJACg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJACg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:36:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:36:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so1050735pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KYXszwQ89hkONVI1ysv2NZoMsEiEw8904Ywg8FUfkI=;
        b=dsiK3+Vj2bBXVcrL67SxMoRMBWNkQPZ8K+qgnGyOIJOTCtoMu80p+h4ro17ocKE1Gv
         kGwTcV/1jq2e9BNZ9sq+oNvhg5KeKoeQymFm4AN3yyH1am0xh3kNmo29B6TiBBQarHQy
         rl5V7UfHz6uv/DbSe0kYmhXRaxvq8YRLyzN2AOc0bgguVfLPX3zq/84VIuBHP2MLuHUs
         C5EbeVfZINz3HldQ1dbl3tRToDOcvR8QunaBug3+fKms2nu4UL6a+nPWwtW8yFD4mFQX
         CO4TiITnzoBX0HbCoFtqKbPSkbZKK3Dj0YwkSvMurlBtOID5+xqK0jYC5Z6jxQYkMTFK
         /QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KYXszwQ89hkONVI1ysv2NZoMsEiEw8904Ywg8FUfkI=;
        b=omUAwSBqeYc6+F3FO5Zwqn05gSDF3ibRdYxfP3HYxlmIVKbV82e2S5JuaRndCiAbjw
         HyxkBxxcTYeK7qEu9BWHwtigEX0HvXJxWv6VnYIGw/PPfmPvjPTU+NeaP+0Ok2aN9re/
         nc5FWyqnVL7uMJ0+c9m0CkomHOu/JbegC8lAX02H4UQDIQA2WU+mcJAPd63/IAEf3TIC
         lQn0XNbED8TSxdtaC9U051gpgymC0cebN8pzBI/epmgMC1ROp3PnsaRoyx30V4D9u6C5
         fl8lWjspb+HnVTNcXAU9PU1Oi/fv5e+C4FtU4UMCEVHY1CxO8EKd/b1ESHicCMpfIgoC
         4mgw==
X-Gm-Message-State: AOAM530z9Ku+zpdITpteAqNTwuET4aZUQJp3pbiN1sF6ej3mt4EYBsO9
        45lAjn6sTkBVCm9g0UgALfo=
X-Google-Smtp-Source: ABdhPJzIIRGx7RUVV7WCyOmJVN0hmuT6ALzxoLXlc5pjTJwYYLi5KjiiR1iYyYv9AsMo0+1IWPIJxQ==
X-Received: by 2002:a17:90a:760f:: with SMTP id s15mr5034135pjk.214.1601519786250;
        Wed, 30 Sep 2020 19:36:26 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z1sm3405278pgu.80.2020.09.30.19.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 19:36:25 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] misc: bcm-vk: add ttyVK support
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-16-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <278afb05-8c8d-98d2-eed0-f73b954b03c7@gmail.com>
Date:   Wed, 30 Sep 2020 19:36:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012810.4172-16-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 6:28 PM, Scott Branden wrote:
> Add ttyVK support to driver to allow console access to VK card from host.
> 
> Device node will be in the follow form /dev/bcm-vk.x_ttyVKy where:
> x is the instance of the VK card
> y is the tty device number on the VK card
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Was it not possible to:

- emulate a standard 8250 UART and just expose an additional bar + MSI 
vector such that one could get a debug UART out of this device with 
little to no work on the host side?

- or use virtio console and implement virtio on the firmware that runs 
on VK?

It's not a lot of code, but it just feels like this should not have to 
be done at all.
-- 
Florian
