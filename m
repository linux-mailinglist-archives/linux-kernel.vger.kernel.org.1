Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7434A2F024A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAIRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:32:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE3C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 09:32:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so8317999pfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MKoEbOVqeylny0S9yDwuXrCkBIfivEwg8XzUh5/Se+Q=;
        b=eWZogYhk6jKVE7ShBVGqYhFaxhXRRcYovozWnjkp5IWgM2bzSJNc+s9EKdYwvN/iIs
         AUE1buvWebv4Z+zQBKFp2H2IMknZF2agjB9YKUof7vRTH0e8Yqm49D2zAHgjFgeta5TG
         rr6ubpmnE7Lyms6rkTpEkBBVldQmwdadDRd9o4qC6OUQkHrunoIf74s/BfohRLHNBKxe
         XHxaFg6MU+ImlHcpg6hoRf7f7K2R+/dx8Thq/uo55vkQInGEXmVUrc9bryO8AuqXxbsV
         ISygYHN0Sq+VOZ6wvJcE6P6BIzoWlhqWR88UQn3mWibcaJ+bYazubfBIrD8F99ygT7WR
         y/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MKoEbOVqeylny0S9yDwuXrCkBIfivEwg8XzUh5/Se+Q=;
        b=mX0EtMKaH5DIf/dOttJp+VPzDjnttKPsOMXKkfOO+3A/+uE3cptDXI17DZKYNgTm7J
         zd6KI2zhivv5kxqwA1w2wbh1jU0Ww67W6uS15sZkgCTTydXsLc+712Gk8qQ8ZxJaj+Mo
         m1q8aBVf7U9/QIfPCKaOO4LPxWpVPhmbZc3QqsjNhhfsWqLbTfEQBYSPMEMrww8AXuFy
         MIByZ/HQsnuXeZ6HJv0kY9p6RRazGBcXR/je+YLEKxZ//VXiU0IAVrSikRqJyWf2aas9
         7O9H3qIhxTYpHs85M9CpQF3S2T3BMRHfc1+nYe+hbg3ES9CqIto99E1JqhK+228qrSEF
         WP5g==
X-Gm-Message-State: AOAM532D7IhXq8PT4Pq/kGrymqofWJihJ2j0LWnVEcylBt5Ynv8v51sd
        nDwgAn7B9Uw8HbuB6yR6t+o=
X-Google-Smtp-Source: ABdhPJwgtOP/Kev9pwQG3Nk7L5OEYnCa+WCBS6vrQUdFm1wTtTOKn0Qf2eKGImAZ9Jr/lDa+SOVFIQ==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr12337358pgs.77.1610213533026;
        Sat, 09 Jan 2021 09:32:13 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21sm13148403pga.12.2021.01.09.09.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 09:32:12 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrea Adami <andrea.adami@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
 <CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <87fc6d49-b130-cff4-5171-ced243e5e157@gmail.com>
Date:   Sat, 9 Jan 2021 09:32:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2021 4:16 PM, Linus Walleij wrote:
>> * ep93xx -- added in 2006, LinusW still working on it, any users left?
> 
> I was contacted by a user of this platform, using it with mainline and
> fixing bugs in the GPIO driver for this kernel cycle. So it has users.

You can count me as one of the users, I still use my TS7300 system,
however because of the amount of RAM I don't regularly update it.
-- 
Florian
