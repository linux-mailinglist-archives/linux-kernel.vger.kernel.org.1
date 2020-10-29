Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91F29E297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbgJ2C0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:26:18 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59769 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgJ2CZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:25:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 37C725C0136;
        Wed, 28 Oct 2020 22:25:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 28 Oct 2020 22:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=M
        fF4AAKwDJHpJBHd8BnuDeW9kv0jiOpFjUocPRCzXs8=; b=kFsa6yqYhx4U/t5Zt
        EtuTgTF1atSaMwwxCtfVIRLqxDjxMJwjbdJ20AFO4d0IDNkxt4zQ7T4947cFyzfB
        PSiHqz1nmqJyFXmDepx3dlSg6635rRK9Gp9sWJZCsZh3X+DIqmFh8hVI/pDcfsiv
        iLnKJlTc01i3cRsrFx1pxq1P9lw3n+aINKK2Du5xjH6a2KYvosu9Wa0SuPtbG+as
        7OSF6dODskAZRbudFICUvv5ZhIj2UtlyCi0EsPGI7PJmaEXfMFenVvsKmKdrvd9t
        1QZu79Nca9J7RvPpvQQQd1+GFdMEkt4Pn8pNehGQQshcenY1UUat+Dt/peJxNvi/
        707Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=MfF4AAKwDJHpJBHd8BnuDeW9kv0jiOpFjUocPRCzX
        s8=; b=cdoCFbrI+jKI/dO9NoJsiDorx/CLu4e/SRCDmE7OjQZejZH7zjj1Zz7MI
        mM1iII8Td0cnhAsyUNxM0batxG+XqLrF9BSXo6TXpLgqpOKaPH2uoDNrsgx2y2SK
        DuQcZKLls86zWwYmAXpDQ11nyYN0oJfWxTK8OpiEhPAUN0HsxumN1rtE3m8JwLg2
        AaWiOSQzg9VUjCYf7CEt3d/tp58Qbx316g/Kxvj3Q6f1v3BLb9Jfx2wU9qQFIoR5
        nE32nglF8xNLUxsEjw7uc4laLyqy98FOGdmk+EMlSTpY7IChK+ufKV9p/uDhzimF
        JNzE1SlleiKMKVLZVpq557NimhBmA==
X-ME-Sender: <xms:CyiaX-Ie6vxWSQnNMYhe_5mqPN7IDQ0deQKq71BYReGLYj2Eo40b9w>
    <xme:CyiaX2JOvMMoAv0VqMrsdkRmoXA3um-yLLxzK0f7Fndgm1H5oO1m6rQeYfPNF-FcU
    1pQdnYU2SMTK06NaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrledvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefffedvhfehhfekfeetieehfedtveduvdelieelgeettdefjefhjeek
    tdfftdejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejtddrudefhe
    drudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:CyiaX-vDUbtfXtuL9MZkg8MO39q-DwzWPq8RvVzg74d9V0FG7nm2eQ>
    <xmx:CyiaXzb5XOMJX62P0M1X1zHr-CxBtzTxACHwpsCJdj-waD89gWxhNQ>
    <xmx:CyiaX1ZkiCQjX-kUHpAOJfNdD3l6GyzIhgtBShfXnsh-HA_lhO93WA>
    <xmx:DSiaXx41PmLx9VIt3fMLYeIEaxjcmDsDNzzxc7HtV3jibFAwMxyRag>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6239F328005E;
        Wed, 28 Oct 2020 22:25:15 -0400 (EDT)
Subject: Re: Re: [PATCH 1/1] clk: aspeed: modify some default clks are
 critical
To:     Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        BMC-SW <bmc-sw@aspeedtech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
 <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
Date:   Wed, 28 Oct 2020 21:25:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On 10/14/20 12:16 PM, Stephen Boyd wrote:
> Quoting Joel Stanley (2020-10-13 22:28:00)
>> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> Quoting Ryan Chen (2020-09-28 00:01:08)
>>>> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
>>>> default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
>>>> eSPI slave channel, those clks can't be disable should keep default,
>>>> otherwise will affect Host side access SuperIO and SPI slave device.
>>>>
>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>> ---
>>>
>>> Is there resolution on this thread?
>>
>> Not yet.
>>
>> We have a system where the BMC (management controller) controls some
>> clocks, but the peripherals that it's clocking are outside the BMC's
>> control. In this case, the host processor us using some UARTs and what
>> not independent of any code running on the BMC.
>>
>> Ryan wants to have them marked as critical so the BMC never powers them down.
>>
>> However, there are systems that don't use this part of the soc, so for
>> those implementations they are not critical and Linux on the BMC can
>> turn them off.
>>
>> Do you have any thoughts? Has anyone solved a similar problem already?
>>
> 
> Is this critical clocks in DT? Where we want to have different DT for
> different device configurations to indicate that some clks should be
> marked critical so they're never turned off and other times they aren't
> so they're turned off?
> 
> It also sounds sort of like the protected-clocks binding. Where you
> don't want to touch certain clks depending on the usage configuration of
> the SoC. There is a patch to make that generic that I haven't applied
> because it looks wrong at first glance[1]. Maybe not registering those
> clks to the framework on the configuration that Ryan has is good enough?

Could you please be more specific than the patch "looks wrong"? I'm more than
happy to update the patch to address your concerns, but I cannot do that unless
I know what your concerns are.

Regards,
Samuel

> [1] https://lore.kernel.org/r/20200903040015.5627-2-samuel@sholland.org
