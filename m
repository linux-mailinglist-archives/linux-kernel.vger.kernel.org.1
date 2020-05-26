Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAE1D7F82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgERRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgERRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:01:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C7C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:01:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so12735181wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A6wVB9L5JuVcZQhVgNV1j0Bavs6H5jtfAqYurATa2Do=;
        b=bdA653P/QboIHjRsQ/kXQWemQ8gbXJMRQu3sewNP+YlMuTl/p+foWkhrLBStyDO3gs
         P2xavifo28Zofs/Rb7dMxZhbpgta+7Kk+bqr4BIbGuby4R3WDa5HKRGg2vGBBRVYB4YQ
         aEDQ+ayplQUHRW1UmsY0tBOxCcGFp4kf4pIW4vhdh0O3Vkmx23NrQLjGIW0bxNe7fNj3
         V7gc+n4557nQQNW5GXTQMVbWEL++D8cGjwykRK1eXP54o8As3O6011hEi6Ugivsi8Aeo
         m//EeAkt88jJOpWwhlanVeKgEjGYuzreqBkcqexXZUxp3lcCujAJH3Tu31bBPV06jEiR
         6l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A6wVB9L5JuVcZQhVgNV1j0Bavs6H5jtfAqYurATa2Do=;
        b=gm4braudDRqIvVlimtryic+LbiraiKSRYvcXqr9Y1KVcrHLYTHbipjjmPseNLJvB0X
         geGcRXmzgckJi5MjN6+8ddvuhcw/vHNLKRlL6n5KAokqVl9wEiUXrKV2l+W7JxhPDFsM
         A0jxf9d1lq/l3Q1dA4p7Z0VP04G5+wv+k1LqYdSfN+wVzVJ02MXyL0tENNlpCB+cmAdy
         bmAGhyte7FMOu81Pg+rt70hKiqi8JHv5r8xoTRPY2gXlAwjRVt16PEGBddqBv6t39z7x
         RdoBehk10Od9NqfT4wSxe/UL5uE0WTwQ46nR62WlsPHU6pmtJuTKlmWd5+s/C5zeEax/
         VblA==
X-Gm-Message-State: AOAM533b3r3ln2FF6xoyynrGWvrlUnbM2Fh4KmJKiAT0xSS7IBxA9yTW
        WAIwYm6JhdDe8gw17z3cj2ZFUw==
X-Google-Smtp-Source: ABdhPJxWOh06HcVOViu4DIpbbOhR0OOnnCEwdTI40X9By447kp5WfnRE1ew1W4UPHl9Gn9nhNxTnxg==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr20606675wru.62.1589821299348;
        Mon, 18 May 2020 10:01:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id m13sm178601wmi.42.2020.05.18.10.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:01:38 -0700 (PDT)
Subject: Re: [PATCHv3 00/14] Update omaps to use drivers/clocksource timers
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Brian Hutchinson <b.hutchman@gmail.com>,
        Graeme Smecher <gsmecher@threespeedlogic.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20200507172330.18679-1-tony@atomide.com>
 <340cdd4a-d996-073f-127d-89ce6c05f221@linaro.org>
 <20200518170059.GR37466@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c2404711-af5e-e9a2-29c1-55378522ebd2@linaro.org>
Date:   Mon, 18 May 2020 19:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518170059.GR37466@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2020 19:00, Tony Lindgren wrote:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [200518 16:59]:
>>
>> Hi Tony,
>>
>> On 07/05/2020 19:23, Tony Lindgren wrote:
>>> Hi all,
>>>
>>> Here's v3 series to udpate omaps to use drivers/clocksource timers for
>>> the 32k counter and dmtimer, and to remove the old legacy platform code.
>>> Please review and test.
>>>
>>> I've updated the timer-ti-dm-systimer.c patch based on the comments from
>>> Daniel and Rob, and added support for selecting the preferred timers to
>>> use.
>>>
>>> Then for merging when folks are happy with this series, Daniel if you
>>> can please apply the first three patches into an immutable branch it
>>> would be great.
>>
>> so the clk patch also ?
> 
> Oops sorry, just first two are needed as we no longer need the
> device tree binding changes :)

Ok


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
