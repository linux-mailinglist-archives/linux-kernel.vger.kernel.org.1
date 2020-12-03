Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6B2CD98C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLCOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:47:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLCOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:47:22 -0500
Received: from [192.168.1.155] ([95.118.71.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1Ofr-1k1DLm2wnr-012nGT; Thu, 03 Dec 2020 15:44:41 +0100
Subject: Re: [PATCH] (v2) drivers: clk: make gpio-gated clock support optional
To:     Stephen Boyd <sboyd@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20201117160306.21760-1-info@metux.net>
 <160566373556.60232.14730664139007414312@swboyd.mtv.corp.google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <13a5d811-8ebb-9ac8-ac2a-04110f71ea16@metux.net>
Date:   Thu, 3 Dec 2020 15:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160566373556.60232.14730664139007414312@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QSQB3khoAeQ91gi0PGE7IbDjLwBPDKiHqj1H43XTH8ofEMvrxQf
 feIo4eaNA7AC9f7QisxQlAqwm2p00voMbHur1aqXDevsFWo14yoFI/0NshawteQbFlD6QJl
 ktle5vxvh1u+RVqfgeioAyvSYMA9DAUu5LjsRUwCAGCGSgE8lBZ7YQP0Ni+h7S1YY5Uubux
 mlEJfO/QLmNF3PINEnDPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9aOkMfjlCxI=:DXpPiaQDqGnYs6Y2IG7XND
 nDasW+/vV2u0t2FexpuOG/QICh3PmOoHQ6eiSo6uqxgXj3jEFJXv9ZpB5+9rrfi6Z+AhEyt4G
 ZttHG7CeDXXzCaYQoomPYXz73aFWW9Y2X4tSYmNwDV05vu43eU0w7FpXEYzPfO8EpGz7aOB1u
 lX4utFMYfjPkny/1pgXxLFOprYNM89Gz8zoyHKUkF01RPyq5QtoRzFHEWqh/TKY8ZT/0HKRp7
 2zQcj9M13M4E8NibrsvG+f55NFBBBMH7dHfIikHzBg5PQ1dtlAHNJq8pN1JnmTBOrjkP4vRb4
 7U+XujxRkyxQIeNNUpAJiv3kMCXxSH73qbN3VRAnNdJ4Y4yCH/LH3NLK1SKcFwD5vj9VVizZc
 1A7uDbiE/VJOMNgrVso3NSWOeqFzv4JgEoTnyt7b1unWDnnKCNQd9IdaHIA78
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.20 02:42, Stephen Boyd wrote:
> Quoting Enrico Weigelt, metux IT consult (2020-11-17 08:03:06)
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index c715d4681a0b..99e0188a15be 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -38,6 +38,14 @@ menuconfig COMMON_CLK
>>  
>>  if COMMON_CLK
>>  
>> +config COMMON_CLK_GPIO
>> +       tristate "GPIO gated clock support"
>> +       default y
> 
> Maybe 'default GPIOLIB'?
> 
>> +       select gpiolib
> 
> Does lowercase work here?
> 
>> +       help
>> +         Supports gpio gated clocks, which can be enabled/disabled via
>> +         gpio output.
>> +
>>  config COMMON_CLK_WM831X
>>         tristate "Clock driver for WM831x/2x PMICs"
>>         depends on MFD_WM831X


thanks, fixed it in v3.


BTW: just accidentially posted an outdated and broken version again
(some submit helper script was running wild :() - please ignore that.
the valid one is v3 from yesterday. sorry for the noise.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
