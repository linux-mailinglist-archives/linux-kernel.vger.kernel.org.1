Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012272BC616
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgKVOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 09:44:17 -0500
Received: from gecko.sbs.de ([194.138.37.40]:33756 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbgKVOoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:44:16 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AMEhYsW031561
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Nov 2020 15:43:35 +0100
Received: from [167.87.38.29] ([167.87.38.29])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AMEhXd4007532;
        Sun, 22 Nov 2020 15:43:33 +0100
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
To:     Qu Wenruo <wqu@suse.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
 <20201108171811.GB10914@qmqm.qmqm.pl>
 <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cea48473-eeb1-db60-cc0d-ebf9a26aaf0c@siemens.com>
Date:   Sun, 22 Nov 2020 15:43:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.20 00:28, Qu Wenruo wrote:
> 
> 
> On 2020/11/9 上午1:18, Michał Mirosław wrote:
>> On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
>>> Hi Michał,
>>>
>>> Recently when testing v5.10-rc2, I found my RK3399 boards failed to boot
>>> from NVME.
>>>
>>> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
>>> creating regulator") seems to be the cause.
>>>
>>> In RK3399 board, vpcie1v8 and vpcie0v9 of the pcie controller is
>>> provided by RK808 regulator.
>>> With that commit, now RK808 regulator fails to register:
>>>
>>> [    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
>>> [    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
>>> [    1.419856] rk808 0-001b: failed to register 12 regulator
>>> [    1.422801] rk808-regulator: probe of rk808-regulator failed with
>>> error -22
>>
>> Hi,
>>
>> This looks lika the problem fixed by commit cf1ad559a20d ("regulator: defer
>> probe when trying to get voltage from unresolved supply") recently accepted
>> to regulator tree [1]. Can you verify this?
> 
> Thanks, tested with that commit cherry picked to v5.10-rc2 and it solves
> the problem.
> 

We are still missing some magic fix for stable trees: On the STM32MP15x,
things are broken since 5.4.73 now. And 5.9.y is not booting as well on
that board. Reverting the original commit make it boot again.

Linus master is fine, though, but I'm tired of bisecting. Any
suggestions? Or is there something queued up already?

In any case: Is that board in no stable Q&A farm? It's a basic "boot
fails" regression.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
