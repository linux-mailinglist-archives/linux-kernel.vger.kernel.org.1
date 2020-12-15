Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4F2DAFED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgLOPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLOPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:21:41 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88749C06179C;
        Tue, 15 Dec 2020 07:20:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 23so40303088lfg.10;
        Tue, 15 Dec 2020 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuyWwSuY18eHFc35IQmhuZr0KIu0Yk9xgwuhGz8DmXw=;
        b=fZuZuGIP04LrGtCfIAhrsGIcx69XkMj13TAgcfj+6Oy+hp1aa58WV85jLpzXbjSvkx
         +WJf+LyzSm8pAjHlH0bWh4byZgPQpQXCFj7bxD49HdE5rCirVEd/a1iewRQzhWYuamh/
         z9iHdyVoKbXjIPxVbos4NeQvCbUjvYbWV3AEE66ULuZENT9GaGO3D45ArLrnYHNc4/II
         aZSlNIU7qVBPaVCP9Qs71YX7MofvIS6TulP+jdAi3pFFxlM52mULgN62k/oB2uZ+V9Kl
         iGP3jc2cGgxVSeLKm1RcAHWBpbHfFleITpL2JuLUodVCErXlPr5qSOXfsJFn21A39fab
         c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuyWwSuY18eHFc35IQmhuZr0KIu0Yk9xgwuhGz8DmXw=;
        b=olpxg0bBTyOqnpEtnH3JiCyKDHVtNH3P1kjFm2XbnVt70HlfjSGeQXtt2CznDj1KQ6
         RtNS0fKW5PfMgEhr6Yy7yB6oKLuwhPlI33PJUNyELJPYy/CB7dXzygTMwVrkCw3/RXf8
         wKL37bie2Qqub1xr3SahRDDc7fArsRa4g+tCrQsyee50OWmNoaw1sST3WPGCKw97deJc
         p+wlO4k60+iO19Gf04gNIDQWDFWIODVU29TR5BawRtGtkUEYJTzLyLjQjH01NCBS2jZP
         JkC14Zu4n5wVrYW+usn4npY7gDRDSFaVPF0Kh0JWorbRp4UxpbwHJE1ZFus2DwQzZgu1
         Lwuw==
X-Gm-Message-State: AOAM533QJEB1uOKjDyQWQa8l7ZMZXXmPCGvXBaqvGe0PoJfAJ3YrB1NM
        ILHP27JPA0F9/6gRv1HTiKcEJfpMI5g=
X-Google-Smtp-Source: ABdhPJwvwbphgtZ0cU4d7xZToymlNplQxgyNwRsAxc0uyvutGtnjUvp3BbSkdII6b6O885iejnDxEw==
X-Received: by 2002:a19:cbc3:: with SMTP id b186mr11369334lfg.554.1608045655787;
        Tue, 15 Dec 2020 07:20:55 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id d23sm2292395ljj.24.2020.12.15.07.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:20:55 -0800 (PST)
Subject: Re: [PATCH v1] ARM: tegra: Fix misplaced tegra_uart_config in
 decompressor
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201215135222.6899-1-digetx@gmail.com>
 <CACRpkdaUW5E-vqiy6Qghmjx_u7Sde4G18b=AsWBLmn+ARZiD2Q@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c46e91e6-7b25-07ff-6353-3bd9300fc4d5@gmail.com>
Date:   Tue, 15 Dec 2020 18:20:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdaUW5E-vqiy6Qghmjx_u7Sde4G18b=AsWBLmn+ARZiD2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2020 17:28, Linus Walleij пишет:
> On Tue, Dec 15, 2020 at 2:53 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> The tegra_uart_config of the DEBUG_LL code is now placed right at the
>> start of the .text section after commit which enabled debug output in the
>> decompressor. Tegra devices are not booting anymore if DEBUG_LL is enabled
>> since tegra_uart_config data is executes as a code. Fix the misplaced
>> tegra_uart_config storage by embedding it into the code.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2596a72d3384 ("ARM: 9009/1: uncompress: Enable debug in head.S")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Aha I see the problem.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please put this into Russell's patch tracker as a fix!

Thanks, I sent the patch to the tracker.
